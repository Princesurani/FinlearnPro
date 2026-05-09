/// Chapter 4: How Commodity Trading Works
/// Contracts, margins, and the mechanics of a trade
class HowCommodityTradingWorksContent {
  // Lesson 4.1: Futures Contracts Explained
  static Map<String, dynamic> getFuturesContractsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'You\'re Not Buying Gold — You\'re Buying a Promise',
          'emoji': '📜',
          'content':
              'When you trade gold on MCX, you\'re NOT buying physical gold. You\'re buying a futures CONTRACT — an agreement to buy or sell a specific quantity of gold at a specific price on a specific future date. Let\'s decode this.',
        },
        {
          'type': 'concept',
          'title': 'Futures Contracts 101',
          'emoji': '📋',
          'content': '''
**A Futures Contract = A standardized agreement:**
• **What:** A specific commodity (Gold, Crude Oil, etc.)
• **How much:** Standardized lot (Gold = 1 kg, Crude = 100 barrels)
• **When:** A specific expiry date (monthly/bi-monthly)
• **At what price:** The price you agree on today

**Example: Gold Futures on MCX**
You BUY 1 lot of Gold August contract at ₹62,000/10g.
This means: You've agreed to buy 1 kg of gold at ₹62,000/10g in August.

**But You Don't Actually Want 1 kg of Gold!**
Most traders (99%+) close their position BEFORE expiry.
• If gold rises to ₹64,000 before August, you SELL the contract → ₹2,000/10g profit.
• If gold falls to ₹60,000, you SELL → ₹2,000/10g loss.

**The Margin System (Why It's Affordable):**
• Contract value: ₹62,000 × 100 (10g × 100 = 1 kg) = ₹62,00,000 (₹62 Lakhs!)
• Margin required: ~₹4,00,000 (about 6-7% of contract value)
• **You control ₹62 Lakhs of gold with just ₹4 Lakhs. That's ~15x leverage.**

---

**Key Insight:**
Futures trading is inherently leveraged. You only put up a fraction of the contract value. This means small price moves create large percentage gains OR losses. A ₹500/10g move in gold = ₹50,000 profit/loss on 1 regular lot.
''',
          'keyPoints': [
            'Futures = standardized contracts to buy/sell at a future date',
            'Most traders close positions before expiry — no physical delivery',
            'Margin (6-7%) means inherent leverage of 15x on MCX',
            'Small price moves create large P&L due to leverage',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You buy 1 lot of MCX Gold at ₹62,000/10g. Gold moves to ₹62,500/10g. How much profit have you made? (1 lot = 1 kg = 100 units of 10g)',
          'options': [
            '₹500 — just the price difference',
            '₹50,000 — ₹500 per 10g × 100 units in a kg',
            '₹5,000 — ₹500 × 10 units',
            '₹5,00,000 — multiply by the leverage',
          ],
          'correctIndex': 1,
          'explanation':
              'Gold moved ₹500 per 10g. One lot = 1 kg = 100 units of 10g. Profit = ₹500 × 100 = ₹50,000. Your margin was ₹4 Lakhs, and you made ₹50,000 — a 12.5% return from a tiny 0.8% move in gold price. That\'s the power (and danger) of leveraged futures trading.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Commodity futures are contracts, not physical goods',
            'Most traders close before expiry to avoid physical delivery',
            'Margin of 6-7% means ~15x leverage — amplifying both gains and losses',
            'A ₹500/10g gold move = ₹50,000 profit or loss per regular lot',
            'Next: Let\'s walk through your first commodity trade step by step.',
          ],
        },
      ],
    };
  }

  // Lesson 4.2: Your First Commodity Trade
  static Map<String, dynamic> getFirstTradeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Let\'s Trade Gold',
          'emoji': '📱',
          'content':
              'Theory is great, but nothing beats a walkthrough. Let\'s place a Gold Mini trade on MCX — from analysis to execution to exit. We\'ll use a beginner-friendly lot size so you see the real numbers.',
        },
        {
          'type': 'interactive',
          'title': 'Step-by-Step: Gold Mini Trade',
          'emoji': '🪙',
          'content': '''
**Setup: Gold Mini on MCX (Lot Size: 100 grams)**

**Step 1: Analysis 🔍**
• US Federal Reserve hinted at rate cuts → Dollar weakens → Gold typically rises
• Gold is at ₹63,000/10g
• Your target: ₹64,000 (₹1,000 up, 100 pips)
• Your stop loss: ₹62,500 (₹500 down, 50 pips)
• Risk-Reward: 1:2 ✅

**Step 2: Margin Calculation 💰**
• Contract value: ₹63,000 × 10 (100g = 10 units of 10g) = ₹6,30,000
• Margin: ~₹40,000-50,000
• Your account should have at least ₹1,00,000 (buffer for margin fluctuations)

**Step 3: Execute on Your Broker ⚡**
• Open Zerodha/Angel One → Commodity Segment → MCX
• Select: GOLDM (Gold Mini) → Current month contract
• BUY 1 lot at ₹63,000
• Set Stop Loss: ₹62,500
• Set Target: ₹64,000

**Step 4: Outcome Scenarios 📊**
• ✅ Target hit (₹64,000): Profit = ₹1,000 × 10 = ₹10,000
• ❌ Stop loss hit (₹62,500): Loss = ₹500 × 10 = ₹5,000
• 🔄 You close manually at ₹63,500: Profit = ₹500 × 10 = ₹5,000

**Key Lesson:**
Gold Mini lets you trade with ~₹40,000 margin instead of ₹4 Lakhs for regular gold. Always start with mini/petal contracts while learning!
''',
        },
        {
          'type': 'scenario',
          'title': 'Trade Decision',
          'situation':
              'You\'re in a Gold Mini BUY trade at ₹63,000. It\'s 11:00 PM and the gold contract expires TOMORROW. Gold is currently at ₹63,200 (₹200 profit per 10g). Should you hold overnight?',
          'choices': [
            {
              'text': 'Hold — it might go higher tomorrow',
              'isCorrect': false,
              'feedback':
                  '❌ Dangerous! The contract expires TOMORROW. If you don\'t close, you risk physical delivery obligations. Also, overnight gaps in commodity markets can be brutal. With a profit in hand and expiry imminent, close the trade.',
            },
            {
              'text':
                  'Close now with ₹2,000 profit — never hold commodity contracts near expiry',
              'isCorrect': true,
              'feedback':
                  '✅ Smart! Near-expiry contracts can behave erratically (reduced liquidity, wider spreads). Taking a ₹2,000 profit and avoiding delivery risk is textbook commodity trading discipline. You can always re-enter with the next month\'s contract.',
            },
            {
              'text': 'Let it expire and take physical delivery of the gold',
              'isCorrect': false,
              'feedback':
                  '❌ Physical delivery of Gold Mini = 100 grams of gold delivered to your demat account as gold receipts. This involves additional charges, GST, and complications. Unless you specifically want physical gold, close before expiry.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 4 Complete! 🎉',
          'keyPoints': [
            'Futures contracts are leveraged — ₹40,000 margin controls ₹6.3L of gold',
            'Always start with Mini or Petal contracts — manageable risk for beginners',
            'Set stop loss and target BEFORE entering any commodity trade',
            'Close positions before expiry to avoid physical delivery complications',
            'Risk-Reward of 1:2 minimum — risk ₹5K to make ₹10K',
            'Next: What\'s the difference between spot and derivative trading?',
          ],
        },
      ],
    };
  }
}
