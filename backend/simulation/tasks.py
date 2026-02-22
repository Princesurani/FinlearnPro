import os
from celery import Celery
import asyncio
import json
import random
from datetime import datetime, timezone
import redis
from simulation.news_engine import NewsEngine, MarketContext


# Use the redis container hostname from docker-compose
REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379/0")

celery_app = Celery(
    "market_worker",
    broker=REDIS_URL,
    backend=REDIS_URL
)

celery_app.conf.update(
    task_serializer='json',
    accept_content=['json'],
    result_serializer='json',
    timezone='UTC',
    enable_utc=True,
)

# Mock set of instruments to simulate initially
MOCK_INSTRUMENTS = [
    # Indices
    {"symbol": "NIFTY 50", "price": 21495.70, "volatility": 0.15, "drift": 0.08},
    {"symbol": "BANKNIFTY", "price": 47854.20, "volatility": 0.22, "drift": 0.10},
    {"symbol": "SENSEX", "price": 71350.50, "volatility": 0.14, "drift": 0.08},
    {"symbol": "NIFTY IT", "price": 35240.10, "volatility": 0.20, "drift": 0.12},
    
    # Stocks
    {"symbol": "RELIANCE", "price": 2580.40, "volatility": 0.18, "drift": 0.10},
    {"symbol": "TCS", "price": 3820.10, "volatility": 0.15, "drift": 0.09},
    {"symbol": "HDFCBANK", "price": 1680.90, "volatility": 0.18, "drift": 0.11},
    {"symbol": "INFY", "price": 1540.25, "volatility": 0.22, "drift": 0.12},
    {"symbol": "ICICIBANK", "price": 1020.50, "volatility": 0.20, "drift": 0.14},
    {"symbol": "SBIN", "price": 635.80, "volatility": 0.25, "drift": 0.15},
    {"symbol": "BHARTIARTL", "price": 1030.40, "volatility": 0.21, "drift": 0.08},
    {"symbol": "ITC", "price": 465.20, "volatility": 0.12, "drift": 0.05},
    {"symbol": "L&T", "price": 3450.60, "volatility": 0.23, "drift": 0.13},
    {"symbol": "TATASTEEL", "price": 132.40, "volatility": 0.28, "drift": 0.04},

    # USA 
    {"symbol": "S&P 500", "price": 4780.20, "volatility": 0.12, "drift": 0.08},
    {"symbol": "NASDAQ", "price": 15200.50, "volatility": 0.18, "drift": 0.10},
    {"symbol": "DOW JONES", "price": 37600.40, "volatility": 0.10, "drift": 0.06},
    {"symbol": "RUSSELL 2000", "price": 1980.20, "volatility": 0.16, "drift": 0.08},
    {"symbol": "AAPL", "price": 192.50, "volatility": 0.15, "drift": 0.08},
    {"symbol": "MSFT", "price": 390.20, "volatility": 0.14, "drift": 0.10},
    {"symbol": "NVDA", "price": 540.80, "volatility": 0.30, "drift": 0.20},
    {"symbol": "TSLA", "price": 240.50, "volatility": 0.40, "drift": 0.15},
    {"symbol": "AMZN", "price": 155.20, "volatility": 0.20, "drift": 0.12},
    {"symbol": "META", "price": 360.40, "volatility": 0.25, "drift": 0.15},
    {"symbol": "GOOGL", "price": 140.80, "volatility": 0.18, "drift": 0.10},
    {"symbol": "BRK.B", "price": 360.20, "volatility": 0.10, "drift": 0.06},
    {"symbol": "JPM", "price": 170.50, "volatility": 0.14, "drift": 0.08},
    {"symbol": "JNJ", "price": 158.40, "volatility": 0.10, "drift": 0.05},

    # UK
    {"symbol": "FTSE 100", "price": 7680.50, "volatility": 0.12, "drift": 0.05},
    {"symbol": "FTSE 250", "price": 19200.40, "volatility": 0.15, "drift": 0.06},
    {"symbol": "FTSE AIM 100", "price": 3800.20, "volatility": 0.20, "drift": 0.08},
    {"symbol": "FTSE techMARK", "price": 4500.80, "volatility": 0.18, "drift": 0.10},
    {"symbol": "SHEL", "price": 2500.40, "volatility": 0.14, "drift": 0.06},
    {"symbol": "AZN", "price": 10800.50, "volatility": 0.16, "drift": 0.08},
    {"symbol": "HSBA", "price": 630.20, "volatility": 0.12, "drift": 0.05},
    {"symbol": "ULVR", "price": 3800.40, "volatility": 0.10, "drift": 0.04},
    {"symbol": "BP", "price": 480.50, "volatility": 0.16, "drift": 0.06},
    {"symbol": "GSK", "price": 1500.20, "volatility": 0.14, "drift": 0.05},
    {"symbol": "BATS", "price": 2300.80, "volatility": 0.12, "drift": 0.04},
    {"symbol": "RIO", "price": 5400.40, "volatility": 0.20, "drift": 0.08},
    {"symbol": "DGE", "price": 2800.50, "volatility": 0.12, "drift": 0.05},
    {"symbol": "GLEN", "price": 460.20, "volatility": 0.22, "drift": 0.09},

    # Crypto
    {"symbol": "BTC", "price": 43000.50, "volatility": 0.45, "drift": 0.15},
    {"symbol": "ETH", "price": 2300.20, "volatility": 0.55, "drift": 0.20},
    {"symbol": "USDT", "price": 1.00, "volatility": 0.01, "drift": 0.0},
    {"symbol": "BNB", "price": 310.40, "volatility": 0.50, "drift": 0.15},
    {"symbol": "SOL", "price": 105.80, "volatility": 0.70, "drift": 0.25},
    {"symbol": "XRP", "price": 0.55, "volatility": 0.60, "drift": 0.10},
    {"symbol": "USDC", "price": 1.00, "volatility": 0.01, "drift": 0.0},
    {"symbol": "ADA", "price": 0.52, "volatility": 0.65, "drift": 0.15},
    {"symbol": "AVAX", "price": 35.40, "volatility": 0.75, "drift": 0.20},
    {"symbol": "DOGE", "price": 0.08, "volatility": 0.80, "drift": 0.10},
]

@celery_app.task
def simulate_tick_loop():
    """
    Background job meant to run continuously, generating new price ticks 
    for all active instruments and publishing them to Redis Pub/Sub channels.
    """
    from simulation.price_engine import GBMPriceModel
    
    # Initialize engines
    engines = {}
    for inst in MOCK_INSTRUMENTS:
        engines[inst["symbol"]] = GBMPriceModel(
            initial_price=inst["price"],
            drift=inst["drift"],
            volatility=inst["volatility"]
        )
    
    r = redis.from_url(REDIS_URL)
    news_engine = NewsEngine()
    context = MarketContext(sentiment="neutral")

    # In a real daemon, this would be an infinite loop `while True:`
    while True:
        # 1. Possibly Generate News
        news_event = news_engine.generate_news_event(
            context=context,
            active_symbols=[inst["symbol"] for inst in MOCK_INSTRUMENTS],
            active_sectors=["technology", "crypto"]
        )
        
        if news_event:
            # Publish headline to clients
            r.publish("market:news:global", json.dumps(news_event))
            
            # Apply shock to math model
            impact = news_event["impact"]
            if news_event["affected_scope"] == "global":
                for eng in engines.values():
                    eng.drift += (impact / 10) # Temporary drift baseline shift
                    eng.volatility *= 1.5      # Spike volatility on global news
            elif news_event["affected_scope"] == "symbol" and news_event["affected_symbols"]:
                for sym in news_event["affected_symbols"]:
                    if sym in engines:
                        engines[sym].price *= (1 + impact) # Immediate jump
                        engines[sym].volatility *= 2.0     # Elevated volatility post-event
        
        # 2. Tick Generation
        for symbol, engine in engines.items():
            inst_base = next(i for i in MOCK_INSTRUMENTS if i["symbol"] == symbol)
            new_price = engine.generate_next_price()
            
            # Create the Tick structure
            bid = new_price * 0.9995
            ask = new_price * 1.0005
            
            tick = {
                "symbol": symbol,
                "timestamp": datetime.now(timezone.utc).isoformat(),
                "price": new_price,
                "bid": bid,
                "ask": ask,
                "volume": random.uniform(10, 1000),
                "change": new_price - inst_base["price"], # mock relative to base
                "changePercent": ((new_price - inst_base["price"]) / inst_base["price"]) * 100
            }
            
            # Publish to redis for the WebSocket server
            r.publish(f"market:ticks:{symbol}", json.dumps(tick))
            r.publish("market:ticks:global", json.dumps(tick)) # Global feed
            
            # Save latest state for REST API
            snapshot = {
                "symbol": symbol,
                "name": symbol, 
                "price": new_price,
                "open": inst_base["price"], 
                "high": new_price * 1.05,
                "low": new_price * 0.95,
                "previousClose": inst_base["price"],
                "change": new_price - inst_base["price"],
                "changePercent": ((new_price - inst_base["price"]) / inst_base["price"]) * 100,
                "volume": tick["volume"],
                "timestamp": tick["timestamp"],
            }
            r.set(f"market:quote:{symbol}", json.dumps(snapshot))
            
        # 3. Mean Reversion of Volatility over time 
        for engine in engines.values():
            if engine.volatility > 0.30:
                engine.volatility *= 0.98  # Slowly decay spiked volatility back to normal
                
        # sleep slightly to mock real time
        import time
        time.sleep(random.uniform(0.5, 2.0))

