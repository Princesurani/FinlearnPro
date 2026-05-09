/// Chapter 5: Long-Term Investing
class LongTermInvestingContent {
  static Map<String, dynamic> getCompoundingContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Eighth Wonder of the World',
          'emoji': '🌳',
          'content':
              'Albert Einstein reportedly called compound interest "the eighth wonder of the world." Whether he actually said it or not, the math is real: small, consistent investments grow exponentially over time. This is how generational wealth is built.',
        },
        {
          'type': 'interactive',
          'title': 'The Power of Time',
          'emoji': '📈',
          'content': '''
**₹5,000/month SIP in Nifty 50 Index Fund (12% avg annual return):**

| Time Period | Total Invested | Portfolio Value | Profit |
|------------|---------------|-----------------|--------|
| 5 years | ₹3,00,000 | ₹4,12,000 | ₹1,12,000 |
| 10 years | ₹6,00,000 | ₹11,62,000 | ₹5,62,000 |
| 20 years | ₹12,00,000 | ₹49,96,000 | ₹37,96,000 |
| 30 years | ₹18,00,000 | ₹1,76,50,000 | **₹1,58,50,000** |

**You invested ₹18 Lakh over 30 years. It became ₹1.76 CRORE.**
The profit (₹1.58 Crore) is almost 9x your total investment.
That is compounding.

---

**The Tragic Comparison:**
If Raj had taken the same ₹18 Lakh and tried day trading over 30 years, SEBI data suggests he would have lost 70-90% of it.

**Key Insight:**
The most boring investment strategy (SIPs in index funds) beats 93% of active traders over a 10+ year period. Boring is beautiful.
''',
        },
        {
          'type': 'concept',
          'title': 'Why Time Beats Timing',
          'emoji': '⏰',
          'content': '''
**"Time in the market beats timing the market."**

If you invested ₹1 Lakh in the Nifty 50 on January 1, 2003:
• Held for 20 years (through 2008 crash, COVID crash, etc.): **₹16+ Lakh**
• But if you tried to "time" the market and missed just the BEST 10 days in those 20 years: **Only ₹5 Lakh**

Missing just 10 best days out of ~5,000 trading days reduced your return by 70%.

**Why?**
The best days often come RIGHT AFTER the worst days (crash recoveries). If you panic-sold during a crash and were "out" of the market, you missed the recovery rally.

---

**Key Insight:**
Nobody can consistently predict the best and worst days. The solution? Stay invested ALWAYS. Buy consistently (SIP). Let compounding work.
''',
          'keyPoints': [
            '₹5,000/month SIP for 30 years at 12% = ₹1.76 Crore from ₹18L invested',
            'Missing just 10 best days in 20 years reduces returns by 70%',
            'Time in the market always beats timing the market',
            'Consistent investing through crashes is the key to compound growth',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'The market crashes 30%. Your SIP is running. What should you do?',
          'options': [
            'Stop the SIP immediately to avoid more losses',
            'Sell all holdings before it drops further',
            'Continue the SIP — you are buying MORE units at CHEAPER prices. This is a discount sale.',
            'Switch to gold until the market recovers',
          ],
          'correctIndex': 2,
          'explanation':
              'A crash is a SALE for long-term investors. Your SIP buys more units when prices are low. When the market eventually recovers (and it always has), those cheap units generate massive returns. Stopping your SIP during a crash is the worst mistake a long-term investor can make.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Compound interest turns small consistent investments into crores',
            'Time in the market beats timing the market — always',
            'Continue SIPs through crashes to buy cheap units',
            'This "boring" strategy beats 93% of active traders over 10+ years',
            'Next: SIPs and Index Funds — the lazy genius strategy.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getSipIndexContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Lazy Genius',
          'emoji': '🧠',
          'content':
              'What if you could beat 90% of professional fund managers with zero effort? It sounds impossible, but it is statistically true. Index funds + SIPs is the strategy that most financial experts use for their OWN money.',
        },
        {
          'type': 'concept',
          'title': 'SIPs & Index Funds Explained',
          'emoji': '📊',
          'content': '''
**SIP (Systematic Investment Plan):**
Investing a fixed amount (₹500, ₹5,000, ₹50,000) every month automatically.
• Your bank auto-debits the amount on a fixed date
• You buy regardless of market conditions (high or low)
• This is called "Rupee Cost Averaging" — it smooths out your buying price

**Index Fund:**
A fund that simply mirrors an index (like Nifty 50).
• It doesn't try to "beat" the market. It IS the market.
• Extremely low fees (0.1-0.3% expense ratio vs. 1-2% for active funds)
• No fund manager making emotional decisions

**Why This Combination Wins:**
SPIVA India data shows that over a 10-year period, **85% of active mutual fund managers FAIL to beat the Nifty 50 index**. If the experts can't beat it, why not just own it?

---

**Key Insight:**
The best investment strategy for 80% of people: Set up a ₹5,000-₹10,000 monthly SIP in a Nifty 50 Index Fund, and DO NOTHING for 20 years. That's it. That's the whole strategy.
''',
          'keyPoints': [
            'SIP = fixed monthly investment that auto-buys regardless of market level',
            'Index Funds mirror the market at extremely low fees',
            '85% of professional fund managers fail to beat the Nifty 50 index over 10 years',
            'SIP + Index Fund = the proven lazy genius strategy',
          ],
        },
        {
          'type': 'story',
          'title': 'The Tale of Two Brothers',
          'emoji': '👬',
          'content': '''
**Arun and Tarun** both started with ₹10 Lakh at age 30.

**Arun (The Active Trader):**
He spent 4 hours a day analyzing charts, watching news, and buying "hot" stocks.
He made 20% one year, lost 15% the next. He paid huge brokerage fees and STT.
After 20 years, his portfolio grew to ₹35 Lakh. He felt proud of his "trading skills."

**Tarun (The Lazy Genius):**
He put his ₹10 Lakh into a Nifty 50 Index Fund.
He spent 0 hours a day analyzing charts. He focused entirely on his career, got promotions, and enjoyed his weekends.
After 20 years, compounding at 12%, his portfolio grew to ₹96 Lakh.

**The Reality:** Tarun made 3x more money than Arun while doing absolutely zero work.

**Key lesson:** Unless you are going to treat trading as a professional full-time job (top 5%), the most profitable strategy is almost always the most boring one: Index Funds + Time.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Uncle\'s Advice',
          'situation':
              'Your uncle says: "Index funds are boring! My friend\'s son made ₹5 Lakh in options last month. You should do that instead of SIPs." How do you respond?',
          'choices': [
            {
              'text':
                  'He is right. SIPs are too slow. Options are where the money is.',
              'isCorrect': false,
              'feedback':
                  '❌ For every person who made ₹5L in options, 93 lost money. Survivorship bias makes winners loud and losers silent. Your uncle only hears about the wins.',
            },
            {
              'text':
                  'Thank him, but continue your SIP. In 20 years, your boring SIP will likely outperform his friend\'s son who probably lost it all by month 3.',
              'isCorrect': true,
              'feedback':
                  '✅ The SIP investor who does nothing for 20 years almost always beats the active trader. ₹5L made in one month usually becomes ₹5L lost in three months. Your compounding machine works quietly and relentlessly.',
            },
            {
              'text': 'Do both — SIP for long-term and options for excitement',
              'isCorrect': false,
              'feedback':
                  '❌ Adding options "for excitement" is gambling, not investing. If you want to trade actively, follow the 9-course FinlearnPro curriculum first and prove profitability in paper trading.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 5 Complete! 🎉',
          'keyPoints': [
            'Compound interest is the most powerful wealth-building force',
            'SIPs automate discipline — you invest regardless of emotions',
            'Index funds beat 85% of professional managers over 10 years',
            'The "boring" strategy of SIP + Index Fund wins for 80% of people',
            'Ignore uncle\'s tips about quick-money schemes',
            'Next: How to choose between styles based on YOUR time and capital.',
          ],
        },
      ],
    };
  }
}
