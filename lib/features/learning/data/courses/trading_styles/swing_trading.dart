/// Chapter 4: Swing Trading
class SwingTradingContent {
  static Map<String, dynamic> getSweetSpotContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Perfect Balance',
          'emoji': '🌊',
          'content':
              'Swing trading sits in the sweet spot between the adrenaline of day trading and the patience of long-term investing. Hold for days to weeks. Analyze charts for 30 minutes a day. Keep your day job. It is the most practical style for working professionals.',
        },
        {
          'type': 'concept',
          'title': 'Why Swing Trading Works',
          'emoji': '✨',
          'content': '''
**Swing Trading = Riding the "Swings" in Price.**
Markets don't go straight up or straight down. They swing — up for a few days, pull back, then up again. Swing traders capture these multi-day moves.

**The Advantages:**
• **Time-Friendly:** 30 min/day for analysis (evenings or pre-market)
• **Lower Costs:** 2-5 trades per WEEK (vs. 20-50 per day for scalpers)
• **Bigger Targets:** ₹2,000-₹20,000 per trade (vs. ₹200 for scalpers)
• **Less Stress:** You set your orders (stop loss + target) and walk away
• **Compatible with a Job:** You don't need to watch charts during work hours

**The Disadvantages:**
• Overnight risk (gap openings can bypass stop losses)
• Requires patience (trade may take 5-10 days to play out)
• Slower feedback loop (results come weekly, not hourly)

---

**Key Insight:**
Swing trading gives you the best balance of time investment, stress, and profit potential. It is the style most commonly used by consistently profitable retail traders.
''',
          'keyPoints': [
            'Hold for days to weeks, capturing multi-day price swings',
            'Only 30 minutes/day needed — compatible with a full-time job',
            'Lower transaction costs than intraday or scalping',
            'Most consistently profitable retail traders use swing trading',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Swing vs Intraday — Same Stock, Different Approach',
          'emoji': '⚖️',
          'content': '''
**Stock: Tata Motors at ₹600. Moving toward ₹650 resistance.**

**Intraday Trader (Amit):**
• Buys at ₹602 in the morning
• Stop loss: ₹598 (₹4 risk)
• Target: ₹610 (₹8 reward)
• Sells at ₹608 after 3 hours
• Profit: ₹6 × 200 shares = **₹1,200**
• Screen time: 3 hours

**Swing Trader (Priya):**
• Buys at ₹600 on Monday evening (post-analysis)
• Stop loss: ₹580 (₹20 risk)
• Target: ₹650 (₹50 reward)
• Sells at ₹640 on Thursday
• Profit: ₹40 × 50 shares = **₹2,000**
• Screen time: 30 minutes total across 4 days

**Result:** Priya made more money, spent 90% less time, and had 90% less stress.
She also only paid brokerage TWICE (buy + sell) vs Amit's daily costs.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Why is swing trading considered ideal for working professionals?',
          'options': [
            'It requires no knowledge of charts',
            'It needs only 30 min/day, works with a day job, and has lower costs than intraday',
            'It has zero risk',
            'It guarantees profit within a week',
          ],
          'correctIndex': 1,
          'explanation':
              'Swing trading requires chart analysis but only 30 minutes per day (usually in the evening). You set your orders and go to work. Lower trade frequency means lower brokerage. It is the most practical style for someone with a 9-5 job.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Swing trading captures multi-day price moves with minimal daily time',
            'Ideal for working professionals — 30 min/day is sufficient',
            'Lower costs and stress than intraday or scalping',
            'The main risk is overnight gaps (manageable with proper position sizing)',
            'Next: The mechanics of swing trading — entries, stops, and management.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getSwingMechanicsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'How to Swing Trade',
          'emoji': '🔧',
          'content':
              'The mechanics are simple: Find a stock with momentum. Enter at support. Set a stop loss. Set a target. Wait days. Let the market do the work.',
        },
        {
          'type': 'concept',
          'title': 'The Swing Trading Workflow',
          'emoji': '📋',
          'content': '''
**Sunday Evening: The Weekly Scan (30 min)**
• Scan the Nifty 50 or Nifty 200 for stocks near support/resistance
• Mark 3-5 potential trades with clear entry, stop, and target levels
• Write them on your watchlist

**Monday Morning: Order Placement (10 min)**
• Place limit buy orders at your planned entry prices
• Attach bracket orders (stop loss + target) to each entry
• Go to work

**During the Week: Monitoring (5 min/day)**
• Check positions once in the evening
• Move stop loss to breakeven if the trade is in significant profit
• Do NOT touch winning trades mid-day out of anxiety

**Exit:**
• Trade hits target → Automatically sold ✅
• Trade hits stop → Automatically sold ❌
• You manually exit when your thesis changes

---

**Key Insight:**
The best swing trades require doing NOTHING after entry. Set it and forget it. The more you fiddle, the worse the results.
''',
          'keyPoints': [
            'Sunday scan → Monday orders → Daily 5-min check',
            'Use bracket orders to automate stop loss and target exits',
            'The best swing trades require zero intervention after entry',
            'Less fiddling = better results',
          ],
        },
        {
          'type': 'story',
          'title': 'The Fiddler\'s Regret',
          'emoji': '🤦',
          'content': '''
**Aditi** found the perfect swing setup on HDFC Bank.
She bought at ₹1500. Stop at ₹1450. Target at ₹1650.
It was a great plan.

**Tuesday, 11:00 AM:** The stock dropped to ₹1490. Aditi felt nervous and checked her phone during a work meeting. "I should sell before it hits my stop," she thought. She manually sold at ₹1490. Loss: ₹10.

**Thursday:** HDFC Bank hit ₹1650 (her original target).

**Why did she fail?**
She didn't let the market do the work. The drop to ₹1490 was normal volatility. Her stop was safe at ₹1450. Because she "fiddled" with the trade mid-day out of anxiety, she turned a ₹150 winner into a ₹10 loser.

**Key lesson:** Set your bracket order (Stop + Target) and delete the broker app from your mind until the evening. The market needs room to breathe.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Swing Management Decision',
          'situation':
              'You bought a stock at ₹200 on Monday. Stop at ₹185. Target at ₹240. It is Wednesday, and the stock is at ₹220 (in good profit). However, you see a bearish candlestick pattern on the chart. What do you do?',
          'choices': [
            {
              'text':
                  'Sell immediately — the bearish pattern is a warning sign',
              'isCorrect': false,
              'feedback':
                  '❌ Micro-managing swing trades based on daily candles defeats the purpose. Your target is ₹240. One bearish candle doesn\'t invalidate the setup. If you panic at every red candle, you will never hold a winner long enough.',
            },
            {
              'text':
                  'Move your stop loss up to ₹210 (locking in ₹10 profit), and let the trade continue toward ₹240',
              'isCorrect': true,
              'feedback':
                  '✅ Smart management. You recognized potential risk but didn\'t panic. By moving the stop to ₹210, you lock in ₹10 profit no matter what. If the bearish candle was real, you exit with profit. If the trend continues, you hit ₹240.',
            },
            {
              'text': 'Buy more shares to average up',
              'isCorrect': false,
              'feedback':
                  '❌ Adding to a position after a bearish signal increases your risk at the worst possible time. Only add to positions that are moving in your favor with zero warning signs.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 4 Complete! 🎉',
          'keyPoints': [
            'Swing trading workflow: Scan Sunday → Order Monday → Monitor 5 min/day',
            'Use bracket orders to automate exits — less fiddling = better results',
            'Move stops to breakeven when in significant profit',
            'Don\'t panic at every bearish candle — trust the process',
            'Next: Long-term investing — the compound interest machine.',
          ],
        },
      ],
    };
  }
}
