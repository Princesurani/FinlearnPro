import random
from datetime import datetime, timezone
import json

class MarketContext:
    def __init__(self, sentiment="neutral", current_leaders=None, current_laggards=None):
        self.sentiment = sentiment
        self.current_leaders = current_leaders or []
        self.current_laggards = current_laggards or []
        self.active_sectors = [
            "technology", "financialServices", "healthcare",
            "consumerCyclical", "consumerDefensive", "industrials",
            "energy", "utilities", "realEstate", "basicMaterials",
            "communicationServices"
        ]

class NewsEngine:
    """
    Generates realistic financial news that affects simulated markets.
    Based on ADR-005.
    """
    NEWS_CATEGORIES = {
        "company_specific": {
            "earnings": {
                "templates": [
                    "{company} Reports Q{quarter} EPS of ${eps}, {beat_or_miss} by ${difference}",
                    "{company} {beats_or_misses} Revenue Estimates with ${revenue}B",
                    "{company} Raises Full Year Guidance",
                    "{company} Lowers Full Year Guidance on Supply Chain Issues"
                ],
                "impact_range": (-0.08, 0.08),
                "duration_minutes": 60,
                "scope": "symbol"
            },
            "management": {
                "templates": [
                    "{company} CEO Announces Unexpected Retirement",
                    "{company} Names New Chief Financial Officer",
                    "{company} Board Approves Massive Stock Buyback Program"
                ],
                "impact_range": (-0.03, 0.05),
                "duration_minutes": 120,
                "scope": "symbol"
            },
            "product": {
                "templates": [
                    "{company} Launches Revolutionary New Product Line",
                    "{company} Recalls Flagship Product Due to Safety Concerns",
                    "{company} Secures Major Government Contract"
                ],
                "impact_range": (-0.05, 0.10),
                "duration_minutes": 240,
                "scope": "symbol"
            }
        },
        "sector_wide": {
            "regulatory": {
                "templates": [
                    "New Regulations Expected for {sector} Sector",
                    "{sector} Stocks Rally on Unexpected Deregulation News",
                    "Government Announces Antitrust Investigation into Top {sector} Firms"
                ],
                "impact_range": (-0.04, 0.04),
                "scope": "sector"
            }
        },
        "macro_economic": {
            "fed": {
                "templates": [
                    "Federal Reserve Raises Interest Rates by 25 Basis Points",
                    "Fed Chair Signals Pause in Rate Hikes Following Inflation Data",
                    "FOMC Minutes Show Divided Views on Future Economic Policy"
                ],
                "impact_range": (-0.02, 0.02),
                "scope": "global"
            },
            "economic_data": {
                "templates": [
                    "Jobs Report Shows Strong Growth, Crushing Estimates",
                    "Inflation Data Comes In Hot, CPI Exceeds Expectations",
                    "GDP Growth Slows to 1.5%, Below Forecasts"
                ],
                "impact_range": (-0.015, 0.015),
                "scope": "global"
            }
        }
    }

    def _fill_template(self, template: str, category: str, subcat: str, target: str) -> str:
        # Simplistic template filler
        text = template
        if "{company}" in text:
            text = text.replace("{company}", target)
        if "{sector}" in text:
            text = text.replace("{sector}", target.capitalize())
        
        # Quarter
        if "{quarter}" in text:
            text = text.replace("{quarter}", str(random.randint(1,4)))
        
        # EPS/Earnings specific
        if "{eps}" in text:
            text = text.replace("{eps}", f"{random.uniform(0.5, 5.0):.2f}")
        
        is_beat = random.random() > 0.5
        verb1 = "Beats" if is_beat else "Misses"
        verb2 = "beat" if is_beat else "miss"
        
        if "{beat_or_miss}" in text:
            text = text.replace("{beat_or_miss}", verb2)
        if "{beats_or_misses}" in text:
            text = text.replace("{beats_or_misses}", verb1)
            
        if "{difference}" in text:
            text = text.replace("{difference}", f"{random.uniform(0.01, 0.50):.2f}")
        if "{revenue}" in text:
            text = text.replace("{revenue}", f"{random.uniform(1.0, 50.0):.1f}")
            
        return text

    def generate_news_event(self, context: MarketContext, active_symbols: list, active_sectors: list) -> dict:
        """
        Generate a random news event or return None if probability fails.
        """
        # 1% chance to generate news on a given poll tick (to avoid constant chaos)
        if random.random() > 0.01:
            return None

        cat_key = random.choice(list(self.NEWS_CATEGORIES.keys()))
        sub_key = random.choice(list(self.NEWS_CATEGORIES[cat_key].keys()))
        config = self.NEWS_CATEGORIES[cat_key][sub_key]
        
        template = random.choice(config["templates"])
        scope = config.get("scope", "global")
        
        target = "Market"
        affected_symbols = []
        
        if scope == "symbol" and active_symbols:
            target = random.choice(active_symbols)
            affected_symbols = [target]
        elif scope == "sector" and active_sectors:
            target = random.choice(active_sectors)
            # Would typically resolve which symbols belong to the sector here.
            
        headline = self._fill_template(template, cat_key, sub_key, target)
        
        # Divide raw theoretical impact by 10 for realistic sub-1% minute-tick jumps
        impact = random.uniform(*config["impact_range"]) / 10.0
        
        # Amplify impact if sentiment matches
        if context.sentiment == "bullish" and impact > 0:
            impact *= 1.2
        elif context.sentiment == "bearish" and impact < 0:
            impact *= 1.2

        return {
            "headline": headline,
            "category": cat_key,
            "subcategory": sub_key,
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "impact": impact,
            "duration_minutes": config.get("duration_minutes", 60),
            "affected_scope": scope,
            "affected_symbols": affected_symbols
        }
