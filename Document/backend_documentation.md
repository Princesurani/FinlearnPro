# FinLearn Pro - Market Backend Architecture

## Overview
The Market Backend is a highly-concurrent, containerized service designed to simulate a real-time financial market (stocks, indices, crypto). It provides live price streaming via WebSockets, REST APIs for trading and portfolios, and robust historical database storage using optimized time-series databases. 

## Technology Stack
- **Framework:** FastAPI (Python 3.10) for high-performance asynchronous REST endpoints and WebSockets.
- **Background Worker:** Celery for running continuous background price simulation math loops.
- **Message Broker & Cache:** Redis for WebSocket Pub/Sub (broadcasting live ticks to clients) and fast key-value retrieval of the latest market quotes.
- **Database:** PostgreSQL extended with TimescaleDB for hyper-efficient time-series data storage and instant OHLC candlestick generation.
- **Infrastructure:** Docker & Docker Compose for seamless environment consistency and simple startup.

---

## Core Infrastructure Details

### 1. API Server (`FastAPI`)
- **Location:** `backend/main.py`, `backend/api/routes/`
- **Purpose:** Acts as the primary interface for the Flutter mobile application.
- **Key Duties:**
  - `GET /api/v1/market/history/{symbol}` - Uses TimescaleDB to fetch materialized historical candlestick data.
  - `GET /api/v1/market/quotes` - Uses Redis to fetch the absolute latest price instantly.
  - `WS /ws/market/stream` - An active websocket connection that subscribes to Redis and pushes live simulated JSON ticks to the mobile app UI.
  - **Auto-Seeding:** On fresh startup, if the database is empty, the API intercepts the boot cycle to fully bootstrap tables, instrument lists, and generates exactly 5 days of simulated historical ticks so that the frontend charts work instantly without manual scripts.

### 2. Market Simulation Engine (`Celery Worker`)
- **Location:** `backend/simulation/tasks.py`, `backend/simulation/price_engine.py`
- **Purpose:** Emulates how thousands of live traders impact stock prices every second.
- **Key Duties:**
  - Runs an infinite `simulate_tick_loop` that cycles over every active instrument and updates its value every 2-3 seconds.
  - Employs advanced quantitative finance models (Geometric Brownian Motion, Merton's Jump Diffusion, and GARCH volatility clustering) to compute highly realistic, non-linear price trajectories.
  - Publishes every new tick to a Redis Pub/Sub channel (e.g., `market:ticks:AAPL`), empowering the FastAPI websocket to push it down to the UI.
  - Periodically batches historical ticks every X seconds to TimescaleDB to maintain a persistent history without crushing the database with single I/O writes.

### 3. Database (`TimescaleDB`)
- **Location:** `backend/db/models.py`, `backend/db/database.py`
- **Purpose:** To persist critical financial ledgers and time-series history.
- **Key Duties:**
  - Converts standard Postgres tables into specialized **Hypertables** (`price_ticks`), dynamically partitioning data by time intervals to keep queries hyper-fast.
  - Automatically maintains **Continuous Materialized Views** (`candle_1m`, `candle_1h`). This means the database is instantly pre-calculating the Open, High, Low, and Close for charts as data streams in, instead of forcing the API to compute it on the fly.
  - Manages relational dependencies like the `users` table (available cash balance), `portfolio_positions` (owned fractions of stocks), and their `orders` history.

### 4. Memory Cache & Message Routing (`Redis`)
- **Location:** Native Docker Image
- **Purpose:** The glue that keeps the architecture incredibly fast.
- **Key Duties:**
  - Replaces traditional REST polling. The frontend maintains an open WebSocket connected to FastAPI, which is subscribed to Redis.
  - Holds the "Current State": The `market:quote:{symbol}` key is constantly overwritten. When the Flutter app hits the Explore page, the API loads all prices in ~10 milliseconds straight out of RAM rather than waking up the SSD database.

### 5. Trading Engine & Portfolio (Buy/Sell Workflows)
- **Location:** `backend/api/routes/orders.py`, `backend/api/routes/portfolio.py`
- **Purpose:** Manages user accounts, executes trades, calculates profit/loss, and maintains holdings.
- **Key Duties:**
  - **Auto-Registration:** When an order is placed (or portfolio fetched) for a new Firebase UUID, the database automatically injects a new user profile into the `users` table pre-funded with mock cash balances (`usd_balance: 10000`, `inr_balance: 10000`, etc.).
  - **Buying:** 
    1. Validates the latest market price via Redis mapping (to prevent stale-price exploits).
    2. Checks if the user has enough native currency for the transaction (e.g., trying to buy NIFTY 50 verifies against `inr_balance`).
    3. Subtracts the total cost from the corresponding cash balance in the `users` table.
    4. Upserts the quantity and updates the `average_price` mathematically inside the `portfolio_positions` table.
    5. Records an immutable receipt in the `orders` ledger.
  - **Selling:**
    1. Validates that the user physically owns enough quantity of the specfic asset in `portfolio_positions`.
    2. Adds the total exit value directly to their native cash balance.
    3. Decrements their held quantity. If the holding reaches `0`, the row is optionally cleared from the portfolio view.
    4. Logs the "SELL" action to the `orders` historical ledger.

---

## Summary Data Flow
1. **Simulation:** The Celery worker's math loop recalculates the price for AAPL.
2. **Broadcast:** The worker pushes this new JSON tick to Redis via Pub/Sub and updates the cache.
3. **Streaming:** The FastAPI WebSocket reads the Redis channel and pushes that JSON down the pipe to the Flutter UI.
4. **Storage:** The Celery worker aggregates the ticks and writes them to TimescaleDB every 30 seconds.
5. **Charting:** When a user taps AAPL, the FastAPI app immediately reads TimescaleDB's pre-rendered `candle_1m` materialized view to instantly draw the graph.

## Launch Sequence
The entire complex architecture functions by running a single command:
```bash
docker compose up -d --build
```
Because of configured `depends_on` healthchecks, the system automatically waits for TimescaleDB to warm up, boots Redis, boots FastAPI to auto-seed missing tables, and finally activates the Celery Simulation Engine.
