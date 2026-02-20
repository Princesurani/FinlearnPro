/// Chapter 6: Risks & Getting Started
/// Stock market risks, who should trade, and building a plan
class SMChapter6Content {
  // Lesson 1: The Risks No One Talks About
  static Map<String, dynamic> getRisksContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Respect the Risk',
          'emoji': '⚠️',
          'content':
              'Everyone talks about stocks that went 10x. Nobody talks about the ones that went to zero. Before you invest a single rupee, you MUST understand what can go wrong — and how bad it can get.',
        },
        {
          'type': 'story',
          'title': 'The Satyam Scandal',
          'emoji': '🚨',
          'content': '''
**Satyam Computers** — India's 4th largest IT company in 2008.
A "Blue Chip" stock. In every mutual fund.
Investors trusted it blindly.

**January 7, 2009:**
Chairman **Ramalinga Raju** confessed in a letter:
"I have been faking the company's accounts for years."
₹7,136 Crore of cash on the books **didn't exist**.

**The Aftermath:**
• Stock price: ₹544 → ₹6.30 **(99% crash in days)**
• Thousands of investors lost their life savings.
• Mutual funds holding Satyam got destroyed.
• Raju went to jail.

**Lesson:**
Even "safe" blue-chip companies can commit fraud. **Never put all your money in a single stock**, no matter how trustworthy it appears.
''',
        },
        {
          'type': 'concept',
          'title': 'Three Types of Risk',
          'emoji': '🌪️',
          'content': '''
**1. Market Risk (Systematic) 🌊**
The entire market crashes together.
Cause: War, pandemic (COVID), recession, global crisis.
Example: March 2020 — Nifty fell 40% in 1 month.
**Can you avoid it?** No. All stocks fall together.
**Can you manage it?** Yes. Hold long-term. Markets always recover.

**2. Company Risk (Unsystematic) 🏢**
One specific company fails.
Cause: Fraud (Satyam), bad products (Maggi ban), CEO scandal.
**Can you avoid it?** Yes! **Diversify** — own 10-15 stocks.
If 1 fails, the other 14 protect you.

**3. Liquidity Risk 💧**
You can't sell when you need to.
Cause: Low trading volume in small/micro-cap stocks.
Example: You own shares of a tiny company. When you try to sell, there are no buyers. You're stuck.
**Can you avoid it?** Yes! Stick to stocks with high daily volume.
''',
          'keyPoints': [
            'Market Risk = Entire market crashes (unavoidable)',
            'Company Risk = One company fails (avoidable via diversification)',
            'Liquidity Risk = Can\'t sell when needed (avoid illiquid stocks)',
            'Diversification is the only free lunch in investing',
          ],
        },
        {
          'type': 'scenario',
          'title': 'Risk Management',
          'situation':
              'You inherit ₹5 Lakhs and want to invest in stocks. Your uncle says "Put it all in Adani — they\'re going to the moon!" What do you do?',
          'choices': [
            {
              'text': 'Listen to uncle — he\'s experienced!',
              'isCorrect': false,
              'feedback':
                  '❌ Even Adani Group (₹20 Lakh Crore company) faced a 65% crash in Jan 2023 after the Hindenburg report. No single stock is "safe enough" for your entire savings.',
            },
            {
              'text': 'Split across 10-15 companies in different sectors',
              'isCorrect': true,
              'feedback':
                  '✅ This is diversification. If one stock crashes 50%, it only affects 7-10% of your portfolio. The rest can compensate. This is how professionals invest.',
            },
            {
              'text': 'Put it all in a Fixed Deposit — stocks are too risky',
              'isCorrect': false,
              'feedback':
                  '⚡ FDs are safe but give 6-7% returns. Inflation is 5-6%. Your real return is barely 1%. Over 20 years, you\'ll lose purchasing power. A balanced stock portfolio gives 12-15%.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Market crashes are unavoidable — plan for them, don\'t fear them',
            'Company fraud/failure is avoidable through diversification',
            'Never put more than 5-10% of your portfolio in a single stock',
            'Liquidity risk: only invest in stocks with good trading volume',
            'Risk and return go hand in hand — you can\'t have one without the other',
          ],
        },
      ],
    };
  }

  // Lesson 2: Who Should (And Shouldn't) Trade Stocks?
  static Map<String, dynamic> getWhoShouldTradeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Honest Checklist',
          'emoji': '✅',
          'content':
              'The stock market is not for everyone. Not yet, anyway. Before you jump in, let\'s check if you\'re actually ready — financially AND mentally.',
        },
        {
          'type': 'concept',
          'title': 'Prerequisites for Stock Investing',
          'emoji': '📋',
          'content': '''
**Financial Readiness:**
✅ Emergency fund = 6 months of expenses saved.
✅ No high-interest debt (credit card, personal loans).
✅ Stable income source.
✅ Money you invest = Money you can LOSE without it affecting your life.

**Mental Readiness:**
✅ You can watch your portfolio drop 30% and NOT panic-sell.
✅ You understand that losses are normal and temporary.
✅ You won't check your portfolio 50 times a day.
✅ You won't invest based on WhatsApp tips.

**Knowledge Readiness:**
✅ You understand what a stock/share is.
✅ You know the difference between investing and trading.
✅ You can read basic financial data (P/E, revenue, profit).
''',
          'keyPoints': [
            'Build emergency fund BEFORE investing',
            'Clear high-interest debt first',
            'Only invest money you can afford to lose',
            'Mental discipline matters as much as knowledge',
          ],
        },
        {
          'type': 'story',
          'title': 'Two Friends, Two Outcomes',
          'emoji': '👬',
          'content': '''
**Vivek and Ravi** both earn ₹70,000/month.

**Vivek (Not Ready):**
• No emergency fund. Lives paycheck to paycheck.
• Has ₹2L credit card debt at 36% interest.
• Borrows ₹50,000 from his father to "invest in stocks."
• Market drops 15%. He panic-sells at a loss.
• Now he owes his father ₹50K + credit card debt + stock losses.
**Total mess.** 😰

**Ravi (Ready):**
• ₹3L emergency fund in a savings account.
• Zero debt. Cleared everything first.
• Starts ₹10,000/month SIP from his own savings.
• Market drops 15%. He buys MORE (lower prices = bargain).
• After 2 years, his SIP portfolio is up 25%.
**Sleeping peacefully.** 😌

**The Difference:**
Ravi's foundation was solid BEFORE he started investing.
Vivek built a house on sand — it collapsed with the first storm.
''',
        },
        {
          'type': 'quiz',
          'title': 'Ready or Not?',
          'question':
              'You have ₹1 Lakh savings, ₹80,000 credit card debt (36% interest), and no emergency fund. What\'s the best first step?',
          'options': [
            'Invest ₹1L in stocks — you\'ll make more than 36%!',
            'Pay off credit card debt first, then build emergency fund',
            'Split 50-50 between stocks and debt repayment',
            'Put it all in a fixed deposit',
          ],
          'correctIndex': 1,
          'explanation':
              'Credit card debt at 36% interest is a GUARANTEED loss. No stock can reliably beat 36%. Pay off the debt first (guaranteed 36% "return"), then build your emergency fund, THEN start investing.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Step 1: Clear high-interest debt',
            'Step 2: Build 6-month emergency fund',
            'Step 3: Only invest surplus money',
            'Never borrow money to invest in stocks',
            'Mental discipline is half the battle',
          ],
        },
      ],
    };
  }

  // Lesson 3: Your First Investment Plan
  static Map<String, dynamic> getFirstPlanContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Let\'s Build Your Plan',
          'emoji': '🗺️',
          'content':
              'You understand stocks, risks, and your readiness. Now let\'s put it all together into a practical plan that you can start TODAY. No complex strategies — just a clear, actionable roadmap.',
        },
        {
          'type': 'concept',
          'title': 'The Beginner\'s Portfolio',
          'emoji': '🏗️',
          'content': '''
**The 3-Bucket Strategy:**

**Bucket 1: Foundation (60-70% of investment)**
Nifty 50 Index Fund (SIP).
Why: Automatic diversification across India's top 50 companies.
Risk: Low. If Nifty fails, India's economy has failed.

**Bucket 2: Growth (20-30%)**
3-5 individual Large Cap or Mid Cap stocks.
Why: Potential to outperform the index.
Risk: Moderate. Research each company before buying.

**Bucket 3: Exploration (5-10%)**
1-2 Small Cap or sector-specific bets.
Why: Learning experience + high reward potential.
Risk: High. This is your "tuition fee" for learning stock picking.

**Rule:** Never let Bucket 3 exceed 10%.
If a small cap bet fails, you lose 5-10%, not 100%.
''',
          'keyPoints': [
            'Foundation = Index Fund SIP (60-70%) — set and forget',
            'Growth = Researched stocks (20-30%) — active picks',
            'Exploration = Small bets to learn (5-10%) — tuition fees',
            'This structure protects you while you learn',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Your First Watchlist',
          'emoji': '📋',
          'content': '''
**How to pick stocks for Bucket 2:**

**Step 1: Pick 2-3 sectors you understand.**
• Do you use Zomato daily? → Look at Zomato.
• Does your family bank with HDFC? → Look at HDFC Bank.
• Do you work in IT? → Look at TCS/Infosys.

**Step 2: Check the basics.**
• Is the company profitable? (Net Profit > 0) ✅
• Is revenue growing year-over-year? ✅
• Is debt manageable? (Debt/Equity < 1) ✅
• Has the stock given positive returns over 5 years? ✅

**Step 3: Start small.**
• Buy 1-2 shares of each company (not lakhs).
• Track them for 3-6 months.
• Add more only if you understand the business.

**Remember:** Your first stock picks will probably be mediocre.
That's okay. **You're paying tuition to learn.**
''',
        },
        {
          'type': 'scenario',
          'title': 'Building Your Portfolio',
          'situation':
              'You have ₹20,000/month to invest. You\'re a complete beginner. How do you allocate?',
          'choices': [
            {
              'text': '₹20K in individual stocks based on YouTube tips',
              'isCorrect': false,
              'feedback':
                  '❌ As a beginner, stock-picking based on tips is gambling. You don\'t yet have the skills to evaluate companies. Start with the foundation first.',
            },
            {
              'text': '₹14K SIP in Nifty 50 Index Fund + ₹6K in 2-3 Large Caps',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect split! 70% in Index Fund (safe, diversified) + 30% in researched large caps (learning + growth). As you gain experience over 1-2 years, you can add mid/small caps.',
            },
            {
              'text': '₹20K in Fixed Deposit until you learn more',
              'isCorrect': false,
              'feedback':
                  '⚡ Playing it too safe. FDs give 6-7% while inflation is 5-6%. You\'ll barely grow your money. An Index Fund SIP is almost as safe but gives 12-15% long-term returns.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Use the 3-Bucket Strategy: Foundation + Growth + Exploration',
            'Start with an Index Fund SIP — it\'s the easiest first step',
            'Buy businesses you understand (not random tips)',
            'Begin small, track for months, then scale up',
            'Your first picks will be imperfect — and that\'s perfectly fine',
          ],
        },
      ],
    };
  }

  // Lesson 4: Final Challenge - Stock Market Pro
  static Map<String, dynamic> getFinalChallengeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Final Test',
          'emoji': '🏆',
          'content':
              'You\'ve covered the entire Stock Market course. From what a share is to building your own portfolio plan. Let\'s see if you\'re ready to call yourself a Stock Market Pro!',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Market Cap',
          'question':
              'Stock A trades at ₹20 with 100 Crore shares. Stock B trades at ₹2,000 with 50 Lakh shares. Which company is bigger?',
          'options': [
            'Stock B (higher share price)',
            'Stock A (₹2,000 Cr vs ₹100 Cr)',
            'Both are equal',
            'Cannot determine without more information',
          ],
          'correctIndex': 1,
          'explanation':
              'Stock A: ₹20 × 100 Cr = ₹2,000 Crore. Stock B: ₹2,000 × 50 Lakh = ₹100 Crore. Stock A is 20x bigger despite a lower share price. Never judge by price alone!',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: IPO Basics',
          'question':
              'When you buy shares during an IPO, where does your money go?',
          'options': [
            'To the stock exchange (NSE/BSE)',
            'To other investors who are selling',
            'Directly to the company issuing shares',
            'To your broker as commission',
          ],
          'correctIndex': 2,
          'explanation':
              'IPO is the Primary Market — you buy directly from the company. The money goes to the company for growth and expansion. On the Secondary Market (daily trading), money goes to other investors.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: Risk Management',
          'question':
              'What is the BEST way to protect against Company Risk (one company failing)?',
          'options': [
            'Only invest in government bonds',
            'Diversify across 10-15 stocks in different sectors',
            'Put a stop-loss on every trade',
            'Only invest in Large Cap stocks',
          ],
          'correctIndex': 1,
          'explanation':
              'Diversification is the most effective protection against company-specific risk. Even large caps can fail (Satyam was a large cap). Owning stocks across sectors ensures one failure doesn\'t destroy your portfolio.',
        },
        {
          'type': 'quiz',
          'title': 'Question 4: Trading Reality',
          'question':
              'According to SEBI data, what percentage of individual intraday traders in India incur losses?',
          'options': ['50%', '70%', '89%', '95%'],
          'correctIndex': 2,
          'explanation':
              'SEBI\'s study found that approximately 89% of individual intraday traders lose money. This is why beginners should start with long-term investing (SIP) rather than jumping into day trading.',
        },
        {
          'type': 'scenario',
          'title': 'Final Scenario',
          'situation':
              'You\'ve been investing for 1 year via SIP. The market suddenly crashes 30% in a month due to a global crisis. Your portfolio is deep red. Friends are panic-selling. What do you do?',
          'choices': [
            {
              'text': 'Sell everything before it drops more',
              'isCorrect': false,
              'feedback':
                  '❌ Selling during a crash locks in your losses permanently. Every major crash in history (2008, 2020) was followed by a recovery. Patience is your superpower.',
            },
            {
              'text': 'Continue your SIP — crashes = buying at discounts',
              'isCorrect': true,
              'feedback':
                  '✅ Legendary move! Your SIP now buys MORE units at lower prices. When the market recovers (it always has), these units bought at discount will give you the highest returns.',
            },
            {
              'text': 'Double your SIP amount to buy more at low prices',
              'isCorrect': true,
              'feedback':
                  '✅ Even better! This is what Rakesh Jhunjhunwala and Warren Buffett do — "Be greedy when others are fearful." But only if you have surplus cash and a long time horizon.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Congratulations! 🎉',
          'keyPoints': [
            'You understand stocks, IPOs, and market mechanics',
            'You can classify stocks by Market Cap and Sector',
            'You know the difference between investing and trading',
            'You can identify and manage market risks',
            'You have a beginner\'s portfolio plan ready',
            'You are now ready to make your first real investment! 💪',
          ],
        },
      ],
    };
  }
}
