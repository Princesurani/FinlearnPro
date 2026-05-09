/// Chapter 4: Backtesting Basics
/// Proving your strategy works on past data
class BacktestingBasicsContent {
  // Lesson 4.1: The Concept of Backtesting
  static Map<String, dynamic> getConceptOfBacktestingContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Time Machine',
          'emoji': '⏪',
          'content':
              'Before you risk money on a strategy, shouldn\'t you know if it actually worked in the past? Backtesting is the process of applying your trading rules to historical data to see if you have a mathematical edge.',
        },
        {
          'type': 'story',
          'title': 'Vikram\'s Untested Strategy',
          'emoji': '📉',
          'content': '''
**Vikram**, 30, a mechanical engineer in Chennai, decided to trade using a "Golden Cross" strategy he learned on YouTube.

**The strategy:** Buy when the 50-day moving average crosses above the 200-day moving average. Sell when it crosses below.

**Vikram's approach:**
"It makes perfect sense logically. I don't need to test it. I'll just start trading it."

He deposited ₹3,00,000 and followed the strategy for 6 months.

**The results:**
• 8 trades total
• 3 wins, 5 losses
• Win rate: 37.5%
• Net P&L: **-₹48,000**

**What Vikram didn't know:**
If he had backtested the Golden Cross on Nifty 50 over the last 5 years, he would have found:
• It works beautifully in **trending markets** (2020-2021 bull run)
• It gets **destroyed in sideways markets** (2022-2023 chop)
• His 6 months happened to be in a sideways phase

**The lesson:** Vikram paid ₹48,000 for information he could have gotten for FREE by scrolling through historical charts for one afternoon.
''',
        },
        {
          'type': 'concept',
          'title': 'Why We Backtest',
          'emoji': '📊',
          'content': '''
**The Goal of Backtesting:**
To answer one question: "If I took the last 100 setups exactly according to my rules, would I have made money?"

**What Backtesting Reveals:**
1. **Win Rate:** Out of 100 trades, how many hit the target vs the stop loss? (e.g., 45% win rate)
2. **Average R:R:** When you win, how much do you win compared to when you lose? (e.g., 1:2)
3. **Max Drawdown:** What was the longest losing streak? (e.g., 7 losses in a row)
4. **Expectancy:** The mathematical average profit per trade.

**The Psychology of Backtesting:**
When you hit a 5-trade losing streak in live trading, you will want to quit.
But if your backtest proves that 5-trade losing streaks happen normally, and the strategy STILL makes money over 100 trades, you will have the confidence to keep executing.

---

**Key Insight:**
A strategy is guilty until proven profitable. If you cannot prove it worked in the past, you have no business trading it in the present.
''',
          'keyPoints': [
            'Backtesting applies your rules to historical data to prove mathematical edge',
            'It reveals your Win Rate, Average R:R, and Max Drawdown',
            'Backtesting provides the psychological confidence to survive losing streaks',
            'A strategy is guilty until proven profitable over at least 100 past trades',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You backtest a swing trading strategy over 100 trades. Results: 42% win rate, average win ₹6,000, average loss ₹3,000. Is this strategy profitable?',
          'options': [
            'No — 42% win rate is terrible',
            'Yes — Expectancy = (0.42 × ₹6,000) - (0.58 × ₹3,000) = ₹2,520 - ₹1,740 = +₹780 per trade',
            'Cannot determine without more data',
            'Only if you trade Nifty stocks',
          ],
          'correctIndex': 1,
          'explanation':
              'This strategy is PROFITABLE despite losing 58% of the time! The 1:2 R:R (win ₹6K vs lose ₹3K) compensates for the lower win rate. Over 100 trades: +₹78,000. This is why backtesting is essential — you would never know this from intuition alone. Win rate alone is meaningless without R:R context.',
        },
        {
          'type': 'scenario',
          'title': 'The YouTube Strategy',
          'situation':
              'A popular trading YouTuber shares a "90% accurate" strategy using RSI and MACD. The video has 2 million views and thousands of positive comments. You want to use it immediately. What should you do FIRST?',
          'choices': [
            {
              'text':
                  '2 million views can\'t be wrong — start trading it today with real money',
              'isCorrect': false,
              'feedback':
                  '❌ Views and comments prove MARKETING skill, not trading skill. The YouTuber makes money from ads and courses, not from the strategy itself. "90% accuracy" is almost always cherry-picked from the best examples.',
            },
            {
              'text':
                  'Backtest it manually on 100+ historical setups on Nifty charts before risking a single rupee',
              'isCorrect': true,
              'feedback':
                  '✅ The only valid response. Apply the exact rules to 100+ past setups. If the backtest shows positive expectancy, paper trade it for 1 month. If that works, consider real money with tiny size. This process takes 2-3 weeks but can save you lakhs.',
            },
            {
              'text': 'Paper trade it for one day to see if it works',
              'isCorrect': false,
              'feedback':
                  '❌ One day is 1-3 trades. That is statistically meaningless. You need 100+ trade data points to determine if a strategy has a real edge or if results are just random noise.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Never trade an untested strategy with real money',
            'Vikram lost ₹48,000 on a strategy he could have tested for free',
            'Backtesting gives you the mathematical expectations of your system',
            '100 trades is the minimum sample size for a reliable backtest',
            'A 42% win rate CAN be profitable if R:R is favorable',
            'Next: How to actually perform a manual backtest step by step.',
          ],
        },
      ],
    };
  }

  // Lesson 4.2: Manual vs Automated Backtesting
  static Map<String, dynamic> getManualVsAutomatedContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Doing the Work',
          'emoji': '🛠️',
          'content':
              'There are two ways to backtest: writing code (automated) or scrolling through charts by hand (manual). For 99% of new traders, manual backtesting is actually superior. Here is why.',
        },
        {
          'type': 'interactive',
          'title': 'Manual vs Automated: The Comparison',
          'emoji': '⚔️',
          'content': '''
**Automated Backtesting (Coding):**
• ⚡ Speed: Test 10 years of data in seconds
• ❌ Requires Python/Pine Script coding skills
• ❌ "Curve fitting" trap: Tweak code until it perfectly matches past data, then fails live
• ❌ Misses visual context (chart patterns, volume spikes, news events)
• Best for: Experienced quant traders

**Manual Backtesting (Scrolling through charts):**
• 🐢 Speed: 100 trades takes 3-5 hours
• ✅ Zero coding required
• ✅ Builds deep screen time and pattern recognition
• ✅ You see HOW price behaves, not just IF the setup triggered
• ✅ You develop trader intuition that no algorithm can replicate
• Best for: EVERYONE, especially beginners

---

**Time Investment:**
• 100 trades × 2 minutes per trade = **~3.5 hours**
• One afternoon of work = potentially ₹Lakhs saved in prevented losses
• That is the best return on investment you will ever make
''',
        },
        {
          'type': 'concept',
          'title': 'The Manual Backtesting Method',
          'emoji': '👀',
          'content': '''
**Step-by-Step Manual Backtest:**

1. **Open a chart** (e.g., Nifty 15-min) on TradingView.
2. **Scroll back 6 months** in time.
3. **Use the "Replay" tool** to hide future candles.
4. **Step forward one candle at a time.**
5. **When your setup appears,** write it down in a spreadsheet: Date, Entry, Stop, Target.
6. **Step forward** until the trade hits the stop or target. Record the result.
7. **Repeat 100 times.**

**Your Backtesting Spreadsheet Columns:**
| # | Date | Entry ₹ | Stop ₹ | Target ₹ | Result | P&L ₹ | Notes |
|---|------|---------|--------|----------|--------|-------|-------|

---

**The "Cheating" Trap:**
When manual backtesting, your brain will try to cheat. You'll see a setup that failed and say, "Oh, I wouldn't have taken that one because the volume looked a bit low." **LIES.** You must be brutally honest. If it meets your rules, record it — win or loss.

---

**Key Insight:** If your strategy can't survive historical honesty, it won't survive live market reality.
''',
          'keyPoints': [
            'Manual backtesting builds deep intuition and chart-reading skills',
            'Use the "Replay" tool to hide future data while testing',
            'Be brutally honest — do not skip losing setups that meet your rules',
            'Track results in a spreadsheet with Date, Entry, Stop, Target, and P&L',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You are manually backtesting your strategy using historical charts. You see a perfect setup according to your rules. However, you can see the next few candles on the chart, and you know the trade immediately crashes and hits the stop loss. What do you record in your backtest journal?',
          'options': [
            'Skip it. It was obviously a trap.',
            'Record it as a loss. It met the rules. You must accept the statistical reality of the system.',
            'Adjust the rules slightly so this specific trade wouldn\'t trigger.',
            'Record it as a breakeven trade.',
          ],
          'correctIndex': 1,
          'explanation':
              'You MUST record it as a loss. If you filter out the losers in your backtest because you have the benefit of hindsight, your backtest will show a 90% win rate. When you trade live (without hindsight), the strategy will fail, and you won\'t understand why. Brutal honesty is the only way backtesting works.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 4 Complete! 🎉',
          'keyPoints': [
            'Backtesting proves if your strategy has a mathematical edge',
            'Manual backtesting builds screen time and deep market intuition',
            'Use the Bar Replay tool to simulate live trading conditions',
            'Track every trade in a spreadsheet with full details',
            'Brutal honesty is required — record every valid setup, especially the losers',
            'Next: Building the ultimate tool for professional traders — The Journal.',
          ],
        },
      ],
    };
  }
}
