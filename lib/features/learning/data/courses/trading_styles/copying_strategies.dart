/// Chapter 7: Why Copying Strategies Fails
class CopyingStrategiesContent {
  static Map<String, dynamic> getGuruIllusionContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Subscription Trap',
          'emoji': '🎪',
          'content':
              'India has 10,000+ "trading gurus" on YouTube, Instagram, and Telegram offering "95% accuracy tips." If their tips were truly 95% accurate, they would be billionaires. They are not. They make money from YOUR subscription, not from trading.',
        },
        {
          'type': 'concept',
          'title': 'Why Following Tips Always Fails',
          'emoji': '🔍',
          'content': '''
**Reason 1: Timing Gap ⏰**
The guru enters at ₹100. By the time you see the Telegram message, open your app, and place the order, the price is ₹105. Your entry is 5% worse. Your stop loss is tighter. Your R:R ratio is destroyed.

**Reason 2: Risk Mismatch 💰**
The guru has ₹20 Lakh capital and risks 0.5% per trade (₹10,000). You have ₹50,000 and risk the same trade with 20% of your capital. Same trade, completely different risk profiles.

**Reason 3: Exit Uncertainty 🚪**
The guru exits silently. You don't know if he took partial profit at ₹110 or held to ₹120. You are left holding a position with no exit plan.

**Reason 4: No Learning 🧠**
Following tips teaches you nothing about WHY the trade was taken. When the guru disappears (and they all do), you have zero independent skills.

**Reason 5: Survivorship Bias 📊**
You follow the guru AFTER he posts 10 winning trades (carefully curated). You miss the 40 losing trades he never shared.

---

**Key Insight:**
Trading tips are the financial equivalent of giving someone a fish vs teaching them to fish. This entire FinlearnPro course is designed to teach you to fish. Tips feed you for a day — and starve you for a lifetime.
''',
          'keyPoints': [
            'Timing gaps destroy the R:R of copied trades',
            'Risk profiles differ wildly between the guru and the follower',
            'Gurus curate wins and hide losses (survivorship bias)',
            'Following tips builds ZERO independent trading skill',
          ],
        },
        {
          'type': 'scenario',
          'title': 'The Telegram Temptation',
          'situation':
              'A friend adds you to a Telegram channel with 50,000 members. The admin posts live calls and shows daily P&L screenshots of ₹20,000+ profits. Subscription is ₹3,000/month. Several members post testimonials saying "I made ₹50,000 this month!" Should you subscribe?',
          'choices': [
            {
              'text': 'Yes — the testimonials prove it works',
              'isCorrect': false,
              'feedback':
                  '❌ Testimonials are heavily biased. Out of 50,000 members, maybe 50 posted wins (0.1%). The other 49,950 are silent losers. P&L screenshots can be edited in 30 seconds. The admin makes ₹3,000 × 50,000 = ₹15 Crore/month from subscriptions alone. THAT is their real business model.',
            },
            {
              'text':
                  'No. If the admin could really make ₹20,000/day trading, they would not need ₹3,000/month from 50,000 subscribers.',
              'isCorrect': true,
              'feedback':
                  '✅ Exactly. Ask yourself: Why would someone who makes ₹5-6 Lakh/month trading bother running a subscription service? Because they DON\'T make money from trading. They make money from YOUR subscription.',
            },
            {
              'text': 'Try the free trial first to test it',
              'isCorrect': false,
              'feedback':
                  '❌ Free trials are designed to hook you during a winning streak (cherry-picked period). Once you pay, the quality drops dramatically. This is a standard sales funnel.',
            },
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'What is the fundamental problem with following someone else\'s trading calls?',
          'options': [
            'The tips are usually wrong',
            'You cannot replicate the guru\'s exact timing, risk profile, and exit decisions',
            'It is illegal',
            'Brokers block tip-based trades',
          ],
          'correctIndex': 1,
          'explanation':
              'Even if the guru\'s analysis is correct, you will always enter later, size differently, and exit differently. The same trade taken by two different people at two different times with two different risk profiles produces completely different results. The tip might work for them and fail for you simultaneously.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Trading gurus make money from subscriptions, not from trading',
            'Copying trades fails due to timing gaps, risk mismatches, and exit uncertainty',
            'Testimonials are survivorship bias — you only hear from the lucky few',
            'Build YOUR OWN skills through the FinlearnPro curriculum',
            'Next: The final challenge — find your perfect trading style.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getFinalChallengeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Find Your Perfect Fit',
          'emoji': '🎯',
          'content':
              'You have explored all four trading styles and learned why copying others fails. Now let\'s test if you can recommend the right approach for different life situations.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Style Matching',
          'question':
              'Vivek is a doctor who works 12-hour shifts, earns ₹2L/month, and has ₹10L in savings. He wants to build wealth but has zero time for charts. What should he do?',
          'options': [
            'Quit his job and become a full-time trader',
            'Set up a monthly SIP of ₹50,000 in Nifty 50 Index Fund and do nothing else',
            'Start scalping on his phone between surgeries',
            'Join a Telegram options group',
          ],
          'correctIndex': 1,
          'explanation':
              'Vivek has high income, significant savings, and ZERO time. The SIP is the only fit. At ₹50,000/month for 20 years at 12%, he will have approximately ₹5 Crore. He doesn\'t need to stare at charts — compounding will do the work.',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: Risk Assessment',
          'question':
              'What percentage of your total savings should you allocate to active trading?',
          'options': [
            '100% — go all in for maximum returns',
            '50% — balanced approach',
            'Maximum 20% — the rest stays in long-term investments',
            'It doesn\'t matter — trading always makes money',
          ],
          'correctIndex': 2,
          'explanation':
              'The 80/20 rule: 80% in safe, long-term investments (SIPs, index funds). Maximum 20% in active trading as RISK capital you can afford to lose entirely. If trading fails, your financial foundation remains intact.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: The Guru Test',
          'question':
              'A YouTube trader claims "98% accuracy" on their trades. What is the most likely reality?',
          'options': [
            'They are genuinely a market genius',
            'They only show winning trades and delete losing ones (survivorship bias)',
            'It is verified by SEBI',
            '98% accuracy is normal for experienced traders',
          ],
          'correctIndex': 1,
          'explanation':
              'No trader in history has maintained 98% accuracy over a meaningful sample size. Even the best hedge funds average 55-65% win rates. "98% accuracy" means they are selectively showing winners and hiding losers. This is classic survivorship bias used to sell courses and subscriptions.',
        },
        {
          'type': 'scenario',
          'title': 'Your Final Decision',
          'situation':
              'After completing all 11 courses in FinlearnPro, you have ₹3 Lakh saved. You work a 9-5 job. You have been paper trading swing trades for 4 months with consistent profitability. What is your next step?',
          'choices': [
            {
              'text': 'Go full-time. Quit the job and trade with the full ₹3L.',
              'isCorrect': false,
              'feedback':
                  '❌ 4 months of paper trading is good but not enough to quit a steady income. Paper trading doesn\'t replicate the emotional pressure of real money. Never quit your job to trade.',
            },
            {
              'text':
                  'Keep the job. Invest ₹2.4L (80%) in SIPs. Use ₹60,000 (20%) as swing trading capital with strict 1% risk per trade.',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect professional approach. The 80/20 split protects your wealth. ₹60K at 1% risk = ₹600 max loss per trade — completely manageable. Keep building both your investment portfolio AND your trading skills simultaneously.',
            },
            {
              'text': 'Start trading options for faster returns',
              'isCorrect': false,
              'feedback':
                  '❌ You mastered swing trading in paper mode. Jumping to options adds Theta decay, Greeks, and leverage complexity. First prove your swing system works with real money. Then, maybe in 12+ months, consider learning options.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Congratulations! 🎓🎨',
          'keyPoints': [
            'Your trading style must match your personality, time, and capital',
            'Scalping is for full-time pros; Investing is for everyone',
            'Swing trading is the sweet spot for working professionals',
            'The 80/20 split protects your wealth while building trading skill',
            'Never follow tips — build your own independent analysis skills',
            'Calculate return per HOUR, not just total profit.',
          ],
        },
      ],
    };
  }
}
