/// Chapter 5: Calls & Puts
/// The two fundamental options strategies
class CallsPutsContent {
  // Lesson 5.1: Call Options — Betting on Rise
  static Map<String, dynamic> getCallOptionsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Bullish Bet',
          'emoji': '📈',
          'content':
              'A Call Option gives you the right to BUY an asset at a fixed price. You buy Calls when you believe the price will go UP. Think of it as paying a small deposit to lock in today\'s price for a future purchase.',
        },
        {
          'type': 'concept',
          'title': 'How Call Options Work',
          'emoji': '🟢',
          'content': '''
**Call Option = Right to BUY at the Strike Price**

**Real-World Example:**
• Nifty is at 22,000
• You buy a 22,000 Call Option (ATM)
• Premium: ₹150 per unit. Lot size = 25.
• Cost: ₹150 × 25 = **₹3,750**

**If Nifty rises to 22,400 by expiry:**
• Your Call is worth: 22,400 - 22,000 = ₹400 per unit
• Profit = (₹400 - ₹150 premium) × 25 = **₹6,250 profit** ✅
• Return on investment: 167%!

**If Nifty stays at 22,000 or falls:**
• Your Call expires worthless
• Loss = ₹3,750 (the premium you paid) ❌
• That is your MAXIMUM loss. Period.

---

**When to Buy a Call:**
• You expect the market/stock to go UP
• You want limited risk (only lose the premium)
• You want leverage without the dangers of Futures

**Key Insight:**
Buying a Call is like paying ₹3,750 for a lottery ticket that pays ₹6,250+ if your view is right, and costs you exactly ₹3,750 if you are wrong. The risk is defined. The reward is not.
''',
          'keyPoints': [
            'Call Option = right to BUY at the Strike Price',
            'Buy Calls when you are bullish (expect price to rise)',
            'Maximum loss = premium paid; profit potential is large',
            'Calls offer leverage with defined risk (unlike Futures)',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Call Option Profit Calculator',
          'emoji': '🧮',
          'content': '''
**Setup:** Buy Nifty 22,000 Call at ₹200 premium. Lot = 25.

**Cost = ₹200 × 25 = ₹5,000**
**Breakeven = 22,000 + 200 = 22,200**

| Nifty at Expiry | Call Value | P&L per unit | Total P&L |
|-----------------|-----------|-------------|-----------|
| 21,500          | ₹0        | -₹200       | **-₹5,000** ❌ |
| 22,000          | ₹0        | -₹200       | **-₹5,000** ❌ |
| 22,200          | ₹200      | ₹0          | **₹0** (Breakeven) |
| 22,500          | ₹500      | +₹300       | **+₹7,500** ✅ |
| 23,000          | ₹1,000    | +₹800       | **+₹20,000** ✅ |

**Notice:** Below 22,000, your loss stays flat at ₹5,000.
Above 22,200, your profit is UNLIMITED.
This is the asymmetric beauty of buying options.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You buy a Reliance 2500 Call Option for ₹60 premium (lot = 250). At expiry, Reliance is at ₹2,600. What is your net profit?',
          'options': ['₹25,000', '₹15,000', '₹10,000', '₹0 — you lost money'],
          'correctIndex': 2,
          'explanation':
              'Call value at expiry = 2,600 - 2,500 = ₹100. You paid ₹60 premium. Net profit per unit = ₹100 - ₹60 = ₹40. Total profit = ₹40 × 250 (lot) = ₹10,000. Your initial investment was ₹60 × 250 = ₹15,000. Return: 67% — not bad!',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Call = right to buy. Buy Calls when bullish.',
            'Maximum loss is limited to the premium paid',
            'Breakeven = Strike Price + Premium',
            'Below breakeven: you lose (capped at premium). Above: unlimited profit.',
            'Next: Put Options — how to profit when the market falls.',
          ],
        },
      ],
    };
  }

  // Lesson 5.2: Put Options — Betting on Fall
  static Map<String, dynamic> getPutOptionsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Bearish Bet',
          'emoji': '📉',
          'content':
              'A Put Option gives you the right to SELL an asset at a fixed price. You buy Puts when you believe the price will go DOWN. It is your insurance against a market crash.',
        },
        {
          'type': 'concept',
          'title': 'How Put Options Work',
          'emoji': '🔴',
          'content': '''
**Put Option = Right to SELL at the Strike Price**

**The Insurance Analogy:**
You own a car worth ₹10 Lakh. You buy insurance for ₹15,000/year.
If your car gets damaged (loses value), the insurance pays you.
If nothing happens, you lose the ₹15,000 premium. But you had peace of mind.

**A Put Option IS insurance for your portfolio.**

**Example:**
• Nifty is at 22,000
• You buy a 22,000 Put Option (ATM)
• Premium: ₹180 per unit. Lot size = 25.
• Cost: ₹180 × 25 = **₹4,500**

**If Nifty FALLS to 21,500:**
• Put value = 22,000 - 21,500 = ₹500
• Profit = (₹500 - ₹180) × 25 = **₹8,000 profit** ✅

**If Nifty RISES or stays flat:**
• Put expires worthless
• Loss = ₹4,500 (the premium) ❌

---

**Key Insight:**
Puts allow you to PROFIT from falling markets. In the cash market, you can only make money when prices rise. With Puts, you can also profit from crashes, corrections, and bear markets.
''',
          'keyPoints': [
            'Put Option = right to SELL at the Strike Price',
            'Buy Puts when bearish (expect price to fall)',
            'Puts are like insurance — they protect against downside risk',
            'Puts let you profit from falling markets (impossible in cash market)',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Calls vs Puts — Side by Side',
          'emoji': '⚖️',
          'content': '''
| Feature | Call Option | Put Option |
|---------|-----------|------------|
| **Right to** | BUY | SELL |
| **You are** | Bullish (expect rise) | Bearish (expect fall) |
| **Profit when** | Price goes UP | Price goes DOWN |
| **Max loss** | Premium paid | Premium paid |
| **Breakeven** | Strike + Premium | Strike - Premium |
| **Analogy** | Advance booking | Insurance policy |

**Both Call and Put BUYERS have limited risk (premium).**
**Both Call and Put SELLERS have potentially unlimited risk.**

---

**The Golden Rule for Beginners:**
BUY Options (limited risk). Never SELL naked Options (unlimited risk).
Option selling is for advanced traders with deep pockets and deep knowledge.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Market Crash',
          'situation':
              'Global markets are crashing. Nifty is down 500 points pre-market. You have a portfolio of stocks worth ₹3 Lakh that you don\'t want to sell (long-term holdings). How can you protect yourself using options?',
          'choices': [
            {
              'text':
                  'Sell all your stocks immediately before they fall further',
              'isCorrect': false,
              'feedback':
                  '❌ Panic selling long-term holdings during a crash usually locks in losses at the worst prices. Historically, markets recover from crashes.',
            },
            {
              'text':
                  'Buy Nifty Put Options — if the market keeps falling, the Puts gain value and offset your portfolio losses',
              'isCorrect': true,
              'feedback':
                  '✅ This is called HEDGING. The Put Options act as insurance. If the market falls further, your Puts profit, offsetting the losses in your stock portfolio. Your maximum cost is just the premium.',
            },
            {
              'text': 'Buy more stocks to "average down"',
              'isCorrect': false,
              'feedback':
                  '❌ Averaging down during a crash without a clear plan can lead to huge losses. The crash could continue for weeks or months.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 5 Complete! 🎉',
          'keyPoints': [
            'Call = right to buy (bullish); Put = right to sell (bearish)',
            'Both have limited risk for BUYERS (maximum loss = premium)',
            'Puts act as portfolio insurance during market crashes',
            'Never SELL naked options as a beginner — unlimited risk',
            'Options give you tools for both rising and falling markets',
            'Next: The dark side — Margin and Leverage risks in depth.',
          ],
        },
      ],
    };
  }
}
