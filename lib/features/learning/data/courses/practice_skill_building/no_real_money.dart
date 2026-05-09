/// Chapter 1: No Real Money Yet
/// The mandatory proving ground before funding your account
class NoRealMoneyContent {
  // Lesson 1.1: The Cost of Impatience
  static Map<String, dynamic> getCostOfImpatienceContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Most Expensive Mistake',
          'emoji': '💸',
          'content':
              'Imagine wanting to learn how to fly a plane, so you buy a Boeing 747, fill it with passengers, and try to take off having only watched a YouTube video. This is exactly what beginners do when they fund a trading account with real money on Day 1.',
        },
        {
          'type': 'story',
          'title': 'Karan\'s ₹2 Lakh Lesson',
          'emoji': '😰',
          'content': '''
**Karan**, 24, a marketing executive in Pune earning ₹6 Lakh/year.

After watching 20 YouTube trading videos over a weekend, he felt ready. He opened a Zerodha account on Monday and deposited **₹2,00,000** — his entire savings.

**Day 1:** Bought Tata Motors at ₹620. It went to ₹635. He sold. **+₹3,000.** "This is easy!"

**Day 3:** Bought Bank Nifty options. Lost ₹8,000 in 30 minutes. Panicked. Doubled down. Lost another ₹12,000. **Total Day 3: -₹20,000.**

**Week 2:** Tried to "recover" by buying risky penny stocks from a Telegram tip. Lost ₹35,000.

**Month 1 end:** Account balance: ₹1,18,000. **Down ₹82,000 (41%).**

**Karan's words:**
"I knew all the theory. I knew support, resistance, stop losses. But the moment I saw red on my screen with REAL money, my brain just... froze. I couldn't follow any rules."

**Key lesson:** Karan didn't fail because of knowledge. He failed because he skipped the simulation phase where emotional control is built.
''',
        },
        {
          'type': 'concept',
          'title': 'Why You Will Lose Your First Account',
          'emoji': '📉',
          'content': '''
**The universal truth of trading:**
Almost every successful trader blew up their first account. Many blew up their second and third.

**Why does this happen?**
Because trading is a performance skill, not just academic knowledge.
You can memorize the rules of tennis, but you still won't be able to hit a 100mph serve on your first day on the court. You need repetition.

**The "Tuition Fee" Myth:**
People say, "Losing your first account is just the tuition fee to the market."
**This is terrible advice.**
Harvard tuition is ₹50 Lakhs. Would you pay that if you could get the exact same education for free using a simulator?

**The Reality of Real Money:**
When real money is on the line, your brain chemistry changes. Fear and greed override logic. If you haven't built the "muscle memory" of executing trades mechanically in a safe environment, the adrenaline of real money will force you into terrible decisions.
''',
          'keyPoints': [
            'Trading is a performance skill that requires repetition, not just knowledge',
            'Almost everyone loses their first real-money account',
            'Paying "market tuition" by blowing up accounts is unnecessary and foolish',
            'Real money triggers adrenaline that overrides untrained logic',
          ],
        },
        {
          'type': 'scenario',
          'title': 'The Deposit Dilemma',
          'situation':
              'You just finished all 8 courses of FinlearnPro. You feel confident. Your friend says: "Just start with ₹10,000 — it is a small amount, you won\'t lose much." What do you do?',
          'choices': [
            {
              'text':
                  'Deposit ₹10,000 and start trading — it is a small learning investment',
              'isCorrect': false,
              'feedback':
                  '❌ ₹10,000 is "small" until you lose it. More importantly, you will build BAD HABITS because with ₹10K you cannot practice proper position sizing (1% = ₹100 — too small for most trades). You will be forced to risk 10-20% per trade, which is the opposite of what you learned.',
            },
            {
              'text':
                  'Open a paper trading account on TradingView and simulate for 3 months first',
              'isCorrect': true,
              'feedback':
                  '✅ The professional path. Paper trading lets you test your strategy, build execution habits, and experience different market conditions — all with ZERO financial risk. After 3 profitable months, you will enter the market with confidence AND competence.',
            },
            {
              'text':
                  'Wait until you have ₹5 Lakh saved, then start trading directly',
              'isCorrect': false,
              'feedback':
                  '❌ Having more capital without simulation experience just means BIGGER losses. The amount of capital doesn\'t fix the lack of practice. Paper trade first, then fund with whatever amount fits the 1% risk rule.',
            },
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Why is paper trading (simulation) considered essential before trading with real money?',
          'options': [
            'Because SEBI requires it',
            'Because it builds execution muscle memory without financial risk',
            'Because real money trading is illegal for beginners',
            'Because paper trading always makes you profitable',
          ],
          'correctIndex': 1,
          'explanation':
              'Paper trading builds the mechanical habits (entries, exits, stop losses, position sizing) that your brain needs to execute automatically. When real money adds emotional pressure, these habits are your only defense against panic decisions. SEBI does not require it, but common sense does.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Never fund a trading account on Day 1.',
            'Karan lost 41% of his savings because he skipped simulation training.',
            'You wouldn\'t fly a plane without a simulator; don\'t trade without one.',
            'Losing real money is not a required step to becoming profitable.',
            '₹10,000 "learning money" builds bad habits, not good ones.',
            'Next: The simulation rule — exactly how long you must practice.',
          ],
        },
      ],
    };
  }

  // Lesson 1.2: The Simulation Rule
  static Map<String, dynamic> getSimulationRuleContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The 3-Month Rule',
          'emoji': '⏱️',
          'content':
              'To protect your capital, you must pass a test. You cannot trade with real money until you prove you are consistently profitable in a simulated environment.',
        },
        {
          'type': 'interactive',
          'title': 'The Pilot Analogy',
          'emoji': '✈️',
          'content': '''
**How other professions train:**

| Profession | Simulation Hours | Before Real Practice |
|-----------|-----------------|---------------------|
| **Airline Pilot** | 1,500+ hours in flight simulator | Before touching a real plane |
| **Surgeon** | 10,000+ hours cadaver practice | Before operating on a patient |
| **Soldier** | 6+ months boot camp drills | Before seeing combat |
| **Trader** | ??? | Most skip straight to real money! 🤯 |

**The trading simulation equivalent:**
• 3 months × 20 trading days = **60 trading sessions**
• 60 sessions × 3 trades/day = **180 practice trades**
• 180 trades is enough data to prove if your system works

**Would you let a pilot fly you who skipped the simulator?**
Then why would you trust your savings to a trader (YOU) who skipped simulation?
''',
        },
        {
          'type': 'concept',
          'title': 'The Proving Ground',
          'emoji': '🏆',
          'content': '''
**The Golden Rule:**
You are forbidden from using real money until you have achieved **3 consecutive months of net profitability** in a paper trading (simulator) account.

**Why 3 Months?**
• **Month 1:** You might just get lucky. The market might be in a massive uptrend where buying anything makes money.
• **Month 2:** The market changes condition (e.g., goes sideways). Your luck runs out. You learn to adapt.
• **Month 3:** You prove that your system works across different market conditions and that your discipline holds up over time.

**The Psychology of the Rule:**
If you can't be profitable with fake money (where there is zero fear or stress), you have a **0.00% chance** of being profitable with real money (where fear and stress are maximized).

**"But I'm missing out on profits!"**
No, you are missing out on losses. The market will be here in 3 months. It will be here in 30 years. There is no rush.
''',
          'keyPoints': [
            'Rule: 3 consecutive months of paper trading profit before real money',
            'One month of profit can be luck; three months proves statistical edge',
            'If you can\'t win with fake money, you cannot win with real money',
            'The market isn\'t going anywhere — FOMO is your enemy',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You paper traded for 2 weeks and made a hypothetical 15% return. You feel extremely confident. What is the next logical step?',
          'options': [
            'Fund a real account immediately — clearly you have a natural talent.',
            'Fund a small real account to test the waters.',
            'Continue paper trading for another 2.5 months to prove consistency.',
            'Start selling your trading signals to others.',
          ],
          'correctIndex': 2,
          'explanation':
              'Two weeks of profit is statistically insignificant. It is usually the result of a short-term market trend combined with beginner\'s luck. The 3-month rule is non-negotiable. You must prove consistency across different market cycles.',
        },
        {
          'type': 'scenario',
          'title': 'Month 2 Frustration',
          'situation':
              'You are in Month 2 of paper trading. Month 1 was profitable (+5%). But Month 2 has been terrible — you are down 3% and it is day 15. Your strategy seems broken. A friend says: "Paper trading is pointless, just start real trading and you\'ll learn faster." What do you do?',
          'choices': [
            {
              'text':
                  'Agree with the friend. Switch to a real account with small capital.',
              'isCorrect': false,
              'feedback':
                  '❌ This is exactly what the simulation period is designed to test. Month 2\'s struggle means the MARKET CHANGED (from trending to choppy), and your strategy needs adjustment. If you switch to real money NOW, you\'ll lose this drawdown PLUS the emotional spiral that follows.',
            },
            {
              'text':
                  'Continue paper trading. Analyze WHY Month 2 is different from Month 1. Adjust your strategy using your journal data.',
              'isCorrect': true,
              'feedback':
                  '✅ This is the professional response. The fact that Month 2 is different from Month 1 is the ENTIRE POINT of the 3-month rule. Learning to adapt to changing conditions is the most valuable skill you can develop — and you\'re developing it for FREE.',
            },
            {
              'text':
                  'Abandon your current strategy entirely and find a new one on YouTube.',
              'isCorrect': false,
              'feedback':
                  '❌ Strategy-hopping after one bad month is a beginner trap. You need at least 20-30 trades before judging a strategy. Adapt, don\'t abandon.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 1 Complete! 🎉',
          'keyPoints': [
            'Starting with real money guarantees an expensive tuition fee',
            'Pilots train 1,500+ hours in simulators — traders should paper trade at least 3 months',
            'The Golden Rule: 3 consecutive months of simulated profit before real money',
            'Month 2 struggles are EXPECTED and valuable — they teach adaptation',
            'If you fail in simulation, you will definitely fail in reality',
            'Next: How to actually paper trade correctly without building bad habits.',
          ],
        },
      ],
    };
  }
}
