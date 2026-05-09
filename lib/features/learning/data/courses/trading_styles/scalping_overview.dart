/// Chapter 2: Scalping (Overview)
/// Making money in seconds to minutes
class ScalpingOverviewContent {
  static Map<String, dynamic> getWhatIsScalpingContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Speed Demon',
          'emoji': '⚡',
          'content':
              'Scalping is the fastest form of trading. You enter a trade, grab a tiny profit (₹50-₹500), and exit within seconds to minutes. Repeat 20-100 times per day. It looks thrilling on YouTube. The reality is brutal.',
        },
        {
          'type': 'concept',
          'title': 'How Scalpers Operate',
          'emoji': '🏎️',
          'content': '''
**The Scalper's Day:**
• 8:30 AM: Pre-market analysis and marking key levels
• 9:15 AM: Market opens. Full focus begins.
• 9:15 - 3:30 PM: Taking 20-50+ trades with laser concentration
• 3:30 PM: Done. Reviewing trades. Exhausted.

**Requirements:**
• Ultra-fast internet connection and execution platform
• Very low brokerage (₹20/trade eats into tiny profits)
• Deep understanding of Level 2 order book data
• 1-minute and 5-minute chart mastery
• ₹5-10 Lakh minimum capital for viable profit after costs

**The Math:**
50 trades/day × ₹200 avg profit = ₹10,000/day.
But: 50 trades × ₹20 brokerage = ₹1,000 in fees alone.
Plus STT, GST, exchange charges = another ₹500.
Net profit: ₹8,500. But ONE bad loss of ₹3,000 drops it to ₹5,500.

---

**Key Insight:**
Scalping has the highest skill requirement and the lowest margin for error of any trading style. It is NOT a shortcut to quick money.
''',
          'keyPoints': [
            'Scalping involves 20-100+ trades per day with tiny profit targets',
            'Brokerage costs eat heavily into small profits',
            'Requires full-time commitment with 6+ hours of screen time',
            'Highest skill requirement and lowest margin for error of any style',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question': 'Why is scalping NOT recommended for beginners?',
          'options': [
            'Because it requires huge capital',
            'Because it is boring',
            'Because the tiny profit margins are eaten by brokerage fees, and one mistake can wipe out a day\'s gains',
            'Because SEBI has banned scalping',
          ],
          'correctIndex': 2,
          'explanation':
              'Scalping profits are tiny (₹50-₹500 per trade). Brokerage, STT, and taxes take a large percentage. One emotional mistake (holding a loser too long) can erase 10 winning trades. This requires extreme discipline that beginners haven\'t developed.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Scalping is ultra-fast trading with tiny profit targets',
            'Transaction costs heavily impact profitability',
            'Requires full-time focus, fast execution, and iron discipline',
            'NOT recommended for beginners — master other styles first',
            'Next: Why scalping is specifically dangerous for beginners.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getWhyNotBeginnersContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Glamour vs Reality',
          'emoji': '🎭',
          'content':
              'YouTube makes scalping look like free money. Watch a 10-minute video, apply "this one simple trick," and make ₹10,000/day. The reality? Most scalpers lose money, burn out within months, and develop unhealthy screen addictions.',
        },
        {
          'type': 'story',
          'title': 'Rohan\'s Scalping Nightmare',
          'emoji': '😰',
          'content': '''
**Rohan**, 25, quit his ₹40,000/month job to become a "full-time scalper."

He watched 50+ YouTube videos on scalping. He set up dual monitors. He subscribed to a ₹5,000/month "scalping signals" Telegram group.

**Month 1:** 800 trades. Net profit: ₹3,200. Brokerage paid: ₹16,000.
He actually LOST ₹12,800 after costs but his trading platform showed "₹3,200 profit" (before costs).

**Month 2:** He realized the cost problem. Tried to reduce trades. Couldn't. The dopamine hit of clicking "Buy" was addictive.

**Month 3:** Burned out. Headaches every day. Couldn't sleep.
Started revenge trading in the afternoon. Lost ₹25,000.

**Month 6:** ₹1.5 Lakh total losses. Re-applied for his old job.

**Lesson:** Scalping requires professional-grade infrastructure, years of screen time, and institutional-level discipline. It is NOT a beginner's game.
''',
        },
        {
          'type': 'concept',
          'title': 'The Five Reasons Scalping Kills Beginners',
          'emoji': '⚠️',
          'content': '''
**1. Transaction Cost Death ₹₹₹**
At 50 trades/day, costs can exceed ₹1,500/day. That is ₹30,000/month BEFORE you make a single rupee of profit.

**2. Emotional Overload 🧠**
Making split-second decisions 50x per day depletes your mental energy. By afternoon, your brain is mush. Bad decisions multiply.

**3. Tiny Edge, Massive Noise 📊**
On 1-minute charts, 70% of price movement is random noise. Finding real signals in that noise requires years of experience.

**4. Addiction Risk 🎰**
The rapid feedback loop (trade → result in seconds) is neurologically similar to gambling. Many scalpers become addicted to the action, not the profit.

**5. Opportunity Cost ⏰**
The 6+ hours spent staring at charts could be used to learn swing trading (1 hour/day) or build a side business. The return-per-hour of scalping is often NEGATIVE.
''',
          'keyPoints': [
            'Transaction costs can exceed ₹30,000/month for active scalpers',
            'Decision fatigue causes terrible afternoon trades',
            '1-minute charts are 70% random noise',
            'Scalping can be neurologically addictive like gambling',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Rohan made ₹3,200 in trading profit in Month 1 but paid ₹16,000 in brokerage. What was his REAL profit/loss?',
          'options': [
            '₹3,200 profit',
            '₹16,000 profit',
            '₹12,800 loss',
            '₹19,200 loss',
          ],
          'correctIndex': 2,
          'explanation':
              'Real P&L = Trading profit (₹3,200) - Brokerage (₹16,000) = -₹12,800 LOSS. Many beginners look at their trading P&L and think they are profitable, but when they include brokerage, STT, GST, and exchange charges, they are actually deep in the red.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 2 Complete! 🎉',
          'keyPoints': [
            'Scalping is NOT the shortcut to quick money that YouTube suggests',
            'Transaction costs destroy most scalpers before the market even has a chance to',
            'Decision fatigue, addiction risk, and burnout are real dangers',
            'If you want to scalp, master swing trading first for 1-2 years',
            'Next: Intraday trading — a more viable active trading style.',
          ],
        },
      ],
    };
  }
}
