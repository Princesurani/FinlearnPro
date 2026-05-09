/// Chapter 3: Futures Basics
/// Agreements to buy or sell at a future date
class FuturesBasicsContent {
  // Lesson 3.1: How Futures Work
  static Map<String, dynamic> getHowFuturesWorkContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Agreement That Locks a Price',
          'emoji': '🤝',
          'content':
              'A Futures contract is a legally binding agreement between two parties to buy or sell an asset at a specific price on a specific future date. Neither party can back out.',
        },
        {
          'type': 'story',
          'title': 'The Farmer and the Baker',
          'emoji': '🌾',
          'content': '''
**Raju** is a wheat farmer in Punjab. He harvests wheat in April.
**Suresh** owns a bakery chain in Delhi. He needs wheat every month.

**The Problem:**
• Raju fears wheat prices will FALL by April (bad for the farmer).
• Suresh fears wheat prices will RISE by April (bad for the baker).

**The Solution:**
In January, they agree: "On April 1st, Raju will sell 1,000 kg of wheat to Suresh at ₹30/kg."
They sign a contract. This IS a Futures contract.

**Scenario A: Wheat price rises to ₹45/kg in April**
• Raju must sell at ₹30 (missed ₹15/kg extra profit). Raju loses.
• Suresh buys at ₹30 instead of ₹45. Suresh saves ₹15,000. Suresh wins.

**Scenario B: Wheat price drops to ₹20/kg in April**
• Raju sells at ₹30 instead of ₹20. Raju earns ₹10,000 extra. Raju wins.
• Suresh must pay ₹30 when market is ₹20. Suresh overpays ₹10,000. Suresh loses.

**Key Insight:**
Both Raju and Suresh reduced their uncertainty. The farmer locked in a sale price. The baker locked in a purchase price. This is **hedging** — the original purpose of Futures.
''',
        },
        {
          'type': 'concept',
          'title': 'Futures in the Stock Market',
          'emoji': '📈',
          'content': '''
**In the stock market, the principle is identical:**
Instead of wheat, you trade contracts on Nifty, Bank Nifty, or individual stocks.

**Key Features of Stock/Index Futures:**
• **Lot Size:** A fixed number of units per contract (Nifty = 25 units)
• **Margin:** You pay only 15-20% of the contract value upfront
• **Daily Settlement:** Profits and losses are settled DAILY (Mark-to-Market)
• **Expiry:** Last Thursday of every month (weekly options also available)

**Example: Buying Nifty Futures**
• Nifty at 22,000. Lot size = 25.
• Contract value = 22,000 × 25 = ₹5,50,000
• Margin required = ~₹1,10,000

If Nifty moves UP 100 points:
• Profit = 100 × 25 = ₹2,500

If Nifty moves DOWN 100 points:
• Loss = 100 × 25 = ₹2,500

---

**Key Insight:**
In Futures, both profit and loss are UNLIMITED. There is no cap on how much you can gain or lose. This is what makes them dangerous for beginners.
''',
          'keyPoints': [
            'Futures in stock markets use the same principle as commodity Futures',
            'Lot size, margin, daily settlement, and expiry are the key features',
            'You control a large contract value with a small margin deposit',
            'Both profit and loss are UNLIMITED in Futures trading',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You buy 1 lot of Nifty Futures at 22,000 (lot size = 25). At expiry, Nifty is at 21,800. What is your profit or loss?',
          'options': [
            'Profit of ₹5,000',
            'Loss of ₹200',
            'Loss of ₹5,000',
            'Loss of ₹2,00,000',
          ],
          'correctIndex': 2,
          'explanation':
              'Nifty moved down 200 points (22,000 - 21,800 = 200). Your loss = 200 × lot size (25) = ₹5,000. This ₹5,000 is deducted from your margin. If you only had ₹10,000 margin, you just lost 50% of your capital on one trade!',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Futures are binding agreements to buy/sell at a set price on a future date',
            'Originally invented for hedging by farmers and businesses',
            'In stock markets, Futures use lot sizes, margin, and daily settlement',
            'Both profit and loss are unlimited in Futures',
            'Next: How Nifty Futures work in practice on NSE.',
          ],
        },
      ],
    };
  }

  // Lesson 3.2: Nifty Futures in Practice
  static Map<String, dynamic> getNiftyFuturesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Trading the Index',
          'emoji': '📊',
          'content':
              'Nifty Futures is the most traded derivative in India. It lets you bet on the direction of the entire Nifty 50 index without buying all 50 stocks individually.',
        },
        {
          'type': 'concept',
          'title': 'The Mechanics of Nifty Futures',
          'emoji': '⚙️',
          'content': '''
**Contract Specifications:**
• **Underlying:** Nifty 50 Index
• **Lot Size:** 25 (as of 2024)
• **Expiry:** Last Thursday of the month (3 monthly contracts available)
• **Margin:** ~20% of contract value (set by NSE/SEBI)
• **Trading Hours:** 9:15 AM - 3:30 PM (NSE)

**Mark-to-Market (Daily Settlement):**
Every evening, the exchange calculates your profit or loss based on the closing price.
• If you are in profit: Cash is ADDED to your account.
• If you are in loss: Cash is DEDUCTED from your account.
• If your margin falls below the maintenance margin: you get a **Margin Call**.

**Expiry:**
On the last Thursday, all open Futures contracts are settled at the final settlement price. You don't receive any "shares" — it's a cash settlement.

---

**Key Insight:**
Unlike stocks where you can "hold and forget," Futures require daily monitoring because of Mark-to-Market. A position left unmonitored can drain your margin overnight.
''',
          'keyPoints': [
            'Nifty Futures: Lot size 25, monthly expiry, ~20% margin',
            'Mark-to-Market settles profits and losses DAILY — not at expiry',
            'If margin falls below threshold, you get a Margin Call',
            'Futures require active daily monitoring unlike buy-and-hold stocks',
          ],
        },
        {
          'type': 'interactive',
          'title': 'A Week of Nifty Futures Trading',
          'emoji': '📅',
          'content': '''
**You buy 1 lot of Nifty Futures at 22,000 on Monday.**
Margin deposited: ₹1,10,000

**Monday Close:** Nifty at 22,100 (+100 pts)
• Daily P&L: +100 × 25 = +₹2,500 → Added to your account ✅

**Tuesday Close:** Nifty at 21,900 (-200 pts from Monday)
• Daily P&L: -200 × 25 = -₹5,000 → Deducted from your account ❌

**Wednesday Close:** Nifty at 21,700 (-200 pts from Tuesday)
• Daily P&L: -200 × 25 = -₹5,000 → Deducted from your account ❌
• ⚠️ Total loss from entry: -₹7,500. Margin getting low.

**Thursday Close:** Nifty at 21,500 (-200 pts from Wednesday)
• Daily P&L: -200 × 25 = -₹5,000 → Deducted ❌
• 🚨 MARGIN CALL: Your margin has fallen below the minimum. Broker demands you add ₹15,000 more OR they will AUTO-CLOSE your position.

**Total unrealized loss in 4 days: (22,000 - 21,500) × 25 = ₹12,500**
That is 11.4% of your ₹1,10,000 margin. And Nifty only moved 2.3%.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Margin Call',
          'situation':
              'You get a Margin Call from Zerodha on Thursday morning. Nifty is down 500 points from your entry. They ask you to deposit ₹15,000 more by 2:00 PM or your position will be auto-squared. What do you do?',
          'choices': [
            {
              'text':
                  'Deposit the ₹15,000 immediately to keep the position alive',
              'isCorrect': false,
              'feedback':
                  '❌ Adding more money to a losing position is called "throwing good money after bad." If Nifty drops another 200 points, you\'ll get another margin call. Ask yourself: has anything changed about WHY Nifty is falling?',
            },
            {
              'text':
                  'Let the broker auto-close the position. Accept the ₹12,500 loss. Review what went wrong.',
              'isCorrect': true,
              'feedback':
                  '✅ Hard but correct. The margin call is the market telling you that you were wrong. Accepting the loss and reviewing the trade is the professional approach. Living to trade another day is the priority.',
            },
            {
              'text': 'Add ₹50,000 more and double down by buying another lot',
              'isCorrect': false,
              'feedback':
                  '❌ This is revenge trading with leverage — the fastest path to total account destruction. You are adding more risk to a position that is already proving you wrong.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 3 Complete! 🎉',
          'keyPoints': [
            'Nifty Futures let you trade the entire Nifty 50 index with leverage',
            'Mark-to-Market settles your P&L daily — losses are deducted every evening',
            'Margin Calls force you to add money or have positions auto-closed',
            'A 2.3% Nifty move caused an 11.4% loss on margin — that\'s leverage at work',
            'Never add money to a losing leveraged position without a strong thesis',
            'Next: Options — the RIGHT but not the obligation.',
          ],
        },
      ],
    };
  }
}
