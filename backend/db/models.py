from sqlalchemy import Column, Integer, String, Float, DateTime, Boolean, ForeignKey
from datetime import datetime, timezone
from db.database import Base

class DbInstrument(Base):
    __tablename__ = "instruments"
    
    symbol = Column(String(50), primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    type = Column(String(50), nullable=False)
    sector = Column(String(100), nullable=False)
    market = Column(String(50), nullable=False)
    base_price = Column(Float, nullable=False)
    volatility = Column(Float, nullable=False)
    description = Column(String)

class DbPriceTick(Base):
    """
    To be converted to a TimescaleDB Hypertable
    """
    __tablename__ = "price_ticks"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    symbol = Column(String(50), ForeignKey("instruments.symbol"), index=True, nullable=False)
    timestamp = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), index=True, nullable=False)
    price = Column(Float, nullable=False)
    bid = Column(Float, nullable=False)
    ask = Column(Float, nullable=False)
    volume = Column(Float, nullable=False)
    
class DbNewsEvent(Base):
    __tablename__ = "news_events"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    headline = Column(String(500), nullable=False)
    category = Column(String(100), nullable=False)
    subcategory = Column(String(100), nullable=False)
    timestamp = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), index=True)
    impact = Column(Float, nullable=False)
    duration_minutes = Column(Integer, nullable=False)
    affected_scope = Column(String(50), nullable=False)
    # A JSON string for simplicity, or could use postgres JSONB.
    affected_symbols = Column(String, nullable=True) 

# Note: Candles in TimescaleDB typically use Continuous Aggregates built precisely on top of the price_ticks table.
# E.g. 
# CREATE MATERIALIZED VIEW candle_1m WITH (timescaledb.continuous) AS
#   SELECT time_bucket('1 minute', timestamp) AS bucket,
#          symbol, first(price, timestamp) AS open, max(price) AS high, min(price) AS low, last(price, timestamp) AS close, sum(volume) AS volume
#   FROM price_ticks GROUP BY bucket, symbol;
