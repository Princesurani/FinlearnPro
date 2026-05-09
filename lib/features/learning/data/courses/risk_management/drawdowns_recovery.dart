/// Chapter 6: Drawdowns & Loss Recovery
/// The math of losing — and the mindset of recovery
class DrawdownRecoveryContent {
  // Lesson 6.1: The Drawdown Math
  static Map<String, dynamic> getDrawdownMathContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Math of Ruin',
          'emoji': '📉',
          'content':
              'A drawdown is the percentage drop from your account\'s peak value to its lowest point. Most traders don\'t understand the brutal mathematics of drawdowns: losing money is easy, making it back is exponentially harder.',
        },
        {
          'type': 'story',
          'title': 'Amit\'s 50% Hole',
          'emoji': '🕳️',
          'content': '''
**Amit**, 35, invested ₹10 Lakh in his trading account. 

He didn't use stop losses. "I invest in good companies, they always come back."

During a market correction, his portfolio dropped 50%. His ₹10 Lakh became ₹5 Lakh.

**Amit's logic:** "I lost 50%. So if the market goes up 50%, I'll be back to breakeven."

**The Market Reality:**
The market *did* go up 50% the next year. Amit was thrilled.
But ₹5 Lakh + 50% = **₹7.5 Lakh.**

He was still down ₹2.5 Lakh!

**The brutal realization:** To get his ₹5 Lakh back to ₹10 Lakh, he didn't need a 50% gain. He needed a **100% gain** (doubling his money).

**Key lesson:** Amit learned the hard way that percentages are asymmetric. A 50% loss destroys capital so deeply that it requires superhuman performance just to get back to zero.
''',
        },
        {
          'type': 'concept',
          'title': 'The Asymmetry of Losses',
          'emoji': '⚖️',
          'content': '''
**If you lose 10%, you need MORE than 10% to recover.**
Why? Because you are earning a percentage on a SMALLER capital base.

**The Drawdown Recovery Table:**
• Lose 10% → Need 11% to recover
• Lose 20% → Need 25% to recover
• Lose 30% → Need 43% to recover
• **Lose 50% → Need 100% to recover!**
• Lose 80% → Need 400% to recover
• Lose 90% → Need 900% to recover

**Example:**
Capital: ₹1,00,000
You lose 50% = ₹50,000 remaining.
To get back to ₹1,00,000, you have to turn ₹50,000 into ₹1,00,000.
That is a **100% gain**.

**The Brutal Reality:**
Making a 100% gain requires massive risk-taking or years of perfect trading. When an amateur loses 50%, their brain panics. They take insane leverage to "make it back quickly," which usually leads to the final 90% blowout.

---

**Key Insight:**
This is the mathematical proof of why the **1% Risk Rule** is mandatory. If you only risk 1% and lose 10 trades in a row (a 10% drawdown), you only need an 11% gain to recover. That's entirely manageable. If you risk 10% per trade and lose 5 times (50% drawdown), your account is effectively dead.
''',
          'keyPoints': [
            'Losses are asymmetric: a 50% loss requires a 100% gain to recover',
            'Losing 10% only requires an 11% gain — completely manageable',
            'Large drawdowns force traders into desperate, high-risk "revenge trading"',
            'The 1% risk rule prevents mathematically unrecoverable drawdowns',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Your account drops from ₹2,00,000 to ₹1,50,000 (a 25% drawdown). What percentage gain do you need on the REMAINING balance to get back to breakeven (₹2,00,000)?',
          'options': ['25%', '33.3%', '50%', '100%'],
          'correctIndex': 1,
          'explanation':
              'You need to make ₹50,000 profit. Your current capital is ₹1,50,000. (50,000 / 1,50,000) × 100 = 33.3%. This demonstrates how losing 25% requires significantly more work (33%) just to get back to where you started.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Drawdowns are the enemy of compound interest',
            'The math of recovery is exponentially stacked against you',
            'Never allow a drawdown to exceed 15-20% of your account',
            'Small losses are business expenses; large losses are business killers',
            'Next: How to psychologically survive and recover from a losing streak.',
          ],
        },
      ],
    };
  }

  // Lesson 6.2: Surviving a Losing Streak
  static Map<String, dynamic> getSurvivingLosingStreakContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'When Nothing Works',
          'emoji': '🌧️',
          'content':
              'Every trader, including the best in the world, goes through losing streaks. 5, 8, even 10 losses in a row. It feels like the market is personally attacking you. Your survival depends entirely on how you handle this phase.',
        },
        {
          'type': 'story',
          'title': 'Neha\'s 8-Trade Nightmare',
          'emoji': '🌩️',
          'content': '''
**Neha**, 28, a breakout trader, hit the worst week of her career. The market was chopping sideways, and every breakout she bought immediately reversed.

She lost 8 trades in a row.

**Her Account (starting ₹2,00,000):**
Because she strictly followed the 1% risk rule, her 8 losses cost her exactly ₹16,000 (8% drawdown). Account balance: ₹1,84,000.

**Neha's Actions:**
1. She didn't get angry. She recognized the market was in a "chop phase."
2. She **halved her risk** to 0.5% (₹1,000 per trade).
3. She stopped trading for 2 days to clear her head.

When the market finally started trending again the next week, her strategy started working.
Because she only had an 8% drawdown to recover, it took her just 4 winning trades (at a 1:2 R:R) to get back to breakeven.

**Key lesson:** Neha survived an 8-trade losing streak because she controlled her risk and stepped back. If she had revenge-traded or doubled her size, her account would be gone.
''',
        },
        {
          'type': 'concept',
          'title': 'The Professional Recovery Mindset',
          'emoji': '🧠',
          'content': '''
**Amateur Reaction to a Losing Streak:**
1. Anger: "The market is manipulated!"
2. Desperation: "I need to win the next trade to make it all back."
3. Action: Doubles position size, abandons rules.
4. Result: Blows up account.

**Professional Reaction to a Losing Streak:**
1. Acceptance: "My strategy is currently out of sync with market conditions."
2. Defense: "I need to protect what's left."
3. Action: HALVES position size. Reviews journal.
4. Result: Survives the drawdown, waits for conditions to improve.

---

**The 3-Step Recovery Plan:**

**1. HALVE Your Risk Size ✂️**
If you normally risk 1%, drop to 0.5%.
Why? It slows the bleeding and removes the psychological pressure of losing big money. You trade to regain confidence, not money.

**2. Stop Trading for 48 Hours ⏸️**
Take a break. Your brain is in "fight or flight" mode. You are literally incapable of objective analysis. Go to the gym, sleep, do anything else.

**3. Review the Journal 📓**
Look at the losing trades objectively.
• Were they bad executions? (You broke rules) → Fix your discipline.
• Were they good executions? (You followed rules but market chopped) → Accept it. The market is just in a bad phase for your strategy.

---

**Key Insight:**
You do NOT recover a 20% drawdown with one big 20% trade. You recover it with twenty 1% trades. Recovery is a slow, methodical crawl back to the surface. Patience is mandatory.
''',
          'keyPoints': [
            'Losing streaks are statistically guaranteed to happen',
            'Amateurs increase risk to recover; professionals decrease risk to survive',
            'When in a streak, halve your position size to rebuild confidence',
            'Recovery is a slow, methodical process, not a single lottery ticket',
          ],
        },
        {
          'type': 'scenario',
          'title': 'The Streak Decision',
          'situation':
              'You\'ve lost 6 trades in a row over 3 days. Your account is down 8%. You see a setup that looks absolutely perfect. How do you trade it?',
          'choices': [
            {
              'text': 'Double the risk (2%) to win back the losses in one go',
              'isCorrect': false,
              'feedback':
                  '❌ This is revenge trading. If this "perfect" setup fails (and they often do), you are now down 10% and in a severe psychological spiral. Never try to recover losses in a single trade.',
            },
            {
              'text':
                  'Skip it entirely — you should never trade after 6 losses',
              'isCorrect': false,
              'feedback':
                  '❌ Taking a break is good, but if a truly valid setup appears according to your plan, you shouldn\'t freeze completely out of fear. That breaks the probability math of your strategy.',
            },
            {
              'text':
                  'Take it, but halve your normal risk (0.5%). Your goal right now is restoring confidence, not making money.',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect professional response. By halving risk, a loss won\'t hurt you much further (-0.5%), but a win will restore your confidence and rhythm. You are treating trading as a process, not a slot machine.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 6 Complete! 🎉',
          'keyPoints': [
            'Drawdown math is brutal: 50% loss requires 100% gain',
            'Prevent large drawdowns through strict 1% risk rules',
            'When in a losing streak, the goal is survival, not recovery',
            'HALVE your position size during streaks to protect capital and psychology',
            'Step away for 48 hours to reset your nervous system',
            'Next: Identifying the emotional demons — Fear, Greed, and Overconfidence.',
          ],
        },
      ],
    };
  }
}
