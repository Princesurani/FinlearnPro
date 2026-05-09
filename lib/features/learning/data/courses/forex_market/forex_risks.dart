/// Chapter 8: Risks in Forex Trading
/// Unique dangers that make forex the riskiest retail market
class ForexRisksContent {
  // Lesson 8.1: The Seven Deadly Risks
  static Map<String, dynamic> getSevenRisksContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Know Thy Enemy',
          'emoji': '☠️',
          'content':
              'According to research, approximately 70-80% of retail forex traders lose money. Not because forex is "rigged" — but because most traders don\'t understand the unique risks. Here are the seven biggest threats to your capital.',
        },
        {
          'type': 'concept',
          'title': 'The Seven Deadly Risks of Forex',
          'emoji': '⚠️',
          'content': '''
**1. Leverage Risk ⚔️**
The #1 killer. 100x leverage means a 1% move = 100% loss.
Even "safe" leverage of 20x means 5% move = account gone.

**2. Overnight/Weekend Gap Risk 🌙**
Forex closes Friday evening, reopens Sunday evening.
A major event over the weekend can cause prices to "gap" — opening far from Friday's close. Your stop loss may not protect you.

**3. Central Bank Intervention Risk 🏦**
RBI, Swiss National Bank, or Bank of Japan can suddenly intervene.
In 2015, the Swiss National Bank removed the EUR/CHF floor — EUR/CHF crashed 30% in MINUTES. Accounts were wiped out instantly.

**4. Broker Risk 🏢**
Unregulated brokers can manipulate prices, widen spreads, or refuse withdrawals.
Some brokers are literally designed to make you lose.

**5. Correlation Risk 🔗**
Trading EUR/USD AND GBP/USD? They move similarly.
You think you're diversified but you've actually doubled your exposure.

**6. Emotional/Psychological Risk 🧠**
24-hour markets mean 24-hour temptation to trade.
Overtrading, revenge trading, and FOMO are the biggest account killers.

**7. Regulatory Risk 📜**
Governments can change rules overnight.
India restricted retail forex trading to INR pairs only. If you're on an offshore broker, you may be trading illegally.

---

**Key Insight:**
Most traders focus only on "will the price go up or down?" The real question is: "have I managed all seven risks?" Price direction is just one variable — risk management is the entire framework.
''',
          'keyPoints': [
            'Leverage risk = #1 killer of retail forex traders',
            'Weekend gaps can bypass your stop loss entirely',
            'Central bank surprises can move currencies 5-30% in minutes',
            'Emotional risk: 24-hour markets fuel overtrading and revenge trading',
          ],
        },
        {
          'type': 'story',
          'title': 'The Swiss Franc Tsunami (2015)',
          'emoji': '🌊',
          'content': '''
**January 15, 2015. A date forex traders will never forget.**

**Background:**
For 3 years, the Swiss National Bank (SNB) maintained a floor on EUR/CHF at 1.2000. "We will never let the Euro fall below 1.2000 against the Franc."

Traders trusted this guarantee. Millions of positions were built on this promise.

**9:30 AM (Swiss Time):**
Without warning, SNB removed the floor.
EUR/CHF crashed from 1.2000 to 0.8500 — **a 30% crash in 20 MINUTES.**

**The Carnage:**
• Thousands of traders lost more than their entire accounts.
• Broker FXCM (the largest US forex broker) lost \$225 million in one day.
• Multiple forex brokers went bankrupt.
• Some traders owed money BEYOND their deposits (negative balance).

**One Trader's Story:**
A UK trader had a £10,000 account with 50x leverage.
Position: BUY EUR/CHF at 1.1980 (just below the "guaranteed" floor).
After the crash: He owed his broker £280,000. His £10,000 became a -£280,000 debt.

**Lesson:**
There are no guarantees in forex. Not from central banks, not from stop losses, not from anyone. The only guarantee is uncertainty. Trade accordingly.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You hold a EUR/USD position over the weekend. A major geopolitical event occurs on Saturday. What risk are you exposed to?',
          'options': [
            'No risk — your stop loss will protect you when markets reopen',
            'Gap risk — the market can open Monday at a completely different price, skipping your stop loss entirely',
            'No risk — forex trades 24/7, so the market never closes',
            'Your broker will automatically close your trade if something bad happens',
          ],
          'correctIndex': 1,
          'explanation':
              'Forex closes Friday evening and reopens Sunday evening. During this ~48 hour gap, events can occur that cause prices to "gap" — opening far from Friday\'s close. Your stop loss at 1.0950 is useless if the market opens at 1.0800. This is weekend gap risk.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Seven deadly risks: leverage, gaps, central banks, broker fraud, correlation, emotions, regulation',
            'The 2015 Swiss Franc event wiped out entire brokers and created negative balances',
            'Weekend gaps can skip your stop loss — reduce position size before weekends',
            'No guarantee is permanent in forex — not even central bank promises',
            'Next: How to build a practical risk management toolkit.',
          ],
        },
      ],
    };
  }

  // Lesson 8.2: Risk Management Toolkit
  static Map<String, dynamic> getRiskToolkitContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Your Survival Kit',
          'emoji': '🧰',
          'content':
              'Now that you know what can go wrong, let\'s build your defense system. These aren\'t theoretical concepts — they\'re practical rules that professional traders follow every single day.',
        },
        {
          'type': 'concept',
          'title': 'The 5 Rules of Forex Survival',
          'emoji': '📋',
          'content': '''
**Rule 1: The 1% Rule 🎯**
Never risk more than 1% of your account on a single trade.
• Account: ₹1,00,000 → Max risk per trade: ₹1,000
• This means your stop loss × position size ≤ ₹1,000
• With this rule, you need 100 consecutive losses to blow up (virtually impossible)

**Rule 2: Always Use a Stop Loss 🛑**
No exceptions. No "I'll watch it manually." No "it'll come back."
• Set your stop loss BEFORE entering the trade
• Never move it further away from your entry (tightening is okay)

**Rule 3: Risk-Reward Ratio ≥ 1:2 📐**
Only take trades where your potential profit is at least 2x your risk.
• Risk: 30 pips → Target: minimum 60 pips
• Even if you're right only 40% of the time, you still make money

**Rule 4: Reduce Before Weekends 📅**
Close or reduce positions before Friday close.
Weekend gaps can destroy positions. Not worth the risk.

**Rule 5: No Revenge Trading 🧘**
After a loss, do NOT immediately place another trade to "make it back."
Take a break. Review. Come back fresh tomorrow.

---

**Key Insight:**
Risk management is the ONLY thing that separates profitable traders from unprofitable ones. Two traders with the same strategy will have completely different results based on risk management alone.
''',
          'keyPoints': [
            '1% rule: never risk more than 1% of capital per trade',
            'Always use stop losses — set before entry, never move further away',
            'Risk-Reward ≥ 1:2: potential profit should be 2x the potential loss',
            'Reduce positions before weekends and avoid revenge trading',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The 1% Rule in Action',
          'emoji': '📊',
          'content': '''
**Account: ₹2,00,000 | Max Risk: ₹2,000 (1%)**

**Trade Setup: SELL USD/INR at 84.00**
• Stop Loss: 84.40 (40 pips away)
• Target: 83.20 (80 pips profit)
• Risk-Reward: 1:2 ✅

**Position Size Calculation:**
Max Risk = ₹2,000
Risk per pip per lot (1,000 units) = ~₹1
Pips at risk = 40

Position Size = ₹2,000 / (40 × ₹1) = 50 lots

**Three Possible Outcomes:**

**Win (Target Hit):**
Profit = 80 pips × 50 × ₹1 = ₹4,000 (+2% of account) ✅

**Loss (Stop Hit):**
Loss = 40 pips × 50 × ₹1 = ₹2,000 (-1% of account) 📉

**Break Even (Moved stop to entry):**
Loss = ₹0 (free trade)

**Key Lesson:**
Even 5 consecutive losses (₹10,000) only costs 5% of account. You'd still have ₹1,90,000 to recover with. The 1% rule keeps you alive through losing streaks.
''',
        },
        {
          'type': 'scenario',
          'title': 'Discipline Under Pressure',
          'situation':
              'You\'ve had 3 consecutive losing trades today (-₹3,000 total). You see a "perfect" setup on GBP/USD. Your rule says "max 3 trades per day." What do you do?',
          'choices': [
            {
              'text': 'Take the trade — this one will recover your losses!',
              'isCorrect': false,
              'feedback':
                  '❌ This is textbook revenge trading. After 3 losses, your emotions are compromised. The "perfect" setup looks perfect because you WANT it to be perfect. Stick to your 3-trade rule. There will always be another setup tomorrow.',
            },
            {
              'text':
                  'Stop trading for the day, review your 3 losses, and come back tomorrow with a clear mind',
              'isCorrect': true,
              'feedback':
                  '✅ The hardest but most profitable decision. Reviewing losses when you\'re calm reveals patterns. Maybe all 3 losses were in the wrong session, or against the trend. Tomorrow you\'ll trade better because of today\'s discipline.',
            },
            {
              'text':
                  'Take the trade but with 3x the normal position size to recover faster',
              'isCorrect': false,
              'feedback':
                  '❌ This is the #1 account killer in forex. Increasing size after losses is EXACTLY how professionals describe the blowup pattern. More size + emotional trading + losing streak = account destruction.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 8 Complete! 🎉',
          'keyPoints': [
            'The 1% rule is non-negotiable — it\'s the foundation of professional risk management',
            'Always set stop losses BEFORE entering, and never move them further away',
            'Risk-Reward ≥ 1:2 means you can be wrong 60% of the time and still profit',
            'Revenge trading after losses is the #1 account killer — walk away instead',
            'Risk management separates the 20% who survive from the 80% who don\'t',
            'Next: The final chapter — is forex right for you? The honest self-assessment.',
          ],
        },
      ],
    };
  }
}
