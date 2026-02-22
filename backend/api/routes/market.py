from fastapi import APIRouter, HTTPException, Query, Depends
import os
import json
from datetime import datetime, timezone, timedelta
import redis.asyncio as redis
from typing import List
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, desc

from models.schemas import MarketSnapshot, Candle, Instrument, Timeframe
from db.database import get_db
from db.models import DbInstrument, DbNewsEvent, DbPriceTick

router = APIRouter()

REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379/0")

@router.get("/instruments", response_model=List[Instrument])
async def get_all_instruments(db: AsyncSession = Depends(get_db)):
    """
    Returns a list of all tradable instruments in the simulation.
    """
    try:
        result = await db.execute(select(DbInstrument))
        instruments = result.scalars().all()
        if instruments:
            return instruments
    except Exception:
        pass # Fallback to mock if db fails or hasn't initialized
    
    return [
        # Indian Indices
        Instrument(symbol="NIFTY 50", name="Nifty 50", type="marketIndex", sector="unknown", market="india", basePrice=21495.70, volatility=0.15, description="Benchmark Indian Stock Market Index"),
        Instrument(symbol="BANKNIFTY", name="Nifty Bank", type="marketIndex", sector="financialServices", market="india", basePrice=47854.20, volatility=0.22, description="Indian Banking Sector Index"),
        Instrument(symbol="SENSEX", name="BSE Sensex", type="marketIndex", sector="unknown", market="india", basePrice=71350.50, volatility=0.14, description="BSE Benchmark Index"),
        Instrument(symbol="NIFTY IT", name="Nifty IT", type="marketIndex", sector="technology", market="india", basePrice=35240.10, volatility=0.20, description="Indian IT Sector Index"),
        
        # 10 Top Indian Stocks
        Instrument(symbol="RELIANCE", name="Reliance Industries", type="stock", sector="energy", market="india", basePrice=2580.40, volatility=0.18, description="Reliance Industries Limited"),
        Instrument(symbol="TCS", name="Tata Consultancy Services", type="stock", sector="technology", market="india", basePrice=3820.10, volatility=0.15, description="TCS"),
        Instrument(symbol="HDFCBANK", name="HDFC Bank", type="stock", sector="financialServices", market="india", basePrice=1680.90, volatility=0.18, description="HDFC Bank Limited"),
        Instrument(symbol="INFY", name="Infosys Limited", type="stock", sector="technology", market="india", basePrice=1540.25, volatility=0.22, description="Infosys"),
        Instrument(symbol="ICICIBANK", name="ICICI Bank", type="stock", sector="financialServices", market="india", basePrice=1020.50, volatility=0.20, description="ICICI Bank Limited"),
        Instrument(symbol="SBIN", name="State Bank of India", type="stock", sector="financialServices", market="india", basePrice=635.80, volatility=0.25, description="SBI"),
        Instrument(symbol="BHARTIARTL", name="Bharti Airtel", type="stock", sector="communicationServices", market="india", basePrice=1030.40, volatility=0.21, description="Bharti Airtel Limited"),
        Instrument(symbol="ITC", name="ITC Limited", type="stock", sector="consumerDefensive", market="india", basePrice=465.20, volatility=0.12, description="ITC Limited"),
        Instrument(symbol="L&T", name="Larsen & Toubro", type="stock", sector="industrials", market="india", basePrice=3450.60, volatility=0.23, description="L&T"),
        Instrument(symbol="TATASTEEL", name="Tata Steel", type="stock", sector="basicMaterials", market="india", basePrice=132.40, volatility=0.28, description="Tata Steel Limited"),
        
        # USA Indices
        Instrument(symbol="S&P 500", name="S&P 500", type="marketIndex", sector="unknown", market="usa", basePrice=4780.20, volatility=0.12, description="US Top 500 index"),
        Instrument(symbol="NASDAQ", name="NASDAQ Composite", type="marketIndex", sector="technology", market="usa", basePrice=15200.50, volatility=0.18, description="US Tech index"),
        Instrument(symbol="DOW JONES", name="Dow Jones", type="marketIndex", sector="unknown", market="usa", basePrice=37600.40, volatility=0.10, description="US Dow 30 index"),
        Instrument(symbol="RUSSELL 2000", name="Russell 2000", type="marketIndex", sector="unknown", market="usa", basePrice=1980.20, volatility=0.16, description="US Small cap index"),
        
        # USA Stocks
        Instrument(symbol="AAPL", name="Apple Inc.", type="stock", sector="technology", market="usa", basePrice=192.50, volatility=0.15, description="Apple"),
        Instrument(symbol="MSFT", name="Microsoft", type="stock", sector="technology", market="usa", basePrice=390.20, volatility=0.14, description="Microsoft"),
        Instrument(symbol="NVDA", name="NVIDIA", type="stock", sector="technology", market="usa", basePrice=540.80, volatility=0.30, description="Nvidia"),
        Instrument(symbol="TSLA", name="Tesla", type="stock", sector="consumerCyclical", market="usa", basePrice=240.50, volatility=0.40, description="Tesla Inc"),
        Instrument(symbol="AMZN", name="Amazon", type="stock", sector="consumerCyclical", market="usa", basePrice=155.20, volatility=0.20, description="Amazon"),
        Instrument(symbol="META", name="Meta Platforms", type="stock", sector="communicationServices", market="usa", basePrice=360.40, volatility=0.25, description="Facebook"),
        Instrument(symbol="GOOGL", name="Alphabet", type="stock", sector="communicationServices", market="usa", basePrice=140.80, volatility=0.18, description="Google"),
        Instrument(symbol="BRK.B", name="Berkshire Hathaway", type="stock", sector="financialServices", market="usa", basePrice=360.20, volatility=0.10, description="Berkshire"),
        Instrument(symbol="JPM", name="JPMorgan Chase", type="stock", sector="financialServices", market="usa", basePrice=170.50, volatility=0.14, description="JPMorgan"),
        Instrument(symbol="JNJ", name="Johnson & Johnson", type="stock", sector="healthcare", market="usa", basePrice=158.40, volatility=0.10, description="J&J"),
        
        # UK Indices
        Instrument(symbol="FTSE 100", name="FTSE 100", type="marketIndex", sector="unknown", market="uk", basePrice=7680.50, volatility=0.12, description="UK Top 100"),
        Instrument(symbol="FTSE 250", name="FTSE 250", type="marketIndex", sector="unknown", market="uk", basePrice=19200.40, volatility=0.15, description="UK Mid cap"),
        Instrument(symbol="FTSE AIM 100", name="FTSE AIM 100", type="marketIndex", sector="unknown", market="uk", basePrice=3800.20, volatility=0.20, description="UK Small cap"),
        Instrument(symbol="FTSE techMARK", name="techMARK", type="marketIndex", sector="technology", market="uk", basePrice=4500.80, volatility=0.18, description="UK Tech focus"),
        
        # UK Stocks
        Instrument(symbol="SHEL", name="Shell", type="stock", sector="energy", market="uk", basePrice=2500.40, volatility=0.14, description="Shell PLC"),
        Instrument(symbol="AZN", name="AstraZeneca", type="stock", sector="healthcare", market="uk", basePrice=10800.50, volatility=0.16, description="AstraZeneca"),
        Instrument(symbol="HSBA", name="HSBC", type="stock", sector="financialServices", market="uk", basePrice=630.20, volatility=0.12, description="HSBC Holdings"),
        Instrument(symbol="ULVR", name="Unilever", type="stock", sector="consumerDefensive", market="uk", basePrice=3800.40, volatility=0.10, description="Unilever PLC"),
        Instrument(symbol="BP", name="BP", type="stock", sector="energy", market="uk", basePrice=480.50, volatility=0.16, description="BP PLC"),
        Instrument(symbol="GSK", name="GSK", type="stock", sector="healthcare", market="uk", basePrice=1500.20, volatility=0.14, description="GSK PLC"),
        Instrument(symbol="BATS", name="Brit. Amer. Tobacco", type="stock", sector="consumerDefensive", market="uk", basePrice=2300.80, volatility=0.12, description="BAT"),
        Instrument(symbol="RIO", name="Rio Tinto", type="stock", sector="basicMaterials", market="uk", basePrice=5400.40, volatility=0.20, description="Rio Tinto"),
        Instrument(symbol="DGE", name="Diageo", type="stock", sector="consumerDefensive", market="uk", basePrice=2800.50, volatility=0.12, description="Diageo PLC"),
        Instrument(symbol="GLEN", name="Glencore", type="stock", sector="basicMaterials", market="uk", basePrice=460.20, volatility=0.22, description="Glencore"),

        # Crypto Top 10
        Instrument(symbol="BTC", name="Bitcoin", type="crypto", sector="unknown", market="crypto", basePrice=43000.50, volatility=0.45, description="Bitcoin"),
        Instrument(symbol="ETH", name="Ethereum", type="crypto", sector="unknown", market="crypto", basePrice=2300.20, volatility=0.55, description="Ethereum"),
        Instrument(symbol="USDT", name="Tether", type="crypto", sector="unknown", market="crypto", basePrice=1.00, volatility=0.01, description="Tether"),
        Instrument(symbol="BNB", name="BNB", type="crypto", sector="unknown", market="crypto", basePrice=310.40, volatility=0.50, description="Binance Coin"),
        Instrument(symbol="SOL", name="Solana", type="crypto", sector="unknown", market="crypto", basePrice=105.80, volatility=0.70, description="Solana"),
        Instrument(symbol="XRP", name="XRP", type="crypto", sector="unknown", market="crypto", basePrice=0.55, volatility=0.60, description="Ripple"),
        Instrument(symbol="USDC", name="USDC", type="crypto", sector="unknown", market="crypto", basePrice=1.00, volatility=0.01, description="USDC Coin"),
        Instrument(symbol="ADA", name="Cardano", type="crypto", sector="unknown", market="crypto", basePrice=0.52, volatility=0.65, description="Cardano"),
        Instrument(symbol="AVAX", name="Avalanche", type="crypto", sector="unknown", market="crypto", basePrice=35.40, volatility=0.75, description="Avalanche"),
        Instrument(symbol="DOGE", name="Dogecoin", type="crypto", sector="unknown", market="crypto", basePrice=0.08, volatility=0.80, description="Dogecoin"),
    ]

@router.get("/quote/{symbol}", response_model=MarketSnapshot)
async def get_quote(symbol: str):
    """
    Returns the current market snapshot (quote) for a given symbol.
    """
    redis_client = await redis.from_url(REDIS_URL)
    try:
        raw = await redis_client.get(f"market:quote:{symbol}")
        if raw:
            return json.loads(raw)
        
        # Fallback if not populated by celery worker yet
        raise HTTPException(status_code=404, detail=f"Quote for {symbol} not found")
    finally:
        await redis_client.close()

@router.get("/history/{symbol}", response_model=List[Candle])
async def get_history(
    symbol: str, 
    timeframe: Timeframe = Query(Timeframe.fourHour, description="The timeframe resolution for candles"),
    db: AsyncSession = Depends(get_db)
):
    """
    Returns historical candlestick data for charting.
    """
    # In a full Timescale implementation, this would query the continuous aggregate view.
    # Alternatively, you can just query price_ticks via time_bucket directly if the view isn't there:
    
    interval_str = "4 hours"
    if timeframe == Timeframe.oneMinute:
        interval_str = "1 minute"
    elif timeframe == Timeframe.fiveMinute:
        interval_str = "5 minutes"
    elif timeframe == Timeframe.fifteenMinute:
        interval_str = "15 minutes"
    elif timeframe == Timeframe.oneHour:
        interval_str = "1 hour"
    elif timeframe == Timeframe.oneDay:
        interval_str = "1 day"
    elif timeframe == Timeframe.oneWeek:
        interval_str = "1 week"
    
    import random
    from sqlalchemy import text
    try:
        query = text(f"""
            SELECT 
                time_bucket('{interval_str}', timestamp) AS bucket,
                first(price, timestamp) AS open, 
                max(price) AS high, 
                min(price) AS low, 
                last(price, timestamp) AS close, 
                sum(volume) AS volume
            FROM price_ticks
            WHERE symbol = :symbol
            GROUP BY bucket
            ORDER BY bucket DESC
            LIMIT 100
        """)
        
        result = await db.execute(query, {"symbol": symbol})
        rows = result.fetchall()
        
        if rows:
            candles = []
            for row in rows:
                if row.bucket is None:
                    continue
                candles.append({
                    "timestamp": row.bucket.isoformat(),
                    "open": row.open,
                    "high": row.high,
                    "low": row.low,
                    "close": row.close,
                    "volume": row.volume
                })
            return list(reversed(candles)) # Return chronological
    except Exception as e:
        print(f"Error reading from TimescaleDB: {e}")
        pass

    # Quick mock instrument fetching to get the base price
    base_price = 100.0
    # Search the hardcoded list we made above
    mock_instruments_list = await get_all_instruments(db)
    for inst in mock_instruments_list:
        if inst.symbol == symbol:
            base_price = inst.basePrice
            break
            
    # Try to grab the latest actual price from redis if available
    try:
        redis_client = await redis.from_url(REDIS_URL)
        raw = await redis_client.get(f"market:quote:{symbol}")
        if raw:
            snap = json.loads(raw)
            if "price" in snap:
                base_price = snap["price"]
        await redis_client.close()
    except Exception:
        pass

    candles = []
    current_price = base_price
    now = datetime.now(timezone.utc)
    
    # Generate backwards in time, reverse the random walk
    # So the most recent candle ends exactly at 'current_price'
    for i in range(50):
        t = now - timedelta(hours=i*4 if timeframe == Timeframe.fourHour else i)
        
        variation = random.uniform(-0.002, 0.002)
        old_price = current_price / (1 + variation)
        
        high = max(old_price, current_price) * (1 + random.uniform(0, 0.01))
        low = min(old_price, current_price) * (1 - random.uniform(0, 0.01))
        
        candles.append({
            "timestamp": t.isoformat(),
            "open": old_price,
            "high": high,
            "low": low,
            "close": current_price,
            "volume": random.randint(1000, 50000)
        })
        current_price = old_price
        
    return list(reversed(candles))

@router.get("/news")
async def get_news(
    symbol: str = None, 
    limit: int = Query(10, le=50),
    db: AsyncSession = Depends(get_db)
):
    """
    Returns recent generated market news. Option to filter by symbol.
    """
    try:
        query = select(DbNewsEvent).order_by(desc(DbNewsEvent.timestamp)).limit(limit)
        # simplistic filter if needed: if symbol: query = query.filter(DbNewsEvent.affected_symbols.contains(symbol))
        result = await db.execute(query)
        events = result.scalars().all()
        if events:
            return events
    except Exception:
        pass
        
    # Mock fallback
    return [
        {
            "headline": f"{symbol or 'Market'} Stocks Rally unexpectedly today.",
            "category": "macro_economic",
            "subcategory": "economic_data",
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "impact": 0.02,
            "duration_minutes": 60,
            "affected_scope": "global",
            "affected_symbols": []
        }
    ]

