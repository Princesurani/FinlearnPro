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
    crypto = "crypto"
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
    crypto = "crypto"

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
