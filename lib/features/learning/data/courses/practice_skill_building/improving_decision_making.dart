/// Chapter 7: Improving Decision-Making
/// Using data to fix the trader
class ImprovingDecisionMakingContent {
  // Lesson 7.1: The Feedback Loop
  static Map<String, dynamic> getFeedbackLoopContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Professional\'s Engine',
          'emoji': '🔄',
          'content':
              'Trading is not a static skill you learn once. It is an ongoing cycle of execution, observation, and correction. This cycle is called the Feedback Loop, and it is the engine of all profitable traders.',
        },
        {
          'type': 'concept',
          'title': 'The Four Stages of the Loop',
          'emoji': '⚙️',
          'content': '''
**Stage 1: Execute 🎯**
• Trade according to your written pre-trade plan.
• Mechanical, emotionless execution.

**Stage 2: Journal 📝**
• Log the mechanical data (entry, stop, target, size).
• Log the psychological data (emotions, rule adherence).
• Do this immediately after the trade closes.

**Stage 3: Review 🔍**
• The weekend session.
• Analyze aggregate data. Identify the #1 mistake costing you money.
• Separate execution errors from strategy errors.

**Stage 4: Adjust 🔧**
• Create a specific, actionable rule to fix the #1 mistake.
• Example: If the mistake was "Revenge Trading after a loss," the adjustment is: "I will set a hard software block that locks my platform for 30 minutes after any loss."

**The Cycle Repeats:**
You take your new rule into Monday morning. You Execute, Journal, Review, and Adjust again. Over 6 months, you eliminate the leaks one by one until only profitable execution remains.
''',
          'keyPoints': [
            'The Feedback Loop: Execute → Journal → Review → Adjust',
            'Execution must be based on the plan, not emotion',
            'Adjustments must be specific, actionable rules, not vague promises ("I will try harder")',
            'Continuous iteration is how professionals stay profitable for decades',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The Post-Trade Autopsy',
          'emoji': '🔬',
          'content': '''
**Review your latest trade.**

**The Trade:** Bought XYZ stock. Stop hit. Loss: ₹1,500.

**The Autopsy Questions:**
1. Did the setup meet my written criteria perfectly?
   *(Answer: No, the RSI was at 55, my rule requires < 40)*
2. Did I respect my stop loss?
   *(Answer: Yes, I exited exactly when it hit ₹300)*
3. Was my position size correct?
   *(Answer: Yes, exactly 1% risk)*

**The Diagnosis:**
This was a bad trade, but not a total failure. The execution and risk management were professional (good). The entry was impulsive and broke the strategy rules (bad).

**The Prescription (Adjustment):**
"Tomorrow, I will not look at any chart unless my scanner confirms RSI is below 40."
''',
        },
        {
          'type': 'story',
          'title': 'The Power of One Adjustment',
          'emoji': '🚀',
          'content': '''
**Neha** reviewed her last 100 trades.
She found a shocking statistic in her journal:
- Trades taken between 9:15 AM and 10:00 AM: Win rate 20%, Net Loss ₹40,000.
- Trades taken after 10:00 AM: Win rate 65%, Net Profit ₹30,000.

**The Aha Moment:**
Neha realized she was trading the morning volatility out of excitement, getting chopped out, and then trading well the rest of the day.

**The Adjustment:**
She created a new, unbreakable rule: *"I am not allowed to open my trading app until 10:01 AM."*

By making this ONE adjustment, she instantly eliminated ₹40,000 of losses from her next 100 trades, turning a net losing system into a highly profitable one without changing a single technical indicator.

**Key lesson:** The Feedback Loop uncovers the invisible leaks in your trading. Data never lies.
''',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Trading mastery is a process of continuous iteration',
            'Without the Feedback Loop, you will repeat the same mistakes for years',
            'Focus on fixing ONE specific behavioral leak per week',
            'Next: The final exam for Practice & Skill Building.',
          ],
        },
      ],
    };
  }

  // Lesson 7.2: Final Challenge: Practice Pro
  static Map<String, dynamic> getFinalChallengeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Ultimate Practice Test',
          'emoji': '🏆',
          'content':
              'You\'ve learned how to paper trade, build a pre-trade plan, backtest, and maintain a professional journal. Let\'s see if you are ready to apply the Feedback Loop.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: The Simulation Rule',
          'question':
              'What is the minimum requirement before funding a live trading account with real money?',
          'options': [
            'Reading 5 books on technical analysis',
            '1 week of profitable paper trading',
            '3 consecutive months of net profitability in a paper trading account',
            'Finding a mentor with a 90% win rate',
          ],
          'correctIndex': 2,
          'explanation':
              'The 3-month rule is non-negotiable. It proves you have an edge across different market conditions and that your discipline holds up over time.',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: Paper Trading Traps',
          'question':
              'Why is it dangerous to paper trade with a ₹1 Crore virtual account if you only plan to fund your real account with ₹50,000?',
          'options': [
            'It isn\'t dangerous; it\'s good to practice with big numbers.',
            'The platform will crash with large numbers.',
            'It builds unrealistic expectations and poor position sizing habits that won\'t translate to your real capital.',
            'Brokers charge more for large virtual accounts.',
          ],
          'correctIndex': 2,
          'explanation':
              'Paper trading must exactly mirror your future reality. Trading ₹1 Crore requires entirely different psychology and sizing than trading ₹50,000. You must learn to compound the exact amount you will actually start with.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: The Journal',
          'question':
              'Which column in your trading journal is the most important for long-term improvement?',
          'options': [
            'Profit / Loss Amount',
            'Entry Price',
            'Did I follow my rules? (Yes/No)',
            'The specific indicator used',
          ],
          'correctIndex': 2,
          'explanation':
              'The "Rule Followed?" column shifts your focus from the OUTCOME (which you can\'t control) to the PROCESS (which you can control). A loss where you followed the rules is a good trade. A win where you broke the rules is a toxic habit.',
        },
        {
          'type': 'scenario',
          'title': 'The Weekend Review Scenario',
          'situation':
              'During your Sunday review, you notice a clear pattern: You followed your rules on 15 trades, resulting in a 40% win rate and a net profit. However, you took 5 additional trades out of FOMO that were not in your plan. All 5 were losses, completely wiping out your profit for the week. What is your Adjustment for Monday?',
          'options': [
            'Change my strategy to improve the 40% win rate.',
            'Create a hard rule: "If a setup is not written on my pre-market plan, I am physically not allowed to click the buy button." Focus 100% on eliminating FOMO entries next week.',
            'Increase position size on the good trades to offset the bad ones.',
            'Stop reviewing; the data is too depressing.',
          ],
          'correctIndex': 1,
          'explanation':
              '✅ Perfect Feedback Loop application. The strategy works (it generated a profit). The leak is the TRADER (FOMO entries). The adjustment targets the specific behavioral leak, not the strategy.',
        },
        {
          'type': 'summary',
          'title': 'Congratulations! 🎓📊',
          'keyPoints': [
            'You understand that real money requires real proof (3-month rule)',
            'You know how to paper trade without building "video game" habits',
            'You can build a comprehensive pre-trade plan',
            'You understand how to manual backtest to find your mathematical edge',
            'You know how to journal mechanical and psychological data',
            'You have mastered the Execute → Journal → Review → Adjust feedback loop',
            'You are now equipped to build professional trading skills safely.',
          ],
        },
      ],
    };
  }
}
