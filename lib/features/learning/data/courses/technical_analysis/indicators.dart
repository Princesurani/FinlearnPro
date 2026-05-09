/// Chapter 6: Indicators
/// Moving Averages, RSI, MACD, and Bollinger Bands
class IndicatorsContent {
  // Lesson 6.1: Moving Averages
  static Map<String, dynamic> getMovingAveragesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Smoothing the Noise',
          'emoji': '〰️',
          'content':
              'Price charts are noisy. Is that dip a buying opportunity or the start of a crash? Moving averages smooth out the noise and reveal the true trend. They\'re the most widely used indicators in the world.',
        },
        {
          'type': 'concept',
          'title': 'SMA vs EMA',
          'emoji': '📊',
          'content': '''
**Simple Moving Average (SMA):**
Average of the last N closing prices.
• 20-day SMA = average of last 20 closes
• Gives equal weight to all 20 days
• Smoother, slower to react to new price changes

**Exponential Moving Average (EMA):**
Same concept but gives MORE weight to recent prices.
• 20-day EMA reacts faster to current price than 20-day SMA
• Better for short-term trading and catching trend changes early
• Most professionals prefer EMA for entries

---

**The Key Moving Averages Every Trader Watches:**
• **9 EMA / 20 EMA:** Short-term trend. Day traders and scalpers.
• **50 SMA / 50 EMA:** Medium-term trend. Swing traders.
• **200 SMA:** Long-term trend. Investors and fund managers.

**The 200 SMA Rule:**
• Price ABOVE 200 SMA = Long-term uptrend → Favor buying
• Price BELOW 200 SMA = Long-term downtrend → Favor selling or avoiding

---

**Golden Cross & Death Cross:**
• **Golden Cross:** 50 SMA crosses ABOVE 200 SMA = Major bullish signal
• **Death Cross:** 50 SMA crosses BELOW 200 SMA = Major bearish signal
• These are watched by EVERY major institution globally

---

**Key Insight:**
The 200-day SMA is the single most important indicator in all of technical analysis. When Nifty is above its 200 SMA, it's been profitable to buy dips 78% of the time. Below it? Only 35%. This ONE indicator transforms your probability of success.
''',
          'keyPoints': [
            'SMA = equal weight to all periods; EMA = more weight to recent prices',
            '200 SMA is the most important indicator — above it = bullish, below = bearish',
            'Golden Cross (50 above 200) = bullish; Death Cross = bearish',
            'Use shorter MAs (9/20) for entries, longer MAs (50/200) for trend direction',
          ],
        },
        {
          'type': 'story',
          'title': 'The 200 SMA Shield',
          'emoji': '🛡️',
          'content': '''
**2008 Financial Crisis:**
Nifty started the year at 6,200.
By January 21, it crossed BELOW the 200-day Simple Moving Average (SMA).
The "smart money" sold their positions and went to cash.

**Retail investors kept buying:**
"It's down 10%, what a bargain!"
"It's down 20%, it has to bounce!"

Nifty continued falling... and falling... until it hit 2,500. A massive 60% crash.
Retail investors were wiped out. The smart money survived because they had one simple rule: **"I do not buy when the price is below the 200 SMA."**

**May 2009:**
Nifty finally crossed back ABOVE the 200 SMA. The smart money bought back in and rode the massive 10-year bull market that followed.

**Key lesson:** The 200 SMA is your shield against catastrophic market crashes. You don't need to predict crashes; you just need to obey the 200 SMA.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Nifty is trading above its 200-day SMA and the 50-day SMA just crossed above the 200-day SMA. What\'s this signal called and what does it indicate?',
          'options': [
            'Death Cross — sell everything immediately',
            'Golden Cross — a major bullish signal indicating a new uptrend is likely',
            'Spinning Top — indecision in the market',
            'Double Top — bearish reversal signal',
          ],
          'correctIndex': 1,
          'explanation':
              'When the 50-day SMA crosses ABOVE the 200-day SMA, it\'s called a Golden Cross — one of the most bullish signals in technical analysis. It indicates that short-term momentum has turned positive and aligns with the long-term uptrend. Historically, Golden Crosses in Nifty have led to significant rallies.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Moving averages smooth price noise and reveal the true trend',
            'EMA reacts faster than SMA — better for short-term trading',
            '200 SMA is the line between bull market (above) and bear market (below)',
            'Golden Cross = major buy signal; Death Cross = major sell signal',
            'Next: RSI and MACD — momentum indicators that time reversals.',
          ],
        },
      ],
    };
  }

  // Lesson 6.2: RSI & MACD
  static Map<String, dynamic> getRsiMacdContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Measuring Momentum',
          'emoji': '⚡',
          'content':
              'Moving averages tell you WHERE the trend is. RSI and MACD tell you HOW STRONG the trend is — and when it\'s about to run out of steam. These momentum indicators help you avoid buying at the top and selling at the bottom.',
        },
        {
          'type': 'concept',
          'title': 'RSI (Relative Strength Index)',
          'emoji': '📈',
          'content': '''
**What is RSI?**
A momentum oscillator that measures the speed and magnitude of price changes.
Ranges from 0 to 100.

**Key Levels:**
• **RSI > 70 = Overbought** 🔴 Price has risen too fast. Potential pullback/reversal.
• **RSI < 30 = Oversold** 🟢 Price has fallen too fast. Potential bounce/reversal.
• **RSI 40-60 = Neutral zone.** No extreme.

**How to Use RSI:**
• **Buy signal:** RSI drops below 30 (oversold) then rises back above 30
• **Sell signal:** RSI rises above 70 (overbought) then falls back below 70

**RSI Divergence (The Power Move):**
• **Bullish divergence:** Price makes a LOWER LOW but RSI makes a HIGHER LOW
  → Price is falling but momentum is weakening → Reversal up likely
• **Bearish divergence:** Price makes a HIGHER HIGH but RSI makes a LOWER HIGH
  → Price is rising but momentum is fading → Reversal down likely

---

**Key Insight:**
RSI divergence is one of the most reliable signals in TA. When price and RSI disagree, RSI is usually right. Watch for divergence at key S/R levels for the highest probability trades.
''',
          'keyPoints': [
            'RSI > 70 = overbought (potential sell); RSI < 30 = oversold (potential buy)',
            'RSI divergence is one of the most reliable reversal signals',
            'When price and RSI disagree, RSI is usually right about the next move',
            'RSI works best at key support/resistance levels — not in isolation',
          ],
        },
        {
          'type': 'interactive',
          'title': 'MACD (Moving Average Convergence Divergence)',
          'emoji': '📊',
          'content': '''
**What is MACD?**
Tracks the relationship between two EMAs (usually 12 and 26 period).

**MACD Components:**
• **MACD Line:** 12 EMA - 26 EMA
• **Signal Line:** 9 EMA of the MACD Line
• **Histogram:** MACD Line - Signal Line (shows momentum visually)

**How to Read MACD:**

**1. Crossovers (Entry/Exit Signals):**
• MACD crosses ABOVE Signal Line = **Bullish** → BUY signal
• MACD crosses BELOW Signal Line = **Bearish** → SELL signal

**2. Zero Line Cross:**
• MACD crosses above zero = Uptrend confirmed
• MACD crosses below zero = Downtrend confirmed

**3. Histogram:**
• Growing green bars = Bullish momentum increasing
• Shrinking green bars = Bullish momentum fading (warning)
• Growing red bars = Bearish momentum increasing
• Shrinking red bars = Bearish momentum fading (hope)

**4. MACD Divergence:**
Same concept as RSI divergence:
• Price Higher High + MACD Lower High = Bearish divergence
• Price Lower Low + MACD Higher Low = Bullish divergence

**Key Lesson:**
RSI tells you IF momentum is extreme. MACD tells you WHEN momentum is shifting. Use RSI for overbought/oversold zones and MACD for crossover entry signals.
''',
        },
        {
          'type': 'quiz',
          'title': 'Divergence Check',
          'question':
              'Reliance makes a new 52-week high at ₹3,000. However, the RSI peaks at 60, whereas during the previous high (₹2,900), RSI was at 80. What is this phenomenon called and what does it signal?',
          'options': [
            'Bullish Divergence — signals price will go even higher',
            'Bearish Divergence — signals momentum is fading despite higher prices, potential reversal down',
            'Golden Cross — strong buy signal',
            'Neutral alignment — no signal',
          ],
          'correctIndex': 1,
          'explanation':
              'This is classic Bearish Divergence. Price made a Higher High (₹2,900 → ₹3,000), but RSI made a Lower High (80 → 60). This means the stock is still going up, but the buying power (momentum) behind the move is exhausted. It\'s a strong warning of a potential trend reversal or pullback.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'RSI measures momentum extremes (overbought > 70, oversold < 30)',
            'MACD tracks momentum shifts through crossovers of fast and slow EMAs',
            'Divergence between price and RSI/MACD is the most reliable reversal signal',
            'RSI = "are we at extremes?"; MACD = "is momentum shifting?"',
            'Next: Bollinger Bands and volume — volatility and confirmation.',
          ],
        },
      ],
    };
  }

  // Lesson 6.3: Bollinger Bands & Volume
  static Map<String, dynamic> getBollingerVolumeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Squeeze and the Surge',
          'emoji': '📏',
          'content':
              'Bollinger Bands measure volatility. When bands squeeze tight, an explosive move is coming. Volume confirms whether that move is real. Together, they\'re the ultimate confirmation duo.',
        },
        {
          'type': 'concept',
          'title': 'Bollinger Bands & Volume Explained',
          'emoji': '📊',
          'content': '''
**Bollinger Bands (BB):**
Three lines around price:
• **Middle Band:** 20-day SMA
• **Upper Band:** 20 SMA + 2 Standard Deviations
• **Lower Band:** 20 SMA - 2 Standard Deviations

**How to Read Bollinger Bands:**
• **Price near Upper Band:** Potentially overbought (but CAN stay here in strong trends)
• **Price near Lower Band:** Potentially oversold
• **Bands SQUEEZE (narrow):** Low volatility → Big move coming (direction unknown)
• **Bands EXPAND (widen):** High volatility → Move is happening

**The Bollinger Squeeze Strategy:**
1. Wait for bands to squeeze tightly (low volatility)
2. A breakout above the upper band = bullish move beginning
3. A breakdown below the lower band = bearish move beginning
4. Confirm with volume!

---

**Volume — The Truth Indicator:**
Volume = number of shares/contracts traded.

**Volume Rules:**
• **Rising price + Rising volume** = Healthy trend → Continue trading the trend ✅
• **Rising price + Falling volume** = Weak rally → Trend may reverse soon ⚠️
• **Breakout + High volume** = Real breakout → Trade it! ✅
• **Breakout + Low volume** = Fake breakout → Avoid! ❌

---

**Key Insight:**
Price tells you WHAT happened. Volume tells you WHO participated. A move on high volume means institutions are involved (real move). A move on low volume means only retail traders are playing (likely to reverse).
''',
          'keyPoints': [
            'Bollinger Bands measure volatility — squeeze = big move coming',
            'Volume confirms moves — high volume = real; low volume = fake',
            'Rising price + falling volume = warning that the rally is weakening',
            'Breakouts with 2-3x average volume are the most reliable signals',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Bollinger Bands have been squeezing for 2 weeks. Today, price breaks above the upper band with 3x average volume. What\'s the signal?',
          'options': [
            'Sell — price is overbought above the upper band',
            'Bullish breakout confirmed — the squeeze has resolved upward with volume confirmation',
            'Ignore — Bollinger Bands are unreliable',
            'Wait 2 more weeks before acting',
          ],
          'correctIndex': 1,
          'explanation':
              'The Bollinger Squeeze is one of the most reliable setups in TA. When bands squeeze (low volatility), a big move is being "loaded." The breakout direction + high volume confirms it\'s a real move. This setup has been used profitably by traders for decades.',
        },
        {
          'type': 'story',
          'title': 'The Fake Breakout',
          'emoji': '👻',
          'content': '''
**Neha** was watching an ascending triangle on an IT stock.
At 1:00 PM, the stock broke above resistance.
"Breakout!" Neha thought, immediately buying 500 shares.

But she didn't check the volume at the bottom of her chart.
The breakout happened on **very low volume** — much lower than the 20-day average.

**What was actually happening:**
Large institutions weren't buying. A few retail traders had pushed the price up during the lunch hour when trading is thin. The "smart money" used this temporary pop to sell their existing shares into the retail buying.

**1:30 PM:** The real volume returned. Massive red bars. The stock crashed back below resistance, triggering Neha's stop loss. It was a "Bull Trap" (Fake Breakout).

**Key lesson:** Price breaks resistance, but Volume confirms if the break is real. Never trade a breakout without seeing a massive spike in volume. If volume is low, it's a trap.
''',
        },
        {
          'type': 'summary',
          'title': 'Chapter 6 Complete! 🎉',
          'keyPoints': [
            'Moving averages reveal trend direction; RSI/MACD measure momentum',
            'Bollinger Bands measure volatility — squeeze predicts explosive moves',
            'Volume is the ultimate confirmation tool — high volume = real move',
            'Don\'t use indicators in isolation — combine 2-3 for confluent signals',
            'Golden stack: Trend (MA) + Momentum (RSI/MACD) + Volatility (BB) + Confirmation (Volume)',
            'Next: Putting it all together — planning entries and exits like a professional.',
          ],
        },
      ],
    };
  }
}
