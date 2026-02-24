/// Chapter 1: What is Trading & Investing
/// Complete interactive content for all lessons in this chapter
class WhatIsTradingInvestingContent {
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
**Raj** and **Priya** are college friends. Both just got their first job and have ₹1 lakh saved.

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

**Raj's** account: ₹87,000 (Lost ₹13,000 + countless hours of stress)
**Priya's** account: ₹2,85,000 (Almost 3x return + peace of mind)

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
              'Here\'s a shocking truth: 90-95% of retail traders lose money. Not just some money—many lose everything. In this lesson, you\'ll discover the psychological traps, hidden costs, and brutal realities that destroy trading accounts. This isn\'t meant to scare you—it\'s meant to save you. Let\'s meet Amit and see what went wrong...',
        },
        {
          'type': 'story',
          'title': 'The YouTube Dream',
          'emoji': '💰',
          'content': '''
Meet **Amit**, a 28-year-old software engineer in Bangalore earning ₹12 lakhs per year.

One evening, YouTube recommends a video:
**"I made ₹1,50,000 in ONE WEEK trading options! Here's how!"**

**Amit** watches, mesmerized:
• The trader shows screenshots of massive gains
• "It's so simple! Just follow these patterns!"
• "I quit my job and now make ₹5 lakhs per month!"

**Amit's Calculation:**
"If I make ₹1.5 lakhs per week × 4 weeks = ₹6 lakhs per month!"
"That's half my annual salary in ONE month!"
"I'll trade part-time and double my income!" 💭

**Week 1: The Beginner's Luck**
• Opens Zerodha account, deposits ₹2 lakhs (his savings)
• Watches 5 YouTube videos, joins 3 Telegram groups
• First trade: Buys Nifty Call Option at ₹150
• Market goes up! Sells at ₹180 → Makes ₹15,000! 🎉
• "This is EASY! I'm a natural trader!"

**Week 2: The Confidence Trap**
• Increases position size (now trading ₹50k per trade)
• Buys Bank Nifty Put Option at ₹200
• Market moves against him → Option expires worthless
• Loss: ₹50,000 😰
• "It's okay, I'll recover it tomorrow..."

**Week 3: The Revenge Trading Spiral**
• Desperate to recover ₹50k loss
• Takes bigger risks, trades more frequently
• Follows every "hot tip" from Telegram
• Loses another ₹60,000 😡
• "I NEED to win this back!"

**Week 4: The Crash**
• Account down 55% (₹1,10,000 lost)
• Takes one final "all-in" bet
• Loses ₹30,000 more
• Total remaining: ₹60,000 out of ₹2,00,000 😔

**3 Months Later:**
• **Amit** stops trading
• Deletes all trading apps
• Never tells anyone about the ₹1.4 lakh loss
• Goes back to his job, feeling defeated

**What destroyed Amit's account?**
''',
        },
        {
          'type': 'concept',
          'title': 'The Psychology of Failure',
          'emoji': '🧠',
          'content': '''
**Why 90% of Traders Fail: It's All in the Mind.**

**1. Overconfidence Bias**
One win ≠ Skill. Amit felt like a genius after one lucky trade.
**Reality:** You need 100+ trades to prove you're good.

**2. Loss Aversion**
We feel losses 2.5x more than gains.
**Result:** Holding losers hoping they recover (Gambling) vs Selling winners too early (Fear).

**3. Revenge Trading (The Killer)**
Trying to "win back" lost money immediately.
**Fact:** 70% of revenge traders blow up their accounts in 3 months.

**4. FOMO & The Herd**
Chasing "Hot Tips" or moving prices.
**Truth:** By the time you hear a tip, the smart money has already sold.
''',
          'keyPoints': [
            'Overconfidence after early wins is the #1 psychological trap',
            'Loss aversion makes you hold losers and sell winners too early',
            'Revenge trading (emotional decisions) destroys 70% of accounts',
            'FOMO causes overtrading—the best traders wait patiently',
            'Following tips = buying high, selling low (you\'re the exit liquidity)',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The Real Cost of Trading',
          'emoji': '💸',
          'content': '''
**The BRUTAL Math of Trading (India 2024):**

**Scenario:** ₹2 Lakhs Capital, Active Options Trading.

**1. The Hidden Fees (11% Loss)**
Before you even start, you pay:
• Brokerage + GST
• STT (Transaction Tax)
• Exchange Charges
**Total:** ~₹22,000/year (Just to play!)

**2. The Break-Even Challenge**
To make REAL money, you need to beat:
• Market Return (12%)
• Inflation (6%)
• Costs (11%)
**Target:** You need **29% returns** just to be *average*.

**3. The Reality**
• Only 1% of traders consistently beat 29%.
• 76% of retail traders lose money.

**Warren Buffett says:**
"The stock market transfers money from the impatient to the patient."
''',
        },
        {
          'type': 'quiz',
          'title': 'Reality Check',
          'question':
              'What percentage of retail traders actually make consistent profits?',
          'options': ['About 50%', 'About 25%', 'About 10%', 'About 1-5%'],
          'correctIndex': 3,
          'explanation':
              'Only 1-5% of retail traders make consistent profits. Studies show 76% of retail accounts lose money, and 90-95% fail within the first year. The odds are worse than a casino!',
        },
        {
          'type': 'scenario',
          'title': 'The Revenge Trading Trap',
          'situation':
              'You just lost ₹15,000 on an options trade. You\'re frustrated and your heart is racing. The market is still open. What do you do?',
          'choices': [
            {
              'text': 'Take a bigger position to recover losses faster',
              'isCorrect': false,
              'feedback':
                  '❌ DANGER! This is "revenge trading"—the #1 account killer. 70% of traders who do this blow up their accounts within 3 months. Your brain is in "fight mode," not "think mode."',
            },
            {
              'text': 'Close your trading app and take a 24-hour break',
              'isCorrect': true,
              'feedback':
                  '✅ PERFECT! Emotional decisions = bad decisions. Taking a break prevents impulsive trades. Come back tomorrow with a clear mind. The market will still be there.',
            },
            {
              'text': 'Follow a "guaranteed" tip from Telegram to recover',
              'isCorrect': false,
              'feedback':
                  '❌ Desperate decisions lead to bigger losses. "Guaranteed tips" don\'t exist. By the time you get the tip, smart money has already exited. You\'re the exit liquidity.',
            },
            {
              'text':
                  'Accept the loss, journal what went wrong, stick to your plan',
              'isCorrect': true,
              'feedback':
                  '✅ EXCELLENT! Losses are tuition fees. Analyze the mistake, learn from it, and move on. The best traders have a 40-60% win rate but still profit because they cut losses fast.',
            },
          ],
        },
        {
          'type': 'concept',
          'title': 'Why Trading Gurus Are Rich',
          'emoji': '🎓',
          'content': '''
**The "Guru" Business Model:**

Most Instagram/YouTube gurus don't trade. They sell dreams.

**1. How they make money:**
• Selling courses (₹10 Crores revenue > Trading profits)
• Premium Telegram Channels
• Affiliate links

**2. Red Flags 🚩**
• "Guaranteed Returns" or "100% Accuracy" (Impossible!)
• Rented luxury cars & lifestyle flexing.
• Only showing winning screenshots (hiding losses).

**The Reality Test:**
If they could double money every month, why would they need your ₹5,000 for a course?

**Real Mentors:** Talk about Risk, Psychology, and Losses. Not Lamborghinis.
''',
          'keyPoints': [
            'Most trading gurus make money from courses, not trading',
            'Cherry-picked screenshots hide the 90% of losing trades',
            'Verified track records are rare—most are fake or misleading',
            'Real experts emphasize risk management, not get-rich-quick schemes',
            'If it sounds too good to be true, it always is',
          ],
        },
        {
          'type': 'summary',
          'title': 'The Bottom Line',
          'keyPoints': [
            '90-95% of retail traders lose money—it\'s not a game, it\'s a battlefield',
            'Psychology (overconfidence, loss aversion, FOMO, revenge trading) kills accounts',
            'Hidden costs (fees, taxes, time, stress) require 29%+ returns just to break even',
            'Only 1-5% of traders achieve consistent profitability',
            'Most trading gurus make money selling courses, not trading',
            'If you still want to trade: Get educated, practice for 2+ years, start tiny',
            'For 95% of people: Long-term investing beats active trading',
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
              'You\'ve learned the brutal truths. Now let\'s test if you\'re truly ready. This isn\'t just a quiz—it\'s a mindset check. Can you spot the traps that destroy 95% of traders? Let\'s find out...',
        },
        {
          'type': 'concept',
          'title': 'The Mindset Shift',
          'emoji': '🧠',
          'content': '''
Before we test your knowledge, understand this:

**The Market Rewards:**
• Patience over speed
• Education over luck
• Discipline over emotion
• Long-term thinking over quick wins

**The Market Punishes:**
• Greed and FOMO
• Overconfidence and arrogance
• Following tips blindly
• Revenge trading after losses

**Your Goal in This Quiz:**
Not to get 100% correct—but to recognize dangerous thinking patterns that lead to losses.

**Remember:** Every wrong answer is a lesson learned NOW instead of a costly mistake LATER.
''',
          'keyPoints': [
            'The market is a teacher, not a slot machine',
            'Wrong answers here = lessons learned without losing money',
            'Recognizing traps is more valuable than memorizing facts',
            'Your mindset determines your success more than your strategy',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Social Proof Trap',
          'question':
              'Your friend made ₹20,000 in one day trading options. They show you screenshots. What\'s the most likely reality?',
          'options': [
            'They have a secret strategy you should copy immediately',
            'They got lucky, and you\'re not seeing their overall losses',
            'Trading is easy money for everyone who tries',
            'You should quit your job and trade full-time too',
          ],
          'correctIndex': 1,
          'explanation':
              'Survivorship bias! People only share wins, not losses. Studies show 76% of retail traders lose money overall. One lucky day ≠ consistent profitability. For every ₹20k win, they might have ₹50k in hidden losses. Always ask: "What\'s your verified track record over 12+ months?"',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: First Step Wisdom',
          'question':
              'You have ₹50,000 saved. What\'s the smartest first step before investing a single rupee?',
          'options': [
            'Put it all in one "hot stock" recommended by a guru',
            'Spend 3-6 months learning, then start with ₹5,000',
            'Follow a premium Telegram group\'s daily tips',
            'Trade daily to maximize opportunities and learn faster',
          ],
          'correctIndex': 1,
          'explanation':
              'Education first, money second! The market will still be there after you learn. Warren Buffett spent YEARS studying before investing. Start with 10% of your capital (₹5,000) while learning. Rushing in is how 90-95% lose money in their first year. Time spent learning saves money lost trading.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: Root Cause Analysis',
          'question':
              'What\'s the #1 reason 90-95% of retail traders lose money?',
          'options': [
            'The market is rigged by big institutions',
            'Lack of emotional discipline and proper education',
            'They don\'t have enough starting capital',
            'Brokerage fees and taxes eat all the profits',
          ],
          'correctIndex': 1,
          'explanation':
              'Psychology kills accounts, not the market! While institutions have advantages, the real killers are: overconfidence, loss aversion (2.5x pain), FOMO, and revenge trading. 70% of traders who revenge trade blow up in 3 months. Education + emotional control = the 1-5% who succeed.',
        },
        {
          'type': 'quiz',
          'title': 'Question 4: Time Horizon Test',
          'question':
              'You want to build wealth for retirement (20+ years away). What\'s the proven approach?',
          'options': [
            'Day trading to compound gains faster',
            'Long-term investing in quality assets with patience',
            'Following stock tips from social media influencers',
            'Timing the market perfectly to maximize returns',
          ],
          'correctIndex': 1,
          'explanation':
              'Time in the market > Timing the market! Historical data: Nifty 50 returned 12-15% annually over 20 years. Day traders? 95% fail. Compound interest needs TIME to work magic. ₹1 lakh invested at 12% for 20 years = ₹9.6 lakhs. Same amount day-traded? Most likely ₹0 after costs and losses.',
        },
        {
          'type': 'quiz',
          'title': 'Question 5: Loss Response Test',
          'question':
              'You lost ₹10,000 on your first trade. You\'re frustrated. What should you do RIGHT NOW?',
          'options': [
            'Take a bigger position to recover losses quickly',
            'Close the app, take a 24-hour break, then analyze',
            'Follow a "guaranteed" tip to make it back',
            'Keep trading until you break even today',
          ],
          'correctIndex': 1,
          'explanation':
              'STOP! Emotional decisions = bigger losses. Your brain is in "fight mode," not "think mode." 70% of revenge traders blow up their accounts. Take a break, journal what went wrong, and come back with a clear mind. The best traders have 40-60% win rates but still profit because they cut losses FAST and never revenge trade.',
        },
        {
          'type': 'quiz',
          'title': 'Question 6: Guru Detection Test',
          'question':
              'A "trading guru" promises "100% accuracy" and shows luxury cars. What should you think?',
          'options': [
            'They must be successful—I should buy their course',
            '🚩 RED FLAG: They make money from courses, not trading',
            'Their strategy must work—look at their lifestyle!',
            'I should join their premium group immediately',
          ],
          'correctIndex': 1,
          'explanation':
              'SCAM ALERT! 🚨 No one has 100% accuracy—not even Warren Buffett. Real traders show: verified track records, both wins AND losses, and emphasize risk management. Gurus make money selling dreams (₹10 crore from 10,000 students) not trading. If trading was so easy, why waste time selling courses? Cherry-picked screenshots hide 90% of losing trades.',
        },
        {
          'type': 'summary',
          'title': 'Mindset Unlocked! 🎓',
          'keyPoints': [
            'You can now spot the psychological traps that destroy 95% of traders',
            'You understand: Education + Patience + Discipline > Luck + Speed + Emotion',
            'You know the difference: Investing builds wealth, gambling destroys it',
            'You\'re ready to learn with realistic expectations (not get-rich-quick dreams)',
            'Next step: Master the fundamentals before risking real money',
            'Remember: The goal is wealth building, not lottery tickets',
          ],
        },
      ],
    };
  }
}
