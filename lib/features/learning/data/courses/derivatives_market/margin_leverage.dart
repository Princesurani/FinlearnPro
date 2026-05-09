/// Chapter 6: Margin & Leverage Risks
/// The double-edged sword
class MarginLeverageContent {
  // Lesson 6.1: Understanding Margin
  static Map<String, dynamic> getUnderstandingMarginContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Borrowing to Trade',
          'emoji': '🏦',
          'content':
              'Margin is essentially borrowed money from your broker. It lets you control a larger position than your actual capital allows. It sounds great until the trade goes wrong — then the borrowed money accelerates your losses.',
        },
        {
          'type': 'concept',
          'title': 'Types of Margin',
          'emoji': '📋',
          'content': '''
**1. Initial Margin 🔑**
The upfront deposit required to OPEN a derivative position.
• Set by the exchange (NSE) based on the volatility of the underlying asset.
• Nifty Futures: ~15-20% of contract value.
• Volatile stocks: Up to 40-50% margin.

**2. Maintenance Margin 🛡️**
The minimum balance you must maintain WHILE the position is open.
• Usually 75-80% of the initial margin.
• If your account falls below this: MARGIN CALL.

**3. SPAN + Exposure Margin (India-Specific) 🇮🇳**
In India, total margin = SPAN margin + Exposure margin.
• SPAN margin: Calculated by the exchange using risk algorithms.
• Exposure margin: Additional buffer (usually 3-5% of contract value).

---

**The Intraday Margin Trap:**
Some brokers offer 5x to 10x intraday leverage on top of the exchange margin.
This means with ₹1 Lakh, you can control ₹10-20 Lakh worth of positions.
SEBI has cracked down on this, but some brokers still offer it via workarounds.

**Key Insight:**
More leverage ≠ more skill. It is the financial equivalent of driving 200 km/h without a seatbelt. You MIGHT get somewhere faster, or you WILL crash harder.
''',
          'keyPoints': [
            'Initial margin = deposit to open. Maintenance margin = minimum to keep open.',
            'SPAN + Exposure margin is India\'s framework for calculating requirements',
            'Intraday leverage of 5-10x is extremely dangerous for beginners',
            'More leverage = faster profit OR faster destruction (usually the latter)',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The Leverage Multiplier Effect',
          'emoji': '📊',
          'content': '''
**Same ₹1,00,000 capital. Same 3% market move. Different leverage.**

| Leverage | Position Size | 3% Gain | 3% Loss |
|----------|-------------|---------|---------|
| 1x (No leverage) | ₹1,00,000 | +₹3,000 | -₹3,000 |
| 5x | ₹5,00,000 | +₹15,000 | -₹15,000 |
| 10x | ₹10,00,000 | +₹30,000 | -₹30,000 |
| 20x | ₹20,00,000 | +₹60,000 | -₹60,000 |

**At 20x leverage, a 5% drop = 100% of your capital wiped out.**
That is ONE bad day. ONE gap-down opening. ONE unexpected news event.

**Professional Hedge Funds:**
Even the best hedge funds in the world rarely exceed 3-5x leverage.
Retail traders on Zerodha routinely use 10-20x. Who do you think survives?
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You have ₹2,00,000 in your account. Your broker offers 10x intraday leverage. You use the full leverage to buy ₹20,00,000 worth of Nifty Futures. Nifty drops 2% during the day. How much do you lose?',
          'options': [
            '₹4,000 (2% of your capital)',
            '₹40,000 (2% of ₹20L position)',
            '₹2,00,000 (your entire account is wiped out)',
            '₹20,000',
          ],
          'correctIndex': 1,
          'explanation':
              'Loss = 2% of your ₹20,00,000 position = ₹40,000. That is 20% of your ₹2,00,000 capital — gone in one day! A 5% drop would cost ₹1,00,000 (50% of your account). A 10% crash would wipe you out completely.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Margin lets you control large positions with small capital',
            'Initial margin opens the position; maintenance margin keeps it open',
            'At 10x leverage, a 2% drop costs you 20% of your capital',
            'Professional funds rarely exceed 5x leverage; retail traders use 10-20x',
            'Next: The Margin Call nightmare — when the broker forces you out.',
          ],
        },
      ],
    };
  }

  // Lesson 6.2: The Margin Call Nightmare
  static Map<String, dynamic> getMarginCallContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Forced Exit',
          'emoji': '🚨',
          'content':
              'A Margin Call is your broker saying: "You\'re losing too much. Add more money RIGHT NOW, or we will close your position at whatever price the market gives us." It is the scariest moment in a trader\'s life.',
        },
        {
          'type': 'story',
          'title': 'Ananya\'s Margin Call Morning',
          'emoji': '😱',
          'content': '''
**Ananya**, 29, a chartered accountant in Mumbai. She was trading Bank Nifty Futures.

**Tuesday Night:**
She held 2 lots of Bank Nifty Futures overnight at 48,000.
Margin used: ₹2,40,000 (her entire trading capital).
She thought, "RBI policy is tomorrow, market will rally."

**Wednesday 9:15 AM:**
RBI unexpectedly raises interest rates by 25 basis points.
Bank Nifty opens at 47,200 — a 800-point GAP DOWN.

**The Math:**
• Loss per lot: 800 × 15 (lot size) = ₹12,000
• Total loss: ₹12,000 × 2 lots = **₹24,000 instantly**
• By 10:00 AM, Bank Nifty falls to 46,800. Loss: ₹36,000.

**10:15 AM: The Margin Call.**
Zerodha's auto-system sends her an alert:
"Your margin has fallen below the minimum requirement. Please add ₹50,000 by 1:00 PM or your positions will be auto-squared."

**10:30 AM:** Ananya panics. Transfers ₹30,000 from her savings.
**11:00 AM:** Bank Nifty drops further to 46,400. Another margin call.
**12:00 PM:** Zerodha auto-squares both lots at 46,200.

**Final Damage:** ₹54,000 loss (22.5% of her capital) in 3 hours.

**The Lesson:**
Never hold leveraged positions through major events. The gap risk is enormous.
''',
        },
        {
          'type': 'concept',
          'title': 'How to Avoid Margin Calls',
          'emoji': '🛡️',
          'content': '''
**Rule 1: Never Use Full Margin 📏**
Use maximum 40-50% of your available margin. Keep the rest as a buffer.

**Rule 2: Never Hold Through Events 📅**
RBI policy, Union Budget, US Fed meetings, Election results — close positions BEFORE these events. The gap risk is unmanageable.

**Rule 3: Use Stop Losses Religiously 🛑**
A stop loss exits your position BEFORE you reach margin call territory.

**Rule 4: Know Your Broker's Rules 📋**
• At what level do they send warnings?
• At what level do they auto-square?
• What are the peak margin rules for overnight positions?

---

**Key Insight:**
A margin call is the market's way of telling you that you are wrong, overleveraged, or both. The best defense is to NEVER reach a margin call in the first place.
''',
          'keyPoints': [
            'Never use more than 40-50% of available margin',
            'Close all leveraged positions before major economic events',
            'Stop losses prevent positions from reaching margin call territory',
            'Know your broker\'s specific margin call and auto-square levels',
          ],
        },
        {
          'type': 'scenario',
          'title': 'The Budget Day Decision',
          'situation':
              'It is the night before the Union Budget. You hold 3 lots of Nifty Futures in profit. Tomorrow\'s budget could send Nifty 300 points up OR 500 points down. What do you do?',
          'choices': [
            {
              'text': 'Hold — the budget will be positive. I feel confident.',
              'isCorrect': false,
              'feedback':
                  '❌ "Feeling confident" is not a risk management strategy. A 500-point gap down on 3 lots = ₹37,500 loss INSTANTLY at market open. You cannot place a stop loss against a gap.',
            },
            {
              'text':
                  'Close all positions before market close today. Re-enter AFTER the budget reaction is clear.',
              'isCorrect': true,
              'feedback':
                  '✅ Professional approach. You protect your profits. You remove the gap risk. You can always re-enter after the budget when the direction is confirmed. The market will be there tomorrow.',
            },
            {
              'text': 'Add 2 more lots to maximize the potential rally',
              'isCorrect': false,
              'feedback':
                  '❌ This is pure gambling. You are increasing risk before the single most unpredictable event of the year. If the budget disappoints, 5 lots × 500 points × 25 = ₹62,500 loss at the opening bell.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 6 Complete! 🎉',
          'keyPoints': [
            'Margin is borrowed money that amplifies both gains and losses',
            'At 10x leverage, a 2% drop costs 20% of your capital',
            'Margin Calls are forced exits at the worst possible time and price',
            'Never use full margin; keep 50%+ as a safety buffer',
            'Close leveraged positions before major events (RBI, Budget, Elections)',
            'Next: The most important question — should YOU be trading derivatives at all?',
          ],
        },
      ],
    };
  }
}
