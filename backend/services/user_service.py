import random
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from db.models import DbUser, DbUserBalance

async def generate_unique_username(db: AsyncSession, uid: str) -> str:
    """
    Auto-generates a unique username using 'Trader_<first_6_chars_of_uid>'.
    If a collision occurs, appends a random two-digit suffix.
    """
    base = f"Trader_{uid[:6]}"
    stmt = select(DbUser).where(DbUser.username == base)
    result = await db.execute(stmt)
    if not result.scalar_one_or_none():
        return base

    # Handle extremely rare collision cases
    while True:
        candidate = f"Trader_{uid[:6]}_{random.randint(10, 99)}"
        stmt = select(DbUser).where(DbUser.username == candidate)
        res = await db.execute(stmt)
        if not res.scalar_one_or_none():
            return candidate

async def get_or_create_user(db: AsyncSession, firebase_uid: str, username: str = None, starting_balance: float = 10000.0) -> DbUser:
    """
    Retrieves a user by firebase_uid or creates them with the provided/generated unique username and starting balances.
    """
    stmt = select(DbUser).where(DbUser.firebase_uid == firebase_uid)
    result = await db.execute(stmt)
    user = result.scalar_one_or_none()
    
    if not user:
        if not username:
            username = await generate_unique_username(db, firebase_uid)
        else:
            # Check if the requested username is already taken
            taken_stmt = select(DbUser).where(DbUser.username == username)
            taken_res = await db.execute(taken_stmt)
            if taken_res.scalar_one_or_none() is not None:
                # If taken, generate a unique one as a fallback
                username = await generate_unique_username(db, firebase_uid)
                
        user = DbUser(
            firebase_uid=firebase_uid,
            email=None,
            username=username
        )
        db.add(user)
        await db.flush()  # Populate firebase_uid
        
        # Create starting balances for standard markets
        for market in ["india", "usa", "uk"]:
            balance = DbUserBalance(
                firebase_uid=firebase_uid,
                market=market,
                balance=starting_balance
            )
            db.add(balance)
        await db.flush()
        
    return user
