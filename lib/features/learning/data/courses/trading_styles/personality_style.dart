/// Chapter 1: Choose Based on Personality
/// Your trading style must fit your life
class PersonalityStyleContent {
  // Lesson 1.1: The Personality Test
  static Map<String, dynamic> getPersonalityTestContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Who Are You as a Trader?',
          'emoji': '🪞',
          'content':
              'Your trading style should match your personality like a glove. A calm, patient person should NOT be scalping. An adrenaline junkie should NOT be long-term investing. The wrong fit guarantees failure, no matter how good the strategy is.',
        },
        {
          'type': 'interactive',
          'title': 'The Trader Personality Matrix',
          'emoji': '📊',
          'content': '''
**Answer these honestly:**

**1. How much time do you have for the markets?**
• A) Full-time (6+ hours/day) → Scalping or Intraday
• B) Part-time (1-2 hours/day) → Swing Trading
• C) Very little (30 min/week) → Long-term Investing

**2. How do you handle stress?**
• A) I thrive under pressure → Scalping
• B) I can manage moderate stress → Intraday/Swing
• C) I hate financial stress → Investing

**3. What is your capital?**
• A) ₹5 Lakh+ dedicated to trading → Active trading viable
• B) ₹1-5 Lakh → Swing trading or small intraday
• C) Under ₹1 Lakh → Investing (SIPs, index funds)

**4. Can you accept many small losses?**
• A) Yes, I understand probability → Active trading
• B) No, every loss stresses me → Investing

---

**Key Insight:**
The market doesn't care about your ambitions. It cares about your EXECUTION. And you can only execute consistently in a style that matches your temperament, time, and capital.
''',
        },
        {
          'type': 'concept',
          'title': 'Why Fit Matters',
          'emoji': '🧩',
          'content': '''
**Case Study — Wrong Fit:**
Ravi is a software developer working 10-hour shifts. He wants to be a scalper.
He tries trading on his phone during meetings. He misses exits because of work calls.
He can't monitor positions in real-time. His trades go against him while he is coding.
Result: 3 months of losses. Not because scalping is bad, but because it doesn't fit his life.

**Case Study — Right Fit:**
Same Ravi switches to swing trading. He analyzes charts on Sunday evening, places orders with stop losses on Monday morning, and checks positions once daily after work.
Result: Better execution, lower stress, and actual profitability.

---

**Key Insight:**
The best trading strategy is the one you can ACTUALLY execute consistently given your life circumstances. A mediocre strategy executed perfectly will always beat a perfect strategy executed poorly.
''',
          'keyPoints': [
            'Your style must match your available time, stress tolerance, and capital',
            'Wrong fit leads to poor execution regardless of strategy quality',
            'A mediocre strategy executed perfectly beats a perfect one executed poorly',
            'Be honest about your lifestyle constraints before choosing a style',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Sneha works a demanding 9-5 job, has ₹80,000 in savings, and gets very anxious when she sees her portfolio in the red. Which trading style is most appropriate?',
          'options': [
            'Scalping — she can trade during lunch breaks',
            'Intraday trading — close everything by 3:30 PM',
            'Long-term investing via monthly SIPs in index funds',
            'Swing trading with tight stop losses',
          ],
          'correctIndex': 2,
          'explanation':
              'Sneha has limited time (9-5 job), small capital (₹80K), and low stress tolerance (anxious about red portfolios). Long-term investing via SIPs is the only fit. She invests ₹5,000-₹10,000 per month, doesn\'t watch daily prices, and lets compounding work over years.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Your trading style must match your personality, time, and capital',
            'Wrong fit guarantees failure regardless of strategy quality',
            'Be brutally honest about your lifestyle constraints',
            'A calm, patient person and a stressed, time-poor person need completely different approaches',
            'Next: An overview of all four major trading styles.',
          ],
        },
      ],
    };
  }

  // Lesson 1.2: The Four Trading Styles
  static Map<String, dynamic> getFourStylesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Four Flavors of Trading',
          'emoji': '🎨',
          'content':
              'From lightning-fast scalping to decades-long investing, there are four distinct ways to participate in the markets. Each has its own rules, timeframes, and personality requirements.',
        },
        {
          'type': 'interactive',
          'title': 'Style Comparison Chart',
          'emoji': '📋',
          'content': '''
| Feature | Scalping | Intraday | Swing | Investing |
|---------|----------|----------|-------|-----------|
| **Holding Time** | Seconds-minutes | Hours (same day) | Days-weeks | Months-years |
| **Trades/Day** | 20-100+ | 2-10 | 0-3 per week | 1-2 per month |
| **Screen Time** | 6+ hours | 4-6 hours | 30 min/day | 30 min/week |
| **Capital Needed** | ₹5L+ | ₹2-5L | ₹1-3L | ₹5K+ (SIP) |
| **Stress Level** | 🔴 Extreme | 🟠 High | 🟡 Moderate | 🟢 Low |
| **Win Rate Needed** | 60%+ | 50%+ | 40%+ | N/A |
| **Best For** | Full-time pros | Full-time/dedicated | Working pros | Everyone |

---

**The 80/20 Reality:**
• 80% of people are best suited for Investing or Swing Trading.
• Only ~20% have the time, capital, and temperament for Intraday or Scalping.
• Most beginners want to scalp (exciting!) but should be investing (boring but profitable).
''',
        },
        {
          'type': 'concept',
          'title': 'Quick Definitions',
          'emoji': '📖',
          'content': '''
**Scalping ⚡:** Taking dozens of trades per day, holding for seconds to minutes. Profit target: ₹100-₹500 per trade. Requires extreme focus, fast execution, and very low brokerage costs.

**Intraday 📊:** Opening and closing all positions within the same trading day. No overnight risk. Profit target: ₹500-₹5,000 per trade. Requires 4-6 hours of screen time.

**Swing Trading 🌊:** Holding positions for days to weeks, capturing multi-day price "swings." Profit target: ₹2,000-₹20,000 per trade. Can be done with just 30 minutes of analysis per day.

**Long-Term Investing 🌳:** Buying quality assets and holding for months, years, or decades. Leverages the power of compound interest. Warren Buffett style. Requires patience and minimal time.

---

**Key Insight:**
The right style is the one you can do CONSISTENTLY for 10 years without burning out. Most scalpers burn out in 6 months. Most investors can do it for 30 years.
''',
          'keyPoints': [
            'Scalping: seconds, extreme stress, full-time only',
            'Intraday: same-day, no overnight risk, requires 4-6 hrs',
            'Swing: days-weeks, ideal for working professionals',
            'Investing: months-years, lowest stress, suitable for everyone',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Which trading style requires the LEAST amount of daily screen time?',
          'options': [
            'Scalping',
            'Intraday Trading',
            'Swing Trading',
            'Long-Term Investing',
          ],
          'correctIndex': 3,
          'explanation':
              'Long-term investors may check their portfolio once a week or even once a month. They buy quality assets and let time and compound interest do the work. Scalpers need 6+ hours of intense focus daily — the complete opposite.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 1 Complete! 🎉',
          'keyPoints': [
            'Four styles: Scalping, Intraday, Swing, and Investing',
            '80% of people are best suited for Swing Trading or Investing',
            'Your style must match your time, capital, stress tolerance, and personality',
            'Sustainability matters: choose a style you can maintain for 10+ years',
            'Next: Deep dive into Scalping — the fastest (and most dangerous) style.',
          ],
        },
      ],
    };
  }
}
