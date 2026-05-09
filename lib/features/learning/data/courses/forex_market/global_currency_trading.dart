/// Chapter 1: Global Currency Trading
/// Why currencies move and who trades them
class GlobalCurrencyTradingContent {
  // Lesson 1.1: The Invisible Market
  static Map<String, dynamic> getInvisibleMarketContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Market You Can\'t See',
          'emoji': '🌍',
          'content':
              'There\'s no building. No bell. No opening ceremony. Yet every single day, \$7.5 TRILLION changes hands in the forex market — more than all stock markets combined. You interact with it every time you buy petrol, order from Amazon US, or check the Dollar-Rupee rate. Let\'s pull back the curtain.',
        },
        {
          'type': 'story',
          'title': 'How the Rupee Ruined Ravi\'s Vacation',
          'emoji': '✈️',
          'content': '''
**Ravi**, a 31-year-old product manager in Mumbai, planned a Europe trip in January.

**January (Planning):**
EUR/INR rate = ₹88 per Euro.
Ravi's budget: €2,000 = ₹1,76,000.
"I'll convert the money in March when I get my bonus."

**March (Reality):**
EUR/INR rate = ₹93 per Euro.
Same €2,000 now costs ₹1,86,000.
**Ravi paid ₹10,000 MORE for the same trip.** He didn't lose money in any investment. The Rupee simply weakened against the Euro.

**His Colleague Meera:**
Same trip, same timing. But Meera converted her Euros in January itself.
She paid ₹1,76,000. Saved ₹10,000.

**The Lesson:**
Currency movements affect you even if you never "trade forex." Every imported phone, every foreign vacation, every barrel of oil India buys — all priced in foreign currencies. Understanding forex isn't optional; it's financial literacy.

**Key Question:**
If Ravi had understood that the Rupee was weakening, could he have saved ₹10,000? Absolutely. That's why this course exists.
''',
        },
        {
          'type': 'concept',
          'title': 'The World\'s Largest Market',
          'emoji': '📊',
          'content': '''
**Daily Trading Volume Comparison:**
• **Indian Stock Market (NSE):** ~₹70,000 Crore/day
• **US Stock Market (NYSE):** ~₹4 Lakh Crore/day
• **Global Forex Market:** ~₹62 Lakh Crore/day (\$7.5 Trillion!)

**Forex is 150x larger than the Indian stock market.**

**Why So Big?**
Because EVERY international transaction requires currency exchange:
• India buys oil from Saudi Arabia → Pay in USD → Sell INR, buy USD
• Apple sells iPhones in India → Revenue in INR → Convert to USD
• A student pays MIT fees → INR → USD
• Governments manage reserves → Buy/sell USD, EUR, GBP, JPY

**When Does It Trade?**
• Stocks: 9:15 AM - 3:30 PM (6.25 hours, Mon-Fri)
• Forex: **24 hours a day, Monday to Friday** (follows the sun across time zones)

---

**Key Insight:**
You're already a participant in the forex market — you just don't know it. Every time the Rupee weakens, your imported goods cost more. Understanding currency movements is understanding the global economy.
''',
          'keyPoints': [
            'Forex trades \$7.5 trillion daily — 150x the Indian stock market',
            'It operates 24 hours a day across global time zones (Mon-Fri)',
            'Every international transaction involves currency exchange',
            'Rupee movements directly affect your purchasing power for imports',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'The USD/INR rate moves from ₹83 to ₹86. What does this mean for an Indian student paying college fees in America?',
          'options': [
            'Their fees become cheaper — the Rupee got stronger',
            'Their fees become more expensive — the Rupee weakened against the Dollar',
            'Nothing changes — college fees are fixed in Rupees',
            'They should wait because the rate always comes back down',
          ],
          'correctIndex': 1,
          'explanation':
              'When USD/INR goes from 83 to 86, each Dollar costs ₹3 more. If annual fees are \$50,000, the student now pays ₹4,30,000 instead of ₹4,15,000 — a ₹15,000 increase. The Rupee weakened (depreciated) against the Dollar.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Forex is the world\'s largest financial market — \$7.5 trillion traded daily',
            'It runs 24 hours a day, Monday through Friday, across global time zones',
            'Currency movements affect everyone — imports, vacations, education abroad, fuel prices',
            'Understanding forex isn\'t just for traders — it\'s basic financial literacy',
            'Next: Who are the actual players in this massive market?',
          ],
        },
      ],
    };
  }

  // Lesson 1.2: Who Trades Currencies & Why
  static Map<String, dynamic> getWhoTradesCurrenciesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Players Behind the Curtain',
          'emoji': '🎭',
          'content':
              'When the Rupee falls 2% in a day, it\'s not random. Massive forces — central banks, hedge funds, corporations — are buying and selling billions. Retail traders like us? We\'re tiny fish in a whale\'s ocean.',
        },
        {
          'type': 'concept',
          'title': 'The Five Big Players',
          'emoji': '🏛️',
          'content': '''
**1. Central Banks (The Gods) 🏦**
RBI, US Federal Reserve, ECB — they control monetary policy.
When RBI buys Dollars, the Rupee weakens. When it sells Dollars, the Rupee strengthens.
**They move markets intentionally.** They ARE the market.

**2. Commercial Banks (The Plumbing) 🏢**
HDFC, SBI, JPMorgan — they execute forex transactions for clients.
When a company needs to convert ₹500 Crore to USD, they call their bank.
Banks earn the spread (difference between buy and sell price).

**3. Corporations (The Real Economy) 🏭**
Tata Motors imports steel from Japan → Needs JPY.
Infosys earns in USD → Converts to INR.
Their transactions are driven by business needs, not speculation.

**4. Hedge Funds & Institutions (The Whales) 🐋**
George Soros famously "broke" the British Pound in 1992 — made \$1 billion in one day.
These players trade billions on macroeconomic bets. They move markets.

**5. Retail Traders (Us — The Minnows) 🐟**
Individual traders using platforms like Zerodha or forex brokers.
We account for only ~5% of daily volume. We're the smallest fish.

---

**Key Insight:**
In stocks, a retail trader can find an undervalued small-cap before institutions. In forex, you're always trading against central banks, hedge funds, and algorithms. The game is fundamentally different.
''',
          'keyPoints': [
            'Central banks are the most powerful force — they set interest rates and intervene directly',
            'Commercial banks handle the actual currency exchange infrastructure',
            'Corporations trade forex for business needs, not speculation',
            'Retail traders are only ~5% of volume — the smallest players',
          ],
        },
        {
          'type': 'scenario',
          'title': 'What Would You Do?',
          'situation':
              'RBI announces an emergency interest rate hike of 0.5%. You\'re holding a USD/INR short position (betting the Rupee will strengthen). The Rupee starts strengthening rapidly as foreign investment flows in. What do you do?',
          'choices': [
            {
              'text': 'Hold the position — RBI is on your side now',
              'isCorrect': true,
              'feedback':
                  '✅ In this case, the central bank\'s action supports your position. Higher interest rates attract foreign capital, strengthening the Rupee. But always have a stop loss — unexpected events can reverse moves quickly.',
            },
            {
              'text':
                  'Close immediately — central bank actions are unpredictable',
              'isCorrect': true,
              'feedback':
                  '✅ Also valid! Taking quick profits when the trade goes your way is disciplined trading. Central bank effects can be temporary, and the market could reverse on the next news cycle.',
            },
            {
              'text': 'Double your position — easy money!',
              'isCorrect': false,
              'feedback':
                  '❌ Dangerous! Adding to a winning position during high-volatility central bank events is reckless. The market can reverse in seconds. Professional traders reduce risk during central bank events, not increase it.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 1 Complete! 🎉',
          'keyPoints': [
            'Five key players: Central Banks, Commercial Banks, Corporations, Hedge Funds, Retail Traders',
            'Central banks are the most powerful force — they can move currencies by 2-5% with a single decision',
            'Retail traders are only 5% of the market — we\'re always trading against bigger players',
            'Forex is driven by macroeconomics (interest rates, inflation, trade deficits), not company earnings',
            'Understanding who you\'re up against is the first step to not getting crushed',
            'Next: How is the forex market actually structured? No building, no exchange — how does it work?',
          ],
        },
      ],
    };
  }
}
