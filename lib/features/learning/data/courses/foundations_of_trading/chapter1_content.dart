/// Chapter 1: What is Trading & Investing
/// Complete interactive content for all lessons in this chapter
class Chapter1Content {
  // Lesson 1: Trading vs Investing
  static Map<String, dynamic> getTradingVsInvestingContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Trading vs Investing',
          'emoji': '🎯',
          'content':
              'Welcome to your first lesson! You\'re about to learn the fundamental difference between trading and investing. This knowledge will shape your entire financial journey. Let\'s start with a story about two friends who took different paths...',
        },
        {
          'type': 'story',
          'title': 'Meet Raj and Priya',
          'emoji': '👥',
          'content': '''
Raj and Priya are college friends. Both just got their first job and have ₹1 lakh saved.

**Raj's Approach:**
"I want to make quick money! I'll buy and sell stocks every day. I saw someone on YouTube make ₹50,000 in one day!"

He starts trading actively:
• Checks his phone every 5 minutes
• Buys when prices go up (FOMO)
• Sells when prices drop (panic)
• Follows random tips from WhatsApp groups

**Priya's Approach:**
"I want to build wealth for my future. I'll invest in good companies and hold them for years."

She starts investing systematically:
• Researches companies thoroughly
• Invests monthly (SIP style)
• Ignores daily price movements
• Focuses on long-term growth

**5 Years Later...**

Raj's account: ₹87,000 (Lost ₹13,000 + countless hours of stress)
Priya's account: ₹2,85,000 (Almost 3x return + peace of mind)

What made the difference? Let's find out.
''',
        },
        {
          'type': 'concept',
          'title': 'Trading vs Investing: The Core Difference',
          'emoji': '📊',
          'content': '''
**TRADING** is buying and selling assets frequently to profit from short-term price movements.

**Time Horizon:** Days, weeks, or months
**Goal:** Quick profits from price swings
**Approach:** Active, requires constant monitoring
**Skills Needed:** Technical analysis, chart reading, timing
**Risk Level:** HIGH (90% of traders lose money)
**Time Commitment:** Full-time job
**Stress Level:** Very high

---

**INVESTING** is buying assets to hold long-term and build wealth over time.

**Time Horizon:** Years or decades
**Goal:** Wealth building through compound growth
**Approach:** Passive, buy and hold
**Skills Needed:** Fundamental analysis, patience
**Risk Level:** LOWER (time reduces volatility)
**Time Commitment:** Part-time research
**Stress Level:** Much lower

---

**Key Insight:** Neither is "better" - they're different games with different rules. But for beginners, investing is safer and more proven.
''',
          'keyPoints': [
            'Trading = Short-term, active, high-risk, requires expertise',
            'Investing = Long-term, passive, lower-risk, beginner-friendly',
            'Time is your biggest advantage as an investor',
            '90% of traders lose money, but patient investors usually win',
            'You can do both, but master investing first',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Sarah wants to buy stocks and hold them for 10+ years to fund her daughter\'s education. Is she trading or investing?',
          'options': ['Trading', 'Investing', 'Both', 'Neither'],
          'correctIndex': 1,
          'explanation':
              'Sarah is investing! Her long time horizon (10+ years) and wealth-building goal (education fund) are classic investing characteristics. She\'s not trying to make quick profits from price swings.',
        },
        {
          'type': 'scenario',
          'title': 'What Would You Do?',
          'situation':
              'You have ₹50,000 saved. A friend tells you about a "hot stock tip" that could double in a week. What do you do?',
          'choices': [
            {
              'text': 'Invest all ₹50,000 immediately',
              'isCorrect': false,
              'feedback':
                  '❌ Dangerous! This is gambling, not investing. Hot tips are usually cold by the time you hear them. You could lose everything.',
            },
            {
              'text': 'Research the company thoroughly first',
              'isCorrect': true,
              'feedback':
                  '✅ Smart! Never invest based on tips alone. Do your own research. If it\'s truly a good opportunity, it\'ll still be there after you research.',
            },
            {
              'text': 'Ignore it and keep money in savings',
              'isCorrect': true,
              'feedback':
                  '✅ Also valid! If you don\'t understand it, don\'t invest in it. Better to miss an opportunity than lose your hard-earned money.',
            },
            {
              'text': 'Ask the friend for proof of their gains',
              'isCorrect': true,
              'feedback':
                  '✅ Good thinking! Most "hot tips" are unverified. If your friend really made money, they should have proof. But even then, do your own research.',
            },
          ],
        },
        {
          'type': 'interactive',
          'title': 'The Compound Interest Magic',
          'emoji': '🪄',
          'content': '''
Let's see why Priya's investing approach won:

**Raj (Trading):**
• Started with: ₹1,00,000
• Average annual return: -3% (losses from bad trades)
• After 5 years: ₹87,000
• Stress level: 😰😰😰😰😰

**Priya (Investing):**
• Started with: ₹1,00,000
• Average annual return: 15% (market average)
• After 5 years: ₹2,01,136
• Stress level: 😊

**But wait, Priya did even better!**
She also invested ₹5,000 every month (SIP):
• Total invested: ₹1,00,000 + (₹5,000 × 60 months) = ₹4,00,000
• Final value after 5 years: ₹5,28,000+
• Total gain: ₹1,28,000+

**The Power of:**
1. Time in the market (not timing the market)
2. Regular investing (SIP)
3. Compound interest
4. Patience

This is why Warren Buffett says: "The stock market is a device for transferring money from the impatient to the patient."
''',
        },
        {
          'type': 'summary',
          'title': 'Key Takeaways',
          'keyPoints': [
            'Trading and investing are fundamentally different approaches to the market',
            'Trading is short-term, high-risk, and requires expertise (90% fail)',
            'Investing is long-term, lower-risk, and proven to work for patient people',
            'Time is your biggest advantage - compound interest works magic over years',
            'Never invest based on tips - always do your own research',
            'For beginners: Start with investing, not trading',
          ],
        },
      ],
    };
  }

  // Lesson 2: Why People Trade (And Why Most Fail)
  static Map<String, dynamic> getWhyPeopleTradeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Why People Trade (And Fail)',
          'emoji': '⚠️',
          'content':
              'In this lesson, we\'re going to explore the harsh reality of trading. You\'ll learn why 90% of traders lose money and what mistakes they make. This isn\'t meant to discourage you—it\'s meant to prepare you. Let\'s meet Amit and see what went wrong...',
        },
        {
          'type': 'story',
          'title': 'The Allure of Trading',
          'emoji': '💰',
          'content': '''
Meet Amit, a 25-year-old software engineer earning ₹8 lakhs per year.

One day, he sees a YouTube video:
**"I made ₹50,000 in ONE DAY trading stocks! You can too!"**

Amit's mind races:
"If I make ₹50k per day × 20 trading days = ₹10 lakhs per month!"
"That's more than my annual salary in just one month!"
"I'll quit my job and become a full-time trader!"

**Week 1:** 
He opens a trading account, deposits ₹1 lakh, watches 10 YouTube videos, and starts trading.

First trade: Buys Reliance at ₹2,500
Price goes to ₹2,520 → He makes ₹2,000!
"This is easy! I'm a genius!" 😎

**Week 2:**
Buys TCS at ₹3,400
Price drops to ₹3,350 → Down ₹5,000
"It'll come back up..." (It doesn't)
Panic sells at ₹3,320 → Lost ₹8,000 😰

**Week 3:**
Desperate to recover losses
Takes bigger risks
Loses ₹15,000 more
"I need to win this back!" 😡

**Week 4:**
Account down 40% (₹40,000 lost)
Stops trading
Deletes trading app
Never talks about it again 😔

**What went wrong?**
''',
        },
        {
          'type': 'concept',
          'title': 'Why 90% of Traders Fail',
          'emoji': '📉',
          'content': '''
**The Harsh Truth:** 90% of retail traders lose money. Here's why:

**1. Unrealistic Expectations**
• They expect to get rich quick
• They see success stories, not the 90% who failed
• They underestimate how hard trading actually is

**2. No Proper Education**
• They watch a few YouTube videos and think they're ready
• They don't understand risk management
• They don't have a proven strategy

**3. Emotional Decisions**
• **Fear:** They panic-sell when prices drop
• **Greed:** They hold winners too long, hoping for more
• **FOMO:** They buy when everyone else is buying (at peaks)
• **Revenge Trading:** They try to "win back" losses with bigger bets

**4. No Risk Management**
• They risk too much per trade (sometimes 50%+ of capital!)
• They don't use stop-losses
• They don't diversify

**5. Overtrading**
• They trade too frequently (racking up fees)
• They can't sit still and wait for good opportunities
• Every price movement feels like a "must trade" moment

**6. Following Tips**
• They rely on WhatsApp groups, Twitter, Telegram
• They don't do their own analysis
• By the time they get the "tip," it's too late

**7. Underestimating Costs**
• Brokerage fees
• Taxes (short-term capital gains = 15%)
• Time and stress
''',
          'keyPoints': [
            '90% of traders lose money - it\'s not a game',
            'Success requires years of education and practice',
            'Emotions (fear, greed, FOMO) are the biggest enemies',
            'Most "trading gurus" make money selling courses, not trading',
            'The house always wins - brokers profit from your trades',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Reality Check',
          'question':
              'What percentage of retail traders actually make consistent profits?',
          'options': ['About 90%', 'About 50%', 'About 10%', 'About 1%'],
          'correctIndex': 2,
          'explanation':
              'Only about 10% of retail traders make consistent profits. Some studies suggest it\'s even lower (5% or less). Trading is extremely difficult, and most people underestimate the skill, discipline, and capital required.',
        },
        {
          'type': 'scenario',
          'title': 'The Revenge Trading Trap',
          'situation':
              'You just lost ₹10,000 on a trade. You\'re frustrated and want to win it back. What do you do?',
          'choices': [
            {
              'text': 'Take a bigger position to recover losses faster',
              'isCorrect': false,
              'feedback':
                  '❌ This is "revenge trading" - the #1 way traders blow up their accounts. Emotional decisions lead to bigger losses.',
            },
            {
              'text': 'Stop trading for the day and analyze what went wrong',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect! Taking a break prevents emotional decisions. Analyze your mistake, learn from it, and come back with a clear mind.',
            },
            {
              'text': 'Follow a "hot tip" to make quick money',
              'isCorrect': false,
              'feedback':
                  '❌ Desperate decisions lead to more losses. Hot tips are rarely reliable, especially when you\'re emotional.',
            },
            {
              'text': 'Accept the loss and stick to your original strategy',
              'isCorrect': true,
              'feedback':
                  '✅ Excellent! Losses are part of trading. The key is to keep them small and stick to your proven strategy, not chase losses.',
            },
          ],
        },
        {
          'type': 'interactive',
          'title': 'The Real Cost of Trading',
          'emoji': '💸',
          'content': '''
Let's calculate the REAL cost of active trading:

**Scenario:** You have ₹1 lakh and trade actively

**Direct Costs:**
• Brokerage: ₹20 per trade × 200 trades/year = ₹4,000
• STT (Securities Transaction Tax): ~0.1% = ₹1,000
• GST on brokerage: 18% of ₹4,000 = ₹720
• Stamp duty: ~0.015% = ₹150

**Total Direct Costs:** ₹5,870 per year

**Indirect Costs:**
• Short-term capital gains tax: 15% of profits
• Time spent: 3 hours/day × 250 days = 750 hours/year
  (If your time is worth ₹500/hour = ₹3,75,000!)
• Stress and health impact: Priceless (but costly)

**Opportunity Cost:**
If you had invested that ₹1 lakh in an index fund:
• Average return: 12% per year
• After 5 years: ₹1,76,234
• Gain: ₹76,234

**The Reality:**
Most active traders:
• Lose money after costs
• Waste hundreds of hours
• Experience high stress
• Miss out on simple index fund returns

**The Math Doesn't Lie:**
To break even as a trader, you need to:
1. Beat the market return (12%)
2. Cover all costs (6%+)
3. Beat inflation (6%)
= You need 24%+ annual returns just to break even!

Only 1-2% of traders achieve this consistently.
''',
        },
        {
          'type': 'summary',
          'title': 'The Bottom Line',
          'keyPoints': [
            'Trading looks easy but is extremely difficult in reality',
            '90% of traders lose money due to lack of education, discipline, and realistic expectations',
            'Emotions (fear, greed, FOMO, revenge) are the biggest killers',
            'The costs of trading (fees, taxes, time, stress) are massive',
            'You need 20%+ returns just to break even after all costs',
            'If you still want to trade: Get educated, practice for years, start small',
            'For most people: Long-term investing beats active trading',
          ],
        },
      ],
    };
  }

  // Lesson 3: Your First Reality Check (Quiz)
  static Map<String, dynamic> getRealityCheckContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Reality Check Quiz',
          'emoji': '🎯',
          'content':
              'Let\'s test if you\'ve understood the harsh truths about trading vs investing. This quiz will challenge your assumptions and ensure you\'re ready to move forward with realistic expectations.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1',
          'question':
              'Your friend made ₹20,000 in one day trading. What\'s the most likely reality?',
          'options': [
            'They have a secret strategy you should copy',
            'They got lucky, and you\'re not seeing their losses',
            'Trading is easy money for everyone',
            'You should quit your job and trade too',
          ],
          'correctIndex': 1,
          'explanation':
              'Most people only share their wins, not their losses. One lucky day doesn\'t make someone a successful trader. For every ₹20k win, they might have ₹50k in losses they\'re not telling you about.',
        },
        {
          'type': 'quiz',
          'title': 'Question 2',
          'question':
              'You have ₹50,000 to invest. What\'s the smartest first step?',
          'options': [
            'Put it all in one "hot stock" for quick gains',
            'Learn the basics, start small, and build knowledge',
            'Follow a Telegram group\'s tips',
            'Trade daily to maximize opportunities',
          ],
          'correctIndex': 1,
          'explanation':
              'Education first, money second. Start with small amounts while you learn. The market will still be there when you\'re ready. Rushing in is how most people lose money.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3',
          'question': 'What\'s the main reason 90% of traders fail?',
          'options': [
            'The market is rigged against retail traders',
            'They lack emotional discipline and proper education',
            'They don\'t have enough capital',
            'The brokerage fees are too high',
          ],
          'correctIndex': 1,
          'explanation':
              'While the market is competitive, the main reason is lack of education and emotional control. Fear, greed, and FOMO cause most losses, not external factors.',
        },
        {
          'type': 'quiz',
          'title': 'Question 4',
          'question':
              'If you want to build wealth over 10+ years, what should you focus on?',
          'options': [
            'Day trading for quick profits',
            'Long-term investing in quality assets',
            'Following stock tips from social media',
            'Timing the market perfectly',
          ],
          'correctIndex': 1,
          'explanation':
              'For long-term wealth building, investing beats trading. Time in the market beats timing the market. Compound interest works magic over decades.',
        },
        {
          'type': 'quiz',
          'title': 'Question 5',
          'question':
              'You lost ₹5,000 on your first trade. What should you do?',
          'options': [
            'Take a bigger position to win it back quickly',
            'Stop, analyze what went wrong, and learn from it',
            'Follow a "guaranteed" tip to recover losses',
            'Keep trading until you break even',
          ],
          'correctIndex': 1,
          'explanation':
              'Losses are tuition fees in the market. Stop, learn, and improve. Revenge trading (trying to win back losses) is how small losses become big disasters.',
        },
        {
          'type': 'summary',
          'title': 'Reality Check Complete! ✅',
          'keyPoints': [
            'You now understand the difference between trading and investing',
            'You know why 90% of traders fail (and how to avoid their mistakes)',
            'You recognize that education and patience beat quick-money schemes',
            'You\'re ready to learn the fundamentals with realistic expectations',
            'Remember: The goal is to build wealth, not to gamble',
          ],
        },
      ],
    };
  }
}
