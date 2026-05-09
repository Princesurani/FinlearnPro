/// Chapter 6: Strategy Selection Based on Time & Capital
class StrategySelectionContent {
  static Map<String, dynamic> getTimeCapitalContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Decision Matrix',
          'emoji': '🗺️',
          'content':
              'Stop asking "what is the best trading strategy?" Start asking "what strategy fits MY life?" Your available time and capital are not wishes — they are hard constraints that dictate your options.',
        },
        {
          'type': 'interactive',
          'title': 'The Strategy Selection Matrix',
          'emoji': '📊',
          'content': '''
**Find yourself in this matrix:**

| Your Time | Your Capital | Recommended Style |
|-----------|-------------|-------------------|
| Full-time (6+ hrs) | ₹5L+ | Intraday Trading |
| Full-time (6+ hrs) | ₹1-5L | Swing Trading (build capital first) |
| Part-time (1-2 hrs) | ₹2L+ | Swing Trading |
| Part-time (1-2 hrs) | Under ₹1L | Investing (SIP) + Paper Trade to learn |
| Very little (30 min/week) | Any amount | Long-term Investing (SIP + Index Fund) |

**The Capital Reality:**
• Under ₹1L: Active trading is not viable. Fees eat your profits. INVEST.
• ₹1-3L: Swing trading is possible with strict position sizing.
• ₹3-5L: Intraday becomes viable if you have the time.
• ₹5L+: You can choose any style based on your time and skill.

---

**Key Insight:**
80% of people should be investing. 15% should be swing trading. Only 5% have the combination of time, capital, skill, and temperament to day trade. Be honest about which bucket you fall into.
''',
        },
        {
          'type': 'concept',
          'title': 'The Time Value Equation',
          'emoji': '⏰',
          'content': '''
**Calculate your hourly return:**

**Scalper (Rohan):**
• Monthly profit: ₹15,000 (on a good month)
• Time spent: 130 hours/month (6.5 hrs/day × 20 days)
• Hourly rate: ₹115/hour
• His old IT job paid: ₹250/hour

**Swing Trader (Priya):**
• Monthly profit: ₹12,000
• Time spent: 10 hours/month (30 min/day × 20 days)
• Hourly rate: ₹1,200/hour
• She also earns her full ₹80,000/month salary

**Long-Term Investor (Meera):**
• Annual return: 12% on ₹5 Lakh = ₹60,000/year
• Time spent: 6 hours/year (monthly 30-min SIP reviews)
• Hourly rate: ₹10,000/hour
• She also earns her full salary and sleeps peacefully

---

**Key Insight:**
When you calculate return per HOUR, long-term investing and swing trading beat scalping and intraday almost every time. Don't just measure total profit — measure profit per unit of TIME and STRESS.
''',
          'keyPoints': [
            'Calculate your hourly return — not just total profit',
            'Swing trading often yields higher returns per hour than scalping',
            'Investing has the highest return-per-hour of any style',
            '80% should invest, 15% swing trade, only 5% should day trade',
          ],
        },
        {
          'type': 'story',
          'title': 'The Stress Premium',
          'emoji': '😓',
          'content': '''
**Vivek** was a swing trader making a peaceful ₹20,000 a month with 1 hour of evening work.
He saw a Twitter post of a scalper making ₹50,000 in one day and got jealous.

He decided to switch to scalping.
For the next 3 months, he stared at the screen for 6 hours a day. His blood pressure went up. He started arguing with his family because he was constantly stressed.

**The result:** He made ₹30,000 a month scalping (after brokerage).
Yes, he made ₹10,000 *more* per month.
But he spent 120 *more* hours a month to get it.
He traded 120 hours of his life and his mental peace for an extra ₹10,000 (that's ₹83 per hour).

**Key lesson:** Your trading style must match your temperament. If a strategy makes more money but destroys your mental health, it is a losing strategy. The "Stress Premium" is never worth it.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Amit has ₹75,000 saved, works 9-6, and can spare 30 minutes in the evening. What style should he use?',
          'options': [
            'Scalping on his phone during office breaks',
            'Intraday with leverage to make his small capital work harder',
            'Long-term investing via SIPs, while paper trading swing setups to learn',
            'Options buying on Telegram tips',
          ],
          'correctIndex': 2,
          'explanation':
              'With ₹75K (below the active trading threshold), limited time, and no experience, SIP investing is the safe path while he builds skills through paper trading. Scalping on a phone, leveraged intraday, or Telegram tips will all lead to losing his ₹75K.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Your time and capital are constraints, not wishes — they dictate your style',
            'Under ₹1L capital: INVEST. Don\'t try to actively trade.',
            'Calculate return per HOUR, not just total return',
            'Most people are best served by investing or swing trading',
            'Next: The hybrid approach — combining investing and trading intelligently.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getHybridApproachContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Best of Both Worlds',
          'emoji': '🔀',
          'content':
              'You don\'t have to choose just ONE style. Many successful traders use a hybrid: investing for wealth building and active trading for additional income. The key is keeping them in separate accounts with separate rules.',
        },
        {
          'type': 'concept',
          'title': 'The 80/20 Portfolio Split',
          'emoji': '📊',
          'content': '''
**The Professional Hybrid:**
• **80% of capital → Long-term investment account (SIPs, Index Funds, Blue Chips)**
  This is your wealth-building engine. You NEVER touch this for trading.
• **20% of capital → Active trading account (Swing or Intraday)**
  This is your "skill-building" capital. If you lose it, your financial life is unchanged.

**Example (₹5 Lakh total savings):**
• ₹4 Lakh → SIP in Nifty 50 Index Fund (₹20,000/month)
• ₹1 Lakh → Swing trading account with 1% risk per trade

**Why 80/20?**
If you lose the entire ₹1L trading account (worst case), your ₹4L investment portfolio continues compounding. Your financial future is still secure.

---

**Key Insight:**
Professional traders treat trading capital as RISK capital — money they can afford to lose. Their wealth is built through investing, not trading. Trading is the high-risk, high-skill side hustle.
''',
          'keyPoints': [
            '80% of capital in investments (SIPs, index funds) — never touched for trading',
            '20% in active trading — this is your risk capital',
            'If you lose the trading account, your financial life is unaffected',
            'Trading is a high-risk skill; investing is the wealth foundation',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Why should you keep investment and trading capital in SEPARATE accounts?',
          'options': [
            'For tax purposes only',
            'To prevent emotional trading decisions from affecting your long-term wealth',
            'Because brokers require it',
            'There is no real reason — it is just a suggestion',
          ],
          'correctIndex': 1,
          'explanation':
              'Separation prevents cross-contamination. When you have a bad trading day, the temptation is to dip into investment savings to "recover." Separate accounts make this physically harder and psychologically clearer. Your investment portfolio is off-limits.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 6 Complete! 🎉',
          'keyPoints': [
            'Use the 80/20 split: 80% investing, 20% active trading',
            'Keep them in SEPARATE accounts to prevent emotional crossover',
            'Your investments build wealth; your trading builds skill',
            'If trading fails, your financial future is still secure',
            'Next: The final truth — why copying someone else\'s strategy never works.',
          ],
        },
      ],
    };
  }
}
