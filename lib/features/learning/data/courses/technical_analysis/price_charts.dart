/// Chapter 2: Price Charts & Timeframes
/// Line, bar, and candlestick charts decoded
class PriceChartsContent {
  // Lesson 2.1: Types of Charts
  static Map<String, dynamic> getChartTypesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Reading the Market\'s Heartbeat',
          'emoji': '💓',
          'content':
              'A price chart is the market\'s heartbeat monitor. Just as a doctor reads an ECG to understand heart health, a trader reads price charts to understand market health. Three types exist — each revealing different levels of detail.',
        },
        {
          'type': 'concept',
          'title': 'Three Types of Price Charts',
          'emoji': '📊',
          'content': '''
**1. Line Chart — The Simple View 📈**
• Connects closing prices with a single line
• Shows overall direction clearly but hides intraday details
• Best for: Getting a quick sense of the big picture
• Limitation: You can't see the high, low, or open — just the close

**2. Bar Chart (OHLC) — The Detailed View 📊**
• Each bar shows: Open, High, Low, Close
• Gives more information than line charts
• The left tick = Open price, right tick = Close price
• Best for: Seeing price range and direction together

**3. Candlestick Chart — The Storyteller 🕯️**
• Same OHLC data as bar charts, but MUCH easier to read
• **Green/White candle:** Close > Open (buyers won this period)
• **Red/Black candle:** Close < Open (sellers won this period)
• The "body" shows Open-Close range; "wicks/shadows" show High-Low extremes
• Best for: Reading market psychology at a glance

---

**Why Candlesticks Dominate:**
Invented in 18th century Japan by rice trader Homma Munehisa. He noticed patterns in price candles that predicted future moves. 300 years later, these patterns still work.

**Key Insight:**
95% of professional traders use candlestick charts. The visual format makes it instantly clear who's winning — buyers or sellers. Learn candlesticks and you'll never go back to line charts.
''',
          'keyPoints': [
            'Line charts show direction; candlesticks show direction + psychology',
            'Green candle = buyers won; Red candle = sellers won',
            'Body = Open-Close range; Wicks = High-Low extremes',
            'Candlesticks were invented 300 years ago in Japan — still the gold standard',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The Candlestick Visualizer',
          'emoji': '🕯️',
          'content': '''
**Let's build a candlestick from scratch.**

**The Setup:**
1. The market opens at 9:15 AM. Price = ₹100.
2. Sellers push it down to ₹90.
3. Buyers fight back, pushing it up to ₹120.
4. It settles and closes at 3:30 PM at ₹115.

**The Resulting Candle:**
• **Open:** ₹100
• **Close:** ₹115
• **High:** ₹120
• **Low:** ₹90
• **Color:** Green (because Close > Open)

**The Body:** The thick part between ₹100 and ₹115. This represents the *net* movement of the day.
**The Lower Wick:** The thin line down to ₹90. This shows the sellers *tried* but failed.
**The Upper Wick:** The thin line up to ₹120. This shows the buyers *tried* to go higher but got pushed back slightly.

**The Psychology:** The buyers won decisively today. The lower wick shows they aggressively bought the dip at ₹90.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'A candlestick has a very small body but very long upper and lower wicks. What does this tell you?',
          'options': [
            'Strong buyer conviction — price will go up',
            'Strong seller conviction — price will go down',
            'Indecision — both buyers and sellers fought hard but neither side won decisively',
            'The market was closed and no trading happened',
          ],
          'correctIndex': 2,
          'explanation':
              'A small body means Open and Close were nearly the same — no clear winner. Long wicks mean price swung wildly in both directions during the period. This is a "Doji" pattern — it signals indecision and often appears before reversals. The market is undecided about direction.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Line charts show the big picture; candlesticks reveal the full story',
            'Candlesticks show Open, High, Low, Close — and who\'s winning (buyers vs sellers)',
            'Green = bullish (close > open); Red = bearish (close < open)',
            'Candlestick charts are used by 95% of professional traders',
            'Next: Does the same chart look different on 1-minute vs daily vs monthly?',
          ],
        },
      ],
    };
  }

  // Lesson 2.2: Timeframes & What They Mean
  static Map<String, dynamic> getTimeframesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Same Stock, Different Stories',
          'emoji': '🔍',
          'content':
              'Reliance on a 5-minute chart might look bearish. The same Reliance on a daily chart looks bullish. And on a weekly chart? Neutral. Which one is "right"? All of them — they just answer different questions.',
        },
        {
          'type': 'concept',
          'title': 'Timeframes Explained',
          'emoji': '⏱️',
          'content': '''
**Each candle represents a period of time:**

**Intraday Timeframes (for day traders):**
• **1-Minute:** Ultra short-term. Very noisy. For scalpers.
• **5-Minute:** Popular for intraday trading in India.
• **15-Minute:** Good balance of detail and noise reduction.
• **1-Hour:** Intraday swing trading. Cleaner patterns.

**Swing Trading Timeframes:**
• **4-Hour:** Multi-day positions. Used by forex traders.
• **Daily:** The most popular timeframe for swing trading. One candle = one trading day.

**Investment Timeframes:**
• **Weekly:** Each candle = one week. Filters out daily noise.
• **Monthly:** Big picture trends. Each candle = one month.

---

**The Multi-Timeframe Rule:**
Always check at least TWO timeframes:
1. **Higher timeframe** for TREND direction (weekly/daily)
2. **Lower timeframe** for ENTRY timing (hourly/15-min)

**Example:**
• Weekly chart: Reliance is in a clear uptrend ✅
• Daily chart: Currently pulling back to support ✅
• Action: BUY on the daily pullback, aligned with the weekly uptrend

---

**Key Insight:**
The higher the timeframe, the more reliable the signal. A support level on a weekly chart is far more important than one on a 5-minute chart. Always trade in the direction of the higher timeframe.
''',
          'keyPoints': [
            '1-min to monthly — each timeframe tells a different story',
            'Higher timeframes are more reliable (weekly > daily > hourly)',
            'Always check multiple timeframes before trading',
            'Trade in the direction of the higher timeframe for best results',
          ],
        },
        {
          'type': 'story',
          'title': 'The Noise vs Signal Trap',
          'emoji': '📻',
          'content': '''
**Amit** started day trading using a 1-minute chart.
**10:15 AM:** The 1-minute candle closed as a massive red bearish engulfing. "It's crashing!" Amit sold short.
**10:17 AM:** The next two candles were green, shooting past his entry. He got stopped out. Loss: ₹2,000.

Frustrated, Amit showed the chart to his mentor.
The mentor zoomed out to the **1-hour chart**.

On the 1-hour chart, Amit's "massive red candle" was just a tiny microscopic dip within a huge, unbroken green uptrend. The 1-hour trend was powerfully bullish.

**The Mentor said:** "You were looking at the waves on the surface (1-min) while ignoring the tide of the ocean (1-hour). The waves are just noise. The tide is the signal."

**Key lesson:** The lower the timeframe, the more "noise" (random fluctuations) you see. The higher the timeframe, the clearer the true "signal" (trend) becomes. Never trade a low timeframe without checking the higher one first.
''',
        },
        {
          'type': 'scenario',
          'title': 'Which Timeframe?',
          'situation':
              'You\'re a working professional who can check charts twice a day — once at lunch and once after market close. Which timeframe combination is best for you?',
          'choices': [
            {
              'text': '1-minute and 5-minute charts — for maximum detail',
              'isCorrect': false,
              'feedback':
                  '❌ 1-min and 5-min charts require constant monitoring. A 5-minute candle changes every 5 minutes — if you check only twice a day, you\'ll miss 95% of the action. These are for full-time day traders, not working professionals.',
            },
            {
              'text':
                  'Weekly for trend direction + Daily for entry signals — suitable for checking twice a day',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect match for your schedule! Weekly charts set the trend, daily charts give you one new candle per day. Checking at lunch (intraday overview) and after close (daily candle formed) is sufficient. This is swing trading — positions held for days to weeks.',
            },
            {
              'text': 'Monthly charts only — check once a month',
              'isCorrect': false,
              'feedback':
                  '❌ Monthly charts are great for identifying multi-year trends but too slow for active trading. You\'d miss good entry and exit points. Monthly charts are best for long-term investors, not traders.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 2 Complete! 🎉',
          'keyPoints': [
            'Candlestick charts are the standard — they reveal price AND psychology',
            'Timeframes range from 1-minute (scalping) to monthly (investing)',
            'Higher timeframes are more reliable — weekly signals trump 5-minute signals',
            'Match your timeframe to your lifestyle — working professional = daily/weekly',
            'Always use multi-timeframe analysis: higher for trend, lower for entry',
            'Next: The two most important levels on any chart — support and resistance.',
          ],
        },
      ],
    };
  }
}
