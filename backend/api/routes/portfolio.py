from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, desc

from db.database import get_db
from db.models import DbPortfolioPosition, DbUser, DbOrder, DbTrade, DbWatchlist

router = APIRouter()

STARTING_BALANCE = 10_000.0  # ₹10,000 paper trading balance


@router.get("/positions/{firebase_uid}")
async def get_portfolio_positions(firebase_uid: str, db: AsyncSession = Depends(get_db)):
    """
    Fetch all current holdings for a specific user.
    Auto-creates the user record with ₹10,000 if they don't exist yet.
    """
    # Get or create user
    result = await db.execute(select(DbUser).where(DbUser.firebase_uid == firebase_uid))
    user = result.scalar_one_or_none()

    if not user:
        user = DbUser(
            firebase_uid=firebase_uid,
            email=None,  # Email is optional — set by Firebase later
            balance_india=STARTING_BALANCE,
            balance_usa=STARTING_BALANCE,
            balance_uk=STARTING_BALANCE,
            balance_crypto=STARTING_BALANCE,
        )
        db.add(user)
        await db.commit()
        await db.refresh(user)

    # Get positions — will be empty for new users
    pos_result = await db.execute(
        select(DbPortfolioPosition).where(DbPortfolioPosition.firebase_uid == firebase_uid)
    )
    positions = pos_result.scalars().all()

    return {
        "balances": {
            "india": user.balance_india,
            "usa": user.balance_usa,
            "uk": user.balance_uk,
            "crypto": user.balance_crypto,
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
    # Auto-create user if needed
    result = await db.execute(select(DbUser).where(DbUser.firebase_uid == firebase_uid))
    user = result.scalar_one_or_none()
    if not user:
        user = DbUser(firebase_uid=firebase_uid, email=None, balance=10_000.0)
        db.add(user)
        await db.flush()

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
