/// Chapter 5: Speaking the Language
/// Complete interactive content for all lessons in Chapter 5
class SpeakingTheLanguageContent {
  // Lesson 5.1: Bid, Ask, and Spread
  static Map<String, dynamic> getBidAskContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Hidden Cost',
          'emoji': '🕵️',
          'content':
              'Have you ever bought a stock and immediately seen a small loss in red? You haven\'t lost money yet—you just paid the "Spread." Let\'s uncover this hidden cost.',
        },
        {
          'type': 'concept',
          'title': 'Bids and Asks',
          'emoji': '📊',
          'content': '''
The stock market is an auction.

**Bid (Buyers):**
"I am willing to BUY at ₹100." (Highest Bid)

**Ask (Sellers):**
"I am willing to SELL at ₹100.05." (Lowest Ask)

**The Spread:**
The difference (₹0.05) is the **Spread**.

**If you place a Market Buy Order:**
You pay the Seller's price (**Ask**): ₹100.05.

**If you place a Market Sell Order:**
You get the Buyer's price (**Bid**): ₹100.

**The Instant Loss:**
If you Buy at ₹100.05 and Sell strictly at ₹100, you lose ₹0.05 immediately. This is the cost of liquidity.
''',
          'keyPoints': [
            'Bid = Best Buyer Price',
            'Ask = Best Seller Price',
            'You Buy at Ask, You Sell at Bid',
            'Spread = Ask - Bid',
          ],
        },
        {
          'type': 'story',
          'title': 'Raju\'s Illiquid Trap',
          'emoji': '🔒',
          'content': '''
**Raju** finds a small company stock trading at ₹50.
He looks at the Order Book:

**Buyers (Bid):** ₹48.00
**Sellers (Ask):** ₹52.00

The Spread is HUGE (₹4.00 or 8%!).

**The Trade:**
**Raju** buys at ₹52 (Ask).
His dashboard instantly shows: Current Value ₹48 (Bid).
**Raju** is down -8% the moment he clicked buy!

**The Trap:**
To break even, the stock must rise 8% just to cover the spread. This is why trading illiquid stocks is dangerous.
''',
        },
        {
          'type': 'interactive',
          'title': 'Calculate the Cost',
          'emoji': '🧮',
          'content': '''
**Stock A (Liquid):**
Bid: ₹1000.00 | Ask: ₹1000.05
Spread: 0.005% (Tiny cost)

**Stock B (Illiquid):**
Bid: ₹100.00 | Ask: ₹105.00
Spread: 5% (Massive cost)

**Key Lesson:**
Always check the "Market Depth" or Order Book before trading. If the gap between Buy and Sell is wide, use a **Limit Order** in the middle, or avoid the stock.
''',
        },
        {
          'type': 'quiz',
          'title': 'Spread Quiz',
          'question': 'Who benefits from the Bid-Ask Spread?',
          'options': [
            'The Retail Trader',
            'The Market Maker / Liquidity Provider',
            'The Long Term Investor',
            'The Government',
          ],
          'correctIndex': 1,
          'explanation':
              'Market Makers earn the spread. They buy from you at the Bid (Low) and sell to someone else at the Ask (High). This is their fee for providing liquidity.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 5.1 Recap',
          'keyPoints': [
            'Every trade has a transaction cost called the Spread',
            'Spread = Ask (Sell Price) - Bid (Buy Price)',
            'Liquid stocks have tight spreads (cheap to trade)',
            'Illiquid stocks have wide spreads (expensive to trade)',
            'You are instantly at a loss equal to the spread when you enter a market order',
          ],
        },
      ],
    };
  }

  // Lesson 5.2: Volume and Liquidity
  static Map<String, dynamic> getVolumeLiquidityContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Is Anyone Home?',
          'emoji': '📢',
          'content':
              'Price tells you WHAT the stock is worth. Volume tells you HOW MANY people agree. Trading without looking at volume is like driving blindfolded.',
        },
        {
          'type': 'concept',
          'title': 'What is Volume?',
          'emoji': '📶',
          'content': '''
**Volume** = Total number of shares traded today.

**High Volume:**
• Millions of shares traded.
• Easy to buy/sell (Liquid).
• Price movement is "real" (supported by many people).

**Low Volume:**
• Few shares traded.
• Hard to buy/sell (Illiquid).
• Price movement might be "fake" (manipulated by few people).

**Rule of Thumb:**
Only trade stocks with high average volume (e.g., Nifty 50 stocks).
''',
          'keyPoints': [
            'Volume confirms the trend',
            'High Volume + Price Up = Strong Bullish Signal',
            'Low Volume + Price Up = Weak/Fake Signal',
            'Avoid low volume stocks to prevent getting trapped',
          ],
        },
        {
          'type': 'story',
          'title': 'The Penny Stock Trap',
          'emoji': '🕸️',
          'content': '''
**Amit** gets a tip: "Buy XYZ Corp at ₹5! Going to ₹50!"

**The Setup:**
XYZ Corp has very low volume. Only 100 shares trade per day.
**Amit** buys 5,000 shares at ₹5. Price jumps to ₹10 on his buying alone!

**The Profit:**
**Amit's** portfolio shows +100% gain! He is ecstatic. ₹25,000 profit!

**The Exit:**
He tries to sell.
**Buyers:** 0
**Sellers:** **Amit** (5,000 shares)

**The Result:**
He cannot sell. The price starts falling... ₹8, ₹6, ₹4...
He is trapped. He eventually sells at ₹2 months later.

**Detailed Lesson:**
Paper profits mean nothing without **Liquidity** (Volume).
''',
        },
        {
          'type': 'scenario',
          'title': 'Volume Analysis',
          'situation':
              'Stock A is up 5% with 10 Million volume. Stock B is up 5% with 1000 volume. Which one is safer to buy?',
          'choices': [
            {
              'text': 'Stock A',
              'isCorrect': true,
              'feedback':
                  '✅ Correct. High volume means many institutions and traders are participating. The move is genuine and liquid.',
            },
            {
              'text': 'Stock B',
              'isCorrect': false,
              'feedback':
                  '❌ Risky. Low volume suggests manipulation or lack of interest. You might get stuck.',
            },
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question': 'Why is "High Volume" important for a breakout?',
          'options': [
            'It means the stock is cheap',
            'It confirms that many traders agree with the price move',
            'It means the company has high profits',
            'It guarantees the price will never fall',
          ],
          'correctIndex': 1,
          'explanation':
              'Volume represents conviction. If price rises on high volume, it means "Big Money" is buying. If price rises on low volume, it might be a trap.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 5.2 Recap',
          'keyPoints': [
            'Volume confirms the validity of a price move',
            'Liquidity ensures you can exit when you want',
            'High Volume means institutions are participating',
            'Avoid low volume stocks ("Roach Motel" effect - easy to enter, hard to exit)',
            'Next: Understanding the two main emotions of the market.',
          ],
        },
      ],
    };
  }

  // Lesson 5.3: Bulls, Bears, and Market Sentiment
  static Map<String, dynamic> getBullsBearsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Welcome to the Zoo',
          'emoji': '🐾',
          'content':
              'Why is there a giant Bull statue on Wall Street and Dalal Street? Why do traders talk about animals? It\'s not a zoo—it\'s the language of market sentiment.',
        },
        {
          'type': 'story',
          'title': 'Raju the Bull vs Amit the Bear',
          'emoji': '⚔️',
          'content': '''
**Raju (The Bull):**
"I think the economy is growing! Companies will make more profit. I'm BUYING stocks because I expect prices to go UP."
**Raju** is **Bullish**. He attacks by thrusting his horns UP 🐂.

**Amit (The Bear):**
"Inflation is high! People have no money. I'm SELLING stocks because I expect prices to go DOWN."
**Amit** is **Bearish**. He attacks by swiping his paws DOWN 🐻.

**The Market Battle:**
Price is just the result of this constant fight.
If **Raju** and his friends buy more than **Amit** sells -> **Bull Market** (Price Up).
If **Amit** sells more -> **Bear Market** (Price Down).
''',
        },
        {
          'type': 'concept',
          'title': 'Defining the Markets',
          'emoji': '📉',
          'content': '''
**1. Bull Market (Optimism)**
• Prices rising consistently (usually +20% over months).
• Sentiment: Greed, Hope, Confidence.
• Strategy: "Buy the dip" (Buy when price drops slightly).

**2. Bear Market (Pessimism)**
• Prices falling consistently (usually -20% from peak).
• Sentiment: Fear, Panic, Despair.
• Strategy: "Sell into strength" or "Stay Cash".

**3. Sideways Market (Indecision)**
• Prices stuck in a range (Neither up nor down).
• Most frustrating for traders.
• Strategy: Wait for a breakout.

**Key Insight:**
"Bulls make money, Bears make money, Pigs get slaughtered." (Don't be greedy).
''',
          'keyPoints': [
            'Bull = Optimistic = Prices Up',
            'Bear = Pessimistic = Prices Down',
            'Sideways = No clear trend',
            'Trade with the trend (Don\'t be a bull in a bear market)',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Gauge the Sentiment',
          'emoji': '🧭',
          'content': '''
**Scenario A:**
GDP is growing, unemployment is low, companies reporting record profits.
**Verdict:** **Bullish** 🟢

**Scenario B:**
Central Bank raises interest rates, war breaks out, companies firing employees.
**Verdict:** **Bearish** 🔴

**Scenario C:**
Prices goes up 1% today, down 1% tomorrow, flat for a month.
**Verdict:** **Sideways** 🟡

**Why it matters:**
Your strategy must change based on the market type. Buying and holding works great in Bull markets, but destroys wealth in Bear markets.
''',
        },
        {
          'type': 'quiz',
          'title': 'Sentiment Quiz',
          'question':
              'If a trader believes the stock price will fall and decides to sell, what is their sentiment?',
          'options': ['Bullish', 'Bearish', 'Neutral', 'Sideways'],
          'correctIndex': 1,
          'explanation':
              'Bearish! Bears expect prices to fall (swipe down). Use this term to describe negative views on a stock or the economy.',
        },
        {
          'type': 'scenario',
          'title': 'Strategic Choice',
          'situation':
              'We are officially in a "Bear Market" (Prices down 25%). You see a stock jump up 5% one day. What do you do?',
          'choices': [
            {
              'text': 'Buy immediately! The Bear Market is over!',
              'isCorrect': false,
              'feedback':
                  '❌ Risky. Bear markets often have "Dead Cat Bounces" (temporary rallies). One day doesn\'t change the trend.',
            },
            {
              'text': 'Be cautious. Wait for more confirmation.',
              'isCorrect': true,
              'feedback':
                  '✅ Smart. In a Bear Market, "Hope" is dangerous. Wait for a sustained trend change before risking capital.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 5 Complete! 🎉',
          'keyPoints': [
            'Bid/Ask Spread is the cost of doing business',
            'Volume confirms if a move is real or fake',
            'Liquidity protects you from getting trapped',
            'Bullish = Up/Optimistic; Bearish = Down/Pessimistic',
            'Understand the market mood before placing a trade',
            'Next Chapter: Are you ready to start trading for real?',
          ],
        },
      ],
    };
  }
}
