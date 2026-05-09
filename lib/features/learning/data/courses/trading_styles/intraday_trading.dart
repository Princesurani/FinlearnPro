/// Chapter 3: Intraday Trading
class IntradayTradingContent {
  static Map<String, dynamic> getIntradayLifestyleContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Day Trader\'s World',
          'emoji': '☀️',
          'content':
              'Intraday trading means opening AND closing all positions within the same day. No overnight risk. No gap-down surprises. But it demands full attention during market hours and strict discipline.',
        },
        {
          'type': 'story',
          'title': 'A Day in Priya\'s Life',
          'emoji': '👩‍💻',
          'content': '''
**Priya**, 30, a full-time intraday trader in Hyderabad.

**8:00 AM:** Wakes up. Checks global markets (US, Asia). Notes any overnight news.
**8:30 AM:** Opens charts. Marks key support/resistance levels on Nifty and Bank Nifty. Writes down 2-3 specific trade plans.
**9:15 AM:** Market opens. She watches the first 15 minutes WITHOUT trading (the "opening noise").
**9:30 AM:** Sees her first planned setup. Enters with a pre-calculated stop loss.
**10:30 AM:** Trade hits target. +₹3,200. She logs it in her journal.
**11:00 AM:** Second setup appears. She enters. Gets stopped out. -₹1,500. Logged.
**12:00 PM:** Lunch break. She takes a walk to reset her mind.
**1:30 PM:** Back at the desk. One more setup. Enters carefully. +₹2,800.
**2:30 PM:** No more valid setups. She closes the laptop. Done for the day.
**3:30 PM:** Journals all trades. Reviews screenshots.

**Daily Result:** +₹4,500 on 3 trades. Total screen time: ~5 hours.

**Key Insight:** Priya took only 3 trades. Not 30. Quality over quantity.
''',
        },
        {
          'type': 'concept',
          'title': 'Intraday Fundamentals',
          'emoji': '📋',
          'content': '''
**Advantages of Intraday:**
• No overnight risk (positions closed by 3:15 PM)
• No gap-down surprises from global events
• Daily income potential
• Can use intraday leverage (with caution)

**Disadvantages:**
• Requires 4-6 hours of focused screen time
• Missing big multi-day moves (you exit too early)
• Brokerage costs add up with multiple daily trades
• Mentally exhausting — decision fatigue is real

**Who It Suits:**
• Full-time traders or those with flexible schedules
• People comfortable with fast decision-making
• Capital of ₹2-5 Lakh minimum
• Risk tolerance: Medium-High

---

**Key Insight:**
Intraday trading is a JOB, not a hobby. If you treat it like a casual side activity, the market will treat your capital like a casual donation.
''',
          'keyPoints': [
            'All positions must be closed before market close (3:15-3:30 PM)',
            'Eliminates overnight risk but requires 4-6 hours of focus',
            'Mentally demanding — decision fatigue causes afternoon errors',
            'Treat it as a full-time job, not a casual hobby',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'What is the biggest advantage of intraday trading over swing trading?',
          'options': [
            'Higher profit potential',
            'Lower brokerage costs',
            'Zero overnight risk — no gap-up/gap-down surprises',
            'Less screen time needed',
          ],
          'correctIndex': 2,
          'explanation':
              'The #1 advantage is zero overnight risk. When you close all positions by 3:30 PM, a global crisis at 2 AM doesn\'t affect you. Swing traders who hold overnight are exposed to gap openings. However, intraday traders miss multi-day trends and pay higher brokerage.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Intraday = open and close all positions within the same day',
            'Eliminates overnight risk but requires 4-6 hours of dedication',
            'Quality trades matter — 3 good trades beat 30 random ones',
            'Decision fatigue causes most losses in the afternoon session',
            'Next: The non-negotiable survival rules for intraday traders.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getIntradayRulesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Rules That Keep You Alive',
          'emoji': '📜',
          'content':
              'Intraday trading without rules is gambling. These are the non-negotiable principles that separate the 7% who profit from the 93% who lose.',
        },
        {
          'type': 'concept',
          'title': 'The 7 Iron Rules of Intraday',
          'emoji': '⚔️',
          'content': '''
**Rule 1: Skip the First 15 Minutes ⏰**
The first 15 minutes after market open are pure chaos — retail orders, overnight gaps settling. Wait for the noise to clear.

**Rule 2: Maximum 3-5 Trades per Day 🎯**
If your plan doesn't trigger, you don't trade. Boredom is NOT a valid reason to enter.

**Rule 3: Risk 1% Maximum per Trade 📏**
Your position size ensures that if stopped out, you lose no more than 1% of capital.

**Rule 4: Always Use a Stop Loss 🛑**
Hard stop in the system. Not in your head. If you can't define where you're wrong, don't enter.

**Rule 5: 2% Daily Max Loss Limit 🚫**
If you lose 2% of capital in one day, shut the computer. Come back tomorrow.

**Rule 6: Close ALL Positions by 3:15 PM 🕒**
No exceptions. Never carry an intraday position overnight "just this once."

**Rule 7: Journal Every Trade 📓**
Entry, exit, emotion, rule adherence. No trade goes unrecorded.
''',
          'keyPoints': [
            'Skip the first 15 minutes of market noise',
            'Maximum 3-5 trades; 1% risk per trade; 2% daily loss limit',
            'Hard system stops on every trade — no mental stops',
            'Close ALL positions by 3:15 PM — zero overnight exposure',
          ],
        },
        {
          'type': 'story',
          'title': 'The "Just Once" Exception',
          'emoji': '🚨',
          'content': '''
**Rohan** was a disciplined intraday trader. For 6 months, he always closed positions at 3:15 PM.

**Thursday, 3:10 PM:** He was long on Reliance. He was down ₹5,000 for the day.
The chart looked like it might bounce tomorrow. He thought, *"I don't want to book this loss today. I'll carry it overnight, just this once."*

**Thursday Night:** US inflation data came out much higher than expected. The US markets crashed 3%.
**Friday, 9:15 AM:** The Indian market gapped down massively. Reliance opened 4% lower.

Rohan's ₹5,000 loss instantly became a ₹35,000 loss before he could even click sell.
He panicked, froze, and watched it drop to a ₹50,000 loss by 10 AM.

**Key lesson:** Intraday rules are not suggestions; they are the walls of your fort. The moment you make an exception "just this once," you invite the market to destroy months of discipline. If you trade intraday, NEVER carry overnight.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Afternoon Temptation',
          'situation':
              'It is 2:45 PM. You have taken 0 trades today because no valid setup appeared. You see a stock moving 3% in the last 30 minutes. The FOMO is intense. What do you do?',
          'choices': [
            {
              'text': 'Jump in — a 3% move is too good to miss!',
              'isCorrect': false,
              'feedback':
                  '❌ This is classic FOMO + boredom trading at the worst possible time. The move has already happened (you are chasing). There is only 45 minutes until close, leaving almost no time for the trade to work. Plus, you have no pre-planned setup.',
            },
            {
              'text':
                  'Close the laptop. Today was a "no trade" day. That is perfectly fine. Protect your capital for tomorrow when a real setup appears.',
              'isCorrect': true,
              'feedback':
                  '✅ Excellent discipline. Not trading IS a valid trading decision. The market will be here tomorrow. The capital you saved today by NOT FOMO trading is available for a high-quality setup tomorrow.',
            },
            {
              'text': 'Enter with very small size "just to be in the market"',
              'isCorrect': false,
              'feedback':
                  '❌ This is boredom trading. Even with small size, you are building a habit of taking trades outside your plan. That habit will grow and cost you real money in the future.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 3 Complete! 🎉',
          'keyPoints': [
            'Intraday trading demands full attention and strict rules',
            'Skip the first 15 minutes, cap at 3-5 trades, and stop at 2% daily loss',
            'Not trading is a valid and often PROFITABLE decision',
            'Decision fatigue makes afternoon trading dangerous',
            'Close everything by 3:15 PM — no exceptions',
            'Next: Swing trading — the sweet spot for working professionals.',
          ],
        },
      ],
    };
  }
}
