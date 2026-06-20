from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional, List
from enum import Enum

class InstrumentType(str, Enum):
    stock = "stock"
    marketIndex = "marketIndex"
    etf = "etf"
    commodity = "commodity"
    forex = "forex"
    bond = "bond"

class Sector(str, Enum):
    technology = "technology"
    financialServices = "financialServices"
    healthcare = "healthcare"
    consumerCyclical = "consumerCyclical"
    consumerDefensive = "consumerDefensive"
    industrials = "industrials"
    energy = "energy"
    utilities = "utilities"
    realEstate = "realEstate"
    basicMaterials = "basicMaterials"
    communicationServices = "communicationServices"
    unknown = "unknown"

class MarketRegime(str, Enum):
    usa = "usa"
    india = "india"
    uk = "uk"

class Instrument(BaseModel):
    symbol: str
    name: str
    type: InstrumentType
    sector: Sector
    market: MarketRegime
    basePrice: float
    volatility: float
    description: str
    logoUrl: Optional[str] = None
    exchange: Optional[str] = None
    isin: Optional[str] = None

class MarketSnapshot(BaseModel):
    symbol: str
    name: str
    price: float
    open: float
    high: float
    low: float
    previousClose: float
    change: float
    changePercent: float
    volume: float
    timestamp: datetime
    fiftyTwoWeekHigh: Optional[float] = None
    fiftyTwoWeekLow: Optional[float] = None
    marketCap: Optional[float] = None
    avgVolume: Optional[float] = None

class PriceTick(BaseModel):
    symbol: str
    timestamp: datetime
    price: float
    bid: float
    ask: float
    volume: float
    change: float
    changePercent: float

class Candle(BaseModel):
    timestamp: datetime
    open: float
    high: float
    low: float
    close: float
    volume: float

class Timeframe(str, Enum):
    oneMinute = "1m"
    fiveMinute = "5m"
    fifteenMinute = "15m"
    oneHour = "1h"
    fourHour = "4h"
    oneDay = "1D"
    oneWeek = "1W"
    oneMonth = "1M"

class UserProfileResponse(BaseModel):
    firebase_uid: str
    username: str
    avatar_url: Optional[str] = None
    bio: Optional[str] = None
    total_xp: int
    weekly_xp: int
    level: int
    current_streak: int
    longest_streak: int
    total_trades: int
    total_courses_completed: int
    total_challenges_completed: int
    win_rate: float
    last_activity_date: Optional[str] = None
    email: Optional[str] = None

class UserProfileUpdateRequest(BaseModel):
    username: Optional[str] = None
    avatar_url: Optional[str] = None
    bio: Optional[str] = None
    email: Optional[str] = None

class LeaderboardEntry(BaseModel):
    firebase_uid: str
    username: str
    avatar_url: Optional[str] = None
    level: int
    total_xp: int
    weekly_xp: int
    current_streak: int
    total_trades: int
    win_rate: float
    rank: int = 0

class TradeShareRequest(BaseModel):
    trade_id: Optional[int] = None
    symbol: str
    side: str
    quantity: int
    price: float
    pnl_percent: Optional[float] = None
    caption: Optional[str] = None

class TradeShareResponse(BaseModel):
    id: int
    firebase_uid: str
    author_name: str
    author_avatar: Optional[str] = None
    author_level: int
    trade_id: Optional[int] = None
    symbol: str
    side: str
    quantity: int
    price: float
    pnl_percent: Optional[float] = None
    caption: Optional[str] = None
    likes_count: int
    comments_count: int
    is_liked_by_me: bool = False
    created_at: datetime
