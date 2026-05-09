/// Chapter 8: Common Technical Mistakes
/// What most traders get wrong — and how to avoid it
class TechnicalMistakesContent {
  // Lesson 8.1: The 7 Deadly TA Mistakes
  static Map<String, dynamic> getSevenMistakesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Why 80% of TA Traders Lose Money',
          'emoji': '😱',
          'content':
              'Technical analysis WORKS — but most traders use it WRONG. The tool is powerful, but the operator makes mistakes. Here are the 7 most common errors that destroy trading accounts.',
        },
        {
          'type': 'concept',
          'title': 'The 7 Deadly TA Mistakes',
          'emoji': '💀',
          'content': '''
**1. Indicator Overload 📊📈📉🔄**
Using 10 indicators simultaneously. RSI, MACD, Stochastic, Bollinger, Ichimoku, Fibonacci, ATR...
Result: Conflicting signals = paralysis or confusion.
**Fix: Use 2-3 indicators maximum. One for trend, one for momentum, one for confirmation.**

**2. Ignoring the Higher Timeframe 🔍**
Trading 5-minute charts without checking the daily trend.
You see a "bullish pattern" on 5-min while the daily chart is screaming "BEARISH."
**Fix: Always check 1-2 timeframes above your trading timeframe.**

**3. Curve Fitting / Overfitting 📐**
Adjusting your strategy until it perfectly matches PAST data.
The strategy looks great in backtests but fails miserably in live trading.
**Fix: Keep strategies simple. If it needs 20 rules, it's overfitted.**

**4. Trading Every Pattern You See 👀**
Seeing patterns that don't exist ("pareidolia"). The chart looks like a Head & Shoulders if you squint...
**Fix: Only trade patterns that are OBVIOUS. If you have to force it, it isn't there.**

**5. No Stop Loss ("It'll Come Back") 🙏**
Hoping instead of managing. A 5% loss becomes 10%, then 20%, then 50%.
**Fix: Set stop loss BEFORE entry. Never remove it. Accept small losses.**

**6. Ignoring Volume 🔇**
A breakout on low volume is probably fake. A reversal pattern without volume is noise.
**Fix: Volume is the lie detector. No volume confirmation = no trade.**

**7. Confirmation Bias 🫣**
Seeing only signals that support your existing belief. You're bullish, so you ignore all bearish signals.
**Fix: Actively look for reasons why your trade SHOULD fail. If you can't find any, it's a better trade.**

---

**Key Insight:**
The biggest mistake isn't any single error — it's NOT HAVING A WRITTEN TRADING PLAN. Without a plan, every decision is made emotionally. With a plan, every decision is systematic.
''',
          'keyPoints': [
            'Use max 2-3 indicators — more isn\'t better, it\'s confusing',
            'Always check the higher timeframe before trading lower timeframes',
            'Only trade obvious patterns — if you have to squint, skip it',
            'Written trading plan eliminates emotional decision-making',
          ],
        },
        {
          'type': 'story',
          'title': 'Karthik\'s 10-Indicator Disaster',
          'emoji': '📉',
          'content': '''
**Karthik**, 30, a software developer, discovered technical analysis.

**Month 1: Learned RSI.**
"RSI is amazing! I'll use it for every trade." Won 6/10 trades. +₹12,000.

**Month 2: Added MACD.**
"MACD + RSI = unstoppable!" But sometimes they gave conflicting signals. Won 5/10. +₹5,000.

**Month 3: Added Bollinger Bands, Stochastic, Fibonacci, ADX, and Ichimoku.**
His chart looked like a rainbow explosion. Every time he wanted to buy:
• RSI said BUY ✅
• MACD said WAIT 🟡
• Stochastic said SELL ❌
• Bollinger said BUY ✅
• Ichimoku said SELL ❌
• Fibonacci said... he couldn't even read it anymore.

**Result: Analysis paralysis. Missed 15 good trades because he was waiting for ALL indicators to agree (which NEVER happens).**

**Month 4: 0 trades taken. 0 profit. ₹0.**

**The Fix:**
Karthik stripped down to 3 tools: 200 SMA (trend) + RSI (momentum) + Volume (confirmation).
He stopped waiting for perfection and started trading CLARITY.
Month 5: Won 7/10 trades. +₹22,000. His best month ever.

**Lesson:**
Simplicity beats complexity. Three clear signals beat ten confusing ones. The best traders have the cleanest charts.
''',
        },
        {
          'type': 'scenario',
          'title': 'Spot the Mistake',
          'situation':
              'Priya sees a "Bullish Engulfing" pattern on the 15-minute chart of Bank Nifty. RSI is at 45 (neutral). She doesn\'t check the daily chart (which shows a strong downtrend). She buys immediately. What mistakes did she make?',
          'choices': [
            {
              'text':
                  'No mistakes — Bullish Engulfing is a reliable buy signal',
              'isCorrect': false,
              'feedback':
                  '❌ Priya made multiple mistakes! (1) She traded a 15-min pattern against the daily downtrend. (2) RSI is neutral, not oversold — no momentum confirmation. (3) She didn\'t check volume. A Bullish Engulfing in a downtrend is often a trap.',
            },
            {
              'text':
                  'Mistakes: (1) Didn\'t check higher timeframe (daily downtrend), (2) No indicator confirmation (RSI neutral), (3) Traded against the trend',
              'isCorrect': true,
              'feedback':
                  '✅ You identified all three mistakes! Higher timeframe = downtrend (trade direction wrong). RSI = neutral (no oversold bounce signal). No volume check. A 15-min Engulfing against a daily downtrend is a low-probability trade.',
            },
            {
              'text': 'Only mistake was not using enough indicators',
              'isCorrect': false,
              'feedback':
                  '❌ More indicators wouldn\'t help — she already had price action and RSI. The real issue is CONTEXT: she ignored the higher timeframe trend. Even the best pattern in the world fails when traded against the dominant trend.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            '7 deadly mistakes: indicator overload, ignoring higher TF, overfitting, forcing patterns, no stops, ignoring volume, confirmation bias',
            'Simplicity wins — 2-3 clean indicators beat 10 confusing ones',
            'Always check the higher timeframe FIRST — trade with the bigger trend',
            'A written trading plan eliminates 90% of emotional mistakes',
            'Next: The final test — prove you\'re ready to apply TA in real markets.',
          ],
        },
      ],
    };
  }

  // Lesson 8.2: Final Challenge: TA Pro
  static Map<String, dynamic> getFinalChallengeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Final Test',
          'emoji': '🏆',
          'content':
              'You\'ve completed the entire Technical Analysis course — charts, patterns, indicators, entries, exits, and mistakes. This knowledge works across stocks, crypto, forex, and commodities. Let\'s see if you\'re TA-Ready.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Candlestick Patterns',
          'question':
              'After a long downtrend, a Hammer candlestick forms at a key support level. The next candle is a strong green candle with above-average volume. What\'s the signal?',
          'options': [
            'Continue selling — the downtrend will resume',
            'No signal — wait for 10 more candles',
            'Bullish reversal confirmed — Hammer at support + green confirmation + volume',
            'Sell on the green candle — it\'s a "bull trap"',
          ],
          'correctIndex': 2,
          'explanation':
              'This is a textbook bullish reversal with triple confluence: (1) Hammer at support = buying pressure emerging, (2) Green confirmation candle = buyers following through, (3) Above-average volume = institutions participating. This is one of the highest probability setups in TA.',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: Indicators',
          'question':
              'RSI on a stock is at 28 (oversold) while the stock is at a key support level. MACD shows a bullish crossover forming. What does this tell you?',
          'options': [
            'Nothing — indicators are useless',
            'Strong sell signal — RSI below 30 means the stock is weak',
            'Bullish confluence — oversold RSI + MACD crossover at support = potential reversal up',
            'Buy immediately without any stop loss — indicators guarantee profit',
          ],
          'correctIndex': 2,
          'explanation':
              'This is confluence: RSI oversold (momentum extreme) + MACD bullish crossover (momentum shifting) + support level (key location). Three signals aligning creates a high-probability buy setup. But always use a stop loss below support — indicators increase probability, they don\'t guarantee outcomes.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: Risk Management',
          'question':
              'You plan to buy a stock at ₹500. The nearest support is at ₹485. Using a 1:2 risk-reward ratio, what should your target be?',
          'options': [
            '₹507.50 (₹7.50 above entry)',
            '₹515 (₹15 risk × 2 = ₹30 reward)',
            '₹530 (₹15 risk × 2 = ₹30 reward, added to entry)',
            '₹570 (₹70 above entry)',
          ],
          'correctIndex': 2,
          'explanation':
              'Risk = Entry - Stop Loss = ₹500 - ₹485 = ₹15. With 1:2 R:R, reward must be 2 × ₹15 = ₹30. Target = Entry + Reward = ₹500 + ₹30 = ₹530. This means you risk ₹15 to make ₹30. Even if you\'re right only 40% of the time, you still make money with 1:2 R:R.',
        },
        {
          'type': 'scenario',
          'title': 'The Ultimate TA Scenario',
          'situation':
              'You see this setup: Weekly uptrend ✅. Daily chart at support ✅. Bullish Engulfing candle ✅. RSI at 33 (near oversold) ✅. Volume is 3x average ✅. But your friend says: "This stock has bad fundamentals — avoid it." What do you do?',
          'choices': [
            {
              'text':
                  'Skip the trade — fundamental analysis overrides technical analysis',
              'isCorrect': false,
              'feedback':
                  '❌ For SHORT-TERM trades, technical analysis can be more relevant than fundamentals. A stock can have poor fundamentals but still make a 10-15% bounce from oversold support. If your trading plan is TA-based, follow YOUR system.',
            },
            {
              'text':
                  'Take the trade — 5/5 TA confluence is extremely rare. Follow your system with proper stop loss. Exit if the setup fails.',
              'isCorrect': true,
              'feedback':
                  '✅ This is a 5/5 confluence setup — the highest probability in TA. Your system gave a clear signal. Take it with a tight stop loss below support. If it fails, you lose 1-2%. If it works, you gain 3-6%. The math is in your favor.',
            },
            {
              'text': 'Wait for fundamental confirmation before entering',
              'isCorrect': false,
              'feedback':
                  '❌ By the time fundamentals "confirm," the price will have already moved. TA-based entries work because they ACT on the signal. Waiting for FA confirmation means missing the move. Trade your system — either you\'re a TA trader or an FA trader. Don\'t mix mid-trade.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Congratulations! 🎉',
          'keyPoints': [
            'You can read candlestick charts and identify key patterns',
            'You understand support, resistance, trends, and breakouts',
            'You know how to use Moving Averages, RSI, MACD, and Bollinger Bands',
            'You can plan entries using confluence and exits using stops + targets + trailing',
            'You know the 7 deadly TA mistakes and how to avoid them',
            'Technical analysis is now a lifelong skill — applicable across every market 🌐',
          ],
        },
      ],
    };
  }
}
