from sqlalchemy import Column, Integer, String, Float, DateTime, Boolean, ForeignKey, JSON, Date, CheckConstraint
from sqlalchemy.dialects.postgresql import ARRAY, ENUM
from datetime import datetime, timezone
from db.database import Base

# Postgres Native Enums for Type Safety
SIDE_ENUM = ENUM("buy", "sell", name="trade_side", metadata=Base.metadata)
ORDER_TYPE_ENUM = ENUM("market", "limit", name="order_type", metadata=Base.metadata)
ORDER_STATUS_ENUM = ENUM("pending", "filled", "cancelled", name="order_status", metadata=Base.metadata)

class DbInstrument(Base):
    __tablename__ = "instruments"
    
    symbol = Column(String(50), primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    type = Column(String(50), nullable=False)      # e.g., 'stock', 'marketIndex'
    sector = Column(String(100), nullable=False)
    market = Column(String(50), nullable=False)      # e.g., 'india', 'usa', 'uk'
    base_price = Column(Float, nullable=False)
    volatility = Column(Float, nullable=False)
    description = Column(String)

class DbPriceTick(Base):
    """
    To be converted to a TimescaleDB Hypertable.
    Uses a composite primary key (symbol, timestamp) to avoid auto-incrementing ID overhead.
    """
    __tablename__ = "price_ticks"
    
    symbol = Column(String(50), ForeignKey("instruments.symbol", ondelete="RESTRICT"), primary_key=True)
    timestamp = Column(DateTime(timezone=True), primary_key=True, default=lambda: datetime.now(timezone.utc))
    price = Column(Float, nullable=False)
    bid = Column(Float, nullable=False)
    ask = Column(Float, nullable=False)
    volume = Column(Float, nullable=False)

class DbNewsEvent(Base):
    """
    Uses PostgreSQL native ARRAY to handle multiple affected instruments in 1st Normal Form.
    """
    __tablename__ = "news_events"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    headline = Column(String(500), nullable=False)
    category = Column(String(100), nullable=False)
    subcategory = Column(String(100), nullable=False)
    timestamp = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), index=True)
    impact = Column(Float, nullable=False)
    duration_minutes = Column(Integer, nullable=False)
    affected_scope = Column(String(50), nullable=False)
    affected_symbols = Column(ARRAY(String(50)), nullable=True) 

class DbUser(Base):
    """
    Consolidated user record combining profile fields (social & gamification)
    to eliminate join/query overhead on login, trade, and leaderboard queries.
    """
    __tablename__ = "users"
    
    firebase_uid = Column(String(128), primary_key=True, index=True)
    email = Column(String(255), unique=True, index=True, nullable=True)
    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    
    # Social Profile Fields
    username = Column(String(100), unique=True, index=True, nullable=False)
    avatar_url = Column(String(500), nullable=True)
    bio = Column(String(300), nullable=True)
    
    # Gamification
    total_xp = Column(Integer, nullable=False, default=0)
    weekly_xp = Column(Integer, nullable=False, default=0)
    level = Column(Integer, nullable=False, default=1)
    current_streak = Column(Integer, nullable=False, default=0)
    longest_streak = Column(Integer, nullable=False, default=0)
    last_activity_date = Column(Date, nullable=True)
    
    # Stats (denormalized for fast leaderboard reads)
    total_trades = Column(Integer, nullable=False, default=0)
    total_courses_completed = Column(Integer, nullable=False, default=0)
    total_challenges_completed = Column(Integer, nullable=False, default=0)
    win_rate = Column(Float, nullable=False, default=0.0)

class DbUserBalance(Base):
    """
    Dynamic currency balance mapping to support any market dynamically.
    """
    __tablename__ = "user_balances"
    
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid", ondelete="CASCADE"), primary_key=True)
    market = Column(String(50), primary_key=True) # e.g. "india", "usa", "uk"
    balance = Column(Float, nullable=False, default=10000.0)

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
    
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid", ondelete="CASCADE"), primary_key=True)
    symbol = Column(String(50), ForeignKey("instruments.symbol", ondelete="RESTRICT"), primary_key=True)
    quantity = Column(Integer, nullable=False, default=0)
    average_cost = Column(Float, nullable=False, default=0.0)
    last_updated = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), onupdate=lambda: datetime.now(timezone.utc))

class DbOrder(Base):
    __tablename__ = "orders"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid", ondelete="CASCADE"), index=True, nullable=False)
    symbol = Column(String(50), ForeignKey("instruments.symbol", ondelete="RESTRICT"), nullable=False)
    side = Column(SIDE_ENUM, nullable=False)
    order_type = Column(ORDER_TYPE_ENUM, nullable=False, default="market")
    quantity = Column(Integer, nullable=False)
    status = Column(ORDER_STATUS_ENUM, nullable=False, default="pending")
    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    filled_at = Column(DateTime(timezone=True), nullable=True)

class DbTrade(Base):
    __tablename__ = "trades"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    order_id = Column(Integer, ForeignKey("orders.id", ondelete="CASCADE"), index=True, nullable=False)
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid", ondelete="CASCADE"), index=True, nullable=False)
    symbol = Column(String(50), ForeignKey("instruments.symbol", ondelete="RESTRICT"), nullable=False)
    side = Column(SIDE_ENUM, nullable=False)
    quantity = Column(Integer, nullable=False)
    price = Column(Float, nullable=False)
    timestamp = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))

class DbWatchlist(Base):
    """
    Watchlist utilizes composite primary keys to prevent duplicates.
    """
    __tablename__ = "watchlist"

    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid", ondelete="CASCADE"), primary_key=True)
    symbol = Column(String(50), ForeignKey("instruments.symbol", ondelete="RESTRICT"), primary_key=True)
    added_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))

class DbDailyChallenge(Base):
    __tablename__ = "daily_challenges"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    challenge_date = Column(Date, unique=True, index=True, nullable=False)
    asset_symbol = Column(String(50), ForeignKey("instruments.symbol", ondelete="RESTRICT"), nullable=False)
    timeframe = Column(String(20), nullable=False)
    scenario_text = Column(String, nullable=False)
    chart_data = Column(JSON, nullable=True)
    choices = Column(JSON, nullable=False)
    correct_choice_index = Column(Integer, nullable=False)
    explanation_correct = Column(String, nullable=False)
    explanation_incorrect = Column(String, nullable=False)
    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))

class DbUserChallengeProgress(Base):
    """
    Composite key enforces single completion of daily challenge by a user.
    """
    __tablename__ = "user_challenge_progress"
    
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid", ondelete="CASCADE"), primary_key=True)
    challenge_id = Column(Integer, ForeignKey("daily_challenges.id", ondelete="CASCADE"), primary_key=True)
    completed_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    was_correct = Column(Boolean, nullable=False)

class DbTradeShare(Base):
    __tablename__ = "trade_shares"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid", ondelete="CASCADE"), index=True, nullable=False)
    trade_id = Column(Integer, ForeignKey("trades.id", ondelete="SET NULL"), nullable=True)
    
    symbol = Column(String(50), ForeignKey("instruments.symbol", ondelete="RESTRICT"), nullable=False)
    side = Column(SIDE_ENUM, nullable=False)
    quantity = Column(Integer, nullable=False)
    price = Column(Float, nullable=False)
    pnl_percent = Column(Float, nullable=True)
    caption = Column(String(500), nullable=True)
    
    likes_count = Column(Integer, nullable=False, default=0)
    comments_count = Column(Integer, nullable=False, default=0)
    
    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))

class DbTradeShareLike(Base):
    """
    Composite key enforces a single like per user per trade share post.
    """
    __tablename__ = "trade_share_likes"
    
    share_id = Column(Integer, ForeignKey("trade_shares.id", ondelete="CASCADE"), primary_key=True)
    firebase_uid = Column(String(128), ForeignKey("users.firebase_uid", ondelete="CASCADE"), primary_key=True)
    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))

class DbInstructor(Base):
    __tablename__ = "instructors"
    
    id = Column(String(100), primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    bio = Column(String(1000), nullable=False)
    photo_url = Column(String(500), nullable=True)
    specialty = Column(String(255), nullable=False)
    linkedin_url = Column(String(255), nullable=True)

