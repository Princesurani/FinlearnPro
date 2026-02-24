/// Chapter 6: Before You Start Trading
/// Complete interactive content for all lessons in Chapter 6
class BeforeYouStartTradingContent {
  // Lesson 6.1: Choosing a Broker: What Actually Matters
  static Map<String, dynamic> getBrokerSelectionContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Gateway',
          'emoji': '🌉',
          'content':
              'You cannot trade directly with the exchange. You need a middleman: A Broker. Choosing the wrong one is like picking a race car with a bad engine.',
        },
        {
          'type': 'concept',
          'title': 'Discount vs Full-Service',
          'emoji': '🏦',
          'content': '''
**1. Discount Brokers (e.g., Zerodha, Groww, Upstox)**
• **Fees:** Flat fee (e.g., ₹20 per trade).
• **Tools:** Modern app, fast UI.
• **Advice:** None. Do your own research.
• **Best for:** Most modern retail traders.

**2. Full-Service Brokers (e.g., ICICI Direct, Kotak Sec)**
• **Fees:** Percentage (e.g., 0.5% of trade value). Expensive!
• **Tools:** Often clunky/traditional.
• **Advice:** They provide "Tips" and Relationship Managers.
• **Best for:** People who want hand-holding and don't mind high fees.

**Key Insight:**
Paying 0.5% brokerage can eat 50% of your profits over time. Most beginners should stick to Discount Brokers.
''',
          'keyPoints': [
            'Discount Brokers = Low Fee, DIY',
            'Full-Service = High Fee, Advisory',
            'Tech stability is more important than slightly lower fees',
            'Hidden charges (AMC, DP charges) add up',
          ],
        },
        {
          'type': 'story',
          'title': 'Rohan\'s "Cheap" Mistake',
          'emoji': '📉',
          'content': '''
**Rohan** wants the absolute cheapest broker.
He finds "App X" that offers ₹0 brokerage.
He ignores reviews saying the app crashes often.

**The Crash:**
Market is crashing! **Rohan** needs to sell his positions to save capital.
He opens "App X".
*Loading... Loading... Server Error.*

**The Result:**
By the time the app works (20 mins later), the stock has fallen another 5%.
**Rohan** saved ₹20 on brokerage but lost ₹5,000 on the trade.

**Lesson:**
Reliability > Cheapest Fees. A broker that crashes when you need it most is useless.
''',
        },
        {
          'type': 'scenario',
          'title': 'Pick Your Partner',
          'situation':
              'You are a beginner with ₹50,000. You plan to make 5 trades a month. You want to learn by yourself.',
          'choices': [
            {
              'text': 'Full Service Broker (0.5% brokerage)',
              'isCorrect': false,
              'feedback':
                  '❌ Too expensive. On a ₹50k turnover, 0.5% is ₹250. A flat fee broker would charge ₹20. Why pay 10x more?',
            },
            {
              'text': 'Discount Broker (Flat ₹20)',
              'isCorrect': true,
              'feedback':
                  '✅ Smart choice. Low costs mean you keep more of your profits. Their apps are also usually better for learning.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 6.1 Recap',
          'keyPoints': [
            'Your broker is your business partner—choose wisely',
            'Discount brokers are usually best for beginners (Low fees)',
            'Check for "Uptime" and reliability, not just low costs',
            'Avoid brokers with hidden "Account Maintenance Charges" if possible',
            'Next: How to practice without losing a single rupee.',
          ],
        },
      ],
    };
  }

  // Lesson 6.2: Paper Trading: Your Practice Ground
  static Map<String, dynamic> getPaperTradingContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Flight Simulator',
          'emoji': '✈️',
          'content':
              'Pilots don\'t fly a Boeing 747 on their first day. They use a simulator. Traders should do the same. Welcome to Paper Trading.',
        },
        {
          'type': 'concept',
          'title': 'What is Paper Trading?',
          'emoji': '📝',
          'content': '''
**Definition:**
Trading with "Fake Money" on real market data.

**How it works:**
1. Download a Paper Trading app (e.g., TradingView, FrontPage).
2. You get ₹1 Crore virtual cash.
3. You buy/sell real stocks at real prices.
4. You track profit/loss.

**The Goal:**
Test your strategy without risking your life savings. Make your rookie mistakes here, where they are free.

**The Catch:**
It feels easy because there is no **Fear**.
''',
          'keyPoints': [
            'Paper Trading = Real Market, Fake Money',
            'Best way to learn platform mechanics',
            'Use it to test if your strategy actually works',
            'It cannot simulate emotional pressure',
          ],
        },
        {
          'type': 'story',
          'title': 'Priya\'s False Confidence',
          'emoji': '🦁',
          'content': '''
**Priya** paper trades for 1 month.
She takes huge risks because "it's fake money."
She turns ₹10 Lakhs into ₹20 Lakhs! (+100%).

**The Real World:**
She thinks she is a genius. She puts ₹5 Lakhs of her REAL savings into the market.

**The Difference:**
In paper trading, she held loss-making trades until they turned green.
In real trading, when she sees -₹10,000 loss, her heart pounds. She panics and sells.

**The Result:**
She loses 20% of her real money in a week.

**Lesson:**
Paper trading builds **skill**, but not **psychology**. Transition slowly.
''',
        },
        {
          'type': 'interactive',
          'title': 'Simulator Mode',
          'emoji': '🎮',
          'content': '''
**Paper Trading Checklist:**
1. Treat the fake money as REAL money.
2. Don't take trade sizes you wouldn't take in real life.
   (e.g., don't buy ₹50 Lakhs of stock if you only have ₹50k real cash).
3. Journal every trade: "Why did I buy?"
4. Do this for at least 30 trades before using real cash.

**Success Metric:**
Not "How much money I made", but "Did I follow my rules?"
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question': 'What is the biggest limitation of Paper Trading?',
          'options': [
            'The prices are not real',
            'You cannot learn technical analysis',
            'It lacks the emotional pressure of losing real money',
            'Apps charge money to use it',
          ],
          'correctIndex': 2,
          'explanation':
              'Emotions! It\'s easy to be brave when you have nothing to lose. Real trading is 80% psychology, which paper trading cannot teach.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 6.2 Recap',
          'keyPoints': [
            'Always verify your strategy in Paper Trading first',
            'Don\'t let paper profits give you an ego',
            'Be realistic with trade sizes',
            'Transition to real trading with very small amounts',
            'Next: The trap that kills 90% of accounts.',
          ],
        },
      ],
    };
  }

  // Lesson 6.3: The #1 Mistake Beginners Make
  static Map<String, dynamic> getMistakeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Account Killer',
          'emoji': '💀',
          'content':
              'Is it bad analysis? No. Is it bad luck? No. The reason most beginners go bust is **Risk Management** (or lack of it).',
        },
        {
          'type': 'concept',
          'title': 'Position Sizing',
          'emoji': '📉',
          'content': '''
**The Mistake:**
Betting too big on a "sure thing."

**The Math of Ruin:**
If you risk 50% of your capital on one trade...
• You have ₹1,00,000.
• You buy ONE stock worth ₹50,000.
• Stock crashes 50%.
• You lose ₹25,000 (25% of total wealth).

**Recovery Trap:**
To recover a 25% loss, you need a 33% gain on the remaining capital.
To recover a 50% loss, you need a **100% gain**!

**The Golden Rule:**
Never risk more than **1-2%** of your total capital on a single trade.
''',
          'keyPoints': [
            'Big bets = Big disaster potential',
            'Losses are harder to recover than you think',
            'Risk 1-2% per trade ensures you can survive 50 losses in a row',
            'Survival is the #1 goal',
          ],
        },
        {
          'type': 'story',
          'title': 'Amit\'s "Sure Shot"',
          'emoji': '🎲',
          'content': '''
**Amit** has ₹1 Lakh.
He hears a tip: "Stock ABC will double tomorrow!"
He is so confident, he puts ₹1 Lakh (100%) into Stock ABC.

**The Outcome:**
The news was fake. Stock ABC opens -20% lower.
**Amit** loses ₹20,000 instantly.
He panics and holds, hoping it comes back.
It falls to -40%.
**Amit** sells at ₹60,000.

**The Aftermath:**
He lost 40% of his life savings in one day.
If he had risked only 2% (₹2,000), this loss would be a minor scratch. Instead, it was a fatal wound.
''',
        },
        {
          'type': 'scenario',
          'title': 'Risk Check',
          'situation':
              'You have ₹1,00,000. You want to buy a stock. Your Stop Loss is 5% below entry. How much should you invest to risk only ₹1,000 (1%)?',
          'choices': [
            {
              'text': 'Invest ₹1,00,000',
              'isCorrect': false,
              'feedback':
                  '❌ If you invest ₹1L and lose 5%, you lose ₹5,000. That is 5% risk. You wanted 1%.',
            },
            {
              'text': 'Invest ₹20,000',
              'isCorrect': true,
              'feedback':
                  '✅ Correct. 5% loss on ₹20,000 = ₹1,000. This is perfect position sizing.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 6.3 Recap',
          'keyPoints': [
            'The #1 mistake is betting too big',
            'Big losses are mathematically very hard to recover',
            'Stick to the 1-2% Rule',
            'Position Sizing protects you when your analysis is wrong (and it will be)',
            'Next: The Final Challenge.',
          ],
        },
      ],
    };
  }

  // Lesson 6.4: Final Challenge: Are You Ready?
  static Map<String, dynamic> getFinalChallengeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Final Exam',
          'emoji': '🎓',
          'content':
              'You have completed the Foundations of Trading. It\'s time to prove you are ready for the real world. Pass this quiz to graduate!',
        },
        {
          'type': 'quiz',
          'title': 'Q1: Market vs Limit',
          'question':
              'The market is extremely volatile and crashing hard. You want to exit a position to save whatever capital is left. What do you use?',
          'options': [
            'Limit Order',
            'Market Order',
            'Stop Loss Limit',
            'Wait for tomorrow',
          ],
          'correctIndex': 1,
          'explanation':
              'In a panic crash, **Speed** is priority. A Limit order might not get filled if price jumps significantly. Market Order guarantees exit.',
        },
        {
          'type': 'quiz',
          'title': 'Q2: The Spread',
          'question':
              'Stock X has Bid: ₹100 and Ask: ₹105. You buy at Market. What is your immediate P&L?',
          'options': ['0 (Break even)', '+₹5 Profit', '-₹5 Loss', '-₹2.5 Loss'],
          'correctIndex': 2,
          'explanation':
              'You buy at Ask (₹105). If you sell immediately, you sell at Bid (₹100). Loss = ₹5 (The Spread).',
        },
        {
          'type': 'quiz',
          'title': 'Q3: Risk Management',
          'question':
              'You have ₹1 Lakh capital. You want to risk 1% per trade. Your Stop Loss is ₹10 away from entry. How many shares can you buy?',
          'options': ['100 Shares', '50 Shares', '1000 Shares', '10 Shares'],
          'correctIndex': 0,
          'explanation':
              'Max Risk = ₹1,000 (1% of 1L). Risk Per Share = ₹10. Number of Shares = 1000 / 10 = 100 Shares.',
        },
        {
          'type': 'quiz',
          'title': 'Q4: Psychology',
          'question':
              'You lost 3 trades in a row. You feel angry and want to "win it back" with a double-size bet. What is this called?',
          'options': [
            'Strategic Hedging',
            'Revenge Trading',
            'Martingale Strategy',
            'Averaging Down',
          ],
          'correctIndex': 1,
          'explanation':
              'This is **Revenge Trading**, and it is the fastest way to blow up an account. The correct action is to stop trading and take a break.',
        },
        {
          'type': 'quiz',
          'title': 'Q5: Sentiment',
          'question':
              'FIIs are selling heavily. Volume is high. Prices are breaking support levels. What is the market sentiment?',
          'options': ['Bullish', 'Bearish', 'Sideways', 'Neutral'],
          'correctIndex': 1,
          'explanation':
              'Selling + High Volume + Breaking Support = Strong **Bearish** signal.',
        },
        {
          'type': 'summary',
          'title': 'Course Complete! 🏆',
          'keyPoints': [
            'Congratulations! You have finished "Foundations of Trading"',
            'You know the Players, the Orders, the Costs, and the Risks',
            'You understand that Psychology > Strategy',
            'Start with Paper Trading, then Small Capital',
            'Keep learning. The market is the ultimate teacher.',
            'Good luck, Trader!',
          ],
        },
      ],
    };
  }
}
