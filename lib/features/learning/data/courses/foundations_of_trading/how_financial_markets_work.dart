/// Chapter 2: How Financial Markets Work
/// Complete interactive content for all lessons in Chapter 2
class HowFinancialMarketsWorkContent {
  // Lesson 2.1: What is a Financial Market?
  static Map<String, dynamic> getFinancialMarketContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Marketplace',
          'emoji': '🏪',
          'content':
              'Imagine a busy vegetable market. Farmers want to sell, people want to buy, and prices change based on demand.\n\nThe stock market is exactly the same—replace vegetables with "shares" of companies. Let\'s see how it works...',
        },
        {
          'type': 'story',
          'title': 'The Vegetable Market Analogy',
          'emoji': '🍅',
          'content': '''
Meet **Raju**, a vegetable vendor.

**08:00 AM (Early Morning):**
• Raju has fresh tomatoes.
• Only a few buyers are around.
• Price: ₹40/kg.

**11:00 AM (Peak Time):**
• Huge crowd arrives. Everyone wants tomatoes for lunch.
• Supply is limited.
• Raju raises price: ₹60/kg. (Demand > Supply)

**08:00 PM (Closing Time):**
• Raju wants to go home. Leftover tomatoes might rot.
• Few buyers left.
• Raju drops price: ₹20/kg. (Supply > Demand)

**The Lesson:**
Prices aren't random. They change because of **Buyers (Demand)** and **Sellers (Supply)**. The stock market works on this exact principle every second.
''',
        },
        {
          'type': 'concept',
          'title': 'What is a Financial Market?',
          'emoji': '📈',
          'content': '''
**The Core Concept:**
A financial market is simply a place where buyers and sellers meet to trade assets (stocks, bonds, currencies).

**Who is involved?**
• **Buyers (Bulls):** Think prices will go UP. They create Demand.
• **Sellers (Bears):** Think prices will go DOWN. They create Supply.

**Price Discovery:**
The "Right Price" is where a Buyer and a Seller agree.
• If more people want to buy (High Demand) → Price Goes **UP** ⬆️
• If more people want to sell (High Supply) → Price Goes **DOWN** ⬇️

**Key Insight:**
The market is a voting machine. Every rupee spent is a vote for what a company is worth at that moment.
''',
          'keyPoints': [
            'Market = Meeting place for Buyers and Sellers',
            'Prices move based on Demand (Buyers) and Supply (Sellers)',
            'Bulls = Buyers (Optimistic)',
            'Bears = Sellers (Pessimistic)',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Price Movement Demo',
          'emoji': '⚖️',
          'content': '''
Let's see how news affects supply and demand for "Tata Motors".

**Scenario A: Good News**
• Tata Motors announces a new electric car.
• **Reaction:** Everyone wants to buy (Demand ⬆️). Sellers hold back (Supply ⬇️).
• **Result:** Price shoots UP to ₹900.

**Scenario B: Bad News**
• Factory strike halts production.
• **Reaction:** Owners panic and sell (Supply ⬆️). Few buyers (Demand ⬇️).
• **Result:** Price drops to ₹850.

**The Balance:**
• **More Buyers than Sellers** = 🟢 Green Candle (Price Up)
• **More Sellers than Buyers** = 🔴 Red Candle (Price Down)

**Key Lesson:**
News drives sentiment -> Sentiment drives Demand/Supply -> Demand/Supply drives Price.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'If a company announces record-breaking profits, what usually happens?',
          'options': [
            'Demand rises, Supply falls, Price goes UP',
            'Demand falls, Supply rises, Price goes DOWN',
            'Nothing happens to the price',
            'The market closes early',
          ],
          'correctIndex': 0,
          'explanation':
              'Good news (profits) attracts buyers (Demand). Existing owners don\'t want to sell cheap (Supply drops). This imbalance pushes the price UP.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 2.1 Recap',
          'keyPoints': [
            'The stock market is just like a vegetable market—prices depend on demand and supply',
            'Buyers (Bulls) push prices up; Sellers (Bears) push prices down',
            'Price Discovery happens when a buyer and seller agree on a value',
            'News and events change people\'s desire to buy or sell, moving the price',
            'Next: Where does this trading actually happen? Meet the Exchanges.',
          ],
        },
      ],
    };
  }

  // Lesson 2.2: Exchanges: Where the Magic Happens
  static Map<String, dynamic> getExchangesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Supermarkets of Shares',
          'emoji': '🏛️',
          'content':
              'You can\'t just buy shares from a shop. You need a centralized marketplace. In India, we have two giants: NSE and BSE. Let\'s see how they power the economy.',
        },
        {
          'type': 'concept',
          'title': 'NSE vs BSE',
          'emoji': '🇮🇳',
          'content': '''
**The Big Two:**

**1. BSE (Bombay Stock Exchange)**
• **Oldest:** Established 1875 (Oldest in Asia!)
• **Listing:** Has 5,000+ companies listed.
• **Index:** **SENSEX** (Top 30 companies).
• **Vibe:** The wise grandfather of markets.

**2. NSE (National Stock Exchange)**
• **Modern:** Established 1992 (Fully digital).
• **Volume:** Hosting most of India's trading volume (esp. Derivatives).
• **Index:** **NIFTY 50** (Top 50 companies).
• **Vibe:** The high-tech, fast-paced powerhouse.

**What they do:**
They provide the infrastructure (computers, networks) to match millions of buy and sell orders per second.

**Key Insight:**
You can buy a stock on NSE and sell it on BSE (if listed on both). They are just marketplaces.
''',
          'keyPoints': [
            'BSE = Oldest, Sensex (30 stocks)',
            'NSE = Largest Volume, Nifty 50',
            'They are the infrastructure providers',
            'Most active trading happens on NSE',
          ],
        },
        {
          'type': 'story',
          'title': 'How a Company Joins the Market',
          'emoji': '🚀',
          'content': '''
Meet **Priya**, founder of "TechChai", a profitable startup.

**The Problem:**
**Priya** wants to expand to 100 cities but needs ₹500 Crores. Banks charge high interest.

**The Solution: IPO (Initial Public Offering)**
**Priya** decides to sell part of her company to the public.

**The Process:**
1. **File Papers:** She applies to SEBI (The regulator).
2. **The Launch:** TechChai launches its IPO.
3. **The Listing:** TechChai gets listed on NSE & BSE.
4. **Trading Begins:** Now, YOU can become a part-owner of TechChai by buying shares!

**Outcome:**
**Priya** gets ₹500 Cr for expansion. You get a chance to grow wealth with her company.
''',
        },
        {
          'type': 'interactive',
          'title': 'Index Demystified',
          'emoji': '📊',
          'content': '''
**What is Nifty 50?**
Imagine a fruit basket representing the whole market.

**The Basket (Nifty 50):**
• Contains the 50 biggest, most reliable fruits (companies).
• Reliance, HDFC Bank, Infosys, TCS, etc.

**Why do we watch it?**
• If the basket price goes UP, the "market" is doing well.
• If the basket price goes DOWN, the "market" is weak.

**Comparison:**
• **Nifty 50:** Top 50 companies on NSE.
• **Sensex:** Top 30 companies on BSE.
• **Bank Nifty:** Top 12 banking stocks.

**Key Insight:**
You can't buy "Nifty" directly (it's just a number), but you can buy products that track it (Index Funds/ETFs).
''',
        },
        {
          'type': 'quiz',
          'title': 'Exchange Quiz',
          'question':
              'Which index represents the top 50 companies on the National Stock Exchange (NSE)?',
          'options': ['Sensex', 'Nifty 50', 'Bank Nifty', 'Midcap 100'],
          'correctIndex': 1,
          'explanation':
              'NIFTY 50 is the flagship index of the National Stock Exchange (NSE). SENSEX belongs to the Bombay Stock Exchange (BSE).',
        },
        {
          'type': 'summary',
          'title': 'Chapter 2.2 Recap',
          'keyPoints': [
            'NSE and BSE are India\'s two main stock exchanges',
            'NSE is larger by volume; BSE is the oldest in Asia',
            'Nifty 50 (NSE) and Sensex (BSE) are indices tracking top companies',
            'IPO is how private companies go public to raise funds',
            'Indices act as a barometer for the overall market health',
          ],
        },
      ],
    };
  }

  // Lesson 2.3: How a Trade Actually Happens
  static Map<String, dynamic> getTradeProcessContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Behind the Click',
          'emoji': '🖱️',
          'content':
              'You press "Buy". One second later, you own shares. But a massive chain reaction happens in that one second. Let\'s peek behind the curtain...',
        },
        {
          'type': 'story',
          'title': 'Amit\'s Order Journey',
          'emoji': '🔄',
          'content': '''
**Amit** wants to buy 10 shares of Reliance at ₹2,500.

**Step 1: The Broker (Zerodha/Groww)**
**Amit** taps "Buy" on his app. The broker checks if he has money. "Yes, he has ₹25,000."

**Step 2: The Exchange (NSE)**
The broker sends the order to NSE. NSE's supercomputer looks for a seller.
"Found! **Sara** wants to sell 10 shares at ₹2,500."

**Step 3: The Match**
NSE matches **Amit** and **Sara**. "Trade Executed!" ✅

**Step 4: Settlement (T+1 Day)**
Money moves from **Amit** -> Order -> **Sara**.
Shares move from **Sara** -> Demat -> **Amit**.

**Result:**
By the next day, **Amit** sees the shares in his Demat account.
''',
        },
        {
          'type': 'concept',
          'title': 'The Three Key Accounts',
          'emoji': '🔑',
          'content': '''
To trade, you need a "3-in-1" setup (usually provided together):

**1. Bank Account** 🏦
• Where your money lives.
• You transfer money FROM here to trade.

**2. Trading Account** 💻
• The interface (App/Web) where you place orders.
• Acts as the bridge between you and the Exchange.

**3. Demat Account** 📂
• Digital locker for your shares.
• Once bought, shares sit here safely (held by CDSL/NSDL).

**Analogy:**
• **Bank:** Your Wallet.
• **Trading Acc:** The check-out counter.
• **Demat:** Your digital shopping bag.

**Key Insight:**
Brokers (like Zerodha) facilitate the trade, but they don't hold your shares. Your shares are safe in the Demat (CDSL/NSDL) even if the broker shuts down.
''',
          'keyPoints': [
            'Bank Account = Source of funds',
            'Trading Account = Where you buy/sell',
            'Demat Account = Where shares are stored',
            'T+1 Settlement = Shares arrive in 1 day',
          ],
        },
        {
          'type': 'scenario',
          'title': 'Placing an Order',
          'situation':
              'Reliance is trading at ₹2,505. You only want to pay ₹2,500. What order type do you use?',
          'choices': [
            {
              'text': 'Market Order',
              'isCorrect': false,
              'feedback':
                  '❌ A Market Order buys immediately at the CURRENT price (₹2,505 or higher). You might pay more than you wanted.',
            },
            {
              'text': 'Limit Order',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect! A Limit Order tells the system: "Buy ONLY if price is ₹2,500 or lower." If price doesn\'t drop, you don\'t buy.',
            },
            {
              'text': 'Stop Loss Order',
              'isCorrect': false,
              'feedback':
                  '❌ Stop Loss is for protecting existing positions or entering on momentum, not for bargaining on entry price.',
            },
          ],
        },
        {
          'type': 'quiz',
          'title': 'Safety Check',
          'question':
              'If your broker (e.g., Zerodha/Upstox) goes bankrupt, what happens to your shares?',
          'options': [
            'They are lost forever',
            'They are safe in your Demat account (CDSL/NSDL)',
            'The broker sells them to pay debts',
            'You have to buy them again',
          ],
          'correctIndex': 1,
          'explanation':
              'Your shares are NOT held by the broker. They are held in a central depository (CDSL or NSDL). You can simply link a new broker to access them.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 2 Complete! 🎉',
          'keyPoints': [
            'Trading involves a Banker, a Broker, an Exchange, and a Depository',
            'You need a Trading Account (to buy) and Demat Account (to store)',
            'Market Order = Speed (Buy Now); Limit Order = Price (Buy at X)',
            'Settlement takes T+1 day (Trade + 1 working day)',
            'Your shares are safe with CDSL/NSDL, separate from your broker',
            'Next Chapter: Who are the players you are competing against?',
          ],
        },
      ],
    };
  }
}
