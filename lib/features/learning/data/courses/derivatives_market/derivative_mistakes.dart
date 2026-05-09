/// Chapter 8: Beginner Mistakes in Derivatives
/// The errors that destroy 93% of F&O traders
class DerivativeMistakesContent {
  // Lesson 8.1: The Seven Deadly Derivative Sins
  static Map<String, dynamic> getSevenSinsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Hall of Shame',
          'emoji': '💀',
          'content':
              'Every blown-up derivative account shares the same autopsy report. Here are the seven mistakes that account for 90% of derivative losses. Memorize them. Tattoo them. Because breaking any one of these rules can end your trading career.',
        },
        {
          'type': 'concept',
          'title': 'Sins 1-4',
          'emoji': '🔥',
          'content': '''
**Sin #1: Buying OTM Weekly Options 🎰**
Cheap ₹5-₹20 options that expire in 2-3 days.
"If Nifty moves 300 points, I'll make 10x!"
Reality: 85%+ expire worthless. It's a lottery ticket, not trading.

**Sin #2: Selling Naked Options Without a Hedge ☠️**
"I'll collect premium income every week!"
Selling Calls or Puts without protection exposes you to UNLIMITED loss.
One gap move can destroy your entire account — and more (you may OWE money).

**Sin #3: Ignoring Theta Decay ⏰**
Buying options on Monday and wondering why they lost 30% of value by Wednesday even though the market barely moved.
Time decay eats option buyers alive. Every day, your option loses value.

**Sin #4: Holding Options Through Expiry Day 📅**
On expiry day, options become extremely volatile. A ₹100 option can go to ₹500 or ₹0 in minutes.
Beginners hold till the last moment "hoping" for a miracle.
Professionals take profits or cut losses BEFORE expiry day.
''',
          'keyPoints': [
            'OTM weekly options are lottery tickets — 85%+ expire worthless',
            'Naked option selling has unlimited risk and can wipe you out instantly',
            'Theta decay destroys option buyer value even when markets don\'t move',
            'Expiry day volatility is extreme — professionals exit before it',
          ],
        },
        {
          'type': 'concept',
          'title': 'Sins 5-7',
          'emoji': '⚠️',
          'content': '''
**Sin #5: Overleveraging Futures 📊**
Using full margin (or more with intraday leverage) on Futures.
A 3% market move at 20x leverage = 60% of your capital gone.
Professional funds rarely exceed 3-5x leverage. Why do you think you need 20x?

**Sin #6: Trading Without Understanding Greeks 🔤**
Options have variables called "Greeks" (Delta, Gamma, Theta, Vega).
If you don't understand how Theta decays your position and how Vega affects it during high-volatility events, you are flying blind.
You don't need to be an expert, but you need the BASICS.

**Sin #7: Trading Derivatives Before Mastering Cash 📉**
The #1 sin. You can't run before you walk.
If you can't consistently make money buying and selling stocks (the simplest form of trading), adding leverage, expiry, and Greeks will only accelerate your losses.

---

**Key Insight:**
Warren Buffett famously called derivatives "weapons of mass destruction." They are tools designed for professionals. In the hands of beginners, they are financial suicide.
''',
          'keyPoints': [
            'Full leverage on Futures is the fastest path to zero',
            'You must understand at least basic Greeks (Delta, Theta, Vega)',
            'Cash market mastery is the absolute prerequisite for derivatives',
            'Warren Buffett called derivatives "weapons of mass destruction"',
          ],
        },
        {
          'type': 'scenario',
          'title': 'Identifying the Sins',
          'situation':
              'Meera, a 3-month beginner, buys 10 lots of OTM Bank Nifty weekly calls for ₹15 each. She uses her entire ₹50,000 capital. The options expire in 2 days. Bank Nifty needs to move 500 points for her to break even. How many sins is she committing?',
          'choices': [
            {
              'text': 'Just one — she bought OTM options',
              'isCorrect': false,
              'feedback':
                  '❌ She is committing at least 4 sins simultaneously: #1 (buying OTM weekly options), #4 (2-day expiry), #5 (using FULL capital — zero risk management), and #7 (only 3 months of experience). This is a recipe for total loss.',
            },
            {
              'text':
                  'Four sins: OTM weeklies, near-expiry, full capital at risk, and trading derivatives as a beginner',
              'isCorrect': true,
              'feedback':
                  '✅ Correct. Sin #1 (OTM lottery tickets), Sin #4 (near expiry — Theta will destroy her), Sin #5 (₹50K is her FULL capital — no risk management), Sin #7 (3 months is way too early for derivatives). Her most likely outcome: losing 80-100% of her ₹50,000.',
            },
            {
              'text': 'None — she paid a small premium, so her risk is limited',
              'isCorrect': false,
              'feedback':
                  '❌ Her risk IS limited to the premium, but she invested her ENTIRE capital in lottery tickets. "Limited risk" means nothing if 100% of your money is at limited risk. She\'ll lose it all.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'The 7 sins: OTM lotteries, naked selling, ignoring Theta, expiry gambling, overleveraging, ignoring Greeks, and skipping cash mastery',
            'Most sins combine to create catastrophic outcomes',
            'Derivatives require far more knowledge than the cash market',
            'Master cash first, then paper trade derivatives for 3+ months',
            'Next: The final exam — test your derivatives knowledge.',
          ],
        },
      ],
    };
  }

  // Lesson 8.2: Final Challenge: Derivatives Pro
  static Map<String, dynamic> getFinalChallengeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Derivatives Survival Exam',
          'emoji': '🎓',
          'content':
              'You\'ve learned about Futures, Options, Calls, Puts, Margin, and the critical mistakes to avoid. Let\'s test whether you truly understand these dangerous instruments.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Futures vs Options',
          'question':
              'What is the key difference in risk between BUYING Futures and BUYING Call Options?',
          'options': [
            'There is no difference — both have the same risk',
            'Futures have LIMITED loss; Options have UNLIMITED loss',
            'Futures have UNLIMITED loss; Options buyers have loss LIMITED to the premium',
            'Options are always riskier because of Theta decay',
          ],
          'correctIndex': 2,
          'explanation':
              'Futures expose you to unlimited loss on both sides. Options BUYERS have their maximum loss capped at the premium paid — the option simply expires worthless. This is the fundamental advantage of buying options.',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: Margin Calls',
          'question':
              'You hold Nifty Futures overnight. RBI announces an unexpected rate cut. Nifty gaps UP 300 points at market open. You had a SHORT position. What happens?',
          'options': [
            'Nothing — your stop loss will protect you',
            'You make a huge profit',
            'You face an immediate loss of 300 × 25 = ₹7,500 per lot. If margin is insufficient, you get a margin call or auto-square.',
            'The exchange cancels the gap move',
          ],
          'correctIndex': 2,
          'explanation':
              'Stop losses CANNOT protect against gap openings. If you had a stop at 22,000 and the market opened at 22,300, your stop was never triggered. Your loss is the full gap × lot size. This is why holding leveraged overnight positions through events is extremely dangerous.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: The Readiness Test',
          'question':
              'Which of the following traders is READY to start trading derivatives?',
          'options': [
            'Amit: 2 months of stock trading, ₹30K capital, follows a Telegram tip group',
            'Priya: 14 months of profitable stock trading, ₹3L separate risk capital, uses stop losses on every trade, has completed paper trading Options for 2 months',
            'Raju: Read 5 books on options, has ₹5L borrowed from his brother',
            'Sneha: 1 year of stock trading (breakeven), ₹1L capital from her emergency fund',
          ],
          'correctIndex': 1,
          'explanation':
              'Only Priya meets ALL criteria: 14 months of cash profitability, separate risk capital, strict risk management, and paper trading experience. Amit is too new and relies on tips. Raju uses borrowed money. Sneha is using her emergency fund and hasn\'t proven profitability.',
        },
        {
          'type': 'scenario',
          'title': 'The Final Decision',
          'situation':
              'After completing this course, a friend asks you: "Should I start trading options?" They have been investing (not trading) in stocks for 6 months via SIPs and have ₹1 Lakh saved up. What do you advise?',
          'choices': [
            {
              'text': 'Yes, start with small option buys to learn',
              'isCorrect': false,
              'feedback':
                  '❌ Investing via SIPs is not the same as active trading. They have zero trading experience (entries, exits, stop losses, position sizing). They need to learn active cash market trading first, THEN derivatives.',
            },
            {
              'text':
                  'Not yet. First learn active trading in the cash market. Get 6-12 months of profitable trading. Then paper trade options for 3 months. Then start small with real capital you can afford to lose.',
              'isCorrect': true,
              'feedback':
                  '✅ The complete professional path. SIP investing ≠ active trading. Your friend needs to build the core skills (stop losses, position sizing, emotional control) in the cash market before adding the complexity of derivatives.',
            },
            {
              'text': 'Just sell options — it\'s free money if you do it right',
              'isCorrect': false,
              'feedback':
                  '❌ This is the #2 deadliest advice in trading. "Free money" from selling options has unlimited downside risk. One gap move can wipe out months of premium income.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Congratulations! 🎓⚠️',
          'keyPoints': [
            'You understand Futures (obligation) vs Options (right)',
            'You know how Calls (bullish) and Puts (bearish) work',
            'You understand the devastating power of leverage and margin calls',
            'You can identify the 7 deadly derivative sins in yourself and others',
            'You know the 7-point readiness checklist before trading derivatives',
            'Remember: Derivatives are tools for professionals. Master the cash market first.',
          ],
        },
      ],
    };
  }
}
