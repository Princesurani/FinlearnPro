/// Chapter 1: What is the Stock Market?
/// Complete interactive content for all lessons in this chapter
class SMChapter1Content {
  // Lesson 1: The Marketplace of Ownership
  static Map<String, dynamic> getMarketplaceContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Welcome to the Market',
          'emoji': '🏛️',
          'content':
              'You\'ve heard about the stock market all your life. Parents discuss it at dinner. Friends brag about profits. News channels scream about "Sensex crashing." But what actually IS the stock market? Let\'s find out.',
        },
        {
          'type': 'story',
          'title': 'The Vegetable Market Analogy',
          'emoji': '🥕',
          'content': '''
**Think of your local sabzi mandi (vegetable market).**

Farmers bring vegetables to sell. Buyers come to buy.
The price of tomatoes depends on **supply and demand**:
• Monsoon fails → Less supply → Tomato = ₹100/kg
• Bumper harvest → More supply → Tomato = ₹10/kg

**Now replace vegetables with "shares of companies."**

The **Stock Market** is a marketplace where:
• **Sellers** sell their ownership in companies
• **Buyers** buy ownership hoping the price goes up
• **Price** is set by how many people want to buy vs sell

**That's it.** No magic. No mystery.
Just buyers and sellers negotiating prices for company ownership.

**Key Difference from sabzi mandi:**
Nobody touches anything physical. Everything happens electronically on exchanges like **NSE** and **BSE** through your phone or laptop.
''',
        },
        {
          'type': 'concept',
          'title': 'NSE & BSE: India\'s Two Exchanges',
          'emoji': '🏢',
          'content': '''
**BSE (Bombay Stock Exchange)**
• Founded in **1875** — Asia's oldest exchange.
• Located at Dalal Street, Mumbai.
• Index: **Sensex** (30 companies).

**NSE (National Stock Exchange)**
• Founded in **1992** — fully electronic from Day 1.
• Most Indian traders use NSE today.
• Index: **Nifty 50** (50 companies).

**Which one should you use?**
Most brokers let you trade on both. NSE has higher **liquidity** (more buyers/sellers), so prices are fairer.

**The Index Explained:**
Sensex and Nifty are like the "temperature" of the market.
If Nifty goes up → Most stocks are going up.
If Sensex crashes → The market is having a bad day.
They track the top companies to give you a quick snapshot.
''',
          'keyPoints': [
            'BSE is Asia\'s oldest exchange (1875)',
            'NSE is India\'s most traded exchange',
            'Sensex tracks 30 stocks; Nifty tracks 50',
            'These indices show the overall market direction',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Supply & Demand in Action',
          'emoji': '📊',
          'content': '''
**Let's see how stock prices move:**

**Scenario: Reliance Industries**
Current Price: ₹2,500

**Case 1: Good News 📈**
Reliance discovers a massive oil reserve.
Everyone wants to buy → Demand shoots up.
Price jumps to ₹2,750 (+10%).

**Case 2: Bad News 📉**
Government puts a new tax on refineries.
Everyone wants to sell → Supply floods in.
Price drops to ₹2,250 (-10%).

**Case 3: No News 😐**
Normal day. Equal buyers and sellers.
Price stays around ₹2,500 (±1%).

**Takeaway:**
Stock prices move because of **news, emotions, and expectations** — not because the company did something that day.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'What primarily determines the price of a stock on any given day?',
          'options': [
            'The company\'s CEO decides the price',
            'Supply and demand from buyers and sellers',
            'The government sets it every morning',
            'It\'s random and unpredictable',
          ],
          'correctIndex': 1,
          'explanation':
              'Stock prices are determined by supply and demand. If more people want to buy (demand), the price goes up. If more people want to sell (supply), the price goes down. No single person controls it.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'The stock market is a marketplace for buying/selling company ownership',
            'NSE (Nifty 50) and BSE (Sensex) are India\'s two exchanges',
            'Prices are driven by supply and demand, not by the company itself',
            'Indices like Nifty and Sensex show overall market health',
            'Everything happens electronically — no physical trading anymore',
          ],
        },
      ],
    };
  }

  // Lesson 2: What Does a "Share" Mean?
  static Map<String, dynamic> getShareMeaningContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Owning a Piece of the Pie',
          'emoji': '🍰',
          'content':
              'When someone says "I bought shares of TCS," what did they actually buy? A piece of paper? A promise? A number on a screen? Let\'s break down what a "share" really means.',
        },
        {
          'type': 'story',
          'title': 'Rohan\'s Pizza Empire',
          'emoji': '🍕',
          'content': '''
**Rohan** has the best pizza shop in Pune. Revenue: ₹50 Lakhs/year.

He wants to open 5 more outlets but needs **₹25 Lakhs**.
He has two choices:

**Option A: Bank Loan**
Borrow ₹25L, pay back ₹32L over 5 years (with interest).
He keeps 100% ownership but has **debt pressure**.

**Option B: Sell Shares**
Divide the business into **10,000 shares**.
Sell 2,500 shares (25%) to investors at ₹1,000 each.
He raises ₹25L. **No debt. No interest.**

**Rohan picks Option B.**

His friend **Meera** buys 100 shares for ₹1,00,000.
Meera now owns **1% of Rohan's Pizza Empire**.

If the business doubles in value:
• Each share goes from ₹1,000 → ₹2,000.
• Meera's investment: ₹1L → ₹2L. 💵

**This is exactly what happens when you buy a stock.**
You become a partial owner of the company.
''',
        },
        {
          'type': 'concept',
          'title': 'Share = Equity = Ownership',
          'emoji': '📜',
          'content': '''
**Three words, same meaning:**
• **Share** = A single unit of ownership
• **Equity** = Ownership stake in a company
• **Stock** = General term for shares of a company

**What you GET as a shareholder:**
• **Voting Rights** — Vote on major company decisions
• **Dividends** — Share of the company's profits (if declared)
• **Capital Gain** — Profit when share price increases

**What you DON'T get:**
• You can't walk into the office and sit in the CEO's chair
• You can't demand free products
• You don't control daily operations

**Key Difference from Lending:**
If you lend ₹1L to a friend, they **must** pay you back.
If you buy ₹1L of shares, the company owes you **nothing**.
You're a **partner**, not a **lender**.
''',
          'keyPoints': [
            'Share = Equity = Stock (same concept)',
            'Shareholders are owners, not lenders',
            'You get voting rights, dividends, and capital gains',
            'If the company fails, you lose your investment — no refund',
            'Ownership is financial, not operational',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Calculate Your Ownership',
          'emoji': '🧮',
          'content': '''
**Let's do the math:**

**TCS (Tata Consultancy Services)**
Total shares outstanding: ~366 Crore shares
Current price: ~₹3,800 per share

**If you buy 100 shares:**
Investment: 100 × ₹3,800 = **₹3,80,000**
Your ownership: 100 / 3,66,00,00,000 = **0.0000027%**

Tiny? Yes. But you're still a **legal owner** of TCS.
You can attend the AGM and vote alongside the Tata family!

**What if TCS price goes up 20%?**
Your ₹3.8L becomes ₹4.56L.
**Profit: ₹76,000** (without doing any work).

**What if TCS price drops 20%?**
Your ₹3.8L becomes ₹3.04L.
**Loss: ₹76,000** (the risk of ownership).
''',
        },
        {
          'type': 'quiz',
          'title': 'Ownership Check',
          'question':
              'Meera buys 500 shares of Infosys. The company reports a loss this quarter. What happens to Meera?',
          'options': [
            'Infosys must pay Meera back her investment',
            'Meera\'s share price may drop, but she gets no refund',
            'Meera becomes liable for Infosys\'s debts',
            'Nothing — share prices never change due to losses',
          ],
          'correctIndex': 1,
          'explanation':
              'As a shareholder, Meera shares in the risk. If the company does poorly, the share price drops and her investment loses value. But she is never liable for the company\'s debts — that\'s the advantage of "limited liability."',
        },
        {
          'type': 'scenario',
          'title': 'The Ownership Dilemma',
          'situation':
              'Your colleague says: "I own 10 shares of Reliance, so I\'m going to their office to demand a tour!" Is he right?',
          'choices': [
            {
              'text': 'Yes — shareholders can visit anytime',
              'isCorrect': false,
              'feedback':
                  '❌ Nope! Owning shares gives you financial ownership, not access to offices, factories, or free products. You can attend the AGM though!',
            },
            {
              'text': 'No — ownership is financial, not operational',
              'isCorrect': true,
              'feedback':
                  '✅ Correct! You own a financial interest in the company. You can vote at the AGM, receive dividends, and benefit from price appreciation — but you can\'t walk into their office.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'A share is a unit of ownership in a company',
            'Buying shares makes you a partner (not a lender)',
            'Shareholders get voting rights, dividends, and capital gains',
            'If the company fails, your investment can go to zero',
            'Your liability is limited to the amount you invested',
          ],
        },
      ],
    };
  }

  // Lesson 3: Stock Market Reality Check (Quiz)
  static Map<String, dynamic> getRealityCheckContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Time to Test Yourself!',
          'emoji': '🧠',
          'content':
              'You\'ve learned the basics of what the stock market is and what shares mean. Let\'s see how much you remember. No pressure — this is your personal checkpoint.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1',
          'question': 'The stock market is best described as:',
          'options': [
            'A government-run bank for stocks',
            'A casino where you gamble on prices',
            'A marketplace for buying and selling company ownership',
            'A place only for rich people to invest',
          ],
          'correctIndex': 2,
          'explanation':
              'The stock market is a regulated marketplace where anyone can buy and sell ownership (shares) in publicly listed companies. It\'s not gambling — it\'s based on real business value.',
        },
        {
          'type': 'quiz',
          'title': 'Question 2',
          'question': 'What is the difference between Sensex and Nifty?',
          'options': [
            'Sensex is for BSE (30 stocks), Nifty is for NSE (50 stocks)',
            'Sensex is for buying, Nifty is for selling',
            'Sensex tracks small companies, Nifty tracks large ones',
            'There is no difference — they are the same thing',
          ],
          'correctIndex': 0,
          'explanation':
              'Sensex is BSE\'s benchmark index tracking 30 companies. Nifty 50 is NSE\'s benchmark tracking 50 companies. Both measure market health, but they track different sets of stocks.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3',
          'question': 'If you buy 1 share of HDFC Bank, you are technically:',
          'options': [
            'A customer of HDFC Bank',
            'An employee of HDFC Bank',
            'A partial owner of HDFC Bank',
            'A creditor of HDFC Bank',
          ],
          'correctIndex': 2,
          'explanation':
              'Buying even 1 share makes you a legal partial owner (shareholder) of the company. You have voting rights and may receive dividends. You\'re an owner, not a customer or lender.',
        },
        {
          'type': 'scenario',
          'title': 'Real World Decision',
          'situation':
              'A stock you bought at ₹500 has dropped to ₹400. Your friend says "Sell it now before it goes to zero!" What should you consider?',
          'choices': [
            {
              'text': 'Sell immediately — your friend must be right',
              'isCorrect': false,
              'feedback':
                  '❌ Panic selling based on emotions is a common mistake. Price drops don\'t always mean the company is failing.',
            },
            {
              'text': 'Check WHY it dropped — is the business still strong?',
              'isCorrect': true,
              'feedback':
                  '✅ Smart approach! A price drop could be temporary market noise. Check the fundamentals — revenue, profits, industry outlook — before making any decision.',
            },
            {
              'text': 'Buy more shares to "average down" without research',
              'isCorrect': false,
              'feedback':
                  '❌ Averaging down without understanding why the stock fell is dangerous. If the company is genuinely in trouble, you\'re just throwing more money at a sinking ship.',
            },
          ],
        },
        {
          'type': 'quiz',
          'title': 'Question 4',
          'question': 'What drives stock prices up or down on a daily basis?',
          'options': [
            'The company\'s board decides the daily price',
            'SEBI (regulator) sets the price each morning',
            'Supply and demand from buyers and sellers',
            'Stock prices change randomly with no pattern',
          ],
          'correctIndex': 2,
          'explanation':
              'Stock prices are purely driven by supply (sellers) and demand (buyers). If more people want to buy, price rises. If more want to sell, price falls. News, earnings, and sentiment influence this balance.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 1 Complete! 🎉',
          'keyPoints': [
            'The stock market is a marketplace for company ownership',
            'NSE (Nifty) and BSE (Sensex) are India\'s main exchanges',
            'A share = equity = ownership in a company',
            'Prices move based on supply and demand',
            'Shareholders are owners, not lenders — risk is real',
            'Never make decisions based on panic or tips alone',
          ],
        },
      ],
    };
  }
}
