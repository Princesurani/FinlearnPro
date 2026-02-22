import asyncio
import os
import random
from datetime import datetime, timezone, timedelta
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text
from db.database import init_db, DB_URL
from db.models import DbPriceTick
from simulation.tasks import MOCK_INSTRUMENTS

async def seed():
    print("Initializing Database tables...")
    await init_db()

    engine = create_async_engine(DB_URL, echo=False)
    
    async with engine.begin() as conn:
        print("Converting price_ticks to hypertable...")
        try:
            await conn.execute(text("SELECT create_hypertable('price_ticks', by_range('timestamp'), migrate_data => true, if_not_exists => true);"))
        except Exception as e:
            print(f"Hypertable already exists or error: {e}")

    async with engine.begin() as conn:
        print("Creating materialized candle views...")
        try:
            candle_sql = """
            CREATE MATERIALIZED VIEW IF NOT EXISTS candle_1m WITH (timescaledb.continuous) AS
            SELECT 
                time_bucket('1 minute', timestamp) AS bucket,
                symbol, 
                first(price, timestamp) AS open, 
                max(price) AS high, 
                min(price) AS low, 
                last(price, timestamp) AS close, 
                sum(volume) AS volume
            FROM price_ticks 
            GROUP BY bucket, symbol;
            """
            await conn.execute(text(candle_sql))
        except Exception as e:
            print(f"Candle 1m error: {e}")

    async with engine.begin() as conn:
        try:    
            candle_sql_1h = """
            CREATE MATERIALIZED VIEW IF NOT EXISTS candle_1h WITH (timescaledb.continuous) AS
            SELECT 
                time_bucket('1 hour', timestamp) AS bucket,
                symbol, 
                first(price, timestamp) AS open, 
                max(price) AS high, 
                min(price) AS low, 
                last(price, timestamp) AS close, 
                sum(volume) AS volume
            FROM price_ticks 
            GROUP BY bucket, symbol;
            """
            await conn.execute(text(candle_sql_1h))
        except Exception as e:
            print(f"View creation error (safe to ignore if exists): {e}")

    async with engine.connect() as conn:
        res = await conn.execute(text("SELECT COUNT(*) FROM price_ticks"))
        count = res.scalar()
        if count > 50000:
            print(f"Database already seeded with {count} ticks. Skipping generation.")
            return
            
        print("Inserting Instruments...")
        for inst in MOCK_INSTRUMENTS:
            try:
                await conn.execute(
                    text("""
                    INSERT INTO instruments (symbol, name, type, sector, market, base_price, volatility, description)
                    VALUES (:symbol, :symbol, 'stock', 'unknown', 'unknown', :base_price, :volatility, '')
                    ON CONFLICT (symbol) DO NOTHING;
                    """),
                    {"symbol": inst["symbol"], "base_price": inst["price"], "volatility": inst["volatility"]}
                )
            except Exception as e:
                pass

        print("Generating historical ticks for 5 days...")
        now = datetime.now(timezone.utc)
        
        # We will generate 1-minute intervals for 5 days = 7200 points per instrument
        for inst in MOCK_INSTRUMENTS:
            print(f"Processing {inst['symbol']}...")
            
            prices = []
            curr_price = inst["price"]
            
            for i in range(5 * 24 * 60):
                t = now - timedelta(minutes=i)
                dt = 1 / 252 / 390
                vol = inst["volatility"]
                drift = inst["drift"]
                dW = random.gauss(0, (dt)**0.5)
                ret = drift * dt + vol * dW
                curr_price = curr_price / (1 + ret)
                curr_price = max(curr_price, 0.01)
                
                bid = curr_price * 0.9995
                ask = curr_price * 1.0005
                vol_amt = random.uniform(10, 5000)
                
                prices.append({
                    "symbol": inst["symbol"],
                    "timestamp": t,
                    "price": curr_price,
                    "bid": bid,
                    "ask": ask,
                    "volume": vol_amt
                })
            
            # insert in batches of 2000
            for i in range(0, len(prices), 2000):
                batch = prices[i:i+2000]
                await conn.execute(
                    text("""
                    INSERT INTO price_ticks (symbol, timestamp, price, bid, ask, volume)
                    VALUES (:symbol, :timestamp, :price, :bid, :ask, :volume)
                    """),
                    batch
                )

    # Refresh continuous aggregates
    async with engine.begin() as conn:
        print("Refreshing materialized views...")
        try:
            await conn.execute(text("CALL refresh_continuous_aggregate('candle_1m', '2000-01-01', '2100-01-01');"))
            await conn.execute(text("CALL refresh_continuous_aggregate('candle_1h', '2000-01-01', '2100-01-01');"))
        except Exception as e:
            print(f"Error refreshing aggregates: {e}")

    print("Seeding Complete!")

if __name__ == "__main__":
    asyncio.run(seed())
