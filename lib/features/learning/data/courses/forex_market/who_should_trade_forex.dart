/// Chapter 9: Who Should Trade Forex
/// Honest self-assessment and final challenge
class WhoShouldTradeForexContent {
  // Lesson 9.1: The Forex Readiness Checklist
  static Map<String, dynamic> getReadinessChecklistContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Hardest Question',
          'emoji': '🪞',
          'content':
              'You\'ve learned about pairs, leverage, sessions, and risks. Now the real question: Should YOU trade forex? The answer isn\'t the same for everyone. Let\'s be brutally honest.',
        },
        {
          'type': 'concept',
          'title': 'Forex Readiness Checklist',
          'emoji': '📋',
          'content': '''
**Financial Prerequisites (ALL must be YES):**
✅ Emergency fund of 6+ months of expenses
✅ Zero high-interest debt (credit cards cleared)
✅ Stable income that covers ALL living expenses
✅ Money allocated to forex = money you can 100% LOSE
✅ NO borrowed money — never trade forex with loans

**Knowledge Prerequisites:**
✅ You understand leverage, margin, and stop losses
✅ You can read currency pairs and calculate pip values
✅ You know which sessions to trade and which to avoid
✅ You've practiced on a demo account for at least 3 months
✅ You have a written trading plan with specific rules

**Psychological Prerequisites:**
✅ You can accept being wrong 50-60% of the time
✅ You won't revenge-trade after a losing streak
✅ You can close a winning trade at your target (not get greedy)
✅ You won't trade out of boredom at 2 AM
✅ You can survive a 20% drawdown without quitting or panicking

---

**Key Insight:**
If you checked YES to ALL items, you MIGHT be ready. If even one is NO, you're not ready yet. And that's okay — most successful forex traders spent 1-2 years learning before trading live.
''',
          'keyPoints': [
            'Financial, knowledge, and psychological readiness are ALL required',
            'Practice on demo for at least 3 months before going live',
            'Never trade forex with borrowed money or essential savings',
            'If even one prerequisite is missing — you\'re not ready yet',
          ],
        },
        {
          'type': 'story',
          'title': 'Amit vs Kavya: Two Journeys',
          'emoji': '👬',
          'content': '''
**Amit (The Rusher) — Lost ₹3 Lakhs:**
• Watched 5 YouTube videos about forex.
• Opened a live account with ₹1 Lakh (his only savings).
• Used 100x leverage from day one.
• No stop losses — "I'll watch the screen."
• First week: Made ₹15,000. "I'm a natural!"
• Second week: Lost ₹40,000 on a single trade. Panic.
• Month 3: Down to ₹8,000. Deposits ₹2 more Lakhs to "win it back."
• Month 6: ₹3 Lakhs gone. Deletes the app. Tells nobody.

**Kavya (The Professional) — Making steady profits:**
• Spent 6 months reading, studying, and paper trading.
• Demo-traded for 3 months with realistic conditions.
• Opened live account with ₹50,000 (5% of savings, not essential money).
• Uses max 10x leverage. Always sets stop losses.
• Follows the 1% rule — max ₹500 risk per trade.
• Trades ONLY during London-NY overlap (her best window).
• Month 1: Lost ₹2,000 (but learned valuable lessons).
• Month 3: Breakeven after refining her strategy.
• Month 6: Up ₹8,000 (16% return). Not flashy, but consistent.

**The Difference:**
Amit treated forex like a casino. Kavya treated it like a business.
Amit sought excitement. Kavya sought consistency.
Amit's story lasts 6 months. Kavya's is still going.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Honest Assessment',
          'situation':
              'Your friend says: "I started forex trading last month. I\'m already up ₹50,000! You should join me — I\'ll share my signals." What do you do?',
          'choices': [
            {
              'text': 'Join immediately — ₹50,000 in a month is incredible!',
              'isCorrect': false,
              'feedback':
                  '❌ Beginner\'s luck is the most dangerous thing in forex. Making money in month 1 with no risk management means the inevitable loss will be catastrophic. Also, "signal sharing" is how pump-and-dump schemes work. Don\'t follow blindly.',
            },
            {
              'text':
                  'Study forex independently, practice on demo for 3 months, then decide based on YOUR own analysis',
              'isCorrect': true,
              'feedback':
                  '✅ The only right answer. Your friend\'s results are irrelevant to your readiness. If you can\'t generate your own trade ideas, you\'ll always depend on someone else — and when they stop (or start losing), you\'re helpless.',
            },
            {
              'text':
                  'Ask your friend to teach you everything in a weekend, then start trading',
              'isCorrect': false,
              'feedback':
                  '❌ Forex cannot be learned in a weekend. It took you 9 chapters just to understand the basics. Live trading with real money requires months of practice, a written plan, and psychological preparation. Shortcuts lead to losses.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Forex readiness requires financial, knowledge, AND psychological preparation',
            'Demo trade for at least 3 months before going live with real money',
            'The difference between winners and losers is patience, not talent',
            'Never follow "signals" — learn to generate your own trade ideas',
            'If you\'re not ready today, that\'s okay — the forex market will be there tomorrow',
          ],
        },
      ],
    };
  }

  // Lesson 9.2: Final Challenge: Forex Pro
  static Map<String, dynamic> getFinalChallengeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Final Test',
          'emoji': '🏆',
          'content':
              'You\'ve completed the entire Forex Trading course — 9 chapters covering everything from currency pairs to leverage to risk management. Let\'s see if you can call yourself Forex-Ready.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Currency Pairs',
          'question':
              'EUR/USD is quoted at 1.1050. You BUY 1 Standard Lot (100,000 EUR). What are you actually doing?',
          'options': [
            'Buying 100,000 Euros and simultaneously selling 110,500 US Dollars',
            'Buying 110,500 US Dollars and selling Euros',
            'Buying 1,10,500 Indian Rupees worth of Euros',
            'Depositing 100,000 Euros in your bank account',
          ],
          'correctIndex': 0,
          'explanation':
              'When you BUY EUR/USD, you are buying the Base (EUR) and selling the Quote (USD). At 1.1050, each Euro costs 1.1050 USD. So 100,000 EUR × 1.1050 = 110,500 USD sold. You now hold Euros and owe Dollars.',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: Leverage',
          'question':
              'You have ₹2,00,000 in your forex account with 50x leverage. The market moves 1.5% against your full-leveraged position. How much do you lose?',
          'options': [
            '₹3,000 (1.5% of your capital)',
            '₹30,000 (15% of your capital)',
            '₹1,50,000 (75% of your capital)',
            '₹2,00,000+ (more than your entire account)',
          ],
          'correctIndex': 2,
          'explanation':
              'With 50x leverage, ₹2L controls ₹1 Crore. A 1.5% move on ₹1 Crore = ₹1,50,000 loss. That\'s 75% of your ₹2L account — from just a 1.5% market move! This is why leverage is called the "double-edged sword" of forex.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: Sessions',
          'question':
              'An Indian trader wants to trade EUR/USD with the tightest possible spreads. When is the optimal trading window (IST)?',
          'options': [
            '6:00 AM - 9:00 AM (Asian session)',
            '6:30 PM - 10:30 PM (London-New York overlap)',
            '12:00 AM - 3:00 AM (Late US session)',
            'Any time — spreads are the same 24 hours',
          ],
          'correctIndex': 1,
          'explanation':
              'The London-New York overlap (6:30-10:30 PM IST) is when both the European and American markets are simultaneously open. This creates maximum liquidity for EUR/USD, resulting in the tightest spreads (0.1-0.3 pips) and best trade execution.',
        },
        {
          'type': 'quiz',
          'title': 'Question 4: Risk Management',
          'question':
              'You have ₹5,00,000 in your forex account. Following the 1% rule, what is the maximum amount you should risk on a single trade?',
          'options': [
            '₹50,000 (10%)',
            '₹25,000 (5%)',
            '₹5,000 (1%)',
            '₹500 (0.1%)',
          ],
          'correctIndex': 2,
          'explanation':
              'The 1% rule states: never risk more than 1% of your total account on a single trade. 1% of ₹5,00,000 = ₹5,000. This means your stop loss × position size must not exceed ₹5,000. With this rule, you can survive 100 consecutive losses before blowing up.',
        },
        {
          'type': 'scenario',
          'title': 'The Ultimate Forex Scenario',
          'situation':
              'You\'ve been profitable for 3 months trading EUR/USD. A friend shows you an offshore broker offering 500x leverage on GBP/JPY (an extremely volatile pair you\'ve never traded). "Bro, one trade and you can make your annual salary!" What\'s your response?',
          'choices': [
            {
              'text':
                  'Open an account — you\'re already profitable so you can handle higher leverage',
              'isCorrect': false,
              'feedback':
                  '❌ Being profitable on EUR/USD with regulated leverage doesn\'t prepare you for GBP/JPY with 500x leverage. That\'s like saying "I can drive a car, so I can fly a fighter jet." Different pair + extreme leverage + unregulated broker = recipe for total account destruction.',
            },
            {
              'text':
                  'Decline — 500x leverage + unregulated broker + unfamiliar pair violates every risk rule you\'ve learned',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect! You identified three red flags: (1) 500x leverage is suicidal, (2) offshore unregulated broker = no protection, (3) GBP/JPY requires separate expertise. True professionals INCREASE discipline with experience, not recklessness.',
            },
            {
              'text': 'Try it with a small amount — ₹10,000 "fun money"',
              'isCorrect': false,
              'feedback':
                  '❌ "Fun money" on an unregulated broker gives them your banking details and personal information. Also, if ₹10,000 works, psychological temptation to deposit more is enormous. The smartest risk is the one you don\'t take.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Congratulations! 🎉',
          'keyPoints': [
            'You understand currency pairs, pips, lots, and position sizing',
            'You know the three trading sessions and optimal timing for Indian traders',
            'You grasp leverage, margin, and why 100x leverage is a death sentence',
            'You can identify broker scams and forex-specific risks',
            'You have a risk management framework: 1% rule, stop losses, R:R ratios',
            'You\'re now equipped to enter the forex market with knowledge, discipline, and respect for risk 💪',
          ],
        },
      ],
    };
  }
}
