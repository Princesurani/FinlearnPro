/// Chapter 3: Types of Commodities
/// Metals, energy, and agricultural products
class CommodityTypesContent {
  // Lesson 3.1: Precious & Industrial Metals
  static Map<String, dynamic> getMetalsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Shiny and the Useful',
          'emoji': '🥇',
          'content':
              'Gold has been worshipped for 5,000 years. Copper built modern civilization. Silver straddles both worlds. Metals are divided into two groups — precious (store of value) and industrial (economic use). Each trades on completely different logic.',
        },
        {
          'type': 'concept',
          'title': 'Precious Metals: Store of Value',
          'emoji': '✨',
          'content': '''
**Gold (The King) 👑**
• India is the world's 2nd largest gold consumer (~800-900 tonnes/year)
• Price driver: Fear. When markets crash, investors buy gold.
• Also driven by: US Dollar strength, interest rates, central bank buying
• Indian connection: Weddings, Diwali, Akshaya Tritiya — cultural demand is massive
• MCX Gold: ₹55,000-75,000 per 10 grams (as of 2024-25)

**Silver (Gold's Volatile Cousin) 🪙**
• Part precious metal, part industrial metal (solar panels, electronics)
• More volatile than gold — can swing 5% in a day
• Gold-Silver Ratio: Historically, 1 gold = 60-80 silver. Traders watch this ratio.
• MCX Silver: ₹65,000-95,000 per kg

---

**Industrial Metals: Economic Barometers 🏭**
• **Copper:** "Dr. Copper" — its price predicts economic health. Rising copper = growing economy.
• **Aluminum:** Used in everything from aircraft to beverage cans.
• **Zinc:** Anti-corrosion coating for steel.
• **Nickel:** Battery technology for EVs. Demand is skyrocketing.

---

**Key Insight:**
Gold tells you about fear. Copper tells you about growth. Together, they paint a picture of the global economy. When gold rises AND copper falls = recession warning. When both rise = inflation.
''',
          'keyPoints': [
            'Gold = fear/safety trade; rises during crises and inflation',
            'Silver = hybrid precious/industrial; more volatile than gold',
            'Copper = economic barometer; rising copper signals economic growth',
            'India is the 2nd largest gold consumer — cultural and investment demand',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Copper prices are rising sharply while gold prices are falling. What does this likely indicate about the global economy?',
          'options': [
            'A recession is coming — sell everything',
            'The economy is growing strongly — investors prefer growth assets over safe havens',
            'Both metals are manipulated — the signals are meaningless',
            'Copper and gold always move together, so this can\'t happen',
          ],
          'correctIndex': 1,
          'explanation':
              'Copper rising = strong industrial demand = economy growing. Gold falling = investors leaving safe havens for riskier assets. Together, this signals economic optimism. This is why copper is called "Dr. Copper" — it has a PhD in predicting economic health!',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Precious metals (gold, silver) are stores of value and safe havens',
            'Industrial metals (copper, zinc, nickel) track economic growth',
            'Gold rises during fear; copper rises during growth — together they tell the full story',
            'India\'s cultural gold demand creates a unique trading dynamic',
            'Next: The commodity that literally moves the world — crude oil.',
          ],
        },
      ],
    };
  }

  // Lesson 3.2: Energy: The Lifeblood
  static Map<String, dynamic> getEnergyContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The World Runs on Oil',
          'emoji': '🛢️',
          'content':
              'Crude oil is the most actively traded commodity on Earth. A single tweet about OPEC production cuts can move oil 5% and change petrol prices in 190 countries. When oil sneezes, the world catches a cold.',
        },
        {
          'type': 'story',
          'title': 'The Day Oil Went Negative',
          'emoji': '📉',
          'content': '''
**April 20, 2020. The most bizarre day in commodity history.**

COVID lockdowns shut the world down. Nobody was driving. Nobody was flying.
Oil demand collapsed. But oil wells can't just "stop" — crude kept flowing.

**The Problem:**
Storage tanks in Cushing, Oklahoma (the delivery point for US oil contracts) were FULL.
If you owned an oil futures contract expiring tomorrow, you had to TAKE PHYSICAL DELIVERY.
But there was nowhere to store it.

**The Result:**
WTI Crude Oil price went to **-\$37.63 per barrel.**
Yes, NEGATIVE. Sellers were PAYING buyers to take the oil off their hands.

**The Indian Impact:**
MCX Crude Oil futures also crashed, though not negative.
Traders who were "long" (betting on oil going up) lost crores in hours.
Some had to pay exchange margins they didn't have.

**Lesson:**
Commodities are PHYSICAL goods. Unlike stocks (which are just numbers in a demat account), commodities can create real-world logistics nightmares. The physical nature of commodities introduces risks that don't exist in stock trading.
''',
        },
        {
          'type': 'concept',
          'title': 'Energy Commodities Decoded',
          'emoji': '⛽',
          'content': '''
**Crude Oil — Two Benchmarks:**
• **Brent Crude:** Global benchmark. Priced in London. India imports mostly Brent-grade oil.
• **WTI Crude:** US benchmark. Priced in Oklahoma.
• India imports ~85% of its oil. When Brent rises, India's import bill rises, Rupee weakens, and petrol costs more.

**Natural Gas:**
• Used for: Power generation, cooking (PNG), fertilizers, industrial heating
• India's dependence: Growing rapidly with city gas distribution
• Price: Extremely volatile. Can double or halve in months.
• MCX trades natural gas contracts linked to US Henry Hub prices.

**Key Price Drivers:**
• **OPEC+ decisions:** The oil cartel controls ~40% of global supply. When they cut production, prices surge.
• **Geopolitics:** Middle East tensions = instant oil price spike.
• **US inventory data:** Released weekly. Builds (excess) = price drops. Draws (deficit) = price rises.
• **Global demand:** China and India's economic growth = more oil consumption.

---

**Key Insight:**
India imports 85% of its crude oil. Every \$10/barrel increase costs India ~₹1 Lakh Crore annually. This makes crude oil perhaps the single most important commodity for the Indian economy.
''',
          'keyPoints': [
            'Brent and WTI are the two global crude oil benchmarks',
            'India imports 85% of its oil — price rises directly hurt the economy',
            'OPEC+ production decisions are the biggest supply-side driver',
            'Natural gas is becoming increasingly important for India\'s energy mix',
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Crude oil is the world\'s most traded commodity — price moves affect everything',
            'Oil went negative in April 2020 — physical delivery risk made it happen',
            'India imports 85% of crude oil — every price rise costs lakhs of crores',
            'OPEC, geopolitics, and inventory data drive oil prices',
            'Next: The commodities that feed the world — agriculture.',
          ],
        },
      ],
    };
  }

  // Lesson 3.3: Agricultural Commodities
  static Map<String, dynamic> getAgricultureContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Food as Finance',
          'emoji': '🌽',
          'content':
              'When droughts hit Maharashtra or floods devastate Punjab, it\'s not just farmers who suffer — commodity traders, food companies, and consumers all feel the impact. Agricultural commodities are where weather meets Wall Street.',
        },
        {
          'type': 'concept',
          'title': 'India\'s Key Agricultural Commodities',
          'emoji': '🚜',
          'content': '''
**Traded on NCDEX and MCX:**

**Cotton (The White Gold) 🧵**
• India: 2nd largest cotton producer globally
• Price drivers: Monsoon quality, global textile demand, China purchases
• Impact: Textile industry, clothing prices, farmer livelihoods

**Soybean & Soy Oil 🫘**
• India: Major producer and consumer
• Price drivers: Monsoon, US harvest, biodiesel demand
• Impact: Cooking oil prices (directly affects kitchen budgets!)

**Sugar 🍬**
• India: Largest sugar producer globally
• Price drivers: Government policies, ethanol blending targets, monsoon
• Impact: Sweet industry, ethanol fuel prices

**Wheat & Rice 🌾**
• India: Among top 3 global producers
• Government heavily regulates through MSP (Minimum Support Price)
• 2022: India banned wheat exports after Russia-Ukraine war disrupted global supply

---

**Key Insight:**
Agricultural commodities are uniquely affected by WEATHER — something no analyst can predict accurately. A single bad monsoon can double food prices and trigger government intervention. This makes agri commodities the most unpredictable to trade.
''',
          'keyPoints': [
            'India is a top-3 global producer of cotton, sugar, wheat, and rice',
            'Weather (monsoon) is the single biggest driver of agricultural prices',
            'Government policies (MSP, export bans) can override market forces',
            'Agricultural commodity prices directly affect your grocery bill',
          ],
        },
        {
          'type': 'scenario',
          'title': 'What Would You Do?',
          'situation':
              'Monsoon forecasts predict a severe drought in central India. You expect soybean prices to surge. How would you trade this?',
          'choices': [
            {
              'text': 'Buy soybean futures on NCDEX immediately',
              'isCorrect': false,
              'feedback':
                  '❌ Careful! The drought is a FORECAST, not reality. Monsoon predictions change frequently. Also, the government might intervene by releasing buffer stocks or banning exports. Trading on weather forecasts is extremely risky.',
            },
            {
              'text':
                  'Wait for the drought to actually materialize, then assess the supply damage before trading',
              'isCorrect': true,
              'feedback':
                  '✅ Smart! Let reality confirm the forecast before risking money. Agricultural commodity trading based on weather predictions is notoriously unreliable. Wait for actual crop damage reports from government agencies.',
            },
            {
              'text':
                  'Buy physical soybean bags and store them to sell later at higher prices',
              'isCorrect': false,
              'feedback':
                  '❌ Physical storage of agricultural commodities requires proper warehousing (temperature, moisture control). Spoilage is a real risk. Also, hoarding can attract government scrutiny. Financial instruments (futures) are a much cleaner way to trade views.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 3 Complete! 🎉',
          'keyPoints': [
            'Precious metals (gold, silver) = safe havens during crises',
            'Industrial metals (copper, nickel) = economic growth barometers',
            'Crude oil = the most influential commodity for India\'s economy',
            'Agricultural commodities = most unpredictable (weather-dependent)',
            'Government intervention in agri markets can override all technical analysis',
            'Next: How does commodity trading actually work? Futures, margins, and execution.',
          ],
        },
      ],
    };
  }
}
