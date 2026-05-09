/// Chapter 9: Discipline, Patience & Consistency
/// The habits that make profitable traders
class DisciplinePatienceContent {
  // Lesson 9.1: The Trading Journal
  static Map<String, dynamic> getTradingJournalContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Mirror of Truth',
          'emoji': '📓',
          'content':
              'Show me a trader without a journal, and I will show you a trader who is losing money. The trading journal is the single most powerful tool for self-improvement. It forces you to confront your mistakes.',
        },
        {
          'type': 'story',
          'title': 'Ravi\'s Two Lives',
          'emoji': '🔄',
          'content': '''
**Ravi**, 33, a chartered accountant in Delhi who understood numbers better than anyone.

**Ravi Without a Journal (Months 1-4):**
Traded F&O on Nifty and Bank Nifty. No journal. Checked his P&L obsessively.
• "I remember winning 3 good trades last week." (He actually won 2 and lost 5.)
• "I mostly follow my rules." (He broke rules on 40% of trades.)
• "My strategy is broken." (His strategy was fine — his execution was the problem.)

**Result:** -₹62,000 in 4 months. He blamed the market.

**Ravi With a Journal (Months 5-8):**
Started logging every trade with 6 columns: Setup, Entry, Stop, Emotion, Rule Followed, P&L.

**Month 5 Review Discovery:**
"Wait... my rule-following trades have a **58% win rate**. But my FOMO trades have **12% win rate.** I took 18 FOMO trades this month. That's where ALL my losses are."

**Month 6:** He added a rule: "If emotion ≠ Calm, close the laptop."
FOMO trades dropped from 18 to 3. Net P&L swung from -₹15K to +₹8K.

**Month 8:** First 2-month profitable streak. The journal showed him exactly what to fix.

**Key lesson:** Ravi's brain LIED to him about his own performance. The journal told him the truth.
''',
        },
        {
          'type': 'concept',
          'title': 'How to Journal Like a Pro',
          'emoji': '📝',
          'content': '''
**What Amateurs Track:**
• Entry price
• Exit price
• Profit/Loss amount

**What Professionals Track (The 6 Pillars):**
1. **The Setup:** What was the technical/fundamental reason for entry?
2. **The Execution:** Entry price, Stop Loss, Target.
3. **The Size:** Risk amount and position size.
4. **The Emotion (Pre-trade):** Was I calm? FOMO? Bored?
5. **The Management:** Did I move my stop? Did I exit early?
6. **The Review:** Did I follow my rules? (Yes/No)

---

**The Power of the "Rule Review"**
The most important column in your journal is: **"Did I follow my rules?"**

**Scenario A:** You lost ₹2,000, but you followed your plan perfectly (stopped out mechanically).
→ **Journal Verdict:** GOOD TRADE. The math played out.

**Scenario B:** You made ₹5,000, but you moved your stop loss and averaged down a losing position.
→ **Journal Verdict:** BAD TRADE. You got lucky. Long-term, this behavior destroys accounts.

---

**Key Insight:**
A journal shifts your focus from the OUTCOME (money) to the PROCESS (execution). When you focus on executing the process perfectly, the money takes care of itself.
''',
          'keyPoints': [
            'A journal is non-negotiable for professional trading',
            'Track emotions and rule-following, not just entry/exit prices',
            'A losing trade that followed the rules is a GOOD trade',
            'A winning trade that broke the rules is a BAD trade',
            'Focus on the process, not the outcome',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You made ₹8,000 on a trade, but you entered without a stop loss and averaged down a losing position that eventually recovered. Your journal should classify this as:',
          'options': [
            'A great trade — you made ₹8,000!',
            'A BAD trade — you broke multiple rules and got lucky',
            'An average trade — the profit offsets the mistakes',
            'Don\'t log it — it was unusual',
          ],
          'correctIndex': 1,
          'explanation':
              'Profit doesn\'t justify rule-breaking. Trading without a stop loss and averaging down are the two most dangerous habits in trading. You got lucky THIS time. But if you repeat this behavior 100 times, you will eventually hit the one trade that doesn\'t recover — and it will wipe out months of gains. The journal labels this as a BAD trade to prevent you from building a deadly habit.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Ravi\'s brain lied to him about his trading — the journal told the truth',
            'If you don\'t measure it, you can\'t improve it',
            'Journaling separates the gamblers from the business operators',
            'The goal is perfect execution, not perfect outcomes',
            'Review your journal every weekend to spot emotional patterns',
            'Next: How to actually build the discipline to follow your journal.',
          ],
        },
      ],
    };
  }

  // Lesson 9.2: Building Iron Discipline
  static Map<String, dynamic> getBuildingDisciplineContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Muscle of Trading',
          'emoji': '💪',
          'content':
              'Discipline isn\'t something you are born with. It\'s a muscle you build. And like any muscle, it requires resistance, repetition, and a structured routine to grow strong.',
        },
        {
          'type': 'interactive',
          'title': 'Professional vs Amateur Day',
          'emoji': '⏰',
          'content': '''
**The Amateur's Trading Day:**
• 9:10 AM — Wake up. Scramble to open charts.
• 9:15 AM — See Nifty moving up. Buy impulsively. No plan.
• 9:45 AM — Down ₹3,000. "It'll come back."
• 11:00 AM — Down ₹7,000. Average down in panic.
• 1:00 PM — Exit in frustration for -₹12,000.
• 2:30 PM — Take a "revenge trade" to recover. Lose ₹5,000 more.
• 3:30 PM — Total: -₹17,000. Blame the market. 😡

---

**The Professional's Trading Day:**
• 8:00 AM — Pre-market analysis. Mark key levels. Write 2-3 trade scenarios.
• 9:15 AM — Market opens. Watch. Wait. No trades in first 15 minutes.
• 9:45 AM — Setup #1 triggers. Enter with stop loss and target PRE-SET.
• 10:30 AM — Target hit. +₹4,500. Log in journal.
• 11:00 AM — No more setups. Close laptop. Go for a walk.
• Total: +₹4,500 in 1 trade. 1 hour of actual work. 😊

**The difference?** Not talent. Not intelligence. ROUTINE and RULES.
''',
        },
        {
          'type': 'concept',
          'title': 'Routines & The Power of "NO"',
          'emoji': '🧘‍♂️',
          'content': '''
**1. The Pre-Market Routine 🌅**
Amateur: Wakes up at 9:10 AM, opens the app, buys whatever is green.
Professional: Wakes up at 8:00 AM. Checks macro news. Marks key support/resistance levels. Writes down 2-3 specific scenarios to trade. If those scenarios don't happen, they don't trade.

**2. The Power of "NO" 🛑**
Trading is 90% waiting and 10% executing.
• Is it a 1:1 Risk/Reward? NO.
• Is it outside my trading hours? NO.
• Am I feeling angry/revengeful? NO.
Saying NO to mediocre trades is how you save capital for the A+ setups.

**3. Mechanical Execution ⚙️**
Discipline means removing human decision-making during the trade.
Before you enter: Set Stop Loss. Set Target.
Once entered: **Hands off the mouse.**
Let the system trigger the stop or the target. No manual intervention unless defined in your plan.

---

**The "If-Then" Framework:**
Build your discipline using conditional logic.
• "IF I lose two trades today, THEN I close the laptop."
• "IF price hits my target, THEN I sell 50% automatically."
• "IF I feel my heart racing, THEN I walk away for 10 minutes."

**Key Insight:**
Willpower is finite. By 2 PM, your willpower is exhausted. That's why most bad trades happen in the afternoon. Rely on ROUTINES and RULES, not willpower.
''',
          'keyPoints': [
            'Discipline is a muscle built through routine, not a personality trait',
            'Pre-market routines separate professionals from gamblers',
            'Trading is 90% saying "NO" to bad setups',
            'Use "If-Then" logic to automate your responses to emotional triggers',
            'Rely on hard rules, because willpower runs out',
          ],
        },
        {
          'type': 'scenario',
          'title': 'The Discipline Test',
          'situation':
              'It\'s 2:30 PM. You are up ₹5,000 for the day (a great day). The market is moving fast. You see a setup that is NOT in your trading plan, but it looks like an easy quick profit. What do you do?',
          'choices': [
            {
              'text': 'Take it with half size — it\'s just a quick scalp',
              'isCorrect': false,
              'feedback':
                  '❌ This is how you ruin a great day. Taking trades outside your plan because you feel confident (Overconfidence Bias) is a discipline failure. It often leads to a quick loss, which triggers revenge trading, wiping out your ₹5,000 profit.',
            },
            {
              'text':
                  'Say NO. It\'s not in the plan. Close the laptop and enjoy your profitable day.',
              'isCorrect': true,
              'feedback':
                  '✅ This is Iron Discipline. You recognized the temptation, checked it against your plan, and said NO. Keeping the ₹5,000 is much harder than making it. Professionals walk away when the work is done.',
            },
            {
              'text': 'Take it with full size to double your daily profit',
              'isCorrect': false,
              'feedback':
                  '❌ Pure Greed and Overconfidence. This is the fastest way to turn a winning day into a losing day.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 9 Complete! 🎉',
          'keyPoints': [
            'A trading journal tracks the process (rules), not just the outcome (money)',
            'The professional trader\'s day is mostly WAITING, not trading',
            'Discipline is built through strict pre-market routines',
            'Saying NO to mediocre trades is a core professional skill',
            'Use "If-Then" statements to mechanicalize your reactions',
            'Protect your winning days — don\'t give them back out of boredom',
            'Next: The final transformation — putting it all together.',
          ],
        },
      ],
    };
  }
}
