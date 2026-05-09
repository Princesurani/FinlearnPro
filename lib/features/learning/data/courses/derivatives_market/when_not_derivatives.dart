/// Chapter 7: When NOT to Trade Derivatives
/// Knowing your limits saves your account
class WhenNotDerivativesContent {
  // Lesson 7.1: The Readiness Checklist
  static Map<String, dynamic> getReadinessChecklistContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Are You Actually Ready?',
          'emoji': '🪞',
          'content':
              'Most people who trade derivatives should NOT be trading derivatives. This is not gatekeeping — it is honest advice that could save you lakhs of rupees. Let\'s find out if you\'re genuinely ready.',
        },
        {
          'type': 'concept',
          'title': 'The 7-Point Readiness Test',
          'emoji': '✅',
          'content': '''
**You should NOT trade derivatives unless ALL of these are true:**

**1. Cash Market Profitability ✅**
You have been consistently profitable in the CASH (equity) market for at least 6-12 months.

**2. Risk Management Mastery ✅**
You use stop losses on every trade, calculate position sizes using the 1% rule, and have daily loss limits.

**3. Sufficient Capital ✅**
You have a SEPARATE trading capital of at least ₹2-5 Lakh that you can afford to lose ENTIRELY without affecting your life.

**4. Emotional Control ✅**
You don't revenge trade. You don't panic sell. You can handle 5 losses in a row without increasing your risk.

**5. Product Knowledge ✅**
You understand what Theta decay is, what a margin call is, and what happens at expiry.

**6. No Borrowed Money ✅**
You are NOT using credit cards, personal loans, or borrowed money to trade.

**7. Disposable Income ✅**
Your emergency fund (6 months of expenses) is fully funded. Your bills are paid. This is genuinely excess capital.

---

**If you answered NO to even ONE of these: STOP. Go back to the cash market. Master those fundamentals first. Derivatives will still be here in 12 months.**
''',
          'keyPoints': [
            '7-point checklist: profitability, risk management, capital, emotions, knowledge, no debt, disposable income',
            'Cash market profitability for 6-12 months is the minimum prerequisite',
            'Never trade derivatives with borrowed money or essential savings',
            'If even ONE condition is not met, you are not ready',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Raj has been trading stocks for 3 months. He made ₹15,000 profit. He has ₹80,000 in savings (which is also his emergency fund). He wants to start options trading. Is he ready?',
          'options': [
            'Yes — he is profitable and has capital.',
            'No — 3 months is too short, and his ₹80K is his emergency fund, not risk capital.',
            'Yes, but he should start with small positions.',
            'He should try paper trading options for a week first.',
          ],
          'correctIndex': 1,
          'explanation':
              '3 months of stock trading is insufficient. He needs 6-12 months of consistent profitability. More critically, his ₹80K is his emergency fund — losing it would affect his daily life. He needs a SEPARATE pool of risk capital that he can afford to lose entirely.',
        },
        {
          'type': 'scenario',
          'title': 'The Friend\'s Pressure',
          'situation':
              'Your colleague says: "I made ₹1 Lakh in options this month! You\'re wasting time in stocks. Come join my Telegram group — we give live options calls." You\'ve been stock trading for 4 months and are slightly profitable. What do you do?',
          'choices': [
            {
              'text': 'Join the group and start with small options trades',
              'isCorrect': false,
              'feedback':
                  '❌ "Telegram groups with live calls" are how most beginners blow up their accounts. The calls are often poorly timed, and the group admin profits from commissions or subscriptions, not from the trades themselves.',
            },
            {
              'text':
                  'Politely decline. Continue building your cash market track record for at least 6 more months before considering derivatives.',
              'isCorrect': true,
              'feedback':
                  '✅ Your colleague\'s one good month proves nothing — ask him about his results over 12 months. SEBI data shows 93% of F&O traders lose money. Your patience now will save you lakhs later.',
            },
            {
              'text': 'Join the group but only watch, don\'t trade',
              'isCorrect': false,
              'feedback':
                  '❌ Watching will create FOMO. You\'ll see trades making ₹10,000 in 30 minutes and your discipline will crack. Avoid the temptation entirely.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Pass ALL 7 readiness criteria before touching derivatives',
            '6-12 months of cash market profitability is the minimum',
            'Never use emergency funds or borrowed money for derivatives',
            'Telegram "tip groups" are the #1 destroyer of beginner derivative accounts',
            'Next: What safer alternatives exist to achieve similar goals?',
          ],
        },
      ],
    };
  }

  // Lesson 7.2: Alternatives to Derivatives
  static Map<String, dynamic> getAlternativesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Getting Similar Results, Safely',
          'emoji': '🛤️',
          'content':
              'Many beginners want derivatives for leverage and short-selling. But there are cash market strategies that achieve similar goals without the extreme risk of margin calls and time decay.',
        },
        {
          'type': 'concept',
          'title': 'Safer Paths to the Same Goals',
          'emoji': '🗺️',
          'content': '''
**Goal 1: "I want to profit from falling markets" 📉**
• *Derivative way:* Buy Puts or sell Futures (complex, time-decaying)
• *Cash alternative:* Inverse ETFs or Bear Market Mutual Funds. They go UP when the market goes DOWN. No expiry, no margin.

**Goal 2: "I want leverage to make bigger profits" ⚡**
• *Derivative way:* Buy Futures with 10x margin (catastrophic risk)
• *Cash alternative:* Focus on high-beta stocks (like small caps) that naturally move 2-5% per day. You get volatility without leverage risk.

**Goal 3: "I want income from my existing stocks" 💰**
• *Derivative way:* Sell Covered Calls (requires options knowledge)
• *Cash alternative:* High-dividend stocks + SIPs. Dividend income is passive and doesn't require complex options management.

**Goal 4: "I want to hedge my portfolio" 🛡️**
• *Derivative way:* Buy Puts on Nifty
• *Cash alternative:* Diversify across asset classes (Gold, Bonds, International funds). Diversification IS hedging.

---

**Key Insight:**
Derivatives are tools for specialists. Most financial goals can be achieved safely through the cash market. Don't use a chainsaw when scissors will do.
''',
          'keyPoints': [
            'Inverse ETFs can profit from falling markets without derivatives',
            'High-beta stocks provide volatility without leverage risk',
            'Dividend stocks provide income without options complexity',
            'Diversification is the simplest and safest form of hedging',
          ],
        },
        {
          'type': 'story',
          'title': 'The Safe Hedge',
          'emoji': '🛡️',
          'content': '''
**Nitin** had a ₹5 Lakh portfolio of Indian stocks. He was worried about a market crash.

**Attempt 1 (The Derivative Way):**
He bought Nifty Put Options worth ₹10,000 to "hedge." The market went sideways. The Puts expired worthless. He lost ₹10,000. He did this every month for 6 months. Total loss: ₹60,000. He bled his own portfolio to death trying to protect it.

**Attempt 2 (The Cash Way):**
He took ₹1 Lakh (20% of his portfolio) and bought Gold ETFs and US Market ETFs.
When the Indian market dropped 10% the next year, Gold went up 15% and the US market went up 8%.
His overall portfolio only dropped 2%, without paying a single rupee in option premiums or worrying about expiry dates.

**Key lesson:** You don't need complex derivatives to protect your money. Simple asset allocation (Cash, Gold, International Equities) is the most powerful hedge in existence, and it doesn't expire.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'A beginner says: "I want to make money when the market crashes." Which is the safest approach?',
          'options': [
            'Sell naked Nifty Call Options',
            'Buy OTM Put Options every week',
            'Invest in an inverse Nifty ETF (like Nifty Bear ETF)',
            'Short Nifty Futures with full leverage',
          ],
          'correctIndex': 2,
          'explanation':
              'An inverse ETF goes up when the index goes down. It trades like a regular stock (no margin, no expiry, no Greeks). Selling naked Calls has unlimited risk. OTM Puts expire worthless 80%+ of the time. Shorting Futures with full leverage is how accounts get wiped out.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 7 Complete! 🎉',
          'keyPoints': [
            'Most beginner goals can be met safely through the cash market',
            'Inverse ETFs, high-beta stocks, and diversification replace derivative needs',
            'Derivatives are specialist tools — not required for building wealth',
            'Pass the 7-point readiness test before considering derivatives',
            'Next: The specific mistakes that blow up beginner derivative accounts.',
          ],
        },
      ],
    };
  }
}
