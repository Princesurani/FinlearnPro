import os
import json
from db.redis_client import get_redis_client
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from datetime import datetime
from pydantic import BaseModel

from db.database import get_db
from db.models import DbOrder, DbTrade, DbPortfolioPosition, DbUser, DbUserBalance
from services.user_service import get_or_create_user

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
    r = get_redis_client()
    raw_data = await r.get(f"market:quote:{order_req.symbol}")

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
    user = await get_or_create_user(db, order_req.firebase_uid, STARTING_BALANCE)

    # 3. Get user balance for the specific market
    bal_result = await db.execute(
        select(DbUserBalance).where(
            DbUserBalance.firebase_uid == order_req.firebase_uid,
            DbUserBalance.market == order_req.market
        )
    )
    user_balance = bal_result.scalar_one_or_none()
    if not user_balance:
        user_balance = DbUserBalance(
            firebase_uid=order_req.firebase_uid,
            market=order_req.market,
            balance=STARTING_BALANCE
        )
        db.add(user_balance)
        await db.flush()

    current_balance = user_balance.balance

    # 4. Get or create portfolio position for this symbol
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

    # 5. Apply buy / sell logic against specific market balance
    side = order_req.side.lower()

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
        user_balance.balance = current_balance - total_value

    elif side == "sell":
        if position.quantity < order_req.quantity:
            raise HTTPException(
                status_code=400,
                detail=f"Insufficient shares. Held: {position.quantity}, Requested: {order_req.quantity}"
            )
        position.quantity -= order_req.quantity
        user_balance.balance = current_balance + total_value
        if position.quantity == 0:
            position.average_cost = 0.0

    else:
        raise HTTPException(status_code=400, detail="side must be 'buy' or 'sell'")

    # 6. Write order + trade records
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

    # 7. Award XP and update stats directly on user (profile columns are merged)
    from api.routes.social import calculate_level
    
    xp_awarded = 15
    user.total_xp += xp_awarded
    user.weekly_xp += xp_awarded
    user.level = calculate_level(user.total_xp)
    user.total_trades += 1
    
    # Simple win_rate update if it's a sell (naive approach)
    if side == "sell" and position.average_cost > 0:
        is_win = current_price > position.average_cost
        total_sells = user.total_trades // 2 # Rough estimate
        if total_sells == 0: total_sells = 1
        wins = user.win_rate * (total_sells - 1) + (1 if is_win else 0)
        user.win_rate = wins / total_sells

    await db.commit()

    r_cache = get_redis_client()
    try:
        await r_cache.delete(f"portfolio:review:{order_req.firebase_uid}")
    except Exception:
        pass

    return {
        "status": "success",
        "message": f"Successfully {side} {order_req.quantity} shares of {order_req.symbol}",
        "fill_price": current_price,
        "total_value": total_value,
        "new_balance": user_balance.balance,
    }

