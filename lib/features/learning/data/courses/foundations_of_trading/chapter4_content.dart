/// Chapter 4: Types of Orders
/// Complete interactive content for all lessons in Chapter 4
class Chapter4Content {
  // Lesson 4.1: Market Orders: Fast but Risky
  static Map<String, dynamic> getMarketOrderContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Speed Button',
          'emoji': '🚀',
          'content':
              'You see a stock moving up fast. You want to buy NOW. You hit the "Market Order" button. But do you know the price you just paid?',
        },
        {
          'type': 'story',
          'title': 'Sneha\'s Expensive Click',
          'emoji': '💸',
          'content': '''
**Sneha** sees "Tata Motors" trading at ₹950.
She is excited and wants to buy 100 shares immediately.

**The Mistake:**
She selects **"Market Order"** and clicks BUY.
She expects to pay ₹950 × 100 = ₹95,000.

**The Shock:**
The trade executes at ₹955!
Total cost: ₹95,500.
**Sneha** lost ₹500 in one second.

**Why?**
The price jumped just as she clicked. A Market Order is like saying: "I don't care about the price, just give me the shares NOW!"
''',
        },
        {
          'type': 'concept',
          'title': 'What is a Market Order?',
          'emoji': '⚡',
          'content': '''
**Definition:**
An order to buy or sell immediately at the *best available current price*.

**Pros:**
• **Guaranteed Execution:** You definitely get the shares.
• **Instant:** No waiting.

**Cons:**
• **Price Risk:** In a fast-moving market, you might pay much more than you see on screen.
• **Slippage:** The difference between expected price vs executed price.

**Best Use Case:**
When you need to get in or out URGENTLY (e.g., stopping a huge loss).
''',
          'keyPoints': [
            'Market Order guarantees execution, not price',
            'Slippage is the hidden cost of speed',
            'Avoid Market Orders in volatile stocks',
            'Use when entering/exiting rapidly',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question': 'When is it SAFEST to use a Market Order?',
          'options': [
            'When the market is extremely volatile',
            'When the stock has very low liquidity',
            'When the stock is highly liquid and stable',
            'When you want a specific price',
          ],
          'correctIndex': 2,
          'explanation':
              'In highly liquid stocks (like Reliance/HDFC), the spread is tiny and price moves smoothly, so Market Orders are generally safe. In volatile or illiquid stocks, they are dangerous.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 4.1 Recap',
          'keyPoints': [
            'Market Orders prioritize Speed over Price',
            'You might pay more (Buy) or get less (Sell) due to Slippage',
            'Never use Market Orders on illiquid stocks',
            'Next: How to control the price perfectly.',
          ],
        },
      ],
    };
  }

  // Lesson 4.2: Limit Orders: Patience Pays
  static Map<String, dynamic> getLimitOrderContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Sniper Approach',
          'emoji': '🎯',
          'content':
              'Professional traders rarely use Market Orders. They use Limit Orders. It\'s like being a sniper waiting for the target to come to you.',
        },
        {
          'type': 'concept',
          'title': 'What is a Limit Order?',
          'emoji': '⚓',
          'content': '''
**Definition:**
An order to buy or sell at a *specific price or better*.

**Example:**
Stock is at ₹102. You place a **Buy Limit Order at ₹100**.
• If price drops to ₹100, you buy.
• If price stays at ₹102, you buy nothing.

**Pros:**
• **Price Guarantee:** You never pay more than your limit.
• **No Slippage.**

**Cons:**
• **Execution Risk:** If price never hits ₹100, you miss the trade completely.

**Best Use Case:**
Buying dips, selling targets, and entering volatile stocks safely.
''',
          'keyPoints': [
            'Limit Order guarantees Price, not Execution',
            'Buy Limit must be BELOW current price',
            'Sell Limit must be ABOVE current price',
            'Protects you from bad fills',
          ],
        },
        {
          'type': 'story',
          'title': 'Raju the Patient Trader',
          'emoji': '🧘',
          'content': '''
**Raju** wants to buy ABC Corp.
Current Price: ₹505.
Raju analysis says it's worth ₹500.

**Strategy:**
He places a **Limit Buy Order at ₹500**.
He goes for lunch.

**The Market:**
Price fluctuates: ₹506... ₹504... and momentarily dips to ₹500.
**Raju's** order executes!
The price bounces back to ₹505.

**Result:**
**Raju** bought at the exact bottom tick. If he used Market Order, he would have paid ₹505.
''',
        },
        {
          'type': 'scenario',
          'title': 'Order Choice',
          'situation':
              'You want to sell your shares at ₹200 to book profit. The current price is ₹198. Which order do you place?',
          'choices': [
            {
              'text': 'Sell Market Order',
              'isCorrect': false,
              'feedback':
                  '❌ You will sell immediately at ₹198 (approx). You wanted ₹200.',
            },
            {
              'text': 'Sell Limit Order at ₹200',
              'isCorrect': true,
              'feedback':
                  '✅ Correct. Your order will sit in the system and only execute if buyers push price up to ₹200.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 4.2 Recap',
          'keyPoints': [
            'Limit Orders let you set your maximum buy price or minimum sell price',
            'Use them to avoid overpaying in volatile markets',
            'The risk is missing the trade if price runs away',
            'Patience pays off with better entry prices',
          ],
        },
      ],
    };
  }

  // Lesson 4.3: Stop Orders: Your Safety Net
  static Map<String, dynamic> getStopOrderContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Emergency Brake',
          'emoji': '🛑',
          'content':
              'Imagine driving a car without brakes. That\'s trading without a Stop Order. It\'s the single most important tool for survival.',
        },
        {
          'type': 'story',
          'title': 'Amit Saves His Capital',
          'emoji': '🛡️',
          'content': '''
**Amit** buys a stock at ₹100.
He fears it might crash.
He sets a **Stop Loss (SL) Order at ₹95**.

**The Crash:**
Bad news hits! The stock plummets.
₹98... ₹96... ₹95 (SL Triggered!)
The system automatically sells his shares.
The stock continues to fall to ₹60.

**The Outcome:**
**Amit** lost ₹5 per share.
If he didn't have the SL, he would have lost ₹40 per share!
His Stop Loss saved him from disaster.
''',
        },
        {
          'type': 'concept',
          'title': 'Stop Loss (SL) Explained',
          'emoji': '📉',
          'content': '''
**Definition:**
An order that becomes a Market Order when a specific "Trigger Price" is hit.

**How it works:**
• You own stock at ₹100.
• You assume "If it falls below ₹90, my analysis is wrong."
• You place **Sell SL-M (Stop Loss Market) at Trigger ₹90**.

**Scenario:**
Price drops to ₹90 -> Order activates -> Sells immediately at market price (e.g., ₹89.90).

**Why use it?**
To limit your losses automatically. You don't need to watch the screen all day.
''',
          'keyPoints': [
            'Stop Loss protects you from unlimited loss',
            'SL-M turns into Market Order when triggered',
            'Always decide your SL point BEFORE entering a trade',
            'Small losses are okay; Big losses destroy careers',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Setting the Stop',
          'emoji': '📏',
          'content': '''
**The 2% Rule:**
Never risk more than 2% of your capital on one trade.

**Scenario:**
Capital: ₹1,00,000.
Max Risk: ₹2,000.
You buy 100 shares.
Max Loss per share = ₹2000 / 100 = ₹20.

**If you buy at ₹500, where is your SL?**
₹500 - ₹20 = ₹480.

**Key Insight:**
Stop Loss isn't random. It's calculated math to keep you in the game.
''',
        },
        {
          'type': 'quiz',
          'title': 'SL Quiz',
          'question': 'Why is trading without a Stop Loss dangerous?',
          'options': [
            'It costs more brokerage',
            'You might miss the profit target',
            'A single bad trade can wipe out 50% of your account',
            'The exchange charges a penalty',
          ],
          'correctIndex': 2,
          'explanation':
              'Without a Stop Loss, a stock can fall indefinitely while you "hope" it comes back. This "holding and hoping" is how accounts get blown up.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 4.3 Recap',
          'keyPoints': [
            'Stop Orders act as an automatic exit if things go wrong',
            'Trigger Price is the line in the sand',
            'SL-M guarantees exit but not price (Slippage possible)',
            'SL-Limit guarantees price but might not exit (Dangerous)',
            'Always use SL to survive long term',
          ],
        },
      ],
    };
  }

  // Lesson 4.4: Practice (Quiz)
  static Map<String, dynamic> getPracticeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Order Type Challenge',
          'emoji': '🎮',
          'content':
              'You now know Market, Limit, and Stop orders. Let\'s put them to the test in real-world scenarios. Pick the right tool for the job!',
        },
        {
          'type': 'scenario',
          'title': 'Scenario 1: The Breakout',
          'situation':
              'A stock is breaking out of a pattern at ₹200. It is moving VERY fast. You want to ensure you get in, even if you pay ₹201 or ₹202.',
          'choices': [
            {
              'text': 'Limit Order at ₹200',
              'isCorrect': false,
              'feedback':
                  '❌ The price is moving fast. It might skip ₹200 and go straight to ₹205. Your Limit won\'t execute.',
            },
            {
              'text': 'Market Order',
              'isCorrect': true,
              'feedback':
                  '✅ Correct. Speed is the priority here. You accept slight slippage to guarantee entry.',
            },
          ],
        },
        {
          'type': 'scenario',
          'title': 'Scenario 2: The Bargain Hunt',
          'situation':
              'The market is crashing. Panic everywhere. You want to buy a quality stock ONLY if it falls to a ridiculous price of ₹500 (Current ₹550).',
          'choices': [
            {
              'text': 'Market Order',
              'isCorrect': false,
              'feedback':
                  '❌ You will buy at ₹550 immediately. You wanted ₹500.',
            },
            {
              'text': 'Buy Limit Order at ₹500',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect. You set the trap and wait. If it hits ₹500, you get a bargain. If not, you stay safe.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 4 Complete! 🎉',
          'keyPoints': [
            'Market Order = Speed',
            'Limit Order = Precision',
            'Stop Order = Protection',
            'Combine them: Enter with Limit, Protect with Stop',
            'Next Chapter: Speaking the Language of the Market (Bid/Ask/Volume)',
          ],
        },
      ],
    };
  }
}
