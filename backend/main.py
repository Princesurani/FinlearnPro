from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from api.routes import market
from api.websockets import stream

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
app.include_router(stream.router, prefix="/ws/market", tags=["stream"])

@app.on_event("startup")
async def startup_event():
    from simulation.tasks import simulate_tick_loop
    # Trigger background simulation loop
    print("Market Service Starting Up... Triggering Simulation Engine.")
    try:
        simulate_tick_loop.delay()
    except Exception as e:
        print(f"Failed to start celery loop: {e}")

@app.on_event("shutdown")
async def shutdown_event():
    # Cleanup connections
    print("Market Service Shutting Down...")

@app.get("/health")
async def health_check():
    return {"status": "ok", "service": "market_service"}
