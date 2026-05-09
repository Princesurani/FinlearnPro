/// Chapter 5: Stop-Loss & Capital Protection
/// Your insurance policy against ruin
class StopLossContent {
  // Lesson 5.1: Types of Stop Losses
  static Map<String, dynamic> getTypesOfStopsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Ultimate Defense',
          'emoji': '🛑',
          'content':
              'A stop loss is an order to automatically sell your position if the price hits a certain level. It is your ultimate defense against catastrophic loss. Trading without a stop loss is driving a car with no brakes.',
        },
        {
          'type': 'concept',
          'title': 'The Four Types of Stops',
          'emoji': '🛡️',
          'content': '''
**1. Technical Stop (The Best Method) 📊**
Placed below a logical chart level where the technical setup is PROVEN WRONG.
• For a long trade: Below the recent swing low or major support level.
• Why? If price breaks support, your thesis was wrong. Exit immediately.

**2. Percentage Stop (Common but Flawed) 📉**
Selling if the price drops by a fixed percentage (e.g., "I'll sell if it drops 5%").
• Flaw: The market doesn't care about your arbitrary 5%. The technical support might be at 6%. You'll get stopped out right before the bounce.

**3. Volatility Stop (ATR) 📈**
Using the Average True Range (ATR) indicator to set stops outside normal market noise.
• Excellent for dynamic markets. Keeps you in the trade during normal fluctuations.

**4. Trailing Stop (For Winning Trades) 🚀**
Moving your stop loss UP as the price moves in your favor.
• Locks in profits while giving the trend room to run.
• Example: Trailing the stop below the 20 EMA during a strong uptrend.

---

**The "Mental Stop" Trap 🧠❌**
"I won't put an order in the system, I'll just sell if it hits ₹100."
When it hits ₹100, fear takes over. "Let me wait 5 minutes." "It'll bounce from ₹98."
Before you know it, you're down 30%.
**Always use HARD stops placed in the broker's system.**
''',
          'keyPoints': [
            'Technical stops are best — they trigger when the chart structure breaks',
            'Percentage stops are arbitrary and often trigger during normal noise',
            'Trailing stops lock in profit while letting winners run',
            'Mental stops always fail due to emotion. Use hard system stops.',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Stop Loss Comparison',
          'emoji': '📊',
          'content': '''
**Same trade, three different stop loss approaches:**

Stock: Infosys | Entry: ₹1,500 | Support: ₹1,440

| Method | Stop Level | Risk/Share | 1% Risk (₹1L cap) | Shares | Result |
|--------|-----------|-----------|-------------------|--------|--------|
| **Percentage (5%)** | ₹1,425 | ₹75 | ₹1,000 ÷ ₹75 | 13 shares | ❌ Stopped out before bounce at ₹1,438 |
| **Technical** | ₹1,435 | ₹65 | ₹1,000 ÷ ₹65 | 15 shares | ✅ Survived dip to ₹1,441, rode to ₹1,580 |
| **No Stop** | None | Unlimited | All-in, 66 shares | 66 shares | 💀 Stock gaps down to ₹1,350 = -₹9,900 (10% loss!) |

**The takeaway:**
• Percentage stop: Too arbitrary. Got stopped before the real support level.
• Technical stop: Just below support. Survived the dip and captured the bounce.
• No stop: Catastrophic. A 10% gap down destroyed the account.

**Stop loss placement is the difference between a controlled ₹1,000 loss and an uncontrolled ₹10,000 loss.**
''',
        },
        {
          'type': 'scenario',
          'title': 'The Stop Loss Decision',
          'situation':
              'You buy a stock at ₹200. The major support level is at ₹185. You are comfortable risking 5% (₹10) per share. Where do you place your stop loss?',
          'choices': [
            {
              'text': 'At ₹190 (your 5% risk limit)',
              'isCorrect': false,
              'feedback':
                  '❌ This is the trap of percentage stops! The real support is at ₹185. If you put a stop at ₹190, the stock will likely dip to ₹185, trigger your stop at ₹190, and then bounce back up. You must use the TECHNICAL level (₹185) and adjust your POSITION SIZE to ensure the loss is within your risk limit.',
            },
            {
              'text': 'At ₹184 (just below technical support)',
              'isCorrect': true,
              'feedback':
                  '✅ Exactly! You place the stop at the logical technical level where your thesis is proven wrong. To keep your risk within limits, you buy FEWER shares (Position Sizing). The chart dictates the stop loss; the math dictates the quantity.',
            },
            {
              'text': 'No stop loss — support is strong, it will bounce',
              'isCorrect': false,
              'feedback':
                  '❌ Support levels break all the time. Trading without a stop loss is how traders blow up their accounts. Never assume a level will hold.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Technical stops > Percentage stops',
            'Place stops where your trading thesis is proven definitively wrong',
            'Mental stops are a trap — always use hard system orders',
            'The chart dictates the stop loss location; position sizing dictates the quantity',
            'Next: When to stop trading for the entire day or week.',
          ],
        },
      ],
    };
  }

  // Lesson 5.2: The Daily & Weekly Loss Limits
  static Map<String, dynamic> getLossLimitsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Circuit Breaker',
          'emoji': '🔌',
          'content':
              'A stop loss protects a single trade. But what protects your account from YOU on a bad day? When emotions spiral, you need a circuit breaker. Enter: The Daily Loss Limit.',
        },
        {
          'type': 'story',
          'title': 'Ananya\'s Worst Tuesday',
          'emoji': '😤',
          'content': '''
**Ananya**, 26, a UX designer in Pune, had been trading for 3 months with modest success.

Then came a Tuesday.

**9:30 AM:** Trade 1 — Bank Nifty long. Stop hit. -₹2,000. "Normal loss."

**10:15 AM:** Trade 2 — Nifty short. Stop hit. -₹2,000. "Bad luck."

**10:45 AM:** Trade 3 — "I NEED to recover." She doubled her size. Nifty moved against her. She removed her stop loss. "It HAS to come back." It didn't. -₹8,000.

**11:30 AM:** Trade 4 — Full tilt mode. She went ALL-IN on a random stock from a WhatsApp tip. -₹12,000.

**12:00 PM:** Total damage: **-₹24,000.** That was 24% of her ₹1 Lakh account. **A month of profits destroyed in 2.5 hours.**

**What would have saved Ananya?**
A daily loss limit of 3% (₹3,000). After Trade 2 (-₹4,000), she would have been FORCED to stop. Total loss: ₹4,000 instead of ₹24,000.

**The ₹20,000 lesson:** Rules protect you from YOURSELF.
''',
        },
        {
          'type': 'concept',
          'title': 'The Power of Stopping',
          'emoji': '🛑',
          'content': '''
**The Revenge Trading Cycle:**
You lose 2 trades. You feel angry. You want the money back.
You take a bad setup. You double the position size. You lose again.
Your brain enters "tilt" mode (like a poker player). Logic vanishes.
In 2 hours, you blow up a month's worth of profits.

**The Solution: The Daily Max Loss Limit 📉**
A hard rule: "If my total losses for the day hit [X] amount, I shut the laptop."
No exceptions. No "one more trade."

**Professional Limits:**
• **Max Risk per Trade:** 1% of Capital
• **Max Daily Loss:** 2% to 3% of Capital (usually 2-3 losing trades)
• **Max Weekly Loss:** 5% to 6% of Capital

---

**Why This Works:**
1. **Prevents the Death Spiral:** It caps the damage on your worst days.
2. **Protects Psychology:** You come back tomorrow fresh, not desperate.
3. **Market Alignment:** If you lose 3 trades in a row, either your strategy is out of sync with today's market, or you are. Either way, STOPPING is the right move.

**Implementation Trick:**
Most modern brokers (like Zerodha) have a "Kill Switch" feature. Use it. It locks your account for the day once you hit your limit. You literally cannot trade even if you want to.
''',
          'keyPoints': [
            'Daily loss limits protect your account from emotional spirals ("tilt")',
            'Standard professional limit: 2% to 3% max daily loss',
            'If you hit the limit, shut the screen. No exceptions.',
            'Use broker "Kill Switch" features to enforce discipline mechanically',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You hit your daily loss limit of 3%. Ten minutes later, you see the "perfect" setup that you are 100% sure will win and recover your losses. What do you do?',
          'options': [
            'Take the trade — a perfect setup shouldn\'t be ignored',
            'Take the trade but with half position size',
            'Close the app. A rule is a rule. There will be other perfect setups tomorrow.',
            'Paper trade it to see if you were right',
          ],
          'correctIndex': 2,
          'explanation':
              'Close the app. When you are down 3%, your brain is compromised by the desire to recover losses. Every setup looks "perfect" when you are desperate. If you break your rule once, the rule is dead. Discipline means honoring the limit even when it hurts.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 5 Complete! 🎉',
          'keyPoints': [
            'Stop losses are non-negotiable insurance for every trade',
            'Use technical stops based on chart levels, not arbitrary percentages',
            'A Daily Loss Limit acts as a psychological circuit breaker',
            'Never risk more than 2-3% of total capital in a single day',
            'If you hit the limit, walk away. Tomorrow is another day.',
            'Next: The brutal mathematics of recovering from large drawdowns.',
          ],
        },
      ],
    };
  }
}
