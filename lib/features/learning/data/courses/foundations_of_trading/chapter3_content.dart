/// Chapter 3: Who's in the Market?
/// Complete interactive content for all lessons in Chapter 3
class Chapter3Content {
  // Lesson 3.1: Retail Traders (That's You!)
  static Map<String, dynamic> getRetailTradersContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'David vs Goliath',
          'emoji': '🐟',
          'content':
              'You are a "Retail Trader." You are smart, ambitious, and... tiny. You are swimming in an ocean full of sharks and whales. To survive and win, you first need to know who you are up against.',
        },
        {
          'type': 'story',
          'title': 'Ravi vs The Machine',
          'emoji': '💻',
          'content': '''
Meet **Ravi**, a retail trader with a laptop and ₹50,000.

**The Setup:**
**Ravi** sees a news flash: "TCS wins big contract."
He thinks: "This is great news! I'll buy immediately!"

**The Race:**
**Ravi** opens his app, types "TCS", enters quantity, and hits Buy.
Time taken: 15 seconds.

**Meanwhile, at a High-Frequency Trading Firm:**
• Algorithms read the news headline in 0.001 seconds.
• AI analyzes sentiment: "Positive."
• Supercomputers execute buy orders in 0.0003 seconds.

**The Result:**
By the time **Ravi's** order reaches the exchange, the price has already jumped up. The "Smart Money" bought first, and **Ravi** bought from them at a higher price.

**Key Lesson:**
You cannot beat them on speed. You must beat them on patience.
''',
        },
        {
          'type': 'concept',
          'title': 'The Retail Reality',
          'emoji': '👤',
          'content': '''
**Who is a Retail Trader?**
Anyone buying/selling with their own personal money (like you, me, and **Ravi**).

**Your Disadvantages:**
• **Capital:** You can't move the market.
• **Information:** You get news last.
• **Speed:** You are slower than machines.
• **Costs:** You pay higher brokerage % than big players.

**BUT... Your Superpowers:**
• **Agility:** You can enter/exit instantly (Big players take days to buy/sell without moving price).
• **No Pressure:** You don't have a boss demanding quarterly profits. You can sit on cash for months.
• **Freedom:** You can trade any stock (Institutions have strict rules).

**Winning Strategy:**
Don't fight the whales. Ride their waves.
''',
          'keyPoints': [
            'Retail traders trade personal capital',
            'We are slower and have less info than institutions',
            'Our advantage is agility and lack of pressure',
            'We don\'t need to trade every day; institutions do',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'What is the biggest advantage a retail trader has over a massive mutual fund?',
          'options': [
            'Better information sources',
            'Faster execution speed',
            'Agility (easy entry/exit) and no pressure to trade',
            'Lower transaction costs',
          ],
          'correctIndex': 2,
          'explanation':
              'Agility! A mutual fund with ₹1,000 Crores cannot sell everything in 1 minute without crashing the price. You can sell your 50 shares instantly. Plus, you can choose to do NOTHING—funds are forced to invest.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 3.1 Recap',
          'keyPoints': [
            'Retail traders are individuals trading their own money',
            'We compete against supercomputers and billion-dollar funds',
            'We cannot win on speed or information',
            'We win by being patient, agile, and picking our battles',
            'Next: Meet the giants who actually move the market.',
          ],
        },
      ],
    };
  }

  // Lesson 3.2: Institutional Players: The Big Money
  static Map<String, dynamic> getInstitutionalPlayersContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Whales 🐳',
          'emoji': '🏢',
          'content':
              'When the market crashes or rallies unexpectedly, it\'s usually not because of people like us. It\'s the "Big Money" moving around. Let\'s meet the FIIs and DIIs.',
        },
        {
          'type': 'concept',
          'title': 'FII vs DII',
          'emoji': '🇮🇳',
          'content': '''
In Indian markets, you'll hear these two terms every day:

**1. FIIs (Foreign Institutional Investors)**
• **Who:** Big funds from USA, Europe, Singapore (e.g., Goldman Sachs, BlackRock).
• **Role:** They bring foreign dollars into India.
• **Impact:** When they buy, markets usually fly. When they sell (to move money to USA/China), markets fall.
• **Nickname:** "Hot Money" (moves fast).

**2. DIIs (Domestic Institutional Investors)**
• **Who:** Indian Mutual Funds (SBI MF, HDFC MF), Insurance Companies (LIC), Pension Funds.
• **Role:** They invest your SIP money and insurance premiums.
• **Impact:** They provide stability. When FIIs sell, DIIs often buy (using your SIP inflows) to support the market.
• **Nickname:** "The Shield."

**The Battle:**
Market trend = FII Flows + DII Flows.
''',
          'keyPoints': [
            'FII = Foreign Investors (Global money)',
            'DII = Domestic Investors (Indian Money/SIPs)',
            'FIIs are powerful trend setters',
            'DIIs provide stability and absorb FII selling',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Market Impact Visualization',
          'emoji': '🌊',
          'content': '''
Imagine the market as a swimming pool.

**You (Retail):** You jump in. *Results: Small splash.* 💦
Your ₹50,000 buy order barely moves the stock price by ₹0.05.

**The Whale (FII/DII):** They jump in. *Results: Massive Tsunami.* 🌊
If **LIC** decides to buy ₹5,000 Crores of Reliance:
1. They can't buy at once (price would skyrocket).
2. They buy slowly over weeks.
3. The price keeps trending UP for weeks.

**How to Profit:**
Don't try to make the splash. Spot the wave created by the whale and surf on it. This is called "Following the Trend."
''',
        },
        {
          'type': 'story',
          'title': 'Why the Market Fell (Example)',
          'emoji': '📉',
          'content': '''
**Tuesday Morning:**
Good news exists everywhere. Companies posted profits. Retail traders like **Raju** are bullish and buying.

**Yet, the market crashes -2% by evening. Why?**

**The Hidden Reason:**
A US based Pension Fund (FII) needed to withdraw cash to pay retirees in America. They sold ₹4,000 Crores of Indian stocks instantly.

**Raju's Confusion:**
"But the news was good! Why did it fall?"

**The Reality:**
Stock prices are driven by **Demand and Supply**, not just news. If a Whale sells (High Supply), price drops, no matter how good the news is.
''',
        },
        {
          'type': 'quiz',
          'title': 'Identify the Player',
          'question':
              'LIC (Life Insurance Corporation) buys shares worth ₹2,000 Crores. Which category does this fall under?',
          'options': [
            'Retail Investor',
            'FII (Foreign Institutional Investor)',
            'DII (Domestic Institutional Investor)',
            'HNI (High Net-worth Individual)',
          ],
          'correctIndex': 2,
          'explanation':
              'LIC is the biggest DII (Domestic Institutional Investor) in India. They invest massive insurance premiums into the market, providing stability against foreign outflows.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 3.2 Recap',
          'keyPoints': [
            'Institutions (Whales) move the market, not retail traders',
            'FIIs (Foreign) bring heavy volatility and trend power',
            'DIIs (Domestic) stabilize markets using SIP/Insurance money',
            'Price follows Order Flow (Buying/Selling volume), not just news headlines',
            'Smart traders track FII/DII data daily',
          ],
        },
      ],
    };
  }

  // Lesson 3.3: Market Makers: The Invisible Hand
  static Map<String, dynamic> getMarketMakersContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Liquidity Providers',
          'emoji': '🤝',
          'content':
              'Ever wondered why you can buy or sell instantly within milliseconds? Who is always there to take the other side of your trade? Meet the Market Maker.',
        },
        {
          'type': 'story',
          'title': 'The Airport Exchange',
          'emoji': '💱',
          'content': '''
Imagine **Priya** is at the airport going to London. She needs Pounds.

She goes to the Currency Booth.
• **Buy Rate:** ₹102 per Pound
• **Sell Rate:** ₹100 per Pound

**Priya** buys 100 Pounds for ₹10,200.
Suddenly, her trip is cancelled! She sells the 100 Pounds back immediately.
She gets ₹10,000.

**Loss:** ₹200.
**Who made that ₹200?**
The Currency Booth. They didn't care if the Pound went up or down. They just profited from the difference (**Spread**) between Buy and Sell price.

**In the Stock Market:**
**Market Makers** are like that booth. They ensure you can always buy/sell, and they earn from the spread.
''',
        },
        {
          'type': 'concept',
          'title': 'Liquidity & Spreads',
          'emoji': '💧',
          'content': '''
**What is Liquidity?**
The ability to buy or sell an asset quickly without changing its price too much.

**Who provides it?**
Market Makers (Specialized firms/Algos). They place BOTH Buy and Sell orders simultaneously.
"I'll buy at ₹100.00 and sell at ₹100.05."

**Bid-Ask Spread:**
The gap between the highest Buying Price (Bid) and lowest Selling Price (Ask).
• Highly Liquid Stock (e.g., Reliance): Spread = ₹0.05 (Tight)
• Illiquid Stock (Small cap): Spread = ₹5.00 (Wide)

**Why it matters:**
Market Makers are not gambling on price direction. They are business owners providing a service (Liquidity) for a fee (Spread).
''',
          'keyPoints': [
            'Market Makers ensure you can trade anytime',
            'They profit from the Bid-Ask Spread',
            'Liquidity = Ease of entry/exit',
            'High liquidity = Low spread (Good for you)',
          ],
        },
        {
          'type': 'scenario',
          'title': 'The Illiquidity Trap',
          'situation':
              'You find a cheap stock at ₹10. You buy 10,000 shares. It goes up to ₹12. Profit = ₹20,000! You hit "Sell". But the order stays "Pending". Why?',
          'choices': [
            {
              'text': 'The broker app has crashed',
              'isCorrect': false,
              'feedback': '❌ Unlikely. The real issue is the market itself.',
            },
            {
              'text': 'There are no Buyers (No Liquidity)',
              'isCorrect': true,
              'feedback':
                  '✅ Correct! In small stocks, Market Makers might be absent. Buying is easy, but if no one wants to buy from you, you are stuck ("Trapped"). Paper profits mean nothing if you can\'t sell.',
            },
            {
              'text': 'The exchange has halted trading',
              'isCorrect': false,
              'feedback':
                  '❌ Trading halts happen (Upper Circuit), but usually "Pending" simply means no matching buyer at your price.',
            },
          ],
        },
        {
          'type': 'quiz',
          'title': 'Role Identification',
          'question':
              'Who profits primarily from the "Spread" rather than price direction?',
          'options': [
            'Retail Traders',
            'Investors',
            'Market Makers',
            'Regulators',
          ],
          'correctIndex': 2,
          'explanation':
              'Market Makers utilize high-frequency algorithms to capture the small difference (spread) between buy and sell prices millions of times a day.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 3 Complete! 🎉',
          'keyPoints': [
            'You (Retail) are agile but small; Institutions are huge but slow',
            'FIIs and DIIs are the primary drivers of market trends',
            'Market Makers provide liquidity and earn from the spread',
            'Don\'t fight the trend caused by institutions—follow it',
            'Beware of illiquid stocks where you can enter but cannot exit',
            'Next Chapter: How to actually place orders like a pro!',
          ],
        },
      ],
    };
  }
}
