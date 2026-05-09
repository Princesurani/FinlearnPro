/// Chapter 6: Reviewing Past Trades
/// The weekend routine that builds professional traders
class ReviewingTradesContent {
  // Lesson 6.1: The Weekly Review
  static Map<String, dynamic> getWeeklyReviewContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Weekend Work',
          'emoji': '🗓️',
          'content':
              'The market is closed on weekends. This is when the real money is made. The Weekly Review is a dedicated 1-2 hour session where you analyze your journal data to find the leaks in your trading system.',
        },
        {
          'type': 'story',
          'title': 'Arjun\'s Sunday Ritual',
          'emoji': '☕',
          'content': '''
**Arjun**, 31, a civil engineer in Ahmedabad, had been swing trading for 5 months.

**Months 1-3 (No reviews):**
He traded, checked his P&L, felt good or bad, and moved on.
Net result: -₹12,000. "Maybe I need a better indicator."

**Months 4-5 (Started weekly reviews):**
Every Sunday, he opened his journal with a cup of chai and spent 90 minutes reviewing.

**Week 1 Discovery:**
"I took 4 trades after 2:00 PM this week. All 4 lost money. My winning trades were all entered between 9:30-11:00 AM."

**Week 3 Discovery:**
"My 'Breakout' setups have a 25% win rate. My 'Pullback to EMA' setups have a 58% win rate. I should stop taking breakout trades."

**Week 6 Discovery:**
"Every Friday, I overtrade. I take 2-3 extra trades because I feel anxious about the weekend gap. These Friday trades are my biggest losers."

**Month 5 result:** +₹14,000 (his first profitable month)

**What changed?** Not his indicators. Not his charts. His AWARENESS of his own patterns, discovered through the Sunday review ritual.
''',
        },
        {
          'type': 'concept',
          'title': 'How to Conduct a Review',
          'emoji': '🔍',
          'content': '''
**Step 1: The Macro Metrics 📊**
Look at your aggregate data for the week:
• Total Trades Taken: (e.g., 12)
• Win Rate: (e.g., 41%)
• Average Risk:Reward: (e.g., 1:1.8)
• Net P&L: (e.g., +₹1,500)

**Step 2: The Discipline Audit ⚖️**
Filter your journal for the "Rule Followed?" column.
• How many trades broke the rules? (e.g., 3 out of 12)
• What was the P&L of JUST the rule-breaking trades? (Usually deeply negative).
• *Realization:* "If I just didn't take those 3 impulsive trades, my profit would be triple."

**Step 3: The Chart Review 🖼️**
Open the screenshots for your losing trades.
Ask objectively: Was the setup valid, and the market just didn't comply? Or did I force a setup that wasn't really there?
Do the same for winning trades. Did you exit perfectly, or did you leave a massive trend on the table out of fear?

---

**Key Insight:**
The goal of the weekly review is not to beat yourself up over losses. The goal is to identify **one specific habit** to improve next week.
''',
          'keyPoints': [
            'The weekly review is a 1-2 hour weekend session analyzing your journal',
            'Check macro metrics: Win rate, average R:R, and total trades',
            'Isolate rule-breaking trades to see exactly how much indiscipline costs you',
            'Review chart screenshots to visually calibrate your eyes to good vs bad setups',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Your Review Checklist',
          'emoji': '✅',
          'content': '''
**Print this and use it every Sunday:**

**📊 WEEKLY REVIEW TEMPLATE**

□ Total trades this week: _____
□ Trades that followed ALL rules: _____ / _____
□ Win rate this week: _____%
□ Best trade (and why): _____________
□ Worst trade (and why): _____________
□ P&L from rule-following trades: ₹_____
□ P&L from rule-breaking trades: ₹_____

**🧠 EMOTIONAL PATTERNS**
□ Most common pre-trade emotion: _______
□ Time of day with worst results: _______
□ Day of week with worst results: _______

**🎯 NEXT WEEK'S FOCUS**
□ ONE specific behavior to improve: _____________
□ ONE rule to add/enforce: _____________

---

**The Power of This Template:**
After 4 Sundays (1 month), you will have a meta-pattern:
"Every week, my rule-breaking trades cost me ₹X."
"My best day is always Tuesday. My worst day is Friday."
"I overtrade when I start the day with a loss."

This data is worth more than any paid course.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'During your weekly review, you discover that you took 15 trades, but only 9 followed your rules. The 9 disciplined trades made +₹8,000. The 6 undisciplined trades lost -₹12,000. What is the #1 priority?',
          'options': [
            'Find a strategy with a higher win rate',
            'Reduce trading frequency to only take the most perfect setups',
            'Focus on eliminating the 6 undisciplined trades — your strategy is profitable when followed',
            'Increase position size on disciplined trades to offset the losses',
          ],
          'correctIndex': 2,
          'explanation':
              'Your strategy is profitable (+₹8,000 on disciplined trades). The problem is YOU, not the strategy. If you simply eliminated the 6 emotional trades, you would have been +₹8,000 instead of -₹4,000. Focus 100% on discipline, not on finding a new system.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Arjun turned a losing streak into his first profitable month through Sunday reviews',
            'Professionals work on their trading business when the market is closed',
            'The Discipline Audit is the most valuable part of the review',
            'Use the review checklist template every Sunday',
            'Identify ONE specific behavioral leak to fix for the upcoming week',
            'Next: How to categorize mistakes so you know exactly what to fix.',
          ],
        },
      ],
    };
  }

  // Lesson 6.2: Categorizing Mistakes
  static Map<String, dynamic> getCategorizingMistakesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Diagnosing the Leak',
          'emoji': '🩺',
          'content':
              'Not all losses are created equal. A loss due to a statistical probability is fine. A loss due to emotional indiscipline is a leak. You must categorize your mistakes to know whether you need to fix your strategy or fix yourself.',
        },
        {
          'type': 'concept',
          'title': 'Execution Errors vs Strategy Errors',
          'emoji': '🗂️',
          'content': '''
**Category 1: Execution Errors (The Trader's Fault) 👤**
You had a plan, but you didn't follow it.
• Moving a stop loss down
• FOMO entry (late to the move)
• Revenge trading
• Sizing too large
*Solution:* Discipline protocols. Checklists. Daily limits. Walk-away rules.

**Category 2: Strategy Errors (The System's Fault) ⚙️**
You followed the plan perfectly, but the system isn't working.
• Your win rate drops to 20% over 50 trades.
• The market environment changed (e.g., from trending to choppy), and your trend-following strategy is taking continuous small losses.
*Solution:* Adjust the strategy parameters or pause trading until conditions change.

**Category 3: "Good" Losses (The Cost of Business) ✅**
You followed the plan perfectly, the setup was A+, but the trade failed.
• This is NOT a mistake.
• This is statistical variance.
*Solution:* Do absolutely nothing. Keep executing.

---

**The Rule of 20:**
Never change a strategy based on 3 or 4 trades. You need a sample size of at least 20 strict executions before you can mathematically determine if the strategy is broken. Until then, assume execution errors are the problem.
''',
          'keyPoints': [
            'Execution errors are failures of discipline (your fault)',
            'Strategy errors are failures of mathematical edge (system\'s fault)',
            'Good losses are perfect executions that statistically failed (nobody\'s fault)',
            'Do not change a strategy based on a few losses — use the Rule of 20',
          ],
        },
        {
          'type': 'scenario',
          'title': 'Classify This Loss',
          'situation':
              'You had a perfect setup. Bullish engulfing candle at the 200 EMA. Volume was above average. You entered with 1% risk and a 1:2 R:R. The trade immediately went against you and hit your stop loss. Your journaled emotion was "Calm". What type of loss is this?',
          'choices': [
            {
              'text':
                  'Execution Error — I should have waited for more confirmation',
              'isCorrect': false,
              'feedback':
                  '❌ You followed all your rules. The setup met your criteria. Adding extra "confirmation" after the fact is hindsight bias. Your rules said enter — you entered correctly.',
            },
            {
              'text': 'Strategy Error — the 200 EMA doesn\'t work anymore',
              'isCorrect': false,
              'feedback':
                  '❌ One trade doesn\'t prove a strategy is broken. You need 20+ trades at minimum. The 200 EMA has worked for decades — one failed trade means nothing.',
            },
            {
              'text':
                  '"Good" Loss — perfect execution, statistical variance. Do nothing differently.',
              'isCorrect': true,
              'feedback':
                  '✅ This is the textbook "good loss." You followed every rule. The setup was valid. The market just didn\'t cooperate this time. Over 100 trades, these losses are factored into your win rate. Feel zero guilt about this trade.',
            },
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You review your week. You took 5 trades. You followed your plan perfectly on all 5. They were all A+ setups. All 5 hit your stop loss. What should you do?',
          'options': [
            'Change your indicators immediately — the strategy is clearly broken.',
            'Double your position size next week to make the money back.',
            'Nothing. 5 trades is too small a sample size. They are "good losses." Continue executing the plan.',
            'Stop trading forever.',
          ],
          'correctIndex': 2,
          'explanation':
              '5 trades is statistical noise. Even a strategy with a 60% win rate will occasionally experience 5 losses in a row. If you change your strategy now, you reset your learning curve to zero. Continue executing until you hit 20 trades to evaluate the real edge.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 6 Complete! 🎉',
          'keyPoints': [
            'Weekend reviews separate amateurs from professionals',
            'Isolate your mistakes into Execution, Strategy, or "Good" losses',
            'A perfect execution that hits a stop loss is a "Good Loss" — feel zero guilt',
            'Never tweak a strategy based on a tiny sample size (Rule of 20)',
            'Your journal + weekly review = the fastest path to consistent profitability',
            'Next: The final chapter — completing the feedback loop.',
          ],
        },
      ],
    };
  }
}
