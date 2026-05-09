/// Chapters 4-6: Risk-First + Continuous Learning + Consistency
class RiskFirstApproachContent {
  static Map<String, dynamic> getRiskBudgetContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Plan Your Losses, Not Your Profits',
          'emoji': '🛡️',
          'content':
              'Amateur traders wake up thinking "How much can I make today?" Professionals wake up thinking "How much am I willing to LOSE today?" This inversion is the most important mental model in trading.',
        },
        {
          'type': 'concept',
          'title': 'The Risk Budget',
          'emoji': '📊',
          'content': '''
**What is a Risk Budget?**
Your risk budget is the maximum amount you are ALLOWED to lose in a given period.

**Daily Risk Budget:**
"I can lose maximum 2% of my capital per day."
Capital = ₹1,00,000. Daily budget = ₹2,000.
If you lose ₹2,000 by 11 AM, you STOP. No exceptions.

**Weekly Risk Budget:**
"I can lose maximum 5% per week."
After losing 5%, you take the rest of the week off. Study charts. Review journal.

**Monthly Risk Budget:**
"If I lose 10% in a month, I halt all trading for 2 weeks."
This is the circuit breaker that prevents catastrophic drawdowns.

---

**The Paradox:**
By LIMITING your losses, you actually INCREASE your profits. Why?
Because the worst trading happens when you are in a losing spiral (revenge trading, emotional overtrading). The risk budget stops the spiral before it destroys your account.

**Key Insight:**
Profit targets create pressure and force trades. Risk budgets create freedom and protect capital. Plan your downside, and the upside takes care of itself.
''',
          'keyPoints': [
            'Daily: max 2% loss. Weekly: max 5% loss. Monthly: max 10% loss.',
            'Risk budgets stop the revenge trading spiral before it begins',
            'Limiting losses paradoxically increases profits',
            'Plan your downside first — the upside takes care of itself',
          ],
        },
        {
          'type': 'story',
          'title': 'The Revenge Trade Spiral',
          'emoji': '🌪️',
          'content': '''
**Amit** had no daily risk budget.
**10:00 AM:** He lost ₹5,000 on his first trade. He felt angry.
**11:00 AM:** To "recover" the ₹5,000, he took a sub-par trade with double the size. He lost ₹10,000. Now down ₹15,000.
**1:00 PM:** Pure panic. He started trading random options. Down ₹30,000.
**3:00 PM:** Account blown.

**Priya** had a strict 2% daily risk budget (₹4,000).
**10:00 AM:** She lost ₹2,000.
**11:00 AM:** She lost another ₹2,000.
**11:01 AM:** She hit her budget. She closed her laptop, walked away, and went to the gym.

Priya survived to trade another day. Amit destroyed months of savings in 5 hours.
**Key lesson:** The Risk Budget is the circuit breaker that prevents one bad day from ruining your entire trading career.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You lost 1.8% of your capital by 10:30 AM. Your daily risk budget is 2%. A perfect A+ setup appears at 11:00 AM. What do you do?',
          'options': [
            'Take it — A+ setups are rare!',
            'Take it but with smaller position size so you stay under 2%',
            'Skip it. You are 0.2% away from your daily limit. The risk of a loss pushing you over the budget is too high. Come back tomorrow.',
            'Double down to recover the losses',
          ],
          'correctIndex': 2,
          'explanation':
              'This is the hardest discipline in trading: walking away from a good setup because your budget says stop. If you take it and lose, you are at 2.8% (over budget) and your emotional state will deteriorate further. The A+ setup will appear again. Your capital might not.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Risk budgets > profit targets for professional trading',
            'Set daily (2%), weekly (5%), and monthly (10%) loss limits',
            'Walking away from a good setup is sometimes the right decision',
            'Protecting capital during drawdowns is more important than any single trade',
            'Next: Building a system that gets STRONGER from losses.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getAntifragileContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Growing From Adversity',
          'emoji': '💎',
          'content':
              'Anti-fragile is not just surviving losses — it is getting STRONGER because of them. An anti-fragile trading system uses every loss as fuel for improvement.',
        },
        {
          'type': 'concept',
          'title': 'The Anti-Fragile System',
          'emoji': '🔧',
          'content': '''
**Fragile System:** Breaks under stress.
"I had 5 losses → I quit trading."

**Robust System:** Survives stress.
"I had 5 losses → I continued trading the same way."

**Anti-Fragile System:** Gets STRONGER from stress.
"I had 5 losses → I analyzed them → Found a pattern → Adjusted my entry filter → My next 50 trades had a HIGHER win rate."

**How to Build Anti-Fragility:**
1. **Journal every loss meticulously** — the data is your raw material
2. **Categorize losses** — Was it execution error or strategy error?
3. **Find patterns** — Do losses cluster at certain times, markets, or emotional states?
4. **Create new rules** — Turn each pattern into a specific filter
5. **Test the new rule** — Paper trade the adjustment before going live

---

**Key Insight:**
The best traders in the world have had MORE losses than beginners — they have just learned MORE from each one. Losses are tuition fees. Make sure you get an education for your money.
''',
          'keyPoints': [
            'Anti-fragile = getting stronger from losses, not just surviving them',
            'Journal → Categorize → Find Patterns → Create Rules → Test',
            'Every loss is a data point that can improve future performance',
            'Losses are tuition fees — extract the lesson from every one',
          ],
        },
        {
          'type': 'story',
          'title': 'Earning Your Tuition',
          'emoji': '🎓',
          'content': '''
**Rahul** lost ₹10,000 on a trade. He got angry, closed the chart, and told himself, "The market is rigged." He learned nothing. The ₹10,000 was just a loss.

**Neha** lost ₹10,000 on a trade. She opened her journal.
She analyzed the chart and realized: "I bought right into a major 4-hour resistance level because I only checked the 5-minute chart."

**Her Adjustment:** "New Rule: Before entering ANY trade, I must mark the 4-hour support/resistance zones."
Over the next year, this one rule saved her from taking 20 bad trades, saving her ₹2,00,000.

**Key lesson:** Neha's ₹10,000 wasn't a loss. It was the tuition fee she paid to learn a ₹2,00,000 lesson. Anti-fragile traders don't get mad at losses; they interrogate them for the hidden lesson.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'What is the difference between a "robust" and an "anti-fragile" trading system?',
          'options': [
            'They are the same thing',
            'Robust survives stress unchanged; Anti-fragile gets BETTER from stress',
            'Anti-fragile avoids all losses',
            'Robust requires more capital',
          ],
          'correctIndex': 1,
          'explanation':
              'A robust system continues working despite losses. An anti-fragile system actually IMPROVES because of losses — each failure provides data that refines the strategy, making it stronger over time.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 4 Complete! 🎉',
          'keyPoints': [
            'Risk budgets (2% daily, 5% weekly, 10% monthly) are non-negotiable',
            'Anti-fragile systems grow stronger from losses',
            'Turn every loss into a new filtering rule through data analysis',
            'Walking away from a setup near your limit is professional discipline',
            'Next: How to keep learning and adapting as markets evolve.',
          ],
        },
      ],
    };
  }
}

class ContinuousLearningContent {
  static Map<String, dynamic> getLearningEcosystemContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Student Never Graduates',
          'emoji': '📚',
          'content':
              'Markets change. What worked in 2020 may not work in 2025. The trader who stops learning is the trader who starts losing. Build a learning ecosystem that keeps you evolving.',
        },
        {
          'type': 'concept',
          'title': 'The Four Learning Pillars',
          'emoji': '🏛️',
          'content': '''
**Pillar 1: Books 📖**
The highest ROI learning. Start with:
• "Trading in the Zone" by Mark Douglas (psychology)
• "The Intelligent Investor" by Benjamin Graham (fundamentals)
• "Technical Analysis of the Financial Markets" by John Murphy (technicals)
One book per month = 12 books/year = you are in the top 1% of traders in knowledge.

**Pillar 2: Market Observation 👁️**
Spend 15 minutes daily just WATCHING the market without trading.
Study how price reacts at key levels. Watch order flow. Build pattern recognition.

**Pillar 3: Community (Carefully Curated) 👥**
Find 2-3 serious traders to discuss ideas with. Avoid hype groups.
Good community: "What did you learn from your losses this week?"
Bad community: "BUY NOW! 🚀🚀🚀"

**Pillar 4: Periodic Courses & Workshops 🎓**
Take one quality course or workshop per quarter on a topic you are WEAKEST in.
Always choose SEBI-registered advisors or well-known institutions.

---

**Key Insight:**
Warren Buffett reads 500 pages per day. Charlie Munger reads 5 newspapers before breakfast. The best investors in the world are the most voracious learners. You are competing with them.
''',
          'keyPoints': [
            'Read 1 book per month to stay in the top 1% of trader knowledge',
            'Observe the market daily without trading to build pattern recognition',
            'Curate 2-3 serious trading peers — avoid hype groups',
            'Take one quality course per quarter on your weakest skill',
          ],
        },
        {
          'type': 'story',
          'title': 'The Hubris Trap',
          'emoji': '🪤',
          'content': '''
**Anil** had a fantastic 2021. Everything he bought went up. He doubled his money.
He thought, *"I'm a genius. I don't need to read books or study anymore."*

**Then 2022 arrived.** The market shifted from a roaring bull market to a choppy, sideways market.
Anil kept using his 2021 breakout strategy. It failed miserably. Within 6 months, he lost all his 2021 profits and 30% of his original capital.

He realized his strategy only worked in one specific environment. He had stopped learning. He had to go back to the books, study market regimes, and learn mean-reversion strategies.

**Key lesson:** The market is a dynamic puzzle that changes its shape every few years. The moment you think you have it "figured out" and stop learning, the market will humble you. Stay a student forever.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'What is the BEST free learning tool available to every trader?',
          'options': [
            'YouTube guru recommendations',
            'Telegram signals',
            'Your own trading journal data from the past 100+ trades',
            'Twitter hot takes',
          ],
          'correctIndex': 2,
          'explanation':
              'Your own journal is the most personalized, relevant, and honest learning resource in existence. It contains YOUR specific patterns, YOUR mistakes, and YOUR emotional triggers. No book, course, or guru can give you that level of personalized insight.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Build a learning ecosystem: Books + Observation + Community + Courses',
            'Your own journal is the best learning tool in existence',
            'Read 1 book per month to outlearn 99% of traders',
            'Curate your trading community carefully',
            'Next: Adapting to different market environments.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getAdaptingContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Market Has Seasons',
          'emoji': '🌦️',
          'content':
              'Markets cycle through regimes: bull trends, bear trends, and sideways chops. A strategy that works perfectly in a trending market will fail completely in a choppy market. Adapting to the current regime is a master-level skill.',
        },
        {
          'type': 'concept',
          'title': 'The Three Market Regimes',
          'emoji': '📊',
          'content': '''
**1. Trending Markets (Bull or Bear) 📈📉**
Clear directional movement lasting weeks to months.
• Best strategies: Trend following, breakouts, momentum.
• Worst strategies: Mean reversion, selling options.
• Indicator hint: ADX above 25. Moving averages fanning out.

**2. Sideways/Choppy Markets ↔️**
Price bouncing between a range with no clear direction.
• Best strategies: Range trading, mean reversion (buy support, sell resistance).
• Worst strategies: Trend following (endless whipsaws).
• Indicator hint: ADX below 20. Moving averages flat and intertwined.

**3. Volatile Crash Markets 💥**
Sudden, violent moves driven by fear (COVID crash, global crises).
• Best strategy: CASH. Stay out entirely.
• Worst strategy: Bottom-picking, averaging down.
• If you must trade: Reduce size by 50% and widen stops.

---

**Key Insight:**
The best traders don't have ONE strategy — they have a toolkit. They identify the current regime and pull out the appropriate tool. In a choppy market, a trend-following trader's best trade is NO TRADE.
''',
          'keyPoints': [
            'Markets cycle through trending, sideways, and crash regimes',
            'Different regimes require completely different strategies',
            'In volatile crash markets, the best trade is often no trade',
            'Identifying the current regime is a master-level skill',
          ],
        },
        {
          'type': 'story',
          'title': 'The Weather Forecast',
          'emoji': '☔',
          'content': '''
**Trading is like sailing.**

If the weather is sunny with strong winds (Trending Market), you raise the sails and go full speed. Your trend-following strategy works perfectly.

If the weather is dead calm (Choppy/Sideways Market), raising the sails does nothing. You just drift aimlessly. A smart sailor drops anchor and waits. A smart trader stops trading breakouts and either waits or uses a specific range-trading strategy.

If a hurricane hits (Crash/Volatile Market), you don't try to sail. You tie the boat to the dock and hide. The smartest trade is CASH.

**Key lesson:** Amateurs try to sail the exact same way regardless of the weather. Professionals check the forecast (the Market Regime) BEFORE deciding which strategy to use that day.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Nifty has been stuck between 21,800 and 22,200 for 3 weeks. ADX is at 15. You are a trend-following trader. What should you do?',
          'options': [
            'Keep taking breakout trades — it will eventually break out!',
            'Switch to range trading: buy at 21,800 support, sell at 22,200 resistance',
            'Reduce your trading frequency significantly and wait for a breakout ABOVE 22,200 or BELOW 21,800 with increasing ADX',
            'Short-sell everything',
          ],
          'correctIndex': 2,
          'explanation':
              'In a choppy market (ADX 15), trend-following breakout trades will get whipsawed repeatedly. The professional response is to reduce activity, wait for the range to break, and confirm with ADX rising above 25 before re-engaging your trend strategy.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 5 Complete! 🎉',
          'keyPoints': [
            'Markets have three regimes: Trending, Sideways, and Crash',
            'One strategy does NOT work in all regimes',
            'Identifying the regime first is more important than finding a trade',
            'In choppy markets, the best trade is often no trade',
            'Next: The final chapter — mastering consistency for a lifetime.',
          ],
        },
      ],
    };
  }
}

class ConsistencyContent {
  static Map<String, dynamic> getTenThousandHoursContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Mastery Takes Time',
          'emoji': '⏳',
          'content':
              'There are no shortcuts. Malcolm Gladwell\'s "10,000-hour rule" applies to trading as much as it applies to music, sports, or medicine. Expect 2-5 YEARS of dedicated effort before consistency. Anyone who tells you otherwise is selling something.',
        },
        {
          'type': 'concept',
          'title': 'The Realistic Timeline',
          'emoji': '📅',
          'content': '''
**Year 1: The Survival Year 🌱**
• Learn the fundamentals (FinlearnPro courses)
• Paper trade for 3-6 months
• Start with micro real-money trades
• Expected outcome: Breakeven or small loss. This is NORMAL.

**Year 2: The Foundation Year 🧱**
• Refine your strategy based on journal data
• Develop emotional control through experience
• Find your trading style
• Expected outcome: Small consistent profit OR breakeven.

**Year 3-5: The Growth Years 📈**
• Your journal has 500+ trades of data
• You can identify market regimes
• Your emotional reactions are minimal
• Expected outcome: Consistent profitability emerges.

---

**The Uncomfortable Truth:**
Most people who trade for 1 month and don't make money QUIT. The 7% who are profitable stuck with it for YEARS. There is no hack, shortcut, or indicator that replaces time and experience.

**Key Insight:**
Every expert was once a struggling beginner. The difference is they didn't quit. Your job is to SURVIVE long enough to become competent.
''',
          'keyPoints': [
            'Year 1: Survival and learning (breakeven is success)',
            'Year 2: Foundation and refinement (small profits)',
            'Year 3-5: Growth and consistency (sustainable profitability)',
            'The #1 edge is refusing to quit before the skill develops',
          ],
        },
        {
          'type': 'story',
          'title': 'The Bamboo Tree',
          'emoji': '🎋',
          'content': '''
**The Chinese Bamboo Tree** takes five years to grow.
For the first four years, you have to water it and fertilize it every single day.
But you see NOTHING. Not even a sprout breaks the soil.
If you stop watering it for even a few weeks, the seed dies.

But in the fifth year, the bamboo tree breaks through the ground and grows 80 feet tall in just six weeks!

**Trading is the Bamboo Tree.**
For the first 1-2 years, you are journaling, studying, taking small losses, and refining your rules. Your P&L shows zero growth. Your friends tell you it's a waste of time.
But beneath the surface, your emotional control and pattern recognition are growing.

**Key lesson:** Then, in year 3 or 4, everything clicks. You hit consistency, and your capital compounds at a rate that shocks everyone. But you must survive the years of invisible growth first. Don't quit in year 2.
''',
        },
        {
          'type': 'scenario',
          'title': 'The 6-Month Decision',
          'situation':
              'You have been swing trading for 6 months. You followed all the FinlearnPro principles. Your results: slight loss overall (-2%), but your last 2 months showed improvement. Your friend says: "If you haven\'t made money in 6 months, trading isn\'t for you." What do you do?',
          'choices': [
            {
              'text': 'Quit — 6 months should be enough',
              'isCorrect': false,
              'feedback':
                  '❌ 6 months is barely the beginning. Professional traders take 2-3 years to find consistent profitability. A -2% loss over 6 months is EXCELLENT for a beginner — most lose 30-50%. Your improving trend suggests you ARE developing skill.',
            },
            {
              'text':
                  'Continue with conviction. Your improving trend in the last 2 months shows that the learning curve is working. Stick to the process for at least 18 more months.',
              'isCorrect': true,
              'feedback':
                  '✅ You are exactly on track. A slight loss with an improving trend is the textbook learning curve. Most professionals will tell you their first year was a net loss. The skill compounds silently — then suddenly, consistency appears.',
            },
            {
              'text': 'Try a completely different strategy',
              'isCorrect': false,
              'feedback':
                  '❌ Switching strategies resets your learning curve to zero. You lose the 6 months of data and experience. Refine what you have — don\'t replace it.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Mastery takes 2-5 years of dedicated, journaled practice',
            'Year 1 breakeven is a SUCCESS, not a failure',
            'The improving trend matters more than the current P&L',
            'Never switch strategies prematurely — refine, don\'t replace',
            'Next: The final exam — your FinlearnPro Graduation Assessment.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getFinalGraduationContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Graduation Exam',
          'emoji': '🎓',
          'content':
              'This is it. The comprehensive final assessment across all 13 courses of FinlearnPro. Not just knowledge — but the WISDOM to apply it. Let\'s see if you are ready to graduate.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Risk Management',
          'question':
              'Your account is ₹2,00,000. You risk 1% per trade. After 5 consecutive losses, what is your account balance?',
          'options': [
            '₹1,90,000 (lost ₹10,000)',
            'Approximately ₹1,90,200 (each subsequent 1% is slightly smaller)',
            '₹1,80,000 (lost ₹20,000)',
            'Depends on the market',
          ],
          'correctIndex': 1,
          'explanation':
              'Each 1% risk is calculated on the CURRENT balance, not the original. Trade 1: ₹2,000 loss (₹1,98,000 remains). Trade 2: ₹1,980 loss (₹1,96,020). And so on. After 5 losses: ~₹1,90,200. This is why 1% risk per trade keeps you in the game — even 5 consecutive losses only cost ~5% of your account.',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: Trading Psychology',
          'question':
              'You just had 3 winning trades. You feel confident and invincible. According to your FinlearnPro training, what should you do?',
          'options': [
            'Increase position size to capitalize on the hot streak',
            'Continue with the exact same position size and risk rules as always',
            'Take a day off to celebrate',
            'Start trading a new market you haven\'t studied',
          ],
          'correctIndex': 1,
          'explanation':
              'Overconfidence after a winning streak is as dangerous as fear after a losing streak. Both cause you to deviate from your plan. The professional response is ALWAYS the same: execute the plan. Same risk. Same position size. The streak is irrelevant.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: The Complete Trader',
          'question':
              'What is the correct order of progression for a complete beginner?',
          'options': [
            'Open Zerodha → Buy stocks → Learn from mistakes',
            'Study all FinlearnPro courses → Paper trade for 3 months → Start with micro real-money trades using 1% risk → Scale up gradually over 12+ months',
            'Watch YouTube → Copy a Telegram guru → Use 10x leverage',
            'Read one book → Start options trading',
          ],
          'correctIndex': 1,
          'explanation':
              'The complete path: Education (FinlearnPro) → Paper Trading (3 months minimum) → Micro Real Money (0.2-1% risk) → Gradual Scaling (12+ months). This systematic approach gives you the highest probability of being in the 7% who survive.',
        },
        {
          'type': 'scenario',
          'title': 'The Ultimate Test',
          'situation':
              'It is Monday morning. You have your trading plan, your journal, your risk budget, and 6 months of paper trading experience. The market opens in 15 minutes. Your first real-money trade. How do you approach it?',
          'choices': [
            {
              'text':
                  'Wait for the perfect setup. Enter with excitement and check P&L every 30 seconds.',
              'isCorrect': false,
              'feedback':
                  '❌ Checking P&L every 30 seconds is a sign of emotional trading. Once you enter with a stop loss and target in place, step back. Micro-managing creates anxiety and leads to premature exits.',
            },
            {
              'text':
                  'Execute your pre-market plan mechanically. Enter at the planned level. Stop loss in the system. Target set. Close the P&L window. Check once per hour. Journal the trade after it closes.',
              'isCorrect': true,
              'feedback':
                  '✅ This is the professional execution. Mechanical entry. System-placed stops. No P&L obsession. One check per hour. Journal after close. This is what 12 courses of preparation looks like in action. Welcome to professional trading.',
            },
            {
              'text': 'Skip the first day — you are too nervous.',
              'isCorrect': false,
              'feedback':
                  '❌ Nervousness is natural. But avoidance doesn\'t build the emotional muscle memory you need. Start with the smallest possible size (0.2% risk) so the financial impact is negligible while you build confidence.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': '🎓 CONGRATULATIONS — You Have Graduated! 🎓',
          'keyPoints': [
            'You have completed all 13 courses of FinlearnPro',
            'You understand markets, instruments, analysis, risk, psychology, and execution',
            'You know to plan losses (not profits), follow process (not outcomes)',
            'You will build an anti-fragile system that grows stronger from adversity',
            'You accept that mastery takes 2-5 years of dedicated practice',
            'Welcome to the 7%. Execute your plan. Trust your process. Trade with discipline.',
          ],
        },
      ],
    };
  }
}
