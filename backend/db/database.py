import os
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy.orm import declarative_base

# The docker compose sets DATABASE_URL to postgresql://...
# We need to change the scheme to postgresql+asyncpg:// for async access.
DB_URL = os.getenv(
    "DATABASE_URL",
    "postgresql+asyncpg://market_user:market_pass@localhost:5432/market_sim",
)
if DB_URL.startswith("postgresql://"):
    DB_URL = DB_URL.replace("postgresql://", "postgresql+asyncpg://", 1)

engine = create_async_engine(DB_URL, echo=False)
AsyncSessionLocal = async_sessionmaker(
    engine, expire_on_commit=False, class_=AsyncSession
)

Base = declarative_base()


async def get_db():
    async with AsyncSessionLocal() as session:
        yield session


DEFAULT_INSTRUMENTS = [
    # Indian Indices
    {"symbol": "NIFTY 50", "name": "Nifty 50", "type": "marketIndex", "sector": "unknown", "market": "india", "base_price": 21495.70, "volatility": 0.15, "description": "Benchmark Indian Stock Market Index"},
    {"symbol": "BANKNIFTY", "name": "Nifty Bank", "type": "marketIndex", "sector": "financialServices", "market": "india", "base_price": 47854.20, "volatility": 0.22, "description": "Indian Banking Sector Index"},
    {"symbol": "SENSEX", "name": "BSE Sensex", "type": "marketIndex", "sector": "unknown", "market": "india", "base_price": 71350.50, "volatility": 0.14, "description": "BSE Benchmark Index"},
    {"symbol": "NIFTY IT", "name": "Nifty IT", "type": "marketIndex", "sector": "technology", "market": "india", "base_price": 35240.10, "volatility": 0.20, "description": "Indian IT Sector Index"},
    
    # Indian Stocks
    {"symbol": "RELIANCE", "name": "Reliance Industries", "type": "stock", "sector": "energy", "market": "india", "base_price": 2580.40, "volatility": 0.18, "description": "Reliance Industries Limited"},
    {"symbol": "TCS", "name": "Tata Consultancy Services", "type": "stock", "sector": "technology", "market": "india", "base_price": 3820.10, "volatility": 0.15, "description": "TCS"},
    {"symbol": "HDFCBANK", "name": "HDFC Bank", "type": "stock", "sector": "financialServices", "market": "india", "base_price": 1680.90, "volatility": 0.18, "description": "HDFC Bank Limited"},
    {"symbol": "INFY", "name": "Infosys Limited", "type": "stock", "sector": "technology", "market": "india", "base_price": 1540.25, "volatility": 0.22, "description": "Infosys"},
    {"symbol": "ICICIBANK", "name": "ICICI Bank", "type": "stock", "sector": "financialServices", "market": "india", "base_price": 1020.50, "volatility": 0.20, "description": "ICICI Bank Limited"},
    {"symbol": "SBIN", "name": "State Bank of India", "type": "stock", "sector": "financialServices", "market": "india", "base_price": 635.80, "volatility": 0.25, "description": "SBI"},
    {"symbol": "BHARTIARTL", "name": "Bharti Airtel", "type": "stock", "sector": "communicationServices", "market": "india", "base_price": 1030.40, "volatility": 0.21, "description": "Bharti Airtel Limited"},
    {"symbol": "ITC", "name": "ITC Limited", "type": "stock", "sector": "consumerDefensive", "market": "india", "base_price": 465.20, "volatility": 0.12, "description": "ITC Limited"},
    {"symbol": "L&T", "name": "Larsen & Toubro", "type": "stock", "sector": "industrials", "market": "india", "base_price": 3450.60, "volatility": 0.23, "description": "L&T"},
    {"symbol": "TATASTEEL", "name": "Tata Steel", "type": "stock", "sector": "basicMaterials", "market": "india", "base_price": 132.40, "volatility": 0.28, "description": "Tata Steel Limited"},
    
    # USA Indices
    {"symbol": "S&P 500", "name": "S&P 500", "type": "marketIndex", "sector": "unknown", "market": "usa", "base_price": 4780.20, "volatility": 0.12, "description": "US Top 500 index"},
    {"symbol": "NASDAQ", "name": "NASDAQ Composite", "type": "marketIndex", "sector": "technology", "market": "usa", "base_price": 15200.50, "volatility": 0.18, "description": "US Tech index"},
    {"symbol": "DOW JONES", "name": "Dow Jones", "type": "marketIndex", "sector": "unknown", "market": "usa", "base_price": 37600.40, "volatility": 0.10, "description": "US Dow 30 index"},
    {"symbol": "RUSSELL 2000", "name": "Russell 2000", "type": "marketIndex", "sector": "unknown", "market": "usa", "base_price": 1980.20, "volatility": 0.16, "description": "US Small cap index"},
    
    # USA Stocks
    {"symbol": "AAPL", "name": "Apple Inc.", "type": "stock", "sector": "technology", "market": "usa", "base_price": 192.50, "volatility": 0.15, "description": "Apple"},
    {"symbol": "MSFT", "name": "Microsoft", "type": "stock", "sector": "technology", "market": "usa", "base_price": 390.20, "volatility": 0.14, "description": "Microsoft"},
    {"symbol": "NVDA", "name": "NVIDIA", "type": "stock", "sector": "technology", "market": "usa", "base_price": 540.80, "volatility": 0.30, "description": "Nvidia"},
    {"symbol": "TSLA", "name": "Tesla", "type": "stock", "sector": "consumerCyclical", "market": "usa", "base_price": 240.50, "volatility": 0.40, "description": "Tesla Inc"},
    {"symbol": "AMZN", "name": "Amazon", "type": "stock", "sector": "consumerCyclical", "market": "usa", "base_price": 155.20, "volatility": 0.20, "description": "Amazon"},
    {"symbol": "META", "name": "Meta Platforms", "type": "stock", "sector": "communicationServices", "market": "usa", "base_price": 360.40, "volatility": 0.25, "description": "Facebook"},
    {"symbol": "GOOGL", "name": "Alphabet", "type": "stock", "sector": "communicationServices", "market": "usa", "base_price": 140.80, "volatility": 0.18, "description": "Google"},
    {"symbol": "BRK.B", "name": "Berkshire Hathaway", "type": "stock", "sector": "financialServices", "market": "usa", "base_price": 360.20, "volatility": 0.10, "description": "Berkshire"},
    {"symbol": "JPM", "name": "JPMorgan Chase", "type": "stock", "sector": "financialServices", "market": "usa", "base_price": 170.50, "volatility": 0.14, "description": "JPMorgan"},
    {"symbol": "JNJ", "name": "Johnson & Johnson", "type": "stock", "sector": "healthcare", "market": "usa", "base_price": 158.40, "volatility": 0.10, "description": "J&J"},
    
    # UK Indices
    {"symbol": "FTSE 100", "name": "FTSE 100", "type": "marketIndex", "sector": "unknown", "market": "uk", "base_price": 7680.50, "volatility": 0.12, "description": "UK Top 100"},
    {"symbol": "FTSE 250", "name": "FTSE 250", "type": "marketIndex", "sector": "unknown", "market": "uk", "base_price": 19200.40, "volatility": 0.15, "description": "UK Mid cap"},
    {"symbol": "FTSE AIM 100", "name": "FTSE AIM 100", "type": "marketIndex", "sector": "unknown", "market": "uk", "base_price": 3800.20, "volatility": 0.20, "description": "UK Small cap"},
    {"symbol": "FTSE techMARK", "name": "techMARK", "type": "marketIndex", "sector": "technology", "market": "uk", "base_price": 4500.80, "volatility": 0.18, "description": "UK Tech focus"},
    
    # UK Stocks
    {"symbol": "SHEL", "name": "Shell", "type": "stock", "sector": "energy", "market": "uk", "base_price": 2500.40, "volatility": 0.14, "description": "Shell PLC"},
    {"symbol": "AZN", "name": "AstraZeneca", "type": "stock", "sector": "healthcare", "market": "uk", "base_price": 10800.50, "volatility": 0.16, "description": "AstraZeneca"},
    {"symbol": "HSBA", "name": "HSBC", "type": "stock", "sector": "financialServices", "market": "uk", "base_price": 630.20, "volatility": 0.12, "description": "HSBC Holdings"},
    {"symbol": "ULVR", "name": "Unilever", "type": "stock", "sector": "consumerDefensive", "market": "uk", "base_price": 3800.40, "volatility": 0.10, "description": "Unilever PLC"},
    {"symbol": "BP", "name": "BP", "type": "stock", "sector": "energy", "market": "uk", "base_price": 480.50, "volatility": 0.16, "description": "BP PLC"},
    {"symbol": "GSK", "name": "GSK", "type": "stock", "sector": "healthcare", "market": "uk", "base_price": 1500.20, "volatility": 0.14, "description": "GSK PLC"},
    {"symbol": "BATS", "name": "Brit. Amer. Tobacco", "type": "stock", "sector": "consumerDefensive", "market": "uk", "base_price": 2300.80, "volatility": 0.12, "description": "BAT"},
    {"symbol": "RIO", "name": "Rio Tinto", "type": "stock", "sector": "basicMaterials", "market": "uk", "base_price": 5400.40, "volatility": 0.20, "description": "Rio Tinto"},
    {"symbol": "DGE", "name": "Diageo", "type": "stock", "sector": "consumerDefensive", "market": "uk", "base_price": 2800.50, "volatility": 0.12, "description": "Diageo PLC"},
    {"symbol": "GLEN", "name": "Glencore", "type": "stock", "sector": "basicMaterials", "market": "uk", "base_price": 460.20, "volatility": 0.22, "description": "Glencore"},
]


DEFAULT_NEWS_EVENTS = [
    {"headline": "Market Indices achieve record highs amid robust economic indicators.", "category": "macro_economic", "subcategory": "economic_data", "impact": 0.015, "duration_minutes": 120, "affected_scope": "global", "affected_symbols": ["NIFTY 50", "BANKNIFTY", "SENSEX", "S&P 500", "NASDAQ"]},
    {"headline": "Tech companies lead growth sector surge as interest rate fears ease.", "category": "sector_wide", "subcategory": "regulatory", "impact": 0.02, "duration_minutes": 240, "affected_scope": "sector", "affected_symbols": ["TCS", "INFY", "AAPL", "MSFT", "NVDA", "META", "GOOGL"]},
    {"headline": "Tesla (TSLA) secures global market leadership with record quarterly vehicle deliveries.", "category": "company_specific", "subcategory": "product", "impact": 0.045, "duration_minutes": 180, "affected_scope": "symbol", "affected_symbols": ["TSLA"]},
    {"headline": "Apple (AAPL) unveils revolutionary AI capabilities, analysts lift targets.", "category": "company_specific", "subcategory": "product", "impact": 0.035, "duration_minutes": 120, "affected_scope": "symbol", "affected_symbols": ["AAPL"]},
    {"headline": "Federal Reserve signals potential rate pause in upcoming meetings.", "category": "macro_economic", "subcategory": "fed", "impact": 0.01, "duration_minutes": 60, "affected_scope": "global", "affected_symbols": []},
    {"headline": "Nvidia (NVDA) announces advanced chip supply expansion to meet global demand.", "category": "company_specific", "subcategory": "product", "impact": 0.05, "duration_minutes": 180, "affected_scope": "symbol", "affected_symbols": ["NVDA"]},
    {"headline": "Reliance Industries (RELIANCE) unveils major renewable energy expansion plans.", "category": "company_specific", "subcategory": "product", "impact": 0.025, "duration_minutes": 240, "affected_scope": "symbol", "affected_symbols": ["RELIANCE"]},
    {"headline": "Larsen & Toubro (L&T) wins mega infrastructure contract in the Middle East.", "category": "company_specific", "subcategory": "product", "impact": 0.03, "duration_minutes": 120, "affected_scope": "symbol", "affected_symbols": ["L&T"]},
    {"headline": "Tata Consultancy Services (TCS) secures multi-billion dollar digital transformation deal.", "category": "company_specific", "subcategory": "product", "impact": 0.02, "duration_minutes": 90, "affected_scope": "symbol", "affected_symbols": ["TCS"]},
    {"headline": "HDFC Bank (HDFCBANK) posts stellar credit growth and improved asset quality in Q1.", "category": "company_specific", "subcategory": "earnings", "impact": 0.028, "duration_minutes": 120, "affected_scope": "symbol", "affected_symbols": ["HDFCBANK"]},
    {"headline": "Microsoft (MSFT) Cloud revenue surges, beating market expectations.", "category": "company_specific", "subcategory": "earnings", "impact": 0.03, "duration_minutes": 120, "affected_scope": "symbol", "affected_symbols": ["MSFT"]},
    {"headline": "Oil majors Shell (SHEL) and BP face consolidation pressure amidst price fluctuations.", "category": "sector_wide", "subcategory": "regulatory", "impact": -0.015, "duration_minutes": 180, "affected_scope": "sector", "affected_symbols": ["SHEL", "BP"]},
    {"headline": "AstraZeneca (AZN) gains critical approvals for advanced therapy drug trial.", "category": "company_specific", "subcategory": "product", "impact": 0.035, "duration_minutes": 240, "affected_scope": "symbol", "affected_symbols": ["AZN"]},
    {"headline": "Ex-dividend dates approach for major UK and US banking conglomerates.", "category": "sector_wide", "subcategory": "regulatory", "impact": -0.005, "duration_minutes": 60, "affected_scope": "sector", "affected_symbols": ["HSBA", "JPM", "ICICIBANK", "SBIN"]},
    {"headline": "Global retail sales grow faster than projected, lifting consumer sector sentiment.", "category": "macro_economic", "subcategory": "economic_data", "impact": 0.012, "duration_minutes": 120, "affected_scope": "global", "affected_symbols": ["AMZN", "ITC", "ULVR", "BATS", "DGE"]}
]

DEFAULT_INSTRUCTORS = [
    {
        "id": "sarah",
        "name": "Dr. Sarah Jenkins",
        "bio": "Dr. Sarah Jenkins is a former Wall Street quantitative researcher with a Ph.D. in Financial Mathematics from MIT. She has over 12 years of experience building algorithmic trading models and teaching risk management to institutional traders.",
        "photo_url": "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&q=80&w=200",
        "specialty": "Quantitative Finance, Risk Management & Technical Analysis",
        "linkedin_url": "https://linkedin.com/in/sarah-jenkins-finlearn"
    },
    {
        "id": "rajesh",
        "name": "Rajesh Kumar, CFA",
        "bio": "Rajesh Kumar is a Chartered Financial Analyst (CFA) and a veteran investment advisor with 15+ years of experience in Indian equity markets. He specializes in value investing, balance sheet auditing, and tax-efficient portfolio structuring.",
        "photo_url": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=200",
        "specialty": "Fundamental Analysis, Corporate Finance & Indian Markets",
        "linkedin_url": "https://linkedin.com/in/rajesh-kumar-finlearn"
    },
    {
        "id": "michael",
        "name": "Michael Vance",
        "bio": "Michael Vance has traded global currency and commodity markets for over two decades. Formerly a senior FX strategist at a London hedge fund, he now focuses on macro economic analysis, leverage strategies, and physical commodity derivatives.",
        "photo_url": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=200",
        "specialty": "Global Macro, Forex & Commodities Trading",
        "linkedin_url": "https://linkedin.com/in/michael-vance-finlearn"
    },
    {
        "id": "elena",
        "name": "Elena Rostova",
        "bio": "Elena Rostova is a blockchain developer and early cryptocurrency investor. She has designed smart contracts for multiple DeFi protocols and is a frequent speaker at global crypto conferences. She specializes in tokenomics and digital asset valuations.",
        "photo_url": "https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&q=80&w=200",
        "specialty": "Blockchain Architecture, DeFi & Cryptocurrency Valuation",
        "linkedin_url": "https://linkedin.com/in/elena-rostova-finlearn"
    }
]


async def init_db():
    # Recreate all database tables cleanly in a fresh transaction block
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

    # Seed default instruments if empty
    from db.models import DbInstrument
    async with AsyncSessionLocal() as session:
        from sqlalchemy import select
        res = await session.execute(select(DbInstrument.symbol))
        if not res.scalars().first():
            instruments = [DbInstrument(**inst) for inst in DEFAULT_INSTRUMENTS]
            session.add_all(instruments)
            await session.commit()

    # Seed default news events if empty
    from db.models import DbNewsEvent
    async with AsyncSessionLocal() as session:
        from sqlalchemy import select
        res = await session.execute(select(DbNewsEvent.id))
        if not res.scalars().first():
            events = [DbNewsEvent(**ev) for ev in DEFAULT_NEWS_EVENTS]
            session.add_all(events)
            await session.commit()

    # Seed default instructors if empty
    from db.models import DbInstructor
    async with AsyncSessionLocal() as session:
        from sqlalchemy import select
        res = await session.execute(select(DbInstructor.id))
        if not res.scalars().first():
            instructors = [DbInstructor(**inst) for inst in DEFAULT_INSTRUCTORS]
            session.add_all(instructors)
            await session.commit()

    # We must explicitly convert tables into TimescaleDB hyper tables where appropriate.
    # In a real production setup, we'd use Alembic migrations and raw SQL to run `SELECT create_hypertable('price_ticks', 'timestamp');`.
