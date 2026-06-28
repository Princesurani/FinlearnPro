from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, desc

from db.database import get_db
from db.models import DbPortfolioPosition, DbUser, DbOrder, DbTrade, DbWatchlist, DbUserBalance, DbInstrument
from services.user_service import get_or_create_user

import os
import json
import logging
from db.redis_client import get_redis_client
from google import genai
from google.genai import types

logger = logging.getLogger(__name__)

router = APIRouter()

REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379/0")

api_key = os.getenv("GEMINI_API_KEY")

client = None
try:
    client = genai.Client(api_key=api_key) if api_key else genai.Client()
except Exception as e:
    logger.warning(f"Could not initialize Gemini client: {e}")

generation_config = types.GenerateContentConfig(
    temperature=0.7,
    top_p=0.95,
    top_k=40,
)

SYSTEM_PROMPT = """
You are an expert AI financial advisor and portfolio manager. Your job is to review the user's current portfolio holdings, sector allocation, and real-time performance to provide a deep, actionable review.
You will be given the user's cash balances, sector weightings, overall statistics, and a list of holdings including their average cost, current price, and unrealized profit and loss (PnL) metrics.

CRITICAL CONSTRAINTS:
1. You MUST output ONLY valid JSON matching this schema exactly:
{
    "overall_score": Integer (0 to 100),
    "summary": "String (1-2 sentences summarizing the portfolio's health, e.g., 'A highly concentrated tech portfolio with strong growth potential but significant sector risk.')",
    "strengths": ["String (positive aspect 1)", "String (positive aspect 2)"],
    "weaknesses": ["String (risk factor 1)", "String (risk factor 2)"],
    "recommendations": ["String (actionable advice 1)", "String (actionable advice 2)"]
}
2. Be highly objective and data-driven. Highlight specific risks based on the sector weightings (e.g. lack of diversification) and discuss underperforming holdings specifically citing their PnL percentage.
3. Limit strengths, weaknesses, and recommendations to 2-4 items each. Keep them concise (1 sentence max per item).
"""

STARTING_BALANCE = 10_000.0  # ₹10,000 paper trading balance


@router.get("/positions/{firebase_uid}")
async def get_portfolio_positions(firebase_uid: str, db: AsyncSession = Depends(get_db)):
    """
    Fetch all current holdings for a specific user.
    Auto-creates the user record with ₹10,000 if they don't exist yet.
    """
    # Get or create user
    user = await get_or_create_user(db, firebase_uid, STARTING_BALANCE)
    await db.commit()

    # Load balances
    bal_res = await db.execute(
        select(DbUserBalance).where(DbUserBalance.firebase_uid == firebase_uid)
    )
    balances_list = bal_res.scalars().all()
    balances = {b.market: b.balance for b in balances_list}

    # Get positions — will be empty for new users
    pos_result = await db.execute(
        select(DbPortfolioPosition).where(DbPortfolioPosition.firebase_uid == firebase_uid)
    )
    positions = pos_result.scalars().all()

    return {
        "balances": {
            "india": balances.get("india", STARTING_BALANCE),
            "usa": balances.get("usa", STARTING_BALANCE),
            "uk": balances.get("uk", STARTING_BALANCE),
        },
        "positions": [
            {
                "symbol": p.symbol,
                "quantity": p.quantity,
                "average_cost": p.average_cost,
            }
            for p in positions
        ],
    }


@router.get("/orders/{firebase_uid}")
async def get_orders(firebase_uid: str, db: AsyncSession = Depends(get_db)):
    """
    Returns order history for a user, newest first.
    Joins with trades to include the actual fill price.
    """
    orders_result = await db.execute(
        select(DbOrder)
        .where(DbOrder.firebase_uid == firebase_uid)
        .order_by(desc(DbOrder.created_at))
    )
    orders = orders_result.scalars().all()

    result = []
    for order in orders:
        # Fetch the trade record for fill price
        trade_result = await db.execute(
            select(DbTrade).where(DbTrade.order_id == order.id)
        )
        trade = trade_result.scalar_one_or_none()

        result.append({
            "id": order.id,
            "symbol": order.symbol,
            "side": order.side,
            "order_type": order.order_type,
            "quantity": order.quantity,
            "status": order.status,
            "fill_price": trade.price if trade else None,
            "created_at": order.created_at.isoformat() if order.created_at else None,
            "filled_at": order.filled_at.isoformat() if order.filled_at else None,
        })

    return result


# ---------------------------------------------------------------------------
# Watchlist endpoints
# ---------------------------------------------------------------------------

@router.get("/watchlist/{firebase_uid}")
async def get_watchlist(firebase_uid: str, db: AsyncSession = Depends(get_db)):
    """Returns the list of symbols in a user's watchlist."""
    result = await db.execute(
        select(DbWatchlist.symbol).where(DbWatchlist.firebase_uid == firebase_uid)
    )
    symbols = result.scalars().all()
    return {"symbols": list(symbols)}


@router.post("/watchlist/{firebase_uid}/{symbol}")
async def add_to_watchlist(firebase_uid: str, symbol: str, db: AsyncSession = Depends(get_db)):
    """Adds a symbol to the user's watchlist (idempotent — ignores duplicates)."""
    # Auto-create user if needed using our user service helper (fixes crash on balance field)
    await get_or_create_user(db, firebase_uid, STARTING_BALANCE)
    await db.commit()

    # Only insert if not already present
    existing = await db.execute(
        select(DbWatchlist).where(
            DbWatchlist.firebase_uid == firebase_uid,
            DbWatchlist.symbol == symbol
        )
    )
    if existing.scalar_one_or_none() is None:
        db.add(DbWatchlist(firebase_uid=firebase_uid, symbol=symbol))
        await db.commit()

    return {"status": "added", "symbol": symbol}


@router.delete("/watchlist/{firebase_uid}/{symbol}")
async def remove_from_watchlist(firebase_uid: str, symbol: str, db: AsyncSession = Depends(get_db)):
    """Removes a symbol from the user's watchlist."""
    result = await db.execute(
        select(DbWatchlist).where(
            DbWatchlist.firebase_uid == firebase_uid,
            DbWatchlist.symbol == symbol
        )
    )
    row = result.scalar_one_or_none()
    if row:
        await db.delete(row)
        await db.commit()
    return {"status": "removed", "symbol": symbol}


# ---------------------------------------------------------------------------
# AI Portfolio Reviewer
# ---------------------------------------------------------------------------

@router.get("/review/{firebase_uid}")
async def get_portfolio_review(firebase_uid: str, db: AsyncSession = Depends(get_db)):
    """
    Generates an AI review of the user's portfolio using Gemini.
    Caches the result in Redis for 24 hours.
    """
    redis_client = get_redis_client()
    cache_key = f"portfolio:review:{firebase_uid}"
    
    try:
        # 1. Check Cache
        try:
            cached = await redis_client.get(cache_key)
            if cached:
                return json.loads(cached)
        except Exception as e:
            logger.error(f"Redis cache error: {e}")
            
        # 2. Fetch Portfolio Data
        result = await db.execute(select(DbUser).where(DbUser.firebase_uid == firebase_uid))
        user = result.scalar_one_or_none()
        if not user:
            return {"error": "User not found."}
            
        # Get positions joined with DbInstrument to retrieve sector and name
        pos_result = await db.execute(
            select(DbPortfolioPosition, DbInstrument)
            .join(DbInstrument, DbPortfolioPosition.symbol == DbInstrument.symbol)
            .where(DbPortfolioPosition.firebase_uid == firebase_uid)
        )
        positions_with_instruments = pos_result.all()
        
        if not positions_with_instruments:
            return {
                "overall_score": 0,
                "summary": "Your portfolio is currently empty. Start investing to get a personalized review!",
                "strengths": [],
                "weaknesses": ["No market exposure."],
                "recommendations": ["Fund your account and make your first trade."]
            }
            
        # Load balances from user_balances table
        bal_res = await db.execute(
            select(DbUserBalance).where(DbUserBalance.firebase_uid == firebase_uid)
        )
        balances_list = bal_res.scalars().all()
        balances = {b.market: b.balance for b in balances_list}

        holdings = []
        total_market_value = 0.0
        total_invested_value = 0.0
        
        for pos, inst in positions_with_instruments:
            raw_quote = None
            try:
                raw_quote = await redis_client.get(f"market:quote:{pos.symbol}")
            except Exception as e:
                logger.error(f"Failed to fetch redis quote for {pos.symbol}: {e}")
                
            current_price = pos.average_cost  # fallback
            if raw_quote:
                try:
                    quote_data = json.loads(raw_quote)
                    if quote_data and "price" in quote_data:
                        current_price = float(quote_data["price"])
                except Exception as e:
                    logger.error(f"Failed to parse quote for {pos.symbol}: {e}")
                    
            invested_value = pos.quantity * pos.average_cost
            current_value = pos.quantity * current_price
            pnl = current_value - invested_value
            pnl_percent = (pnl / invested_value * 100.0) if invested_value > 0 else 0.0
            
            total_invested_value += invested_value
            total_market_value += current_value
            
            holdings.append({
                "symbol": pos.symbol,
                "name": inst.name,
                "type": inst.type,
                "sector": inst.sector,
                "quantity": pos.quantity,
                "average_cost": pos.average_cost,
                "invested_value": invested_value,
                "current_price": current_price,
                "current_value": current_value,
                "pnl": pnl,
                "pnl_percent": pnl_percent
            })
            
        overall_pnl = total_market_value - total_invested_value
        overall_pnl_percent = (overall_pnl / total_invested_value * 100.0) if total_invested_value > 0 else 0.0
        
        # Sector weighting calculation
        sector_values = {}
        for h in holdings:
            sec = h["sector"] or "Other"
            sector_values[sec] = sector_values.get(sec, 0.0) + h["current_value"]
            
        sector_weightings = {}
        if total_market_value > 0:
            for sec, val in sector_values.items():
                sector_weightings[sec] = (val / total_market_value) * 100.0
                
        portfolio_data = {
            "balances": {
                "india": balances.get("india", STARTING_BALANCE),
                "usa": balances.get("usa", STARTING_BALANCE),
                "uk": balances.get("uk", STARTING_BALANCE),
            },
            "statistics": {
                "total_invested_value": total_invested_value,
                "total_market_value": total_market_value,
                "overall_pnl": overall_pnl,
                "overall_pnl_percent": overall_pnl_percent
            },
            "sector_weightings": sector_weightings,
            "holdings": holdings
        }
        
        if not client:
            return {
                "overall_score": 0,
                "summary": "AI Portfolio Reviewer is currently unavailable (no Gemini API key set).",
                "strengths": [],
                "weaknesses": ["AI feedback service offline."],
                "recommendations": ["Configure GEMINI_API_KEY environment variable."]
            }

        prompt = f"Please review the following portfolio:\n{json.dumps(portfolio_data, indent=2)}"
        
        # 3. Call LLM
        try:
            response = client.models.generate_content(
                model="gemini-2.5-flash",
                contents=[SYSTEM_PROMPT, prompt],
                config=generation_config,
            )
            content = response.text.strip()
            if content.startswith("```json"):
                content = content[7:]
            elif content.startswith("```"):
                content = content[3:]
            if content.endswith("```"):
                content = content[:-3]
            content = content.strip()
            
            parsed_data = json.loads(content)
            
            # 4. Save to Cache indefinitely (until invalidated by a trade)
            try:
                await redis_client.set(cache_key, json.dumps(parsed_data))
            except Exception as e:
                logger.error(f"Failed to cache review: {e}")
                
            return parsed_data
            
        except Exception as e:
            logger.error(f"Error generating AI review: {e}")
            return {
                "overall_score": 0,
                "summary": "Failed to generate AI review at this time. Please try again later.",
                "strengths": [],
                "weaknesses": [],
                "recommendations": ["Contact support if the issue persists."]
            }
    finally:
        pass

