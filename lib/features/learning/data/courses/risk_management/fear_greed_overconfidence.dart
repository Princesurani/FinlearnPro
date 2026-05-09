/// Chapter 7: Fear, Greed & Overconfidence
/// The three emotions that destroy traders
class FearGreedOverconfidenceContent {
  // Lesson 7.1: Fear & Greed
  static Map<String, dynamic> getFearGreedContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Twin Demons',
          'emoji': '🎭',
          'content':
              'Charts don\'t move because of lines or math. They move because millions of human beings are simultaneously experiencing fear and greed. If you don\'t control these two emotions in yourself, the market will exploit them.',
        },
        {
          'type': 'story',
          'title': 'Kiran\'s Emotional Rollercoaster',
          'emoji': '🎢',
          'content': '''
**Kiran**, 31, saw a breakout on a midcap stock. 

**The Plan:** Buy at ₹400, Target ₹450, Stop Loss ₹380.

**The Reality:**
1. The stock hit ₹400. Kiran hesitated. "What if it's a fake breakout?" (**FEAR**)
2. The stock surged to ₹425 without him. Kiran panicked. "I'm missing out! Buy now!" (**GREED / FOMO**)
3. He bought at ₹425. The stock immediately pulled back to ₹410.
4. Kiran watched his P&L go red. He couldn't handle the anxiety. He sold at ₹410. (**FEAR**)
5. Two days later, the stock hit his original target of ₹450.

**The result:** He lost ₹15 per share on a trade that should have made him ₹50 per share.

**Key lesson:** The chart didn't beat Kiran. Kiran beat Kiran. His plan was perfect. His execution was destroyed by alternating cycles of fear and greed.
''',
        },
        {
          'type': 'concept',
          'title': 'How They Manifest',
          'emoji': '🧟‍♂️',
          'content': '''
**GREED (The Destroyer of Logic) 🤑**
Greed convinces you that the laws of math no longer apply.
**Symptoms:**
• FOMO (Buying at the top because "it's going to the moon")
• Removing profit targets ("Let it ride forever!")
• Overleveraging (Using 10x margin to get rich today)
**The Cure:** Position sizing and hard Take-Profit orders.

**FEAR (The Destroyer of Opportunity) 😨**
Fear convinces you that every trade will be a disaster.
**Symptoms:**
• Hesitation (Missing perfect setups because "what if it fails?")
• Panic Selling (Selling a winner early at +1% when the target is +5%)
• Moving Stop Losses DOWN (Fear of taking the loss now, resulting in a bigger loss later)
**The Cure:** Acceptance of risk BEFORE entering, and thinking in probabilities.

---

**The Vicious Cycle:**
You enter out of GREED (FOMO at the top).
The market corrects slightly.
You exit out of FEAR (Panic at the bottom).
The market resumes its uptrend.
You enter again out of GREED.

**Key Insight:**
Fear and Greed are evolutionary survival mechanisms. You cannot "delete" them. You can only build RULES that override them. A trading plan is your pre-written logical override for your emotional brain.
''',
          'keyPoints': [
            'Greed leads to overleveraging, FOMO, and ignoring targets',
            'Fear leads to hesitation, panic selling, and moving stop losses',
            'You cannot eliminate emotions; you must build rules that override them',
            'Your trading plan is the logical override for your emotional brain',
          ],
        },
        {
          'type': 'scenario',
          'title': 'Emotional Hijacking',
          'situation':
              'You bought at ₹100. Target is ₹120. Stop is ₹90. Price reaches ₹110, then drops quickly to ₹105. Your heart rate spikes. You feel intense anxiety that your profit is disappearing. What is happening and what should you do?',
          'choices': [
            {
              'text':
                  'It\'s intuition — sell immediately to lock in the ₹5 profit',
              'isCorrect': false,
              'feedback':
                  '❌ This is FEAR hijacking your plan. If you constantly sell winners early out of fear, your Risk:Reward ratio collapses. Over 100 trades, this guarantees unprofitability. Let the trade play out.',
            },
            {
              'text': 'It\'s greed — buy more at ₹105',
              'isCorrect': false,
              'feedback':
                  '❌ Adding to a position during a pullback without a plan is dangerous. You are increasing risk when the trade is moving against you.',
            },
            {
              'text':
                  'It\'s fear (Loss Aversion). Do nothing. The price is between your stop and target. Let the system work.',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect self-awareness. Your brain hates losing "unrealized" profit. Recognize the emotion, but let the plan dictate the action. Either it hits the target, hits the stop, or you execute a planned trailing stop. No emotional mid-trade decisions.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Fear causes you to cut winners early and hesitate on good setups',
            'Greed causes you to hold losers, overleverage, and chase markets',
            'Emotions cannot be deleted, only managed through strict rules',
            'Never make a decision while in the middle of an emotional spike',
            'Next: The silent killer that strikes when you are winning.',
          ],
        },
      ],
    };
  }

  // Lesson 7.2: Overconfidence Bias
  static Map<String, dynamic> getOverconfidenceContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Silent Killer',
          'emoji': '🦚',
          'content':
              'Fear and Greed are obvious. But Overconfidence is silent. It sneaks up on you after a winning streak, whispers that you are a genius, and then burns your account to the ground.',
        },
        {
          'type': 'story',
          'title': 'Rahul\'s "Sure Thing"',
          'emoji': '🎲',
          'content': '''
**Rahul**, 25, had just won 6 swing trades in a row. His account was up 18% for the month. He felt untouchable.

"Trading is so easy once you understand it," he told his friends.

Then he saw a setup on an IT stock right before its earnings report.

**The Overconfident Mindset:**
"It's definitely going up. I'm so sure of it, I don't need a stop loss. In fact, my normal 1% risk is too small. I'm putting 50% of my capital into this."

**The Reality:**
The earnings report was good, but the guidance was weak. The stock gapped down 15% at the open.

**The Result:**
Rahul lost 7.5% of his TOTAL capital in 5 seconds. Half of his glorious 18% monthly profit vanished because of ONE undisciplined trade.

**Key lesson:** Winning creates dopamine, which suppresses your perception of risk. Rahul didn't lose because he was dumb; he lost because his winning streak made him blind to danger.
''',
        },
        {
          'type': 'concept',
          'title': 'The Danger of Winning',
          'emoji': '👑',
          'content': '''
**The Anatomy of Overconfidence:**

**Trade 1-3:** You follow your rules strictly. You win. (+3%)
**Trade 4-6:** You relax a bit. You win again. (+6%)
**Trade 7:** You feel invincible. "I can read the market perfectly."
**Trade 8:** You skip the checklist. You double the position size. No stop loss. "It's a sure thing."

**The Result:**
Trade 8 goes wrong. Because it's double the size and has no stop loss, you lose the 9% profit from the first 7 trades, plus 10% of your capital.
**One overconfident trade wiped out a month of disciplined work.**

---

**Why Winning is Dangerous:**
Winning releases dopamine. Dopamine makes you feel good but reduces your perception of risk. Your brain literally stops seeing the danger.

**The Professional Defense against Overconfidence:**
1. **Never increase risk after a winning streak.** If anything, decrease it slightly.
2. **Beware the "Sure Thing."** There are no sure things. Ever.
3. **Attribute wins to the SYSTEM, not your genius.** "The strategy worked," not "I am smart."
4. **Take profit withdrawals.** Move money out of the trading account so you can't risk it all.

---

**Key Insight:**
The most dangerous time in a trader's life is right after their biggest win. That is when risk management protocols are most likely to be abandoned.
''',
          'keyPoints': [
            'Overconfidence strikes after a winning streak, lowering risk perception',
            'It leads to skipping checklists, doubling risk, and removing stops',
            'The most dangerous time is right after your biggest win',
            'Attribute wins to the system\'s math, not your personal genius',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You\'ve had your best week ever, winning 8 trades in a row. You spot a setup for Monday morning. How should you approach it?',
          'options': [
            'Double the position size — ride the hot streak!',
            'Trade with normal 1% risk, but be hyper-aware that your brain is likely underestimating the risk right now.',
            'Skip trading entirely — streaks always end.',
            'Take maximum leverage — the market is clearly easy for you.',
          ],
          'correctIndex': 1,
          'explanation':
              'Awareness is key. You shouldn\'t skip a valid setup, but you MUST enforce the 1% rule strictly. Your dopamine-flooded brain will try to convince you to increase size. The professional maintains the exact same risk on trade #9 as they did on trade #1.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 7 Complete! 🎉',
          'keyPoints': [
            'Fear makes you miss opportunities and cut winners early',
            'Greed makes you take bad opportunities and hold losers',
            'Overconfidence makes you abandon risk rules after winning',
            'The defense against all three is a rigid, written trading plan',
            'You cannot outsmart emotions; you must out-system them',
            'Next: The twin destructive actions — Overtrading and Revenge Trading.',
          ],
        },
      ],
    };
  }
}
