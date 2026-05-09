/// Chapter 10: Building a Risk-First Mindset
/// The final transformation — thinking like a professional
class RiskFirstMindsetContent {
  // Lesson 10.1: The Professional's Checklist
  static Map<String, dynamic> getChecklistContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Final Transformation',
          'emoji': '🦋',
          'content':
              'Amateurs wake up wondering how much money they will make today. Professionals wake up wondering how much risk they will expose themselves to today. This shift in mindset is the final step in your evolution.',
        },
        {
          'type': 'concept',
          'title': 'The Master Checklist',
          'emoji': '📋',
          'content': '''
**Before taking ANY trade, you must answer YES to all 7 questions:**

**1. The Setup Check ✅**
Is this exact pattern/setup written in my trading plan?

**2. The Macro Check ✅**
Is there a major news event (like RBI policy or Earnings) in the next hour? (If yes, do not trade).

**3. The Risk:Reward Check ✅**
Is the potential reward at least 1.5x or 2x the risk?

**4. The Sizing Check ✅**
Have I calculated the exact quantity so that my loss is strictly 1% (or 2%) of my capital?

**5. The Stop Loss Check ✅**
Is my stop loss placed at a logical technical level (not a random percentage)? Will I place the order in the system immediately?

**6. The Emotional Check ✅**
Am I calm? Am I revenge trading? Am I bored? (If emotional, step away).

**7. The Daily Limit Check ✅**
If this trade hits the stop loss, will it breach my 2% or 3% daily maximum loss limit?

---

**Why This Matters:**
In aviation, a pilot goes through a pre-flight checklist even if they have flown 10,000 times. Why? Because skipping one step can cause a fatal crash. Your trading account is the airplane. The checklist ensures you don't crash it.
''',
          'keyPoints': [
            'Shift from a "Profit-First" to a "Risk-First" mindset',
            'Use a strict 7-point checklist before every single trade',
            'Checklist covers: Setup, Macro, R:R, Sizing, Stops, Emotion, and Limits',
            'Pilots use checklists to prevent crashes; traders must do the same',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The Checklist in Action',
          'emoji': '✅',
          'content': '''
**Let's run a trade through the Master Checklist:**

**The Setup:** Reliance is breaking out of a 3-week consolidation.

1. **Setup Check?** ✅ Yes, breakout is my core strategy.
2. **Macro Check?** ❌ Wait. RBI is announcing interest rates in 10 minutes.
3. **R:R Check?** ✅ Yes, stop is ₹20 away, target is ₹60 away (1:3).
4. **Sizing Check?** ✅ Calculated exactly for 1% risk.
5. **Stop Loss Check?** ✅ Yes, hard technical stop below the range.
6. **Emotion Check?** ✅ Calm and collected.
7. **Limit Check?** ✅ Only down 0.5% today.

**The Decision:**
Because Question 2 is a ❌, the entire trade is a NO.

A major macro event (RBI policy) can cause wild volatility that ignores technicals. A professional skips the trade entirely or waits until 15 minutes after the announcement.
**One ❌ means the airplane stays on the runway.**
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You have a perfect setup. R:R is 1:3. No macro events. You are calm. But you\'ve already hit your 2% daily loss limit. Do you take the trade?',
          'options': [
            'Yes, because all other checklist items are perfect',
            'Yes, but with half position size',
            'No. A single ❌ on the checklist (Limit Check) means no trade.',
            'Paper trade it instead',
          ],
          'correctIndex': 2,
          'explanation':
              'No trade. The checklist is absolute. The Daily Limit is a circuit breaker designed to protect you from yourself. If you bypass it for a "perfect" setup, the rule ceases to exist. There will be other perfect setups tomorrow when your daily limit is reset.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Professionalism is defined by adherence to a process',
            'The 7-point checklist forces you to slow down and think logically',
            'If you cannot answer YES to all 7 questions, you DO NOT trade',
            'Next: The ultimate final exam. Let\'s test your Risk Management instincts.',
          ],
        },
      ],
    };
  }

  // Lesson 10.2: Final Challenge: Risk Management Pro
  static Map<String, dynamic> getFinalChallengeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Ultimate Survival Test',
          'emoji': '🛡️',
          'content':
              'You\'ve learned the rules of survival: Position sizing, R:R, stop losses, managing drawdowns, and fighting emotional demons. Let\'s see if you have the discipline of a professional.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Position Sizing',
          'question':
              'Your capital is ₹5,00,000. Your max risk per trade is 1% (₹5,000). You want to buy at ₹1,000. Your stop loss is ₹950. How many shares do you buy?',
          'options': [
            '500 shares (Full capital)',
            '200 shares',
            '100 shares',
            '50 shares',
          ],
          'correctIndex': 2,
          'explanation':
              'Risk Amount = ₹5,000. Risk per share = Entry(1000) - SL(950) = ₹50. Quantity = Risk Amount (5000) ÷ Risk per share (50) = 100 shares. If you buy 100 shares and the stop hits, you lose exactly ₹5,000 (1%).',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: Drawdown Math',
          'question':
              'Due to poor risk management, your account drops from ₹1,00,000 to ₹50,000 (a 50% drawdown). What percentage return do you need on the remaining ₹50,000 to get back to breakeven?',
          'options': ['50%', '75%', '100%', '200%'],
          'correctIndex': 2,
          'explanation':
              'To go from ₹50,000 back to ₹1,00,000, you need to make ₹50,000 in profit. That is a 100% gain on your current balance. This asymmetry is why preventing large drawdowns (via the 1% rule) is your #1 priority.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: Stop Loss Strategy',
          'question':
              'Which of the following is the WORST way to handle a stop loss?',
          'options': [
            'Using a trailing stop to lock in profits',
            'Placing a hard technical stop below a major support level',
            'Using a "mental stop" and moving it lower to avoid taking the loss',
            'Sizing the position so the stop loss equals exactly 1% of capital',
          ],
          'correctIndex': 2,
          'explanation':
              'Mental stops always fail due to emotion (Fear and Hope). Moving a stop loss down is the ultimate sin in trading — you are actively deciding to increase your risk AFTER the trade has proven you wrong. This behavior leads directly to blown accounts.',
        },
        {
          'type': 'scenario',
          'title': 'The Ultimate Discipline Scenario',
          'situation':
              'You lost two trades in the morning (-2% of capital). It\'s now 2:00 PM. A highly volatile meme stock is crashing, and a friend tells you to "short it for guaranteed recovery." Your daily limit is 2%. What do you do?',
          'choices': [
            {
              'text': 'Short it with a small position just to recover the 2%',
              'isCorrect': false,
              'feedback':
                  '❌ Even a small position is Revenge Trading. You are trading based on a tip (no edge), out of anger (emotion), and you have already hit your daily limit.',
            },
            {
              'text':
                  'Close the laptop. You hit the 2% daily limit. You do not trade tips. You walk away and protect your remaining 98%.',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect! You passed the ultimate test. You honored the daily loss limit. You ignored FOMO/tips. You preserved your mental capital and your financial capital. You survived to trade tomorrow.',
            },
            {
              'text':
                  'Short it aggressively — meme stocks always crash eventually',
              'isCorrect': false,
              'feedback':
                  '❌ This is how accounts go to zero. You breached your daily limit, traded a highly volatile asset based on a tip, and let greed/revenge dictate your sizing.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Congratulations! 🎓🛡️',
          'keyPoints': [
            'You understand that Capital Preservation is the ultimate goal',
            'You know how to calculate exact position sizes (The 1% Rule)',
            'You understand the critical importance of technical stop losses',
            'You know how to manage drawdowns and combat fear, greed, and revenge',
            'You are now equipped with the armor necessary to survive the markets',
            'Trading is 10% strategy and 90% psychology — you now possess the 90%.',
          ],
        },
      ],
    };
  }
}
