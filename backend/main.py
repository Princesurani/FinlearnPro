import logging
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from api.routes import market, portfolio, orders, learning, challenges, social, notifications
from api.websockets import stream

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

app = FastAPI(
    title="FinLearn Pro - Market Service",
    description="Simulates market data, news events, and provides real-time WebSockets.",
    version="1.0.0"
)

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, restrict to actual client origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(market.router, prefix="/api/v1/market", tags=["market"])
app.include_router(portfolio.router, prefix="/api/v1/portfolio", tags=["portfolio"])
app.include_router(orders.router, prefix="/api/v1/orders", tags=["orders"])
app.include_router(learning.router, prefix="/api/v1/learning", tags=["learning"])
app.include_router(challenges.router, prefix="/api/v1/challenges", tags=["challenges"])
app.include_router(social.router, prefix="/api/v1/social", tags=["social"])
app.include_router(notifications.router, prefix="/api/v1/notifications", tags=["notifications"])
app.include_router(stream.router, prefix="/ws/market", tags=["stream"])

@app.on_event("startup")
async def startup_event():
    from db.database import init_db
    from simulation.tasks import simulate_tick_loop
    # Create all DB tables (including new trading tables) if they don't exist
    await init_db()
    
    # Start Cron for Daily Challenges
    from cron_runner import start_cron
    try:
        start_cron()
    except Exception as e:
        logger.error(f"Failed to start challenge cron: {e}")

    # Trigger background simulation loop
    logger.info("Market Service Starting Up... Triggering Simulation Engine.")
    try:
        import asyncio
        # Run as a background task in the main thread's asyncio loop to share connection pool safely
        asyncio.create_task(simulate_tick_loop())
        logger.info("Started simulate_tick_loop as an asyncio background task!")
    except Exception as e:
        logger.error(f"Failed to start simulation task: {e}")

@app.on_event("shutdown")
async def shutdown_event():
    # Cleanup connections
    logger.info("Market Service Shutting Down...")

@app.get("/health")
async def health_check():
    return {"status": "ok", "service": "market_service"}

@app.get("/")
@app.head("/")
async def root_health():
    return {"status": "healthy"}

