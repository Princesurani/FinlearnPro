/// Chapter 5: Candlestick Patterns
/// Reading the story each candle tells
class CandlestickPatternsContent {
  // Lesson 5.1: Single Candle Patterns
  static Map<String, dynamic> getSingleCandleContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'One Candle, Big Signal',
          'emoji': '🕯️',
          'content':
              'A single candlestick can tell you everything about the battle between buyers and sellers in that period. Some single-candle patterns are so powerful they can signal a trend reversal all by themselves.',
        },
        {
          'type': 'story',
          'title': 'Priya Reads the Battlefield',
          'emoji': '⚔️',
          'content': '''
**Priya**, 28, a graphic designer in Jaipur, was learning to read candlestick patterns on Nifty 50.

One day, she noticed a **Hammer candle** forming on Tata Steel at ₹125 — right at a major support level that had held 3 times before.

**Priya's thought process:**
"The sellers pushed the price down to ₹118 during the day, but buyers fought back and closed at ₹124. The long lower wick tells me buyers are defending this level aggressively."

**Next day:** A strong green candle formed (₹124 → ₹131). Confirmation!

**Priya's action:**
She bought at ₹131 with a stop loss at ₹117 (below the Hammer's wick).
Target: ₹145 (previous resistance).

**Result:** Tata Steel rallied to ₹148 over the next 8 days. **+₹17 per share, 13% return.**

**Key lesson:** Priya didn't predict the future. She READ what the candle told her — "Buyers are fighting hard at this level" — and waited for confirmation before acting.
''',
        },
        {
          'type': 'concept',
          'title': 'The 5 Essential Single-Candle Patterns',
          'emoji': '📋',
          'content': '''
**1. Doji ✝️ — Indecision**
• Tiny body, wicks on both sides
• Open ≈ Close (neither buyers nor sellers won)
• Signal: Indecision. Potential reversal if at key S/R level.
• **After an uptrend = warning. After a downtrend = hope.**

**2. Hammer 🔨 — Bullish Reversal**
• Small body at the TOP, long lower wick (2x body minimum)
• Sellers pushed price down hard, but buyers recovered it completely
• Signal: Appears at BOTTOM of downtrends. Buyers are fighting back.
• **Action: Wait for next candle to confirm (green candle after hammer = buy)**

**3. Shooting Star ⭐ — Bearish Reversal**
• Small body at the BOTTOM, long upper wick
• Buyers pushed up hard, but sellers crushed them back down
• Signal: Appears at TOP of uptrends. Sellers are taking control.
• **Action: Wait for confirmation (red candle after shooting star = sell signal)**

**4. Marubozu 🟩/🟥 — Pure Conviction**
• Large body, NO wicks (or very tiny wicks)
• Green Marubozu: Buyers dominated from open to close — pure bullish power
• Red Marubozu: Sellers dominated — pure bearish power
• **Signal: Strong momentum in the direction of the candle**

**5. Spinning Top 🔁 — Weakening Trend**
• Small body, moderate wicks on both sides
• Similar to Doji but with a slightly larger body
• Signal: Current trend is losing steam but hasn't reversed yet

---

**Key Insight:**
Single candle patterns are WARNINGS, not actions. Always wait for the next candle to confirm. A Hammer at support + green confirmation candle = high-probability trade.
''',
          'keyPoints': [
            'Doji = indecision; Hammer = bullish reversal; Shooting Star = bearish reversal',
            'Marubozu = pure conviction; Spinning Top = weakening momentum',
            'Location matters — a Hammer at support is meaningful; mid-trend is noise',
            'Always wait for the next candle to confirm before trading a pattern',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'After a long downtrend, a stock forms a Hammer candle at a key support level. The next day, a strong green candle forms. What\'s the signal?',
          'options': [
            'Continue selling — the downtrend will resume',
            'Bullish reversal confirmed — the Hammer + green confirmation at support is a buy signal',
            'No signal — single candles are always meaningless',
            'Wait for 10 more candles before making any decision',
          ],
          'correctIndex': 1,
          'explanation':
              'This is a textbook bullish reversal setup: (1) Downtrend exhaustion, (2) Hammer at support (buyers fighting back), (3) Green confirmation candle (buyers following through). The confluence of location (support) + pattern (Hammer) + confirmation (green candle) creates a high-probability buy signal.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Five essential patterns: Doji, Hammer, Shooting Star, Marubozu, Spinning Top',
            'Location is crucial — patterns only matter at key S/R levels',
            'Always wait for confirmation — one candle is a warning, not a signal',
            'Hammer at support + green candle = strongest single-candle buy signal',
            'Next: Multi-candle patterns that tell even more powerful stories.',
          ],
        },
      ],
    };
  }

  // Lesson 5.2: Multi-Candle Patterns
  static Map<String, dynamic> getMultiCandleContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Two Candles Tell a Better Story',
          'emoji': '🕯️🕯️',
          'content':
              'If a single candle is a sentence, multi-candle patterns are paragraphs. They combine two or three candles to create even more reliable reversal and continuation signals.',
        },
        {
          'type': 'interactive',
          'title': 'Engulfing Pattern in Action',
          'emoji': '📈',
          'content': '''
**Real Example: Bullish Engulfing on Reliance (Daily Chart)**

**Day 1 (Red candle):**
• Open: ₹2,520 | Close: ₹2,490
• Small red candle (sellers had mild control)
• Body size: ₹30

**Day 2 (Green candle):**
• Open: ₹2,480 | Close: ₹2,545
• LARGE green candle that completely engulfs Day 1
• Body size: ₹65 (more than 2x Day 1)

**What happened:**
Day 2 opened BELOW Day 1's close (gap down) but buyers overwhelmed sellers so powerfully that price closed ABOVE Day 1's open. Complete reversal of power.

**The Trade:**
• Entry: ₹2,545 (close of engulfing candle)
• Stop Loss: ₹2,475 (below the engulfing candle's low)
• Target: ₹2,680 (next major resistance)
• R:R = 1:1.9 ✅

**Result:** Reliance rallied to ₹2,700 over 2 weeks. +₹155/share.

**Pattern Recognition Rule:** The bigger the engulfing candle relative to the previous candle, the stronger the signal.
''',
        },
        {
          'type': 'concept',
          'title': 'The Key Multi-Candle Patterns',
          'emoji': '📊',
          'content': '''
**Reversal Patterns:**

**1. Bullish Engulfing 🟩⬆️**
• Candle 1: Small red candle
• Candle 2: Large green candle that COMPLETELY engulfs the previous red body
• Signal: Buyers overwhelmed sellers. Bullish reversal.
• Best at: Bottom of downtrends at support

**2. Bearish Engulfing 🟥⬇️**
• Candle 1: Small green candle
• Candle 2: Large red candle that engulfs the previous green body
• Signal: Sellers overwhelmed buyers. Bearish reversal.
• Best at: Top of uptrends at resistance

**3. Morning Star ⭐ (3-candle bullish reversal)**
• Candle 1: Large red candle (strong selling)
• Candle 2: Small body (indecision — Doji or Spinning Top)
• Candle 3: Large green candle (buyers take over)
• Signal: The strongest bullish reversal pattern

**4. Evening Star 🌙 (3-candle bearish reversal)**
• Opposite of Morning Star
• Large green → Small body → Large red
• Signal: The strongest bearish reversal pattern

---

**Continuation Pattern:**

**5. Three White Soldiers / Three Black Crows**
• Three consecutive long candles in the same direction
• White Soldiers: 3 green candles = strong uptrend continuation
• Black Crows: 3 red candles = strong downtrend continuation

---

**Key Insight:**
Multi-candle patterns are more reliable than single candles because they show a SHIFT in power. Engulfing = sellers losing control. Morning Star = seller exhaustion + buyer emergence. The story unfolds over 2-3 candles.
''',
          'keyPoints': [
            'Engulfing = one side overwhelms the other in one candle',
            'Morning/Evening Star = 3-candle reversal patterns (strongest signals)',
            'Three Soldiers/Crows = continuation patterns confirming trend strength',
            'Multi-candle patterns are more reliable because they show momentum shift',
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Engulfing patterns show one side overpowering the other',
            'Morning Star (bullish) and Evening Star (bearish) are the strongest reversal signals',
            'Multi-candle patterns are more reliable than single-candle patterns',
            'Always check location (S/R level) and volume for additional confirmation',
            'Next: The big chart formations — Head & Shoulders, Double Tops, Triangles.',
          ],
        },
      ],
    };
  }

  // Lesson 5.3: Chart Patterns
  static Map<String, dynamic> getChartPatternsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Big Picture Formations',
          'emoji': '🗻',
          'content':
              'Candlestick patterns form in 1-3 candles. Chart patterns take weeks or months to form — and they predict much larger moves. These are the formations that fund managers and institutions watch.',
        },
        {
          'type': 'concept',
          'title': 'The 5 Essential Chart Patterns',
          'emoji': '📐',
          'content': '''
**Reversal Patterns:**

**1. Head & Shoulders (H&S) — Bearish Reversal 👤**
• Left Shoulder → Head (higher peak) → Right Shoulder (lower peak)
• "Neckline" connects the two lows between the peaks
• When price breaks BELOW the neckline = strong sell signal
• Target: Height of Head minus Neckline, projected downward

**2. Inverse Head & Shoulders — Bullish Reversal 🙃**
• Same structure, upside down
• Neckline break UPWARD = strong buy signal

**3. Double Top (M-pattern) — Bearish 📉**
• Price hits a resistance level TWICE and fails both times
• Forms an "M" shape
• Break below the support between the two tops = sell

**4. Double Bottom (W-pattern) — Bullish 📈**
• Price hits a support level TWICE and bounces both times
• Forms a "W" shape
• Break above the resistance between the two bottoms = buy

---

**Continuation Pattern:**

**5. Triangles (Ascending, Descending, Symmetrical) 📐**
• **Ascending Triangle:** Flat resistance + rising support → Usually breaks UP
• **Descending Triangle:** Rising resistance + flat support → Usually breaks DOWN
• **Symmetrical Triangle:** Converging trendlines → Can break either way

---

**Key Insight:**
Chart patterns take patience to identify and trade. They form over weeks/months and give the most reliable signals in all of TA. A Head & Shoulders on a weekly chart is one of the most profitable setups in trading.
''',
          'keyPoints': [
            'H&S and Inverse H&S are the most reliable reversal patterns',
            'Double Top (M) = bearish; Double Bottom (W) = bullish',
            'Triangles indicate consolidation before a big move',
            'Chart patterns on higher timeframes (daily/weekly) are the most reliable',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Pattern Identification',
          'question':
              'A stock peaks at ₹500, dips to ₹450, rallies to ₹520 (higher peak), dips to ₹450 again, then rallies to only ₹490 (lower peak). What pattern is forming?',
          'options': [
            'Double Top — two equal peaks',
            'Head and Shoulders — Left Shoulder (₹500), Head (₹520), Right Shoulder (₹490)',
            'Ascending Triangle — higher highs',
            'Triple Bottom — three lows at ₹450',
          ],
          'correctIndex': 1,
          'explanation':
              'Three peaks with the middle one highest (₹520) = Head and Shoulders. Left Shoulder (₹500), Head (₹520), Right Shoulder (₹490). The Neckline is at ₹450. If price breaks below ₹450, the target is ₹450 - (₹520 - ₹450) = ₹380. This is one of the most reliable bearish reversal patterns in all of technical analysis.',
        },
        {
          'type': 'scenario',
          'title': 'Pattern Recognition',
          'situation':
              'On a daily chart, a stock hits ₹800 twice (two peaks), with a dip to ₹720 between them. After the second peak at ₹800, price starts falling toward ₹720 again. What pattern is forming and what should you do?',
          'choices': [
            {
              'text':
                  'It\'s a Double Top — if ₹720 breaks, sell. Target: ₹640 (₹800-₹720 = ₹80, projected below ₹720)',
              'isCorrect': true,
              'feedback':
                  '✅ Textbook Double Top! Two failed attempts at ₹800 resistance form the "M" shape. The neckline is ₹720. If price breaks below ₹720 on volume, the target is ₹720 - ₹80 = ₹640. Set stop loss above ₹740.',
            },
            {
              'text':
                  'Buy at ₹720 — it\'s strong support and will bounce again',
              'isCorrect': false,
              'feedback':
                  '❌ While ₹720 IS support, the Double Top pattern suggests it\'s about to break. Buying at support is normally smart, but when a bearish chart pattern is forming, support is more likely to fail. Context matters!',
            },
            {
              'text':
                  'Buy at ₹800 — it\'s just a temporary pullback before going higher',
              'isCorrect': false,
              'feedback':
                  '❌ The stock tried ₹800 TWICE and failed both times. This is the definition of resistance. Buying at a level that has rejected price twice is fighting the market. Wait for a confirmed breakout above ₹800 before getting bullish.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 5 Complete! 🎉',
          'keyPoints': [
            'Single candle patterns (Doji, Hammer, Shooting Star) are early warnings',
            'Multi-candle patterns (Engulfing, Morning Star) confirm reversals',
            'Chart patterns (H&S, Double Top, Triangles) predict the biggest moves',
            'Always combine patterns with S/R levels and volume for confirmation',
            'Higher timeframe patterns are more reliable than lower timeframe ones',
            'Next: The mathematical tools — Moving Averages, RSI, MACD, and Bollinger Bands.',
          ],
        },
      ],
    };
  }
}
