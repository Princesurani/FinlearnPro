# ADR-005: Market Simulation Engine & Data Modeling

---

# MARKET SIMULATION ENGINE

This document details the comprehensive market simulation system that powers FinLearn Pro's realistic trading environment.

---

## SIMULATION OBJECTIVES

The market simulation engine must:
1. **Feel Real**: Users should believe they're trading real markets
2. **Be Educational**: Every price movement should be explainable
3. **Be Customizable**: Support various market conditions and scenarios
4. **Be Deterministic** (when needed): Allow replay of historical scenarios
5. **Scale**: Handle thousands of concurrent users

---

## SIMULATION ARCHITECTURE

### High-Level Design

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        MARKET SIMULATION ENGINE                          │
│                                                                          │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │                    MARKET DATA GENERATOR                            │ │
│  │                                                                      │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐              │ │
│  │  │    Price     │  │    News      │  │   Economic   │              │ │
│  │  │   Engine     │  │   Engine     │  │   Engine     │              │ │
│  │  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘              │ │
│  │         │                 │                  │                      │ │
│  │         └─────────────────┴──────────────────┘                      │ │
│  │                           │                                         │ │
│  │                    ┌──────▼──────┐                                  │ │
│  │                    │   Market    │                                  │ │
│  │                    │   State     │                                  │ │
│  │                    │  Manager    │                                  │ │
│  │                    └──────┬──────┘                                  │ │
│  └───────────────────────────┼──────────────────────────────────────── │
│                              │                                          │
│  ┌───────────────────────────┼────────────────────────────────────────┐│
│  │                           │      ORDER MATCHING ENGINE             ││
│  │                    ┌──────▼──────┐                                 ││
│  │                    │   Order     │                                 ││
│  │                    │   Book      │                                 ││
│  │                    └──────┬──────┘                                 ││
│  │                           │                                        ││
│  │  ┌──────────────┐  ┌──────▼──────┐  ┌──────────────┐              ││
│  │  │    Fill      │  │  Matching   │  │   Market     │              ││
│  │  │  Simulator   │<─│   Logic     │─>│   Impact     │              ││
│  │  └──────────────┘  └─────────────┘  └──────────────┘              ││
│  └────────────────────────────────────────────────────────────────────┘│
│                                                                          │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │                      BROADCAST LAYER                                │ │
│  │                                                                      │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐              │ │
│  │  │  WebSocket   │  │   Quote      │  │   Trade      │              │ │
│  │  │   Server     │  │  Streamer    │  │   Feed       │              │ │
│  │  └──────────────┘  └──────────────┘  └──────────────┘              │ │
│  └────────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## PRICE GENERATION MODELS

### Model 1: Geometric Brownian Motion (Base)

```python
"""
Base price model using Geometric Brownian Motion (GBM)
dS = μS dt + σS dW

Where:
- S = stock price
- μ = drift (expected return)
- σ = volatility
- W = Wiener process (random walk)
"""

class GBMPriceModel:
    def __init__(self, initial_price: float, drift: float, volatility: float):
        self.price = initial_price
        self.drift = drift
        self.volatility = volatility
        self.dt = 1 / 252 / 390  # 1 minute in trading year units
    
    def generate_next_price(self) -> float:
        """Generate the next price using GBM."""
        # Random shock
        dW = np.random.normal(0, np.sqrt(self.dt))
        
        # Price change
        dS = self.price * (
            self.drift * self.dt + 
            self.volatility * dW
        )
        
        self.price += dS
        return max(self.price, 0.01)  # Price floor


# Example Parameters by Asset Type
ASSET_PARAMETERS = {
    "large_cap_stock": {
        "drift": 0.08,  # 8% annual return
        "volatility": 0.20  # 20% annual volatility
    },
    "small_cap_stock": {
        "drift": 0.12,
        "volatility": 0.35
    },
    "growth_stock": {
        "drift": 0.15,
        "volatility": 0.40
    },
    "value_stock": {
        "drift": 0.07,
        "volatility": 0.18
    },
    "etf": {
        "drift": 0.07,
        "volatility": 0.15
    },
    "bond_etf": {
        "drift": 0.03,
        "volatility": 0.05
    },
    "crypto": {
        "drift": 0.30,
        "volatility": 0.80
    }
}
```

### Model 2: Jump Diffusion (For Event-Driven Moves)

```python
"""
Merton's Jump Diffusion Model
Adds discontinuous jumps to capture sudden price movements
dS = (μ - λk)S dt + σS dW + S dJ

Where:
- λ = jump intensity (expected number of jumps per year)
- k = expected jump size
- J = compound Poisson process
"""

class JumpDiffusionModel:
    def __init__(
        self, 
        initial_price: float,
        drift: float,
        volatility: float,
        jump_intensity: float = 2,  # 2 jumps per year expected
        jump_mean: float = 0,
        jump_std: float = 0.10  # 10% jump magnitude
    ):
        self.price = initial_price
        self.drift = drift
        self.volatility = volatility
        self.jump_intensity = jump_intensity
        self.jump_mean = jump_mean
        self.jump_std = jump_std
        self.dt = 1 / 252 / 390
    
    def generate_next_price(self) -> float:
        """Generate price with possible jumps."""
        
        # GBM component (adjusted for jump expectation)
        k = np.exp(self.jump_mean + 0.5 * self.jump_std**2) - 1
        adjusted_drift = self.drift - self.jump_intensity * k
        
        dW = np.random.normal(0, np.sqrt(self.dt))
        gbm_component = self.price * (
            adjusted_drift * self.dt + 
            self.volatility * dW
        )
        
        # Jump component
        num_jumps = np.random.poisson(self.jump_intensity * self.dt)
        jump_component = 0
        
        if num_jumps > 0:
            jump_sizes = np.random.normal(self.jump_mean, self.jump_std, num_jumps)
            for jump in jump_sizes:
                jump_component += self.price * (np.exp(jump) - 1)
        
        self.price = self.price + gbm_component + jump_component
        return max(self.price, 0.01)
```

### Model 3: GARCH Volatility (For Realistic Volatility Clustering)

```python
"""
GARCH(1,1) Model for time-varying volatility
σ²_t = ω + α * ε²_{t-1} + β * σ²_{t-1}

Captures volatility clustering: high volatility follows high volatility
"""

class GARCHVolatilityModel:
    def __init__(
        self,
        omega: float = 0.000001,  # Long-run variance weight
        alpha: float = 0.1,       # Recent shock weight
        beta: float = 0.85        # Previous variance weight
    ):
        self.omega = omega
        self.alpha = alpha
        self.beta = beta
        
        # Initialize
        self.variance = omega / (1 - alpha - beta)  # Unconditional variance
        self.last_shock = 0
    
    def update_volatility(self, return_val: float) -> float:
        """Update volatility based on observed return."""
        
        # Calculate shock
        shock = return_val - np.mean(return_val) if hasattr(return_val, '__len__') else return_val
        
        # Update variance
        self.variance = (
            self.omega + 
            self.alpha * shock**2 + 
            self.beta * self.variance
        )
        
        self.last_shock = shock
        return np.sqrt(self.variance)


class GBMWithGARCH:
    """Combined GBM with GARCH volatility for realistic simulation."""
    
    def __init__(self, initial_price: float, drift: float, base_volatility: float):
        self.price = initial_price
        self.drift = drift
        self.garch = GARCHVolatilityModel()
        self.garch.variance = base_volatility**2
        self.dt = 1 / 252 / 390
    
    def generate_next_price(self) -> Tuple[float, float]:
        """Generate next price with GARCH volatility."""
        
        volatility = np.sqrt(self.garch.variance)
        
        dW = np.random.normal(0, np.sqrt(self.dt))
        
        return_val = self.drift * self.dt + volatility * dW
        
        self.price *= (1 + return_val)
        
        # Update GARCH model
        self.garch.update_volatility(return_val)
        
        return max(self.price, 0.01), volatility
```

### Model 4: Correlation Engine

```python
"""
Cholesky decomposition for correlated asset returns.
Ensures realistic cross-asset behavior.
"""

class CorrelationEngine:
    def __init__(self, correlation_matrix: np.ndarray, asset_names: List[str]):
        self.correlation_matrix = correlation_matrix
        self.asset_names = asset_names
        
        # Cholesky decomposition for generating correlated random variables
        self.cholesky_matrix = np.linalg.cholesky(correlation_matrix)
    
    def generate_correlated_returns(
        self, 
        base_returns: Dict[str, float],
        volatilities: Dict[str, float]
    ) -> Dict[str, float]:
        """Generate correlated returns across all assets."""
        
        n_assets = len(self.asset_names)
        
        # Generate independent standard normal variables
        Z = np.random.normal(0, 1, n_assets)
        
        # Apply correlation structure
        correlated_Z = self.cholesky_matrix @ Z
        
        # Convert to returns
        returns = {}
        for i, asset in enumerate(self.asset_names):
            drift = base_returns.get(asset, 0)
            vol = volatilities.get(asset, 0.20)
            dt = 1 / 252 / 390
            
            returns[asset] = drift * dt + vol * np.sqrt(dt) * correlated_Z[i]
        
        return returns


# Default Correlation Matrix
DEFAULT_CORRELATIONS = {
    # Major Indices
    ("SPY", "QQQ"): 0.90,
    ("SPY", "IWM"): 0.85,
    ("SPY", "DIA"): 0.95,
    
    # Tech Stocks (highly correlated)
    ("AAPL", "MSFT"): 0.75,
    ("AAPL", "GOOGL"): 0.70,
    ("MSFT", "GOOGL"): 0.72,
    ("NVDA", "AMD"): 0.80,
    
    # Different Sectors (lower correlation)
    ("AAPL", "XOM"): 0.30,
    ("MSFT", "JNJ"): 0.25,
    
    # Negative Correlations (hedges)
    ("SPY", "VXX"): -0.80,
    ("SPY", "TLT"): -0.20,
    ("GLD", "UUP"): -0.40
}
```

---

## MARKET SCENARIOS

### Scenario System

```python
"""
Pre-built market scenarios for educational purposes.
Users can experience various market conditions.
"""

class MarketScenario:
    def __init__(
        self,
        name: str,
        duration_days: int,
        parameters: Dict
    ):
        self.name = name
        self.duration_days = duration_days
        self.parameters = parameters


BUILT_IN_SCENARIOS = {
    
    "bull_market": MarketScenario(
        name="Bull Market Rally",
        duration_days=90,
        parameters={
            "market_drift": 0.30,  # 30% annualized
            "volatility_multiplier": 0.7,
            "sentiment": "extremely_bullish",
            "sector_leaders": ["technology", "consumer_discretionary"],
            "jump_probability": 0.002,  # Low negative jumps
            "news_bias": "positive"
        }
    ),
    
    "bear_market": MarketScenario(
        name="Bear Market Decline",
        duration_days=90,
        parameters={
            "market_drift": -0.25,
            "volatility_multiplier": 1.5,
            "sentiment": "extremely_bearish",
            "sector_leaders": ["utilities", "healthcare"],
            "jump_probability": 0.01,  # Higher negative jumps
            "news_bias": "negative"
        }
    ),
    
    "market_crash": MarketScenario(
        name="Flash Crash",
        duration_days=5,
        parameters={
            "market_drift": -0.50,
            "volatility_multiplier": 3.0,
            "sentiment": "panic",
            "correlation_increase": 0.3,  # Everything goes down together
            "jump_probability": 0.05,
            "recovery_day": 4  # Partial recovery
        }
    ),
    
    "choppy_market": MarketScenario(
        name="Sideways Chop",
        duration_days=60,
        parameters={
            "market_drift": 0.02,
            "volatility_multiplier": 1.2,
            "sentiment": "uncertain",
            "mean_reversion_strength": 2.0,  # Strong pull to center
            "range_bound": True,
            "range_high": 1.05,
            "range_low": 0.95
        }
    ),
    
    "sector_rotation": MarketScenario(
        name="Sector Rotation",
        duration_days=30,
        parameters={
            "market_drift": 0.08,
            "winning_sectors": ["financials", "energy", "industrials"],
            "losing_sectors": ["technology", "consumer_discretionary"],
            "rotation_speed": "fast"
        }
    ),
    
    "fed_announcement": MarketScenario(
        name="Fed Rate Decision",
        duration_days=3,
        parameters={
            "announcement_day": 2,
            "pre_announcement_volatility": 0.5,
            "announcement_jump_size": 0.02,
            "post_announcement_trend": "follows_announcement"
        }
    ),
    
    "earnings_season": MarketScenario(
        name="Earnings Season Volatility",
        duration_days=30,
        parameters={
            "individual_stock_volatility_increase": 2.0,
            "earnings_beat_probability": 0.70,
            "average_beat_reaction": 0.05,
            "average_miss_reaction": -0.08
        }
    ),
    
    "black_swan": MarketScenario(
        name="Black Swan Event",
        duration_days=10,
        parameters={
            "event_day": 1,
            "initial_drop": -0.15,
            "correlation_spike": 0.95,
            "volatility_multiplier": 5.0,
            "gradual_recovery": True,
            "recovery_volatility": 2.5
        }
    ),
    
    "inflation_surge": MarketScenario(
        name="Inflation Surge",
        duration_days=60,
        parameters={
            "market_drift": -0.10,
            "winning_sectors": ["energy", "materials", "real_estate"],
            "losing_sectors": ["technology", "consumer_discretionary"],
            "bond_reaction": -0.15,
            "commodity_rally": 0.30
        }
    ),
    
    "tech_bubble": MarketScenario(
        name="Tech Bubble",
        duration_days=120,
        parameters={
            "phase_1_days": 60,  # Irrational exuberance
            "phase_1_tech_drift": 0.80,
            "phase_2_days": 30,  # Peak and reversal
            "phase_2_tech_drift": 0.10,
            "phase_3_days": 30,  # Crash
            "phase_3_tech_drift": -0.60,
            "other_sectors_drift": 0.05
        }
    )
}
```

### Historical Replay System

```python
"""
Replay actual historical market events for education.
Uses real historical data patterns, not just random generation.
"""

class HistoricalReplay:
    HISTORICAL_EVENTS = {
        "2008_financial_crisis": {
            "start_date": "2008-09-01",
            "end_date": "2009-03-31",
            "description": "Global Financial Crisis",
            "key_learning_points": [
                "Market contagion effects",
                "Importance of risk management",
                "Correlation breakdown during crisis",
                "Value of diversification (or lack thereof)"
            ],
            "data_source": "historical_prices"
        },
        
        "2010_flash_crash": {
            "start_date": "2010-05-06",
            "end_date": "2010-05-07",
            "description": "May 6 Flash Crash",
            "key_learning_points": [
                "Algorithmic trading impact",
                "Liquidity in crisis",
                "Circuit breakers",
                "Recovery patterns"
            ],
            "data_source": "historical_prices"
        },
        
        "2020_covid_crash": {
            "start_date": "2020-02-19",
            "end_date": "2020-08-31",
            "description": "COVID-19 Market Crash and Recovery",
            "key_learning_points": [
                "Speed of modern market crashes",
                "Government intervention effects",
                "V-shaped recovery possibility",
                "Sector divergence during crisis"
            ],
            "data_source": "historical_prices"
        },
        
        "2021_meme_stocks": {
            "start_date": "2021-01-11",
            "end_date": "2021-02-15",
            "description": "GameStop Short Squeeze",
            "key_learning_points": [
                "Short squeeze mechanics",
                "Social media impact on markets",
                "Volatility trading",
                "Market manipulation concerns"
            ],
            "data_source": "historical_prices"
        },
        
        "2022_bear_market": {
            "start_date": "2022-01-01",
            "end_date": "2022-10-31",
            "description": "2022 Bear Market",
            "key_learning_points": [
                "Interest rate impact",
                "Growth vs value rotation",
                "Crypto correlation",
                "Bond-stock correlation shift"
            ],
            "data_source": "historical_prices"
        }
    }
    
    def load_historical_scenario(self, event_name: str) -> HistoricalScenarioData:
        """Load historical data for scenario replay."""
        event = self.HISTORICAL_EVENTS[event_name]
        
        # Load actual historical prices
        prices = self._load_historical_prices(
            start_date=event["start_date"],
            end_date=event["end_date"]
        )
        
        # Load historical news for context
        news = self._load_historical_news(
            start_date=event["start_date"],
            end_date=event["end_date"]
        )
        
        return HistoricalScenarioData(
            name=event_name,
            description=event["description"],
            prices=prices,
            news=news,
            learning_points=event["key_learning_points"],
            educational_overlay=self._generate_educational_overlay(event_name)
        )
    
    def _generate_educational_overlay(self, event_name: str) -> List[EducationalOverlay]:
        """Generate educational popups for key moments in history."""
        
        overlays = {
            "2008_financial_crisis": [
                EducationalOverlay(
                    date="2008-09-15",
                    title="Lehman Brothers Bankruptcy",
                    content="Lehman Brothers, the fourth-largest investment bank, files for bankruptcy...",
                    market_impact="S&P 500 drops 4.7%",
                    lesson="Counterparty risk and systemic importance"
                ),
                EducationalOverlay(
                    date="2008-10-13",
                    title="Fed Announces Emergency Measures",
                    content="Federal Reserve coordinates with global central banks...",
                    market_impact="Largest single-day gain in history",
                    lesson="Government intervention and market response"
                )
            ]
        }
        
        return overlays.get(event_name, [])
```

---

## NEWS SIMULATION ENGINE

### News Generation System

```python
class NewsEngine:
    """
    Generates realistic financial news that affects simulated markets.
    """
    
    NEWS_CATEGORIES = {
        "company_specific": {
            "earnings": {
                "templates": [
                    "{company} Reports Q{quarter} EPS of ${eps}, {beat_or_miss} by ${difference}",
                    "{company} {beats_or_misses} Revenue Estimates with ${revenue}B",
                    "{company} Raises Full Year Guidance"
                ],
                "impact_range": (-0.08, 0.08),
                "duration_minutes": 60
            },
            "management": {
                "templates": [
                    "{company} CEO Announces Retirement",
                    "{company} Names New Chief Financial Officer",
                    "{company} Board Approves Stock Buyback Program"
                ],
                "impact_range": (-0.03, 0.03),
                "duration_minutes": 120
            },
            "product": {
                "templates": [
                    "{company} Launches Revolutionary New Product",
                    "{company} Recalls Products Due to Safety Concerns",
                    "{company} Receives FDA Approval for New Drug"
                ],
                "impact_range": (-0.05, 0.10),
                "duration_minutes": 240
            }
        },
        
        "sector_wide": {
            "regulatory": {
                "templates": [
                    "New Regulations Expected for {sector} Sector",
                    "{sector} Stocks Rally on Deregulation News",
                    "Government Announces Antitrust Investigation into {company}"
                ],
                "impact_range": (-0.04, 0.04),
                "affected_scope": "sector"
            },
            "industry_trend": {
                "templates": [
                    "{sector} Sector Sees Strong Demand Growth",
                    "Supply Chain Issues Impact {sector} Industry",
                    "Analysts Upgrade {sector} Sector to Overweight"
                ],
                "impact_range": (-0.02, 0.03),
                "affected_scope": "sector"
            }
        },
        
        "macro_economic": {
            "fed": {
                "templates": [
                    "Federal Reserve Raises Interest Rates by {basis_points} Basis Points",
                    "Fed Chair Signals Pause in Rate Hikes",
                    "FOMC Minutes Show Divided Views on Future Policy"
                ],
                "impact_range": (-0.02, 0.02),
                "affected_scope": "market"
            },
            "economic_data": {
                "templates": [
                    "Jobs Report Shows {jobs} New Jobs, {above_or_below} Expectations",
                    "Inflation Data Comes In {hot_or_cool}, CPI at {cpi}%",
                    "GDP Growth Slows to {gdp}%, Below Forecasts"
                ],
                "impact_range": (-0.015, 0.015),
                "affected_scope": "market"
            },
            "geopolitical": {
                "templates": [
                    "Markets React to Trade Tensions",
                    "Oil Prices Spike on Middle East Concerns",
                    "Global Markets Slide on Economic Uncertainty"
                ],
                "impact_range": (-0.025, 0.01),
                "affected_scope": "market"
            }
        }
    }
    
    def generate_news_event(
        self, 
        context: MarketContext
    ) -> Optional[NewsEvent]:
        """Generate a news event based on market context."""
        
        # Determine if news should be generated
        news_probability = self._calculate_news_probability(context)
        
        if random.random() > news_probability:
            return None
        
        # Select news category based on context
        category = self._select_category(context)
        subcategory = self._select_subcategory(category, context)
        
        # Generate news content
        template_config = self.NEWS_CATEGORIES[category][subcategory]
        template = random.choice(template_config["templates"])
        
        # Fill in template variables
        filled_template = self._fill_template(template, context)
        
        # Calculate market impact
        impact = random.uniform(*template_config["impact_range"])
        
        # Adjust impact based on market sentiment
        if context.sentiment == "bullish" and impact > 0:
            impact *= 1.2
        elif context.sentiment == "bearish" and impact < 0:
            impact *= 1.2
        
        return NewsEvent(
            headline=filled_template,
            category=category,
            subcategory=subcategory,
            timestamp=datetime.now(),
            impact=impact,
            duration_minutes=template_config.get("duration_minutes", 60),
            affected_scope=template_config.get("affected_scope", "company"),
            affected_symbols=self._determine_affected_symbols(
                category, subcategory, context
            )
        )
    
    def generate_earnings_announcement(
        self, 
        company: Company
    ) -> EarningsNewsEvent:
        """Generate a detailed earnings announcement."""
        
        # Determine if beat or miss (70% beat historically)
        beats = random.random() < 0.70
        
        # Generate financial numbers
        expected_eps = company.analyst_estimates["eps"]
        actual_eps = expected_eps * (
            random.uniform(1.01, 1.15) if beats else random.uniform(0.85, 0.99)
        )
        
        expected_revenue = company.analyst_estimates["revenue"]
        actual_revenue = expected_revenue * (
            random.uniform(1.01, 1.08) if beats else random.uniform(0.94, 0.99)
        )
        
        # Generate guidance
        guidance = random.choice(["raised", "maintained", "lowered"])
        if beats:
            guidance = random.choices(
                ["raised", "maintained", "lowered"],
                weights=[0.5, 0.4, 0.1]
            )[0]
        
        # Calculate stock impact
        base_impact = 0.03 if beats else -0.05
        eps_surprise = (actual_eps - expected_eps) / expected_eps
        guidance_impact = {"raised": 0.02, "maintained": 0, "lowered": -0.03}[guidance]
        
        total_impact = base_impact + (eps_surprise * 5) + guidance_impact
        
        return EarningsNewsEvent(
            company=company.symbol,
            headline=f"{company.name} Reports Q{self._get_quarter()} Results",
            actual_eps=actual_eps,
            expected_eps=expected_eps,
            actual_revenue=actual_revenue,
            expected_revenue=expected_revenue,
            guidance=guidance,
            beats_eps=beats,
            stock_impact=total_impact,
            key_metrics={
                "gross_margin": company.financials["gross_margin"] * random.uniform(0.98, 1.02),
                "operating_margin": company.financials["operating_margin"] * random.uniform(0.95, 1.05),
                "user_growth": random.uniform(-0.02, 0.08) if company.sector == "technology" else None
            }
        )
```

---

## UNIVERSE OF SECURITIES

### Simulated Asset Universe

```yaml
Asset Categories:

Individual Stocks (150):
  Large Cap (50):
    - Technology: AAPL, MSFT, GOOGL, AMZN, META, NVDA, TSLA, etc.
    - Healthcare: JNJ, UNH, PFE, ABT, MRK, etc.
    - Financials: JPM, BAC, WFC, GS, MS, etc.
    - Consumer: WMT, PG, KO, PEP, MCD, etc.
    - Industrials: CAT, BA, HON, UNP, etc.
    - Energy: XOM, CVX, COP, etc.
    
  Mid Cap (50):
    - Mixed sectors representing real mid-cap universe
    
  Small Cap (50):
    - Higher volatility, educational for risk concepts

ETFs (50):
  Index ETFs:
    - SPY: S&P 500
    - QQQ: Nasdaq 100
    - IWM: Russell 2000
    - DIA: Dow Jones
    
  Sector ETFs:
    - XLF: Financials
    - XLK: Technology
    - XLE: Energy
    - XLV: Healthcare
    - XLI: Industrials
    - XLY: Consumer Discretionary
    - XLP: Consumer Staples
    - XLU: Utilities
    - XLB: Materials
    - XLRE: Real Estate
    
  Fixed Income ETFs:
    - TLT: Long-Term Treasury
    - IEF: Intermediate Treasury
    - LQD: Investment Grade Corporate
    - HYG: High Yield Corporate
    - AGG: Total Bond Market
    
  Commodity ETFs:
    - GLD: Gold
    - SLV: Silver
    - USO: Oil
    - UNG: Natural Gas
    
  International ETFs:
    - EFA: Developed Markets
    - EEM: Emerging Markets
    - VGK: Europe
    - FXI: China
    
  Specialty ETFs:
    - VXX: Volatility
    - ARKK: Innovation
    - SCHD: Dividend

Options (Educational):
  - Available on all major stocks and ETFs
  - Weekly and monthly expirations
  - Standard strike increments
  
Futures (Educational):
  - ES: S&P 500 E-mini
  - NQ: Nasdaq 100 E-mini
  - YM: Dow Jones E-mini
  - GC: Gold
  - CL: Crude Oil

Cryptocurrency (Educational):
  - BTC-USD: Bitcoin
  - ETH-USD: Ethereum
  - SOL-USD: Solana
```

### Company Data Model

```python
@dataclass
class SimulatedCompany:
    """Data model for a simulated company."""
    
    # Basic Info
    symbol: str
    name: str
    sector: str
    industry: str
    market_cap: float
    employees: int
    
    # Price Characteristics
    current_price: float
    beta: float
    volatility: float
    dividend_yield: float
    
    # Fundamentals
    pe_ratio: float
    pb_ratio: float
    ps_ratio: float
    peg_ratio: float
    
    revenue: float
    net_income: float
    gross_margin: float
    operating_margin: float
    net_margin: float
    
    revenue_growth: float
    earnings_growth: float
    
    # Balance Sheet
    total_assets: float
    total_debt: float
    cash: float
    debt_to_equity: float
    current_ratio: float
    
    # Analyst Info
    analyst_rating: str  # Buy, Hold, Sell
    price_target: float
    num_analysts: int
    
    # Events
    next_earnings_date: date
    ex_dividend_date: Optional[date]


# Example: Apple Simulation Parameters
AAPL_SIMULATION = SimulatedCompany(
    symbol="AAPL",
    name="Apple Inc.",
    sector="Technology",
    industry="Consumer Electronics",
    market_cap=3_000_000_000_000,  # $3T
    employees=164000,
    
    current_price=185.00,
    beta=1.25,
    volatility=0.28,
    dividend_yield=0.005,
    
    pe_ratio=28.5,
    pb_ratio=45.0,
    ps_ratio=7.5,
    peg_ratio=2.8,
    
    revenue=383_000_000_000,
    net_income=97_000_000_000,
    gross_margin=0.438,
    operating_margin=0.298,
    net_margin=0.253,
    
    revenue_growth=0.05,
    earnings_growth=0.08,
    
    total_assets=352_000_000_000,
    total_debt=111_000_000_000,
    cash=62_000_000_000,
    debt_to_equity=1.95,
    current_ratio=0.99,
    
    analyst_rating="Buy",
    price_target=210.00,
    num_analysts=42,
    
    next_earnings_date=date(2024, 4, 25),
    ex_dividend_date=date(2024, 2, 9)
)
```

---

## ORDER EXECUTION SIMULATION

### Order Book Simulation

```python
class SimulatedOrderBook:
    """
    Simulates a realistic order book with bid/ask dynamics.
    """
    
    def __init__(self, symbol: str, initial_price: float):
        self.symbol = symbol
        self.bids = []  # [(price, quantity, order_id), ...]
        self.asks = []  # [(price, quantity, order_id), ...]
        self._initialize_book(initial_price)
    
    def _initialize_book(self, mid_price: float):
        """Initialize order book with simulated liquidity."""
        
        spread = mid_price * 0.0005  # 5 basis points spread
        
        # Generate bid side
        for i in range(10):
            price = mid_price - spread/2 - (i * 0.01)
            quantity = int(np.random.exponential(500) + 100)
            self.bids.append((price, quantity, str(uuid.uuid4())))
        
        # Generate ask side
        for i in range(10):
            price = mid_price + spread/2 + (i * 0.01)
            quantity = int(np.random.exponential(500) + 100)
            self.asks.append((price, quantity, str(uuid.uuid4())))
        
        self.bids.sort(key=lambda x: x[0], reverse=True)
        self.asks.sort(key=lambda x: x[0])
    
    def get_best_bid(self) -> Tuple[float, int]:
        """Get best bid price and quantity."""
        return (self.bids[0][0], self.bids[0][1]) if self.bids else (0, 0)
    
    def get_best_ask(self) -> Tuple[float, int]:
        """Get best ask price and quantity."""
        return (self.asks[0][0], self.asks[0][1]) if self.asks else (float('inf'), 0)
    
    def get_spread(self) -> float:
        """Get current bid-ask spread."""
        bid, _ = self.get_best_bid()
        ask, _ = self.get_best_ask()
        return ask - bid
    
    def simulate_market_order(
        self, 
        side: str, 
        quantity: int
    ) -> List[Fill]:
        """Simulate a market order execution with realistic slippage."""
        
        fills = []
        remaining = quantity
        
        if side == "buy":
            levels = self.asks.copy()
            for price, available, order_id in levels:
                if remaining <= 0:
                    break
                
                fill_qty = min(remaining, available)
                fills.append(Fill(
                    price=price,
                    quantity=fill_qty,
                    timestamp=datetime.now()
                ))
                remaining -= fill_qty
                
                # Remove or reduce liquidity
                self._reduce_liquidity("ask", price, fill_qty)
        
        else:  # sell
            levels = self.bids.copy()
            for price, available, order_id in levels:
                if remaining <= 0:
                    break
                
                fill_qty = min(remaining, available)
                fills.append(Fill(
                    price=price,
                    quantity=fill_qty,
                    timestamp=datetime.now()
                ))
                remaining -= fill_qty
                
                self._reduce_liquidity("bid", price, fill_qty)
        
        # Regenerate liquidity after trade
        self._regenerate_liquidity()
        
        return fills
    
    def get_market_impact(self, side: str, quantity: int) -> float:
        """Estimate market impact of a large order."""
        
        fills = self.simulate_market_order(side, quantity)
        
        if not fills:
            return 0
        
        vwap = sum(f.price * f.quantity for f in fills) / sum(f.quantity for f in fills)
        
        if side == "buy":
            mid = (self.get_best_bid()[0] + self.get_best_ask()[0]) / 2
            return (vwap - mid) / mid
        else:
            mid = (self.get_best_bid()[0] + self.get_best_ask()[0]) / 2
            return (mid - vwap) / mid
```

### Fill Simulation

```python
class FillSimulator:
    """
    Simulates realistic order fills with appropriate delays
    and partial fills for educational realism.
    """
    
    def simulate_fill(
        self,
        order: Order,
        market_state: MarketState,
        order_book: SimulatedOrderBook
    ) -> FillResult:
        """Simulate order fill with realistic behavior."""
        
        if order.order_type == "market":
            return self._simulate_market_fill(order, order_book)
        
        elif order.order_type == "limit":
            return self._simulate_limit_fill(order, market_state, order_book)
        
        elif order.order_type == "stop":
            return self._simulate_stop_fill(order, market_state, order_book)
        
        elif order.order_type == "stop_limit":
            return self._simulate_stop_limit_fill(order, market_state, order_book)
    
    def _simulate_market_fill(
        self,
        order: Order,
        order_book: SimulatedOrderBook
    ) -> FillResult:
        """Market orders fill immediately with potential slippage."""
        
        fills = order_book.simulate_market_order(order.side, order.quantity)
        
        if not fills:
            return FillResult(
                status="rejected",
                reason="Insufficient liquidity"
            )
        
        total_filled = sum(f.quantity for f in fills)
        avg_price = sum(f.price * f.quantity for f in fills) / total_filled
        
        # Add realistic delay (10-50ms)
        execution_delay = random.uniform(0.010, 0.050)
        
        return FillResult(
            status="filled",
            fills=fills,
            average_price=avg_price,
            total_filled=total_filled,
            execution_delay=execution_delay,
            slippage=self._calculate_slippage(order, avg_price)
        )
    
    def _simulate_limit_fill(
        self,
        order: Order,
        market_state: MarketState,
        order_book: SimulatedOrderBook
    ) -> FillResult:
        """Limit orders may fill partially or not at all."""
        
        if order.side == "buy":
            best_ask = order_book.get_best_ask()[0]
            
            if order.limit_price >= best_ask:
                # Immediate fill possible
                return self._simulate_market_fill(order, order_book)
            else:
                # Order sits on book
                fill_probability = self._calculate_limit_fill_probability(
                    order.limit_price, best_ask, market_state
                )
                
                if random.random() < fill_probability:
                    return FillResult(
                        status="filled",
                        fills=[Fill(price=order.limit_price, quantity=order.quantity)],
                        average_price=order.limit_price
                    )
                else:
                    return FillResult(
                        status="pending",
                        reason="Limit price not reached"
                    )
        
        else:  # sell
            best_bid = order_book.get_best_bid()[0]
            
            if order.limit_price <= best_bid:
                return self._simulate_market_fill(order, order_book)
            else:
                fill_probability = self._calculate_limit_fill_probability(
                    order.limit_price, best_bid, market_state
                )
                
                if random.random() < fill_probability:
                    return FillResult(
                        status="filled",
                        fills=[Fill(price=order.limit_price, quantity=order.quantity)],
                        average_price=order.limit_price
                    )
                else:
                    return FillResult(
                        status="pending",
                        reason="Limit price not reached"
                    )
```

---

## REAL-TIME DATA STREAMING

### WebSocket Data Feed

```python
class MarketDataStreamer:
    """
    Streams real-time simulated market data via WebSocket.
    """
    
    def __init__(self, simulation_engine: MarketSimulationEngine):
        self.simulation_engine = simulation_engine
        self.subscribers: Dict[str, List[WebSocket]] = defaultdict(list)
    
    async def start_streaming(self):
        """Start streaming market data."""
        
        while True:
            # Generate ticks for all active symbols
            for symbol in self.simulation_engine.active_symbols:
                tick = self.simulation_engine.generate_tick(symbol)
                
                # Broadcast to subscribers
                await self._broadcast_tick(symbol, tick)
            
            # Stream at ~10 ticks per second
            await asyncio.sleep(0.1)
    
    async def _broadcast_tick(self, symbol: str, tick: Tick):
        """Broadcast tick to all subscribers."""
        
        message = {
            "type": "tick",
            "symbol": symbol,
            "data": {
                "price": tick.price,
                "bid": tick.bid,
                "ask": tick.ask,
                "volume": tick.volume,
                "timestamp": tick.timestamp.isoformat()
            }
        }
        
        for ws in self.subscribers[symbol]:
            try:
                await ws.send_json(message)
            except:
                self.subscribers[symbol].remove(ws)


# WebSocket Message Types
WEBSOCKET_MESSAGE_TYPES = {
    "subscribe": {
        "description": "Subscribe to symbol updates",
        "payload": {"symbols": ["AAPL", "MSFT"]}
    },
    "unsubscribe": {
        "description": "Unsubscribe from symbols",
        "payload": {"symbols": ["AAPL"]}
    },
    "tick": {
        "description": "Price tick update",
        "payload": {
            "symbol": "AAPL",
            "price": 185.42,
            "bid": 185.41,
            "ask": 185.43,
            "volume": 1250,
            "timestamp": "2024-01-29T14:30:00Z"
        }
    },
    "trade": {
        "description": "Trade execution notification",
        "payload": {
            "symbol": "AAPL",
            "price": 185.42,
            "quantity": 100,
            "side": "buy",
            "timestamp": "2024-01-29T14:30:00Z"
        }
    },
    "news": {
        "description": "News event notification",
        "payload": {
            "headline": "Apple Reports Strong Q1 Earnings",
            "category": "earnings",
            "impact": "positive",
            "affected_symbols": ["AAPL"],
            "timestamp": "2024-01-29T16:30:00Z"
        }
    },
    "market_status": {
        "description": "Market session status",
        "payload": {
            "session": "regular",
            "status": "open",
            "next_event": "close",
            "next_event_time": "2024-01-29T16:00:00Z"
        }
    }
}
```

---

## DATA MODELS

### Core Data Structures

```python
# Time Series Data Models

@dataclass
class OHLCV:
    """Open-High-Low-Close-Volume candle."""
    timestamp: datetime
    open: float
    high: float
    low: float
    close: float
    volume: int
    
    @property
    def typical_price(self) -> float:
        return (self.high + self.low + self.close) / 3
    
    @property
    def is_bullish(self) -> bool:
        return self.close > self.open


@dataclass
class Quote:
    """Real-time quote snapshot."""
    symbol: str
    bid: float
    bid_size: int
    ask: float
    ask_size: int
    last: float
    last_size: int
    timestamp: datetime
    
    @property
    def spread(self) -> float:
        return self.ask - self.bid
    
    @property
    def mid(self) -> float:
        return (self.bid + self.ask) / 2


@dataclass
class MarketDepth:
    """Full order book depth."""
    symbol: str
    bids: List[Tuple[float, int]]  # [(price, size), ...]
    asks: List[Tuple[float, int]]
    timestamp: datetime
    
    @property
    def bid_depth(self) -> int:
        return sum(size for _, size in self.bids)
    
    @property
    def ask_depth(self) -> int:
        return sum(size for _, size in self.asks)
    
    @property
    def imbalance(self) -> float:
        total = self.bid_depth + self.ask_depth
        return (self.bid_depth - self.ask_depth) / total if total > 0 else 0


@dataclass
class DailyStats:
    """Daily market statistics."""
    symbol: str
    date: date
    open: float
    high: float
    low: float
    close: float
    volume: int
    
    prev_close: float
    change: float
    change_percent: float
    
    vwap: float
    avg_volume_30d: int
    relative_volume: float
    
    high_52w: float
    low_52w: float


# Portfolio Data Models

@dataclass  
class Position:
    """Current position in a security."""
    symbol: str
    quantity: int
    average_cost: float
    current_price: float
    
    @property
    def market_value(self) -> float:
        return self.quantity * self.current_price
    
    @property
    def cost_basis(self) -> float:
        return self.quantity * self.average_cost
    
    @property
    def unrealized_pnl(self) -> float:
        return self.market_value - self.cost_basis
    
    @property
    def unrealized_pnl_percent(self) -> float:
        return (self.unrealized_pnl / self.cost_basis) * 100 if self.cost_basis > 0 else 0


@dataclass
class Order:
    """Order representation."""
    id: str
    symbol: str
    side: str  # "buy" or "sell"
    order_type: str  # "market", "limit", "stop", "stop_limit"
    quantity: int
    limit_price: Optional[float]
    stop_price: Optional[float]
    
    status: str  # "pending", "filled", "partial", "cancelled", "rejected"
    filled_quantity: int = 0
    average_fill_price: Optional[float] = None
    
    time_in_force: str = "day"  # "day", "gtc", "ioc", "fok"
    created_at: datetime = field(default_factory=datetime.now)
    filled_at: Optional[datetime] = None


@dataclass
class Trade:
    """Executed trade record."""
    id: str
    order_id: str
    symbol: str
    side: str
    quantity: int
    price: float
    commission: float
    timestamp: datetime
    
    @property
    def total_cost(self) -> float:
        return (self.quantity * self.price) + self.commission
```

---

*Document Version: 1.0*
*Last Updated: January 29, 2026*
