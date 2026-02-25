from sqlalchemy import Column, Integer, String, Float, DateTime, Boolean, ForeignKey, JSON, Date
from datetime import datetime, timezone, date
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
    timestamp = Column(DateTime(timezone=True), primary_key=True, default=lambda: datetime.now(timezone.utc), index=True, nullable=False)
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
    affected_symbols = Column(String, nullable=True) 

class DbUser(Base):
    __tablename__ = "users"
    
    # Using Firebase UID as primary key for Auth-as-a-Service architecture
    firebase_uid = Column(String(128), primary_key=True, index=True)
    email = Column(String(255), unique=True, index=True, nullable=True)
    balance_india = Column(Float, nullable=False, default=10000.0)
    balance_usa = Column(Float, nullable=False, default=10000.0)
    balance_uk = Column(Float, nullable=False, default=10000.0)
    balance_crypto = Column(Float, nullable=False, default=10000.0)
    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))

class DbUserLearningProgress(Base):
    """
    Stores the user's hybrid learning progress payload synced from the device
    """
    __tablename__ = "user_learning_progress"
    
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid", ondelete="CASCADE"), primary_key=True, index=True)
    progress_data = Column(JSON, nullable=False)
    last_synced = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), onupdate=lambda: datetime.now(timezone.utc))

class DbPortfolioPosition(Base):
    __tablename__ = "portfolio_positions"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid"), index=True, nullable=False)
    symbol = Column(String(50), index=True, nullable=False)  # no FK — instruments live in Redis/mock
    quantity = Column(Integer, nullable=False, default=0)
    average_cost = Column(Float, nullable=False, default=0.0)
    last_updated = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), onupdate=lambda: datetime.now(timezone.utc))

class DbOrder(Base):
    __tablename__ = "orders"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid"), index=True, nullable=False)
    symbol = Column(String(50), index=True, nullable=False)  # no FK — instruments live in Redis/mock
    side = Column(String(10), nullable=False)
    order_type = Column(String(20), nullable=False, default="market")
    quantity = Column(Integer, nullable=False)
    status = Column(String(20), nullable=False, default="pending")
    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    filled_at = Column(DateTime(timezone=True), nullable=True)

class DbTrade(Base):
    __tablename__ = "trades"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    order_id = Column(Integer, ForeignKey("orders.id"), index=True, nullable=False)
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid"), index=True, nullable=False)
    symbol = Column(String(50), nullable=False)  # no FK — instruments live in Redis/mock
    side = Column(String(10), nullable=False)
    quantity = Column(Integer, nullable=False)
    price = Column(Float, nullable=False)
    timestamp = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))

class DbWatchlist(Base):
    __tablename__ = "watchlist"

    id = Column(Integer, primary_key=True, autoincrement=True)
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid"), index=True, nullable=False)
    symbol = Column(String(50), index=True, nullable=False)
    added_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))


class DbDailyChallenge(Base):
    __tablename__ = "daily_challenges"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    challenge_date = Column(Date, unique=True, index=True, nullable=False)
    asset_symbol = Column(String(50), nullable=False)
    timeframe = Column(String(20), nullable=False)
    scenario_text = Column(String, nullable=False)
    chart_data = Column(JSON, nullable=True)
    choices = Column(JSON, nullable=False)
    correct_choice_index = Column(Integer, nullable=False)
    explanation_correct = Column(String, nullable=False)
    explanation_incorrect = Column(String, nullable=False)
    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))

class DbUserChallengeProgress(Base):
    __tablename__ = "user_challenge_progress"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid"), index=True, nullable=False)
    challenge_id = Column(Integer, ForeignKey("daily_challenges.id"), index=True, nullable=False)
    completed_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    was_correct = Column(Boolean, nullable=False)


# Note: Candles in TimescaleDB typically use Continuous Aggregates built precisely on top of the price_ticks table.
# E.g. 
# CREATE MATERIALIZED VIEW candle_1m WITH (timescaledb.continuous) AS
#   SELECT time_bucket('1 minute', timestamp) AS bucket,
#          symbol, first(price, timestamp) AS open, max(price) AS high, min(price) AS low, last(price, timestamp) AS close, sum(volume) AS volume
#   FROM price_ticks GROUP BY bucket, symbol;
