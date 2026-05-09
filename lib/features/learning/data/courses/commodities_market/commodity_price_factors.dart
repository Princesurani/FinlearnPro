/// Chapter 6: Factors Affecting Commodity Prices
/// Supply, demand, geopolitics, and weather
class CommodityPriceFactorsContent {
  // Lesson 6.1: Supply & Demand Forces
  static Map<String, dynamic> getSupplyDemandContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Only Two Forces That Matter',
          'emoji': '⚖️',
          'content':
              'At the core, every commodity price is determined by just two forces: supply and demand. But understanding WHAT drives supply and demand for each commodity is where the real skill lies.',
        },
        {
          'type': 'concept',
          'title': 'Supply Drivers',
          'emoji': '🏭',
          'content': '''
**What Increases Supply (Price Falls):**

**1. New Production 🆕**
• New oil fields discovered (US shale revolution crashed oil from \$110 to \$30)
• New mines opened (increased copper production from Chile/Peru)
• Bumper crop harvests (good monsoon = surplus wheat)

**2. Technology Improvements 🔧**
• Fracking made previously inaccessible oil recoverable
• Better farming techniques increase crop yields
• Recycling reduces need for newly mined metals

**3. Government Decisions 🏛️**
• OPEC decides to increase oil production quotas
• India releases buffer stocks of wheat into the market
• Mining regulations relaxed in a major producing country

---

**What Decreases Supply (Price Rises):**
• Natural disasters destroying crops or mines
• OPEC production cuts
• Export bans (India banned wheat exports in 2022)
• Political instability in producing countries (Libya, Venezuela)
• Mine closures due to environmental regulations

---

**Key Insight:**
Supply disruptions cause the SHARPEST price spikes. It takes years to open a new mine or drill a new oil well, but a hurricane can shut down Gulf of Mexico oil rigs overnight. Supply shocks are sudden; supply increases are gradual.
''',
          'keyPoints': [
            'New production, technology, and government decisions increase supply',
            'Disasters, production cuts, and export bans decrease supply',
            'Supply shocks cause sharp, sudden price spikes',
            'Supply increases are gradual; supply decreases can be instant',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Demand Drivers',
          'emoji': '📈',
          'content': '''
**What Increases Demand (Price Rises):**

**1. Economic Growth 📊**
• China building infrastructure = massive copper, steel, cement demand
• India's EV push = lithium, nickel demand skyrocketing
• Urbanization = more energy, more construction materials

**2. Seasonal Patterns 📅**
• Gold demand surges during Indian wedding + Diwali season (Oct-Feb)
• Natural gas demand peaks in winter (heating)
• Agricultural demand peaks during harvest and planting cycles

**3. New Use Cases 🔋**
• Electric vehicles created massive new demand for lithium and nickel
• Solar panels increased silver demand (silver is used in photovoltaic cells)
• Biofuel mandates increased demand for corn and sugarcane

**4. Investment Demand 💰**
• Central banks buying gold (China, India, Russia added 1,000+ tonnes in 2023)
• Gold ETF inflows during crises
• Speculative buying during commodity bull markets

---

**What Decreases Demand (Price Falls):**
• Economic recession (2008: oil fell from \$147 to \$33)
• Substitution (natural gas replacing coal for power generation)
• Technological efficiency (cars using less fuel per km)

**Key Lesson:**
India's gold demand peaks Oct-Feb (wedding + festival season). If you're investing in gold, buying in May-June (low demand) and selling Nov-Dec (peak demand) has historically worked well. Seasonality is your friend.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'OPEC announces a surprise production cut of 2 million barrels/day. What happens to crude oil prices?',
          'options': [
            'Prices fall — less production means less value',
            'Prices rise sharply — reduced supply against unchanged demand creates a deficit',
            'Prices stay the same — OPEC doesn\'t affect global markets',
            'Prices fall because traders sell on the news',
          ],
          'correctIndex': 1,
          'explanation':
              'OPEC controls ~40% of global oil supply. A 2 million barrel/day cut creates an immediate supply deficit. Demand doesn\'t change overnight, so the same number of buyers are chasing fewer barrels. Basic economics: less supply + same demand = higher prices. Oil prices typically spike 5-10% on such announcements.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Supply: production, technology, government decisions',
            'Demand: economic growth, seasons, new use cases, investment buying',
            'Supply shocks are sudden and cause sharp spikes; demand shifts are gradual',
            'Seasonality matters — gold peaks Oct-Feb, natural gas peaks in winter',
            'Next: Beyond supply and demand — geopolitics, weather, and the Dollar.',
          ],
        },
      ],
    };
  }

  // Lesson 6.2: Geopolitics, Weather & the Dollar
  static Map<String, dynamic> getExternalFactorsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Wild Cards',
          'emoji': '🃏',
          'content':
              'Supply and demand explain 70% of commodity price moves. The other 30%? Geopolitics, weather, and the US Dollar. These "wild cards" can override fundamentals overnight.',
        },
        {
          'type': 'story',
          'title': 'Russia-Ukraine: The Commodity Tsunami',
          'emoji': '🌊',
          'content': '''
**February 24, 2022. Russia invades Ukraine.**

**Russia is:**
• World's 3rd largest oil producer
• World's largest natural gas exporter
• Top wheat exporter (with Ukraine)
• Major palladium, nickel, and aluminum producer

**Ukraine is:**
• Called the "breadbasket of Europe"
• Top 5 global wheat and corn exporter
• Major sunflower oil producer (50%+ of global supply!)

**What Happened to Commodities:**
• Brent Crude: \$90 → \$130 (+44% in weeks) 🛢️
• Wheat: ₹2,100/quintal → ₹2,800 (+33%) 🌾
• Natural Gas: Doubled in Europe within months 🔥
• Nickel: Rose 250% in ONE DAY (London Metal Exchange halted trading!) 📈
• Sunflower oil: Disappeared from Indian supermarket shelves 🫙

**Impact on India:**
• Petrol crossed ₹110/litre in multiple states
• Cooking oil prices surged 40%
• Inflation hit 7%+ (highest in years)
• RBI was forced into aggressive rate hikes

**Lesson:**
A war 5,000 km away changed the price of atta, oil, and petrol in your local market within weeks. Commodity markets are globally interconnected — what happens in Ukraine affects your kitchen budget in India.
''',
        },
        {
          'type': 'concept',
          'title': 'The Three Wild Cards',
          'emoji': '🎴',
          'content': '''
**1. Geopolitics 🌍**
• Middle East tension = oil price spike (Strait of Hormuz carries 20% of global oil)
• Trade wars (US-China tariffs disrupted agricultural commodity flows)
• Sanctions (Russian sanctions disrupted energy, metals, and grain markets)
• Elections in major producing nations can change commodity policies overnight

**2. Weather & Climate 🌧️**
• El Niño/La Niña affect crop yields across Asia, Americas, and Australia
• Hurricanes disrupt Gulf of Mexico oil production
• Indian monsoon determines agricultural commodity prices domestically
• Climate change is creating longer droughts and more extreme weather

**3. US Dollar Strength 💵**
• Most commodities are priced in USD globally
• When Dollar strengthens: Commodities become MORE expensive for non-USD buyers → Demand falls → Prices fall
• When Dollar weakens: Commodities become CHEAPER → Demand rises → Prices rise
• **Inverse relationship:** Dollar ↑ = Commodities ↓ (usually)

---

**Key Insight:**
To trade commodities well, you need to be a geopolitical analyst, a weather watcher, AND a currency tracker. It's not enough to study supply and demand — external shocks create the biggest trading opportunities and risks.
''',
          'keyPoints': [
            'Geopolitics (wars, sanctions) can spike prices 30-50% overnight',
            'Weather events (monsoon, El Niño) are the #1 driver of agricultural prices',
            'Commodities move inversely to the US Dollar — strong Dollar = weaker commodities',
            'External shocks create the biggest moves but are hardest to predict',
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 6 Complete! 🎉',
          'keyPoints': [
            'Supply and demand are the fundamentals — but external shocks create the big moves',
            'Russia-Ukraine war demonstrated how geopolitics affects YOUR daily life',
            'Weather (monsoon, El Niño) is unpredictable and drives agricultural prices',
            'US Dollar has an inverse relationship with most commodity prices',
            'Successful commodity traders must track geopolitics, weather, AND currencies',
            'Next: The specific risks of commodity trading — and how to survive them.',
          ],
        },
      ],
    };
  }
}
