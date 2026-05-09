import os
import json
import redis.asyncio as aioredis
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from datetime import datetime
from pydantic import BaseModel

from db.database import get_db
from db.models import DbOrder, DbTrade, DbPortfolioPosition, DbUser

REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379/0")
STARTING_BALANCE = 10_000.0  # ₹10,000 paper trading balance

router = APIRouter()


class OrderRequest(BaseModel):
    firebase_uid: str
    symbol: str
    side: str           # "buy" or "sell"
    quantity: int
    market: str
    order_type: str = "market"


@router.post("/place")
async def place_order(order_req: OrderRequest, db: AsyncSession = Depends(get_db)):
    """
    Execute a market order against the live Redis quote price.
    Atomically updates user balance and portfolio position.
    """
    if order_req.quantity <= 0:
        raise HTTPException(status_code=400, detail="Quantity must be greater than 0")

    # 1. Fetch live price from Redis (key written by simulation/tasks.py)
    r = aioredis.from_url(REDIS_URL)
    try:
        raw_data = await r.get(f"market:quote:{order_req.symbol}")
    finally:
        await r.aclose()

    if not raw_data:
        raise HTTPException(
            status_code=400,
            detail=f"Market data unavailable for {order_req.symbol}. Is the simulation running?"
        )

    quote = json.loads(raw_data)
    current_price: float = quote.get("price")
    if not current_price:
        raise HTTPException(status_code=400, detail="Could not parse current price from Redis")

    total_value = current_price * order_req.quantity

    # 2. Get or auto-create user with 10k paper trading starting balance across markets
    result = await db.execute(select(DbUser).where(DbUser.firebase_uid == order_req.firebase_uid))
    user = result.scalar_one_or_none()
    if not user:
        user = DbUser(
            firebase_uid=order_req.firebase_uid, 
            email=None, 
            balance_india=STARTING_BALANCE,
            balance_usa=STARTING_BALANCE,
            balance_uk=STARTING_BALANCE
        )
        db.add(user)
        await db.flush()

    # 3. Get or create portfolio position for this symbol
    pos_result = await db.execute(
        select(DbPortfolioPosition).where(
            DbPortfolioPosition.firebase_uid == order_req.firebase_uid,
            DbPortfolioPosition.symbol == order_req.symbol
        )
    )
    position = pos_result.scalar_one_or_none()

    if not position:
        position = DbPortfolioPosition(
            firebase_uid=order_req.firebase_uid,
            symbol=order_req.symbol,
            quantity=0,
            average_cost=0.0,
        )
        db.add(position)
        await db.flush()

    # 4. Apply buy / sell logic against specific market balance
    side = order_req.side.lower()
    
    market_attr = f"balance_{order_req.market}"
    current_balance = getattr(user, market_attr, None)
    
    if current_balance is None: # fallback
        market_attr = "balance_india"
        current_balance = user.balance_india

    if side == "buy":
        if current_balance < total_value:
            raise HTTPException(
                status_code=400,
                detail=f"Insufficient funds. Balance: {current_balance:.2f}, Cost: {total_value:.2f}"
            )
        # Weighted average cost
        new_total_cost = (position.quantity * position.average_cost) + total_value
        position.quantity += order_req.quantity
        position.average_cost = new_total_cost / position.quantity
        setattr(user, market_attr, current_balance - total_value)

    elif side == "sell":
        if position.quantity < order_req.quantity:
            raise HTTPException(
                status_code=400,
                detail=f"Insufficient shares. Held: {position.quantity}, Requested: {order_req.quantity}"
            )
        position.quantity -= order_req.quantity
        setattr(user, market_attr, current_balance + total_value)
        if position.quantity == 0:
            position.average_cost = 0.0

    else:
        raise HTTPException(status_code=400, detail="side must be 'buy' or 'sell'")

    # 5. Write order + trade records
    order = DbOrder(
        firebase_uid=order_req.firebase_uid,
        symbol=order_req.symbol,
        side=side,
        order_type=order_req.order_type,
        quantity=order_req.quantity,
        status="filled",
        filled_at=datetime.utcnow(),
    )
    db.add(order)
    await db.flush()  # populate order.id before trade

    trade = DbTrade(
        order_id=order.id,
        firebase_uid=order_req.firebase_uid,
        symbol=order_req.symbol,
        side=side,
        quantity=order_req.quantity,
        price=current_price,
    )
    db.add(trade)

    # 6. Award XP and update profile stats
    from db.models import DbUserProfile
    from api.routes.social import calculate_level
    
    prof_result = await db.execute(select(DbUserProfile).where(DbUserProfile.firebase_uid == order_req.firebase_uid))
    profile = prof_result.scalar_one_or_none()
    
    xp_awarded = 15
    if profile:
        profile.total_xp += xp_awarded
        profile.weekly_xp += xp_awarded
        profile.level = calculate_level(profile.total_xp)
        profile.total_trades += 1
        
        # Simple win_rate update if it's a sell (naive approach)
        if side == "sell" and position.average_cost > 0:
            is_win = current_price > position.average_cost
            total_sells = profile.total_trades // 2 # Rough estimate
            if total_sells == 0: total_sells = 1
            wins = profile.win_rate * (total_sells - 1) + (1 if is_win else 0)
            profile.win_rate = wins / total_sells
    else:
        new_prof = DbUserProfile(
            firebase_uid=order_req.firebase_uid,
            total_xp=xp_awarded,
            weekly_xp=xp_awarded,
            level=calculate_level(xp_awarded),
            total_trades=1
        )
        db.add(new_prof)

    await db.commit()

    return {
        "status": "success",
        "message": f"Successfully {side} {order_req.quantity} shares of {order_req.symbol}",
        "fill_price": current_price,
        "total_value": total_value,
        "new_balance": getattr(user, market_attr),
    }
