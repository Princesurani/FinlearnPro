/// Chapter 7: Entry & Exit Planning
/// Building a complete trading plan with TA
class EntryExitPlanningContent {
  // Lesson 7.1: Planning Your Entry
  static Map<String, dynamic> getPlanningEntryContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Art of Pulling the Trigger',
          'emoji': '🎯',
          'content':
              'You know the patterns, indicators, and trends. But WHEN do you actually click "BUY"? The entry is where analysis becomes action. A great analysis with a bad entry is just an expensive education.',
        },
        {
          'type': 'concept',
          'title': 'The Confluence Entry System',
          'emoji': '🔗',
          'content': '''
**Confluence = Multiple signals aligning at the same point.**
One signal alone is unreliable. But when 3-4 signals point to the same conclusion, the probability of success jumps significantly.

**The Professional Entry Checklist:**

**1. Trend Alignment ✅**
• Check the higher timeframe (weekly/daily). Is the trend in your direction?
• ONLY take trades aligned with the higher timeframe trend.

**2. Key Level (S/R) ✅**
• Is price at a meaningful support (for buys) or resistance (for sells)?
• The more times the level has been tested, the more meaningful it is.

**3. Candlestick Pattern ✅**
• Is there a bullish reversal pattern at support (Hammer, Engulfing)?
• Or a bearish pattern at resistance (Shooting Star, Bearish Engulfing)?

**4. Indicator Confirmation ✅**
• RSI oversold at support? MACD crossover happening?
• At least ONE indicator should support the trade.

**5. Volume ✅**
• Is there buying volume at support or selling volume at resistance?

---

**The Rule of Three:**
Take the trade ONLY when at least 3 of these 5 factors align.
• 3/5 confluence = Acceptable trade
• 4/5 confluence = Strong trade
• 5/5 confluence = The best setups (rare but extremely profitable)

---

**Key Insight:**
Most beginners trade on ONE signal ("RSI is oversold, BUY!"). Professionals wait for CONFLUENCE. This patience is what separates 30% win rates from 60%+ win rates.
''',
          'keyPoints': [
            'Confluence = multiple signals aligning → higher probability trade',
            'The 5 factors: trend, S/R level, candle pattern, indicator, volume',
            'Minimum 3 out of 5 must align before entering any trade',
            'Patience for confluence separates beginners (30% wins) from pros (60%+ wins)',
          ],
        },
        {
          'type': 'story',
          'title': 'The FOMO Entry',
          'emoji': '🏃‍♂️',
          'content': '''
**Rahul** is watching Bank Nifty.
Suddenly, a massive green candle appears on the 5-minute chart.
RSI shoots up to 80.

**Rahul's thought process:** "It's breaking out! If I don't buy now, I'll miss the move!" (Factor: FOMO).
He buys at the absolute top of the candle.

**What the chart actually showed (Confluence check):**
1. Trend (1-hour): Downtrend. ❌
2. S/R Level: Price just hit a major daily resistance. ❌
3. Candle Pattern: The next candle formed a Shooting Star (Bearish). ❌
4. Indicator: RSI was overbought, signaling exhaustion. ❌

Within 10 minutes, the price violently reversed, crashing down. Rahul lost ₹5,000.

**Key lesson:** The market is designed to trick you into entering at the worst possible time (chasing green candles). The Confluence Checklist is your shield against FOMO. If Rahul had checked his list, he would have realized the score was 0/5 and saved his money.
''',
        },
        {
          'type': 'interactive',
          'title': 'A Confluence Trade Example',
          'emoji': '📊',
          'content': '''
**Stock: HDFC Bank | Daily Chart**

**Factor 1 — Trend: ✅**
Weekly chart: Clear uptrend (Higher Highs and Higher Lows)
Trading WITH the trend.

**Factor 2 — S/R Level: ✅**
Price has pulled back to ₹1,550 — a level that acted as support 3 times before.
Strong horizontal support.

**Factor 3 — Candle Pattern: ✅**
A Bullish Engulfing candle formed right at ₹1,550 support.
Buyers are fighting back at a key level.

**Factor 4 — Indicator: ✅**
RSI dropped to 32 (near oversold) and is turning back up.
MACD histogram is shrinking (selling momentum fading).

**Factor 5 — Volume: ✅**
The Engulfing candle had 2x normal volume.
Institutions are participating in this bounce.

**Confluence Score: 5/5 — Excellent Setup!**

**The Trade:**
• Entry: ₹1,560 (after engulfing confirmation)
• Stop Loss: ₹1,530 (below support)
• Target 1: ₹1,620 (R:R = 1:2)
• Target 2: ₹1,680 (R:R = 1:4)

**This is how professionals trade. Not guessing. Stacking probabilities.**
''',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Confluence = stacking multiple signals for higher probability entries',
            'Five factors: trend, S/R, candlestick pattern, indicator, volume',
            'Minimum 3/5 factors must align — 5/5 setups are rare but extremely profitable',
            'Professional trading is about stacking probabilities, not predicting',
            'Next: The hardest part of trading — knowing when and how to EXIT.',
          ],
        },
      ],
    };
  }

  // Lesson 7.2: Planning Your Exit
  static Map<String, dynamic> getPlanningExitContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Hardest Part of Trading',
          'emoji': '🚪',
          'content':
              'Every beginner obsesses over entries. Every professional knows that exits make the real money. When do you take profit? When do you cut losses? When do you trail your stop? Let\'s build your exit system.',
        },
        {
          'type': 'concept',
          'title': 'The Exit Framework',
          'emoji': '🗺️',
          'content': '''
**Three Types of Exits:**

**1. Stop Loss (Protecting Capital) 🛑**
• Set BEFORE entering the trade. Non-negotiable.
• Place below support (for buys) or above resistance (for sells)
• Never move your stop FURTHER from entry (only tighten it)
• Rule: If you don't know where your stop loss is, don't enter the trade.

**2. Take Profit (Booking Wins) 💰**
• **Fixed Target:** Set a price target based on S/R or chart patterns
  → Example: Buy at support (₹100), target next resistance (₹120)
• **Partial Profits:** Sell 50% at Target 1, 50% at Target 2
  → Guarantees SOME profit while letting the rest ride
• **R:R Based:** Exit when reward reaches 2x or 3x the risk

**3. Trailing Stop (Riding Trends) 📈**
• As price moves in your favor, move your stop loss up
• Methods:
  → Trail below the 20 EMA
  → Trail below each new Higher Low
  → Trail using a fixed pip/point distance
• The stop eventually gets hit when the trend reverses — locking in profits

---

**The Professional Exit Rule:**
Decide your exit BEFORE you enter. Write it down:
"I will buy at ₹100. Stop at ₹95. Target at ₹115."
No decisions are made DURING the trade — emotions are too high.

---

**Key Insight:**
Amateurs make money on entries. Professionals make money on exits. The difference between a 5% return and a 50% return is often just better exit management — not better entry timing.
''',
          'keyPoints': [
            'Three exits: stop loss (protect), take profit (book), trailing stop (ride)',
            'Always decide exits BEFORE entering — never make exit decisions during a trade',
            'Partial profits = smart — sell 50% at Target 1, let 50% ride',
            'Trailing stops maximize wins in trending markets — ride the 20 EMA',
          ],
        },
        {
          'type': 'story',
          'title': 'The "Hope" Trade',
          'emoji': '🙏',
          'content': '''
**Priya** bought Tata Motors at ₹400.
Her plan: Target ₹450, Stop Loss ₹380.

**Day 3:** The stock drops to ₹385. Priya is nervous.
**Day 4:** The stock hits ₹380 (Her stop loss).

**The Fatal Mistake:**
Instead of selling, Priya thinks: "It's a great company. It will surely bounce back. I'll just hold it a bit longer." She cancels her stop loss order.

**Day 10:** The stock drops to ₹320. Priya is now down 20%. She is officially an "involuntary long-term investor."
She stops checking her portfolio because looking at the red numbers causes physical pain.

**Key lesson:** A stop loss is not a suggestion; it is a hard boundary. The moment you move or cancel your stop loss, you are no longer trading—you are hoping. Hope is the most expensive strategy in the stock market.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Exit Decision',
          'situation':
              'You bought a stock at ₹200 with a stop at ₹190 and target at ₹230. Price reaches ₹225 (near target). But the trend looks strong and you think it could go to ₹250. What do you do?',
          'choices': [
            {
              'text': 'Move target to ₹250 — the trend is strong!',
              'isCorrect': false,
              'feedback':
                  '❌ Moving targets based on "feeling" is how you turn winners into losers. The stock could reverse at ₹226 and you\'d have given back ₹25 of profit. Stick to the plan, or use a systematic approach like partial exits.',
            },
            {
              'text':
                  'Sell 50% at ₹225, move stop loss to ₹215 (above entry) for the remaining 50%, and let it ride toward ₹250 with a trailing stop',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect! You lock in profit on half the position (guaranteed win), move stop to breakeven-plus on the rest (now a "free trade"), and let the trend reward you further. This is how professionals maximize winning trades while protecting capital.',
            },
            {
              'text': 'Sell everything at ₹225 — close enough to target',
              'isCorrect': false,
              'feedback':
                  '❌ Not wrong, but suboptimal. You\'re leaving potential profit on the table in a strong trend. Partial exits + trailing stop let you capture BOTH — guaranteed profit AND trend continuation. Selling everything limits your upside.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 7 Complete! 🎉',
          'keyPoints': [
            'Confluence entries (3+ factors aligning) dramatically improve win rate',
            'Exits should be planned BEFORE entry — write down stop loss and targets',
            'Partial exits = sell 50% at Target 1, trail the rest for maximum profit',
            'Stop losses are non-negotiable — never move them further from your entry',
            'Professional trading is a system, not intuition — plan, execute, review',
            'Next: The final chapter — the mistakes that destroy most traders\' accounts.',
          ],
        },
      ],
    };
  }
}
