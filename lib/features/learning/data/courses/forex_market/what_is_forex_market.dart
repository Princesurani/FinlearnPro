/// Chapter 2: What is the Forex Market
/// Structure, history, and how it differs from stocks
class WhatIsForexMarketContent {
  // Lesson 2.1: The Decentralized Giant
  static Map<String, dynamic> getDecentralizedGiantContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'A Market With No Address',
          'emoji': '🏗️',
          'content':
              'The stock market has NSE in Mumbai and NYSE in New York. But where is the forex market? Nowhere. And everywhere. It exists as a global network of banks, brokers, and computers. No single building. No closing bell.',
        },
        {
          'type': 'concept',
          'title': 'OTC: Over-The-Counter',
          'emoji': '🌐',
          'content': '''
**The forex market is "OTC" — Over-The-Counter.** There's no centralized exchange.

**How It Works:**
Instead of a single exchange matching orders (like NSE), forex trades happen directly between two parties:
• Bank to Bank (interbank market)
• Bank to Broker
• Broker to Retail Trader (you)

**The Interbank Market (The Real Forex):**
The core of forex is a network of ~10 major global banks:
• JPMorgan, Deutsche Bank, Citi, HSBC, UBS, etc.
• They trade directly with each other in massive volumes.
• Prices you see on your broker's app come FROM this interbank market.

**Your Broker's Role:**
Your retail broker (Zerodha, FXCM, etc.) is a middleman.
They take the interbank price and add a markup (spread).
When you "trade forex," you're actually trading with your broker, not the global market.

---

**Key Insight:**
In stocks, all orders go through a regulated exchange (NSE). In forex, your broker IS the exchange. This means broker quality, regulation, and trust matter enormously. A bad broker can trade against you.
''',
          'keyPoints': [
            'Forex is OTC (Over-The-Counter) — no centralized exchange building',
            'The interbank market between major banks is where real prices are set',
            'Retail brokers are middlemen who mark up interbank prices',
            'Broker regulation and trust are critical — they are your exchange',
          ],
        },
        {
          'type': 'story',
          'title': 'The Bretton Woods Story',
          'emoji': '📜',
          'content': '''
**1944: A New World Order.**

After World War II, 44 countries met in Bretton Woods, USA, to create a new global monetary system.

**The Agreement:**
• All currencies would be pegged to the US Dollar.
• The US Dollar would be pegged to Gold (\$35 per ounce).
• No currency could move freely — governments controlled exchange rates.

**1971: Nixon Breaks the System.**
The US was spending heavily on the Vietnam War. It didn't have enough gold to back all the Dollars in circulation. President Nixon "closed the gold window" — the Dollar was no longer backed by gold.

**The Result:**
• All currencies became "free-floating" — their value determined by markets, not governments.
• **The modern forex market was born.**
• Currency values now change every second based on supply and demand.

**Why This Matters Today:**
When you see USD/INR at 83, that's NOT set by the government. It's the market price — determined by billions of transactions between banks, corporations, and traders worldwide.

**Lesson:**
Forex is a relatively young market (post-1971). Understanding its history helps you understand why currencies are volatile — they're driven by global economic forces, not a fixed peg.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Why is broker selection more important in forex than in stocks?',
          'options': [
            'Because forex brokers charge higher commissions',
            'Because forex is OTC — your broker IS the exchange, so a bad broker can trade against you or manipulate prices',
            'Because forex brokers are not regulated anywhere in the world',
            'Because all forex brokers are the same — it doesn\'t matter',
          ],
          'correctIndex': 1,
          'explanation':
              'In stocks, all trades go through a regulated exchange (NSE/BSE) that ensures fair pricing. In forex, there\'s no exchange — your broker acts as the counterparty. Unregulated brokers can widen spreads, delay execution, or even trade against you. Always choose SEBI-regulated (India) or FCA/ASIC-regulated brokers.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Forex is OTC — no central exchange, trades happen between banks and brokers',
            'The modern forex market began in 1971 when currencies started floating freely',
            'Your broker is your exchange — regulation and trust are non-negotiable',
            'Interbank prices from major banks set the "real" forex rates',
            'Next: How is forex fundamentally different from stock trading?',
          ],
        },
      ],
    };
  }

  // Lesson 2.2: Forex vs Stocks: Key Differences
  static Map<String, dynamic> getForexVsStocksContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Two Different Games',
          'emoji': '🎮',
          'content':
              'Many stock traders think: "I\'m good at Nifty, so I\'ll be good at forex." WRONG. Forex operates on entirely different rules. Let\'s see why.',
        },
        {
          'type': 'interactive',
          'title': 'Forex vs Stocks: Full Comparison',
          'emoji': '⚖️',
          'content': '''
**Feature-by-Feature Comparison:**

**What You Trade:**
• Stocks: Ownership in a company (Reliance, TCS)
• Forex: One currency against another (EUR vs USD)

**Trading Hours:**
• Stocks: 9:15 AM - 3:30 PM, Mon-Fri (6.25 hrs)
• Forex: 24 hours, Mon-Fri (120 hrs!)

**Number of Instruments:**
• Stocks: 5,000+ companies on NSE alone
• Forex: ~8 major pairs cover 70%+ of volume

**Leverage Available:**
• Stocks: 1x-5x (India, regulated)
• Forex: 50x-500x (international brokers) ⚠️

**What Drives Price:**
• Stocks: Company earnings, products, management
• Forex: Interest rates, inflation, GDP, geopolitics

**Market Size:**
• Indian Stocks: ₹70,000 Cr/day
• Global Forex: ₹62 Lakh Cr/day (900x larger!)

**Key Difference:**
In stocks, you can find a hidden gem before everyone else.
In forex, EUR/USD is the same for everyone — no information edge. Success comes from discipline, not discovery.
''',
        },
        {
          'type': 'concept',
          'title': 'Why Forex is Harder',
          'emoji': '⚠️',
          'content': '''
**1. Zero-Sum Game 🎯**
When you buy a stock, the company can grow and EVERYONE profits.
In forex, for every winner there is an EQUAL loser. Your profit = someone else's loss.

**2. Leverage Amplifies Everything 💣**
Stocks: ₹1 Lakh moves ₹1 Lakh of stock.
Forex (100x leverage): ₹1 Lakh controls ₹1 CRORE of currency.
A 1% move = 100% gain OR 100% loss. One wrong trade can erase your entire account.

**3. Macro is King 🌍**
Stock traders study companies. Forex traders study COUNTRIES.
Interest rates, inflation, trade deficits, political stability — you're betting on economies, not businesses.

**4. No Dividends, No Fundamentals 📉**
Stocks generate earnings, dividends, and cash flows. You can value them.
Currencies don't "earn" anything. Their value is purely relative.
Is EUR/USD at 1.10 "expensive" or "cheap"? Nobody truly knows.

---

**Key Insight:**
Forex is not a "better" or "easier" version of stock trading. It's a completely different discipline. Stock skills don't automatically transfer. Most stock traders who jump to forex without relearning — lose money.
''',
          'keyPoints': [
            'Forex is zero-sum — your profit comes directly from someone else\'s loss',
            'Leverage of 100x means a 1% move can wipe out your entire account',
            'Forex is driven by macroeconomics, not company fundamentals',
            'Currencies have no intrinsic value like stocks — no dividends, no earnings',
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 2 Complete! 🎉',
          'keyPoints': [
            'Forex is OTC, 24-hour, and 900x larger than the Indian stock market',
            'The modern forex market began in 1971 after currencies started floating freely',
            'Forex is a zero-sum game — unlike stocks, not everyone can win',
            'Extreme leverage (50x-500x) makes forex far riskier than stocks',
            'Currency prices are driven by macroeconomics, not company earnings',
            'Next: How to actually read a currency pair — the language of forex.',
          ],
        },
      ],
    };
  }
}
