/// Chapter 2: What Are Derivatives
/// Contracts derived from underlying assets
class WhatAreDerivativesContent {
  // Lesson 2.1: The Concept of a Derivative
  static Map<String, dynamic> getConceptContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'A Contract About Something Else',
          'emoji': '📜',
          'content':
              'A derivative is not an asset — it is a CONTRACT about an asset. Its value is "derived" from something else (a stock, an index, gold, a currency). Think of it as a bet on where the price of something will go.',
        },
        {
          'type': 'concept',
          'title': 'The Vegetable Market Analogy',
          'emoji': '🥕',
          'content': '''
**Imagine you are a restaurant owner.**
You need 100 kg of tomatoes every week. The current price is ₹40/kg.

**The Problem:**
What if tomato prices shoot to ₹100/kg next month (monsoon, supply disruption)?
Your costs would triple. Your business would suffer.

**The Solution: A Derivative Contract.**
You go to a farmer and say: "I will pay you ₹45/kg for 100 kg of tomatoes, delivered next month. Let's sign a contract today."

The farmer agrees. You both sign.

**What Just Happened?**
• You created a **derivative contract** (a Futures contract).
• The underlying asset = Tomatoes.
• The agreed price = ₹45/kg.
• The expiry = Next month.

**If tomato price rises to ₹100/kg:**
You still pay ₹45. You saved ₹55/kg. You win!

**If tomato price drops to ₹20/kg:**
You still pay ₹45. You overpaid by ₹25/kg. You lose.

---

**Key Insight:**
Every derivative contract has a buyer and a seller. For every winner, there is a loser. Derivatives are a zero-sum game — unlike stocks where EVERYONE can profit if the market rises.
''',
          'keyPoints': [
            'A derivative is a CONTRACT whose value comes from an underlying asset',
            'It was originally invented to manage risk (hedging) for businesses',
            'Every derivative has a buyer AND seller — one wins, one loses',
            'Derivatives are zero-sum: your profit is someone else\'s loss',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Stocks vs Derivatives',
          'emoji': '⚖️',
          'content': '''
**Buying a Stock (Cash Market):**
• You OWN a piece of the company
• No expiry date — hold forever
• Maximum loss = your investment (can't go below ₹0)
• Dividends, voting rights
• Simple: Buy low, sell high

**Buying a Derivative:**
• You own a CONTRACT, not the asset
• Has an EXPIRY date (weekly, monthly)
• Possible loss can EXCEED your investment (in some cases)
• No ownership benefits
• Complex: Multiple variables affect the price

---

**Why Do People Trade Derivatives?**
1. **Hedging:** Companies protect against price changes (the tomato example).
2. **Speculation:** Traders bet on price direction with leverage.
3. **Arbitrage:** Experts exploit tiny price differences for risk-free profit.

Most retail traders are in category 2 (speculation) — and that's where the 93% losses happen.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'In a derivatives market, you make ₹50,000 profit on a Futures trade. What happened on the other side?',
          'options': [
            'The broker paid you from their own pocket',
            'The market created new money for you',
            'Someone else lost ₹50,000 on the same contract',
            'The government subsidized your trade',
          ],
          'correctIndex': 2,
          'explanation':
              'Derivatives are zero-sum. For every buyer there is a seller. Your ₹50,000 profit came directly from someone else\'s ₹50,000 loss. This is fundamentally different from stocks, where both buyer and seller can profit if the company grows.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'A derivative is a contract whose value is derived from an underlying asset',
            'Originally invented for hedging (risk management) by businesses',
            'Derivatives are zero-sum: your profit = someone else\'s loss',
            'Most retail traders speculate with derivatives — and 93% lose',
            'Next: The four types of derivatives you need to know.',
          ],
        },
      ],
    };
  }

  // Lesson 2.2: Types of Derivatives
  static Map<String, dynamic> getTypesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Four Flavors',
          'emoji': '🍦',
          'content':
              'There are four main types of derivatives. As a beginner, you only need to understand two: Futures and Options. The other two (Forwards and Swaps) are used by institutions and banks.',
        },
        {
          'type': 'concept',
          'title': 'The Derivative Family',
          'emoji': '🗂️',
          'content': '''
**1. Futures ⏳**
A standardized contract to buy/sell an asset at a set price on a future date.
• Traded on exchanges (NSE)
• Standardized lot sizes and expiry dates
• Both buyer AND seller are OBLIGATED to honor the contract
• Example: Nifty Futures, Reliance Futures

**2. Options 🎟️**
A contract that gives the BUYER the RIGHT (but not obligation) to buy/sell at a set price.
• Buyer pays a "premium" for this right
• Seller (writer) is OBLIGATED if buyer exercises
• Two types: Call (right to buy) and Put (right to sell)
• Example: Nifty 22000 Call Option, Bank Nifty 48000 Put Option

---

**3. Forwards (Institutional) 🏦**
Similar to Futures but traded privately (OTC — Over the Counter).
Not relevant for retail traders.

**4. Swaps (Institutional) 🔄**
Exchange of cash flows between two parties. Used by banks and corporations.
Not relevant for retail traders.

---

**Key Insight:**
For Indian retail traders, 99% of derivative trading happens in Futures and Options on the NSE. Focus your learning energy there.
''',
          'keyPoints': [
            'Four types: Futures, Options, Forwards, Swaps',
            'Retail traders primarily use Futures and Options',
            'Futures = obligation for both parties; Options = right for buyer, obligation for seller',
            'Forwards and Swaps are institutional tools — not relevant for beginners',
          ],
        },
        {
          'type': 'scenario',
          'title': 'Choosing the Right Instrument',
          'situation':
              'You believe Nifty will rise 200 points this week. You have ₹50,000. You want to profit from this view but limit your maximum possible loss to a known amount. Which derivative is most appropriate?',
          'choices': [
            {
              'text': 'Buy Nifty Futures — maximum leverage for maximum profit',
              'isCorrect': false,
              'feedback':
                  '❌ Futures give you leverage but your loss is UNLIMITED. If Nifty drops 500 points instead, you could lose far more than ₹50,000 (you\'d owe extra margin). You wanted to LIMIT your maximum loss.',
            },
            {
              'text':
                  'Buy a Nifty Call Option — your max loss is limited to the premium paid',
              'isCorrect': true,
              'feedback':
                  '✅ A Call Option gives you the right to profit if Nifty rises, but your maximum loss is capped at the premium you paid. If you pay ₹5,000 in premium, the absolute worst case is losing ₹5,000 — not your entire ₹50,000.',
            },
            {
              'text': 'Sell a Nifty Put Option to collect premium income',
              'isCorrect': false,
              'feedback':
                  '❌ Selling a Put means you profit if the market stays flat or rises, BUT your loss is potentially UNLIMITED if the market crashes. This does NOT limit your maximum loss.',
            },
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'What is the key difference between a Futures contract and an Options contract?',
          'options': [
            'Futures are traded on exchanges; Options are traded privately',
            'In Futures, BOTH parties are obligated. In Options, only the SELLER is obligated — the buyer has a CHOICE.',
            'Futures are for stocks; Options are for indices',
            'There is no difference — they are the same thing',
          ],
          'correctIndex': 1,
          'explanation':
              'This is the most important distinction. In Futures, if you buy a contract, you MUST honor it at expiry. In Options, the buyer pays a premium for the RIGHT (not obligation) to exercise. If the trade goes against the buyer, they simply let the option expire worthless and lose only the premium.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 2 Complete! 🎉',
          'keyPoints': [
            'Derivatives are contracts derived from underlying assets like stocks or indices',
            'They are zero-sum: your profit is someone else\'s loss',
            'Four types exist: Futures, Options, Forwards, Swaps',
            'Retail traders focus on Futures (obligation) and Options (right)',
            'Options allow limiting your maximum loss to the premium paid',
            'Next: How Futures contracts actually work in practice.',
          ],
        },
      ],
    };
  }
}
