/// Chapter 5: The Two Paths
/// Long-term investing vs short-term trading
class TheTwoPathsContent {
  // Lesson 1: The Long-Term Investor
  static Map<String, dynamic> getLongTermContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Power of Patience',
          'emoji': '🌳',
          'content':
              'What if you could turn ₹5,000/month into ₹1 Crore? No trading screens, no daily stress, no chart analysis. Just patience and consistency. That\'s the long-term investor\'s path.',
        },
        {
          'type': 'story',
          'title': 'Rakesh Jhunjhunwala\'s Titan Bet',
          'emoji': '👑',
          'content': '''
**Rakesh Jhunjhunwala** — India's Warren Buffett.

In **2002**, he bought Titan Company shares at ~₹5 per share.
Everyone thought he was crazy. "A watch company? Really?"

**He didn't day-trade. He didn't panic in crashes.**
He held through 2008 crash, 2020 COVID crash, everything.

**2023:** Titan reached ₹3,500 per share.
His ₹5 → ₹3,500. That's a **700x return!**

₹1 Lakh invested in 2002 = **₹7 CRORE** in 2023.

**What did he do differently?**
• He studied the company's business deeply.
• He believed in the brand's long-term potential.
• He NEVER sold during temporary market crashes.
• He let **compounding** do the work over 20 years.

**His famous quote:**
"Be greedy when others are fearful."
''',
        },
        {
          'type': 'concept',
          'title': 'The Investor\'s Playbook',
          'emoji': '📖',
          'content': '''
**Strategy: Buy & Hold**
Buy good companies. Hold for 5-20+ years. Let compounding grow your wealth.

**Tool 1: SIP (Systematic Investment Plan)**
Invest a fixed amount monthly regardless of price.
₹5,000/month in Nifty 50 Index Fund for 20 years at 12% return = **₹49.95 Lakhs** from just ₹12 Lakhs invested!

**Tool 2: Compounding**
Your returns earn returns. After Year 10, money grows exponentially.
Year 1: ₹1L → Year 10: ₹3.1L → Year 20: ₹9.6L → Year 30: ₹30L (at 12%).

**Tool 3: Dividend Reinvestment**
Instead of spending dividends, use them to buy more shares.
Over decades, this alone can double your returns.
''',
          'keyPoints': [
            'Buy & Hold = The simplest and most proven strategy',
            'SIP removes the need to "time" the market',
            'Compounding is exponential after 10+ years',
            'Time IN the market > Timing the market',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The SIP Calculator',
          'emoji': '📈',
          'content': '''
**₹10,000/month SIP at 12% annual return:**

**After 5 years:**
Invested: ₹6,00,000
Value: **₹8,24,867**
Gain: ₹2.2L (+37%)

**After 10 years:**
Invested: ₹12,00,000
Value: **₹23,23,391**
Gain: ₹11.2L (+93%)

**After 20 years:**
Invested: ₹24,00,000
Value: **₹99,91,479** (~₹1 Crore!)
Gain: ₹76L (+316%) 🔥

**After 30 years:**
Invested: ₹36,00,000
Value: **₹3,52,99,138** (₹3.5 Crore!)
Gain: ₹3.17 Cr (+880%) 🚀

**Notice:** The first 10 years gave ₹11L profit.
The next 10 years gave ₹77L profit.
**Compounding accelerates over time. Start early!**
''',
        },
        {
          'type': 'quiz',
          'title': 'Investor\'s Check',
          'question':
              'Why is SIP (Systematic Investment Plan) recommended for beginners?',
          'options': [
            'It guarantees profits every month',
            'It removes the need to time the market perfectly',
            'It\'s the fastest way to double your money',
            'SIP investments can never lose value',
          ],
          'correctIndex': 1,
          'explanation':
              'SIP invests a fixed amount monthly regardless of market conditions. When prices are high, you buy fewer units. When prices are low, you buy more. This "rupee cost averaging" removes the stress of timing.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Long-term investing is buying quality and holding for years',
            'SIP makes investing systematic and stress-free',
            'Compounding turns small amounts into crores over decades',
            'Patience is the most underrated skill in investing',
            'Start early — even ₹5,000/month can make you wealthy',
          ],
        },
      ],
    };
  }

  // Lesson 2: The Short-Term Trader
  static Map<String, dynamic> getShortTermContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Speed Has a Price',
          'emoji': '⚡',
          'content':
              'Intraday trading. Swing trading. Quick profits. It sounds exciting — and it is. But for every trader showing off profits, 9 others are hiding their losses. Let\'s understand the short-term trading world honestly.',
        },
        {
          'type': 'concept',
          'title': 'Types of Short-Term Trading',
          'emoji': '🏎️',
          'content': '''
**1. Scalping (Minutes)**
Buy and sell within seconds/minutes.
Target: ₹50-200 per trade.
**Risk:** Extremely high. Requires millisecond decisions.
**Who does it:** Professional algo traders. NOT for beginners.

**2. Intraday Trading (Hours)**
Buy and sell within the same day.
Target: 0.5-2% per trade.
**Risk:** Very high. Must exit by 3:15 PM, no exceptions.
**Who does it:** Full-time traders with screens and charts.

**3. Swing Trading (Days to Weeks)**
Hold for 2-15 days, riding short-term price "swings."
Target: 3-10% per trade.
**Risk:** Moderate to High. Overnight gaps can hurt.
**Who does it:** Part-time traders with some experience.

**4. Positional Trading (Weeks to Months)**
Hold for weeks/months based on medium-term trends.
Target: 10-30% per trade.
**Risk:** Moderate. Closest to investing with a shorter timeframe.
''',
          'keyPoints': [
            'Scalping = Seconds. Intraday = Hours. Swing = Days.',
            'Shorter the timeframe, higher the stress and risk',
            'Beginners should avoid scalping and intraday',
            'Swing and positional trading are more manageable',
          ],
        },
        {
          'type': 'story',
          'title': 'The Day Trader\'s Reality',
          'emoji': '📉',
          'content': '''
**Sanjay**, 30, quit his ₹80,000/month job to become a full-time day trader.

**Month 1:** Made ₹45,000. "This is easy!"
**Month 2:** Lost ₹62,000. "Bad luck. I'll recover."
**Month 3:** Made ₹30,000. "See, I'm back!"
**Month 4:** Lost ₹1,10,000. Biggest loss. Panic sets in.
**Month 5:** Made ₹15,000, but paid ₹8,000 in brokerage + taxes.
**Month 6:** Lost ₹55,000.

**6-Month Scorecard:**
Total P&L: **-₹1,37,000** (Net Loss)
Salary he gave up: **₹4,80,000** (6 months × ₹80K)
Real cost of day trading: **₹6,17,000** 😨

**What went wrong:**
• No formal training in technical analysis.
• Revenge trading after losses (betting bigger to "win back").
• Overtrading (15-20 trades/day instead of 2-3 quality ones).

**SEBI Data:** Only 1 in 10 intraday traders are profitable after costs.
''',
        },
        {
          'type': 'quiz',
          'title': 'Trading Reality',
          'question':
              'According to SEBI studies, what percentage of individual intraday traders in India make a loss?',
          'options': ['30%', '50%', '70%', '89%'],
          'correctIndex': 3,
          'explanation':
              'SEBI\'s 2023 study found that approximately 89% of individual intraday traders in India incurred losses. Only 11% were profitable, and of those, most made less than ₹1 Lakh/year after costs.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Short-term trading ranges from seconds (scalping) to months',
            '89% of intraday traders lose money (SEBI study)',
            'Brokerage and taxes eat into profits significantly',
            'Don\'t quit your job to day trade — most fail',
            'If you must trade, start with swing/positional, not intraday',
          ],
        },
      ],
    };
  }

  // Lesson 3: Which Path Suits You?
  static Map<String, dynamic> getFindStyleContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Know Yourself First',
          'emoji': '🪞',
          'content':
              'The right strategy depends on YOU — your time, risk tolerance, capital, and personality. There\'s no universal answer. Let\'s find your fit.',
        },
        {
          'type': 'interactive',
          'title': 'Self-Assessment',
          'emoji': '📝',
          'content': '''
**Answer honestly. Count your score:**

**Q1: How much time can you dedicate daily?**
A) 15 minutes (checking portfolio) → +1
B) 1-2 hours (research + monitoring) → +2
C) Full day (6+ hours staring at screens) → +3

**Q2: If your stock drops 20%, what do you do?**
A) Buy more shares (it's cheaper now!) → +1
B) Wait and watch for a few days → +2
C) Sell immediately to cut losses → +3

**Q3: What's your investment horizon?**
A) 5-20 years → +1
B) 1-6 months → +2
C) 1 day to 1 week → +3

**Q4: How much capital can you risk losing?**
A) Can't afford to lose any → +1
B) Can lose 10-20% → +2
C) Can lose 50%+ (high risk tolerance) → +3

**Your Score:**
4-6: Long-Term Investor 🌳
7-9: Swing/Positional Trader ⛵
10-12: Active/Intraday Trader ⚡
''',
        },
        {
          'type': 'concept',
          'title': 'The Honest Comparison',
          'emoji': '⚖️',
          'content': '''
**Long-Term Investing:**
✅ Works part-time (15 min/day)
✅ Lower stress, higher success rate
✅ Tax advantage (LTCG taxed at 10% vs 15% for STCG)
✅ No brokerage for delivery
❌ Requires patience (years for big returns)
❌ Boring (no excitement of daily profits)

**Short-Term Trading:**
✅ Potential for quick profits
✅ Exciting and engaging
✅ Works in both rising and falling markets
❌ 89% lose money (SEBI data)
❌ High stress, requires full-time attention
❌ Brokerage and taxes eat into profits
❌ Requires advanced technical skills
''',
          'keyPoints': [
            'Know your time availability, risk tolerance, and capital',
            'Investing = Part-time, lower risk, higher success rate',
            'Trading = Full-time job, higher risk, lower success rate',
            'Start with investing, learn trading later (if ever)',
          ],
        },
        {
          'type': 'scenario',
          'title': 'Choose Your Path',
          'situation':
              'You earn ₹60,000/month. After expenses, you can save ₹15,000. You have zero market experience. What\'s the smartest first step?',
          'choices': [
            {
              'text': 'Start intraday trading with ₹15,000',
              'isCorrect': false,
              'feedback':
                  '❌ With zero experience and limited capital, intraday trading is almost guaranteed to lose money. You\'ll burn through ₹15,000 in weeks learning expensive lessons.',
            },
            {
              'text':
                  'Start a ₹10,000 SIP in Nifty 50 Index Fund + ₹5,000 in liquid fund',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect! The SIP builds long-term wealth automatically. The liquid fund acts as an emergency buffer. No stress, no screens, no expertise needed. Learn more as your portfolio grows.',
            },
            {
              'text': 'Buy a trading course and start swing trading',
              'isCorrect': false,
              'feedback':
                  '⚡ Better than Option A, but still premature. Build your investing base first. Once you have ₹2-3 L invested and understand markets, THEN consider swing trading with a small portion.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Your strategy must match your time, risk, and capital',
            'Long-term investing has a far higher success rate',
            'Short-term trading is a full-time job with 89% failure rate',
            'Beginners should start with SIP investing, not trading',
            'You can explore trading later with a small % of your portfolio',
            'The best approach: Invest 80-90% + Trade 10-20% (optional)',
          ],
        },
      ],
    };
  }
}
