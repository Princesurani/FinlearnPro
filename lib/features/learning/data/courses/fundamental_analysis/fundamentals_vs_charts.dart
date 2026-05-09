/// Chapter 7: When Fundamentals Matter More Than Charts
/// Combining FA with TA and final challenge
class FundamentalsVsChartsContent {
  // Lesson 7.1: FA vs TA: When to Use Which
  static Map<String, dynamic> getFaVsTaContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Right Tool for the Right Job',
          'emoji': '🧰',
          'content':
              'Fundamental analysis and technical analysis are not enemies — they\'re teammates. Knowing WHEN to lean on which approach is the skill that separates average traders from exceptional ones.',
        },
        {
          'type': 'concept',
          'title': 'When FA Wins vs When TA Wins',
          'emoji': '⚖️',
          'content': '''
**Fundamentals Matter MORE When:**

**1. Long-Term Investing (1+ years) 📈**
Over years, stock prices ALWAYS converge to fundamental value.
Short-term: Noise. Long-term: Value wins.
Example: Buying TCS at any point in 2010 was profitable by 2024 because the business grew massively.

**2. Macro Shocks 🌍**
During COVID, Ukraine, or RBI surprises, fundamentals drive entire sectors.
No chart pattern predicted COVID. But understanding economic impact helped investors rebalance.

**3. Earnings Season 📊**
A company beating estimates by 20% will rally regardless of what the chart says.
Fundamentals create the CATALYST; charts just show the reaction.

**4. Valuation Extremes 💎**
When a great company trades at P/E 5 (incredibly cheap), fundamentals scream BUY.
Charts might look bad (it's fallen), but the value is undeniable.

---

**Technical Analysis Wins When:**

**1. Short-Term Trading (minutes to weeks) ⚡**
Over hours and days, emotions drive price more than fundamentals.
TA reads emotions (fear, greed) through price patterns.

**2. Timing Entries & Exits ⏱️**
FA says "buy HDFC Bank." But when? TA says: "at ₹1,550 support, when RSI is oversold."
TA gives the WHEN that FA can't provide.

**3. Purely Speculative Assets 🎰**
Meme coins, penny stocks, and hype-driven assets have NO fundamentals.
TA is the ONLY tool that works here (and even it's unreliable).

**4. Momentum Markets 🚀**
In strong trending markets, momentum matters more than value.
TA captures momentum; FA can't measure sentiment.

---

**The Golden Rule:**
FA tells you WHAT to buy. TA tells you WHEN to buy.
Use FA for selection. Use TA for timing.
This combination is how the world's best hedge funds operate.
''',
          'keyPoints': [
            'FA wins for: long-term investing, macro shocks, earnings, extreme valuations',
            'TA wins for: short-term trading, entry timing, speculative assets, momentum',
            'FA = WHAT to buy; TA = WHEN to buy — use both together',
            'Over long periods, price ALWAYS converges to fundamental value',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Decision Matrix: FA or TA?',
          'emoji': '📋',
          'content': '''
**Situation → Which Tool?**

**"I want to invest ₹5L for 5+ years for retirement"**
→ FA dominant (80%). TA for entry timing (20%).
→ Evaluate fundamentals deeply. Use TA to find a good entry price.

**"I want to day-trade Bank Nifty options"**
→ TA dominant (90%). FA minimal (10%).
→ Use charts, patterns, and momentum. Check macro only for event risk.

**"RBI policy decision is tomorrow"**
→ FA dominant (70%). TA for levels (30%).
→ Understand what RBI will likely do and sector impact. Use TA for key S/R levels.

**"My friend said buy this meme coin"**
→ TA only (if you must trade). FA = non-existent for meme coins.
→ Better yet: don't trade meme coins at all.

**"I see a stock at 52-week low with strong financials"**
→ FA + TA combined (50/50).
→ FA confirms it's fundamentally strong. TA checks if the decline is stabilizing (Hammer, RSI oversold at support).

**Key Lesson:**
There is no "better" approach. The best approach depends on your TIME HORIZON, the ASSET CLASS, and the MARKET CONDITION. Flexibility is the mark of a mature investor.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Final FA Decision',
          'situation':
              'A strong company (20% ROE, P/E 12, zero debt, market leader) has fallen 35% from its highs due to a sector-wide correction. The daily chart looks bearish (downtrend, below 200 SMA). An RSI divergence is forming at a major support level. What do you do?',
          'choices': [
            {
              'text':
                  'Avoid — the chart is bearish, below 200 SMA means downtrend',
              'isCorrect': false,
              'feedback':
                  '❌ You\'re ignoring exceptional fundamentals. A company with 20% ROE, P/E 12, and zero debt trading 35% below highs is fundamentally undervalued. The chart is bearish because of SECTOR weakness, not company weakness. RSI divergence at support suggests the selling is exhausting.',
            },
            {
              'text':
                  'Start building a position (FA confirms value) but wait for TA confirmation (RSI divergence + green candle) before committing fully',
              'isCorrect': true,
              'feedback':
                  '✅ The perfect FA+TA combination! FA says: "This company is worth much more than the current price." TA says: "Wait for a confirmed reversal signal before going all in." You might start with 30% of your planned position now and add the remaining 70% once TA confirms a bottom.',
            },
            {
              'text':
                  'Buy the maximum amount immediately — fundamentals are too good to wait',
              'isCorrect': false,
              'feedback':
                  '❌ Strong fundamentals don\'t mean the bottom is in. "Catching a falling knife" can lead to short-term losses of another 10-20% even on great companies. Use TA to time your entry — let the chart confirm that sellers are exhausted before committing your capital.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'FA for selection (WHAT), TA for timing (WHEN) — professionals use both',
            'Long-term investing favors FA; short-term trading favors TA',
            'Over years, price always converges to fundamental value',
            'The best entries combine fundamental value with technical confirmation',
            'Flexibility is key — the right tool depends on time horizon and situation',
          ],
        },
      ],
    };
  }

  // Lesson 7.2: Final Challenge: FA Pro
  static Map<String, dynamic> getFinalChallengeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Final Test',
          'emoji': '🏆',
          'content':
              'You\'ve mastered Fundamental Analysis — from Price vs Value to financial statements, economic indicators, crypto tokenomics, and combining FA with TA. Let\'s see if you can call yourself FA-Ready.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Price vs Value',
          'question':
              'Stock A costs ₹50/share with a P/E of 150 and declining revenue. Stock B costs ₹3,000/share with a P/E of 15 and 25% revenue growth. Which is CHEAPER for an investor?',
          'options': [
            'Stock A — it\'s only ₹50',
            'Stock B — P/E 15 with 25% growth makes it fundamentally cheaper despite the higher share price',
            'Both are the same — price doesn\'t matter',
            'Impossible to determine',
          ],
          'correctIndex': 1,
          'explanation':
              'Stock B at P/E 15 means you pay ₹15 for every ₹1 of earnings, and those earnings are growing 25%/year. Stock A at P/E 150 means you pay ₹150 for every ₹1 of declining earnings. Stock B is fundamentally 10x cheaper. Share price (₹50 vs ₹3,000) is completely irrelevant to "cheapness."',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: Financial Statements',
          'question':
              'A company shows ₹800 Cr net profit but has Debt-to-Equity of 3.5 and negative operating cash flow. A strong company shows ₹400 Cr profit with D/E of 0.3 and strong positive cash flow. Which is SAFER to invest in?',
          'options': [
            'Company 1 — higher profit means better company',
            'Company 2 — lower debt, positive cash flow makes it fundamentally safer despite lower profit',
            'Both are equally safe',
            'Neither — you need P/E ratios to decide',
          ],
          'correctIndex': 1,
          'explanation':
              'Company 1\'s high profit is built on a mountain of debt (D/E 3.5) and isn\'t generating real cash (negative cash flow). This is a house of cards. Company 2 earns less but is genuinely profitable (positive cash flow) and financially healthy (low debt). In a downturn, Company 1 risks bankruptcy while Company 2 survives.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: Macro Economics',
          'question':
              'RBI announces a surprise 50 bps rate CUT. Which sector is MOST LIKELY to benefit immediately?',
          'options': [
            'IT sector — rate cuts help tech companies',
            'Pharma — rate cuts help drug companies',
            'Real Estate & Auto — rate cuts reduce EMIs, boosting housing and car demand',
            'Mining — rate cuts increase commodity demand',
          ],
          'correctIndex': 2,
          'explanation':
              'Real estate and auto are the most "rate-sensitive" sectors. When RBI cuts rates, banks lower home loan and car loan rates. Lower EMIs → More people can afford homes and cars → Demand surges → Real estate and auto companies benefit. IT and pharma are relatively insensitive to domestic interest rates.',
        },
        {
          'type': 'scenario',
          'title': 'The Ultimate FA Scenario',
          'situation':
              'You\'ve identified a fundamentally strong stock (P/E 10, ROE 25%, zero debt, market leader). It\'s at a 52-week low. Your friend says: "If it was good, it wouldn\'t be falling." Your chart shows RSI oversold at a 3-year support level. What\'s your conclusion?',
          'choices': [
            {
              'text':
                  'Your friend is right — if the market is selling, there must be a reason',
              'isCorrect': false,
              'feedback':
                  '❌ Markets are driven by emotions in the short term. Sector rotations, fund redemptions, and global risk-off can cause great companies to fall. Warren Buffett\'s best purchases were stocks that "everyone was selling." The market is a voting machine short-term, but a weighing machine long-term.',
            },
            {
              'text':
                  'Strong FA (undervalued, quality business) + TA confirmation (RSI oversold at 3-year support) = high-probability buying opportunity. Start building a position.',
              'isCorrect': true,
              'feedback':
                  '✅ This is the synthesis of the entire course! FA confirms value (P/E 10, ROE 25%, zero debt). TA provides timing (RSI oversold at major support). The combination creates a high-probability setup. Start with a partial position and add on confirmation.',
            },
            {
              'text':
                  'Wait until the stock recovers to its high, then buy for safety',
              'isCorrect': false,
              'feedback':
                  '❌ Buying at highs when the stock has "recovered" means you pay a premium. You\'d buy at P/E 20+ instead of P/E 10. The best time to buy quality is when it\'s on sale — that\'s now. "Buy when others are fearful, sell when others are greedy." — Warren Buffett',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Congratulations! 🎉',
          'keyPoints': [
            'You understand the difference between price and value — the foundation of all investing',
            'You can read financial statements and calculate key ratios (P/E, ROE, D/E)',
            'You understand how GDP, inflation, and RBI policy move markets',
            'You can evaluate crypto projects using use-case and tokenomics analysis',
            'You know when to lean on FA vs TA — and how to combine them for best results',
            'Fundamental analysis is now your compass for navigating all markets 🧭',
          ],
        },
      ],
    };
  }
}
