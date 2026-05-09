/// Chapter 4: Trend Analysis
/// The trend is your friend — until it ends
class TrendAnalysisContent {
  // Lesson 4.1: Identifying Trends
  static Map<String, dynamic> getIdentifyingTrendsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Trend is Your Friend',
          'emoji': '📈',
          'content':
              'The single most profitable rule in trading: trade WITH the trend. 80% of your profits will come from correctly identifying the trend and riding it. Fighting the trend is fighting the ocean — you\'ll always lose.',
        },
        {
          'type': 'concept',
          'title': 'Three Types of Trends',
          'emoji': '🔄',
          'content': '''
**1. Uptrend (Bullish) 📈**
• Price makes **Higher Highs (HH)** and **Higher Lows (HL)**
• Each peak is higher than the previous peak
• Each dip is higher than the previous dip
• **Action: Buy on dips (pullbacks to support/trendline)**

**2. Downtrend (Bearish) 📉**
• Price makes **Lower Highs (LH)** and **Lower Lows (LL)**
• Each peak is lower than the previous peak
• Each dip is lower than the previous dip
• **Action: Sell rallies or stay away**

**3. Sideways (Range-Bound) ↔️**
• Price bounces between support and resistance
• No clear higher highs or lower lows
• **Action: Buy at support, sell at resistance — OR wait for a breakout**

---

**How to Identify the Trend:**
• Zoom out to a higher timeframe (weekly/daily)
• Connect the swing lows — if they're rising, it's an uptrend
• Connect the swing highs — if they're falling, it's a downtrend
• If neither, it's sideways

---

**Key Insight:**
"The trend is your friend until it bends." Trade with the trend for 80% of your trades. Only attempt counter-trend trades with strict risk management and a proven edge.
''',
          'keyPoints': [
            'Uptrend = Higher Highs + Higher Lows → Buy on pullbacks',
            'Downtrend = Lower Highs + Lower Lows → Sell rallies or avoid',
            'Sideways = No clear direction → Trade the range or wait',
            'Always check the higher timeframe for the dominant trend',
          ],
        },
        {
          'type': 'story',
          'title': 'Catching the Falling Knife',
          'emoji': '🔪',
          'content': '''
**Rohan loved "buying the dip."**

XYZ Corp had been in a brutal downtrend for 6 months, falling from ₹1,000 to ₹500. It was making consistent Lower Highs and Lower Lows.

**Rohan's logic:** "It's down 50%. It *has* to bounce. It's so cheap!"
He bought at ₹500. (Fighting the trend).

The next week, XYZ Corp dropped to ₹400.
Rohan averaged down: "Even cheaper now!"
A month later, it dropped to ₹250.

**The Mentor's advice:** "Rohan, you are standing in front of a speeding freight train and hoping it stops just because you bought a ticket. A downtrend doesn't care what price you think is 'cheap.' It only ends when the chart proves it by making a Higher High."

**Key lesson:** Never try to pick the absolute bottom of a downtrend. It's called "catching a falling knife" — you only get hurt. Wait for the trend to shift (Lower Lows turn into Higher Lows) before buying.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'A stock made these swing points: Low at ₹100, High at ₹120, Low at ₹108, High at ₹125, Low at ₹115. What\'s the trend?',
          'options': [
            'Downtrend — the stock is falling',
            'Uptrend — Higher Highs (₹120→₹125) and Higher Lows (₹100→₹108→₹115)',
            'Sideways — no clear direction',
            'Impossible to determine from this data',
          ],
          'correctIndex': 1,
          'explanation':
              'Highs: ₹120 → ₹125 (Higher High ✅). Lows: ₹100 → ₹108 → ₹115 (Higher Lows ✅). Both conditions for an uptrend are met. The correct action is to buy on dips near the rising trendline connecting the higher lows.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Three trend types: uptrend (HH+HL), downtrend (LH+LL), sideways',
            'Trade WITH the trend for 80% of trades — it\'s the highest probability',
            'Higher timeframes show the dominant trend; lower timeframes show entry opportunities',
            'A trend continues until price breaks the pattern of higher lows (uptrend) or lower highs (downtrend)',
            'Next: How to draw trendlines and channels to visualize trends precisely.',
          ],
        },
      ],
    };
  }

  // Lesson 4.2: Trendlines & Channels
  static Map<String, dynamic> getTrendlinesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Drawing the Map',
          'emoji': '✏️',
          'content':
              'A trendline is the simplest and most powerful tool in TA. Connect two swing lows in an uptrend, and you have a roadmap for where to buy on the next pullback. Let\'s learn to draw them correctly.',
        },
        {
          'type': 'concept',
          'title': 'Trendlines & Channels',
          'emoji': '📐',
          'content': '''
**Drawing a Trendline:**
1. **Uptrend line:** Connect at least 2-3 swing LOWS (higher lows)
2. **Downtrend line:** Connect at least 2-3 swing HIGHS (lower highs)
3. **More touches = stronger trendline**

**Rules for Valid Trendlines:**
• Must touch at least 2 points (3+ is better)
• Don't force it — if the line doesn't fit naturally, it's not a valid trendline
• Use candle bodies or wicks consistently (don't mix)

---

**Price Channels:**
A channel is TWO parallel trendlines:
• **Ascending channel:** Uptrend line (bottom) + parallel line at the highs (top)
• **Descending channel:** Downtrend line (top) + parallel line at the lows (bottom)

**How to Trade Channels:**
• BUY when price touches the bottom of an ascending channel
• SELL when price touches the top of a channel
• A BREAK below the channel signals the trend may be ending

---

**Trendline Break = Trend Change Warning:**
When price breaks below an uptrend line (with volume), it's a warning:
• It doesn't mean "crash immediately"
• It means "the current trend is weakening — be cautious"
• Wait for a retest of the broken trendline as new resistance to confirm

---

**Key Insight:**
Trendlines are guides, not exact science. Price may slightly undershoot or overshoot. Use trendlines as ZONES (not exact lines) and combine with other tools (S/R, volume) for confirmation.
''',
          'keyPoints': [
            'Connect 2-3 swing lows for uptrend line; swing highs for downtrend line',
            'Channels = two parallel trendlines — buy at bottom, sell at top',
            'Trendline breaks signal potential trend changes — wait for confirmation',
            'Treat trendlines as zones, not exact prices — combine with other tools',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Trendline Trading Example',
          'emoji': '📊',
          'content': '''
**Example: Bank Nifty Ascending Channel**

**Observations:**
• Bank Nifty has been in an ascending channel for 3 months
• Bottom trendline connects: 44,000 → 44,500 → 45,000 (rising)
• Top trendline connects: 46,000 → 46,500 → 47,000 (parallel rise)

**Trade Plan:**
• BUY when Bank Nifty touches the bottom trendline (~45,200 next time)
• SELL/Take profit at the upper trendline (~47,200)
• Stop Loss: Below the bottom trendline by 200 points (45,000)

**Risk-Reward:**
• Entry: 45,200
• Target: 47,200 (+2,000 points)
• Stop: 45,000 (-200 points)
• R:R = 1:10 🔥

**What if the channel breaks?**
• If price breaks BELOW 45,000 on high volume = EXIT immediately
• The uptrend is over. Don't hope. Don't average down.
• Wait for a new structure to form before re-entering.

**Key Lesson:**
Channels give the highest Risk:Reward entries in trending markets. The key is patience — wait for price to come to YOUR level instead of chasing.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You drew a perfect uptrend line connecting 4 swing lows. Today, the price drops BELOW this line with a large red candle and high volume. What is the most appropriate action?',
          'options': [
            'Buy more immediately — the trendline was just a suggestion',
            'Exit long positions and potentially prepare to short — the trend may be changing',
            'Hold and hope it bounces back up tomorrow',
            'Draw a new trendline that fits the new low and ignore the break',
          ],
          'correctIndex': 1,
          'explanation':
              'A high-volume break of a major trendline is a primary warning signal that the prevailing trend is weakening or reversing. The smartest move is defensive: exit longs. You do not redraw trendlines to fit your bias. Respect the break.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 4 Complete! 🎉',
          'keyPoints': [
            'Trends are defined by Higher Highs/Lows (up) or Lower Highs/Lows (down)',
            'Trendlines connect swing points — more touches = stronger line',
            'Channels provide the best risk-reward entries in trending markets',
            'Trendline breaks are warnings, not guarantees — wait for confirmation',
            'Trade WITH the trend — it\'s the single most profitable habit in trading',
            'Next: The ancient art of candlestick patterns — reading the story of each candle.',
          ],
        },
      ],
    };
  }
}
