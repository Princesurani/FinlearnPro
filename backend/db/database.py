import os
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy.orm import declarative_base

# The docker compose sets DATABASE_URL to postgresql://...
# We need to change the scheme to postgresql+asyncpg:// for async access.
DB_URL = os.getenv("DATABASE_URL", "postgresql+asyncpg://market_user:market_pass@localhost:5432/market_sim")
if DB_URL.startswith("postgresql://"):
    DB_URL = DB_URL.replace("postgresql://", "postgresql+asyncpg://", 1)

engine = create_async_engine(DB_URL, echo=False)
AsyncSessionLocal = async_sessionmaker(engine, expire_on_commit=False, class_=AsyncSession)

Base = declarative_base()

async def get_db():
    async with AsyncSessionLocal() as session:
        yield session

async def init_db():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
        
    # We must explicitly convert tables into TimescaleDB hyper tables where appropriate.
    # In a real production setup, we'd use Alembic migrations and raw SQL to run `SELECT create_hypertable('price_ticks', 'timestamp');`.
