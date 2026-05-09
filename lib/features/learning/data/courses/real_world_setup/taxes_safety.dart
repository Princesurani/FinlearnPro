/// Chapters 5-6: Taxation Overview + Trading Safely & Legally
class TaxationContent {
  static Map<String, dynamic> getTradingTaxesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Tax Man Cometh',
          'emoji': '🧾',
          'content':
              'You made ₹2 Lakh trading this year. Congratulations! Now the government wants its share. If you don\'t file correctly, you face penalties, interest, and potential audits. Let\'s simplify trading taxes.',
        },
        {
          'type': 'concept',
          'title': 'Indian Trading Tax Categories',
          'emoji': '📋',
          'content': '''
**1. Short-Term Capital Gains (STCG) 📊**
• Applies to: Stocks held for LESS than 12 months
• Tax rate: **15%** (flat, regardless of your income slab)
• Example: Buy at ₹100, sell at ₹150 after 6 months. Gain = ₹50. Tax = ₹7.50 per share.

**2. Long-Term Capital Gains (LTCG) 🌳**
• Applies to: Stocks held for MORE than 12 months
• Tax rate: **10%** on gains ABOVE ₹1 Lakh per year
• First ₹1 Lakh of LTCG is TAX FREE!
• Example: ₹2L LTCG. Tax-free: ₹1L. Taxable: ₹1L × 10% = ₹10,000.

**3. Speculative Business Income (Intraday) 💹**
• Applies to: Intraday equity trades (bought and sold same day)
• Taxed as: BUSINESS INCOME at your income tax slab rate
• Example: If your salary puts you in the 30% bracket, intraday profits are taxed at 30%!

**4. Non-Speculative Business Income (F&O) 📈**
• Applies to: Futures & Options trades
• Taxed as: BUSINESS INCOME at your slab rate
• Tax audit required if F&O turnover exceeds ₹10 Crore (or losses need to be carried forward)

---

**Key Insight:**
Intraday and F&O profits are taxed as business income (up to 30%). Long-term stock gains are taxed at just 10% above ₹1L. The tax structure REWARDS patience and PUNISHES overtrading.
''',
          'keyPoints': [
            'STCG (stocks <12 months): 15% flat',
            'LTCG (stocks >12 months): 10% above ₹1L (first ₹1L free)',
            'Intraday profits: Taxed at your slab rate (up to 30%)',
            'F&O profits: Also business income at slab rate + audit requirements',
          ],
        },
        {
          'type': 'story',
          'title': 'The Tax Trap',
          'emoji': '💸',
          'content': '''
**Rahul** was a software engineer earning ₹20 Lakh per year (30% tax bracket).
He decided to try day trading for extra income.

After a year of stressful intraday trading, his P&L showed a profit of ₹2 Lakh. He was thrilled. He thought he would pay 15% tax (like STCG).

**Tax season arrived:**
His CA explained that intraday trading is considered *speculative business income*, not capital gains. It is added to his existing salary and taxed at his slab rate.
Rahul's slab rate was 30%.
Plus 4% health & education cess.

He paid over ₹62,400 in taxes on his ₹2 Lakh trading profit.
His net profit after a year of hard work and stress was less than ₹1.4 Lakh.

**Key lesson:** Knowing the tax laws *before* you trade dictates your strategy. For a high-income earner like Rahul, intraday trading makes zero sense compared to Swing Trading (which would have been taxed at a flat 15%).
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You earned ₹3 Lakh from long-term stock investments (held >12 months). How much tax do you owe?',
          'options': [
            '₹30,000 (10% on full amount)',
            '₹20,000 (10% on ₹2L above the ₹1L exemption)',
            '₹45,000 (15% on full amount)',
            '₹0 (all LTCG is tax-free)',
          ],
          'correctIndex': 1,
          'explanation':
              'LTCG tax: First ₹1 Lakh is exempt. Taxable = ₹3L - ₹1L = ₹2L. Tax = 10% × ₹2L = ₹20,000. This is much better than intraday profits, which would be taxed at your slab rate (potentially 30%, or ₹90,000 on ₹3L).',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Tax structure rewards long-term holding and punishes overtrading',
            'LTCG is the most tax-efficient: 10% above ₹1L exemption',
            'Intraday and F&O are taxed as business income at your slab rate',
            'Always consult a CA for complex trading tax situations',
            'Next: How to be tax-efficient in your trading.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getTaxEfficientContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Legal Tax Optimization',
          'emoji': '🧠',
          'content':
              'Tax avoidance is illegal. Tax PLANNING is smart. There are completely legal strategies to minimize your tax burden from trading.',
        },
        {
          'type': 'concept',
          'title': 'Tax Planning Strategies',
          'emoji': '📊',
          'content': '''
**Strategy 1: Tax-Loss Harvesting 🌾**
Sell losing positions before March 31 to book losses. These losses can be set off against your gains, reducing your tax bill.
Example: ₹1L gain + ₹40K harvested loss = ₹60K taxable gain. Tax saved: ₹6,000.

**Strategy 2: Hold for 12+ Months ⏰**
LTCG (10% above ₹1L) is far better than STCG (15%) or business income (30%).
If a swing trade is profitable and you are near the 12-month mark, consider holding longer.

**Strategy 3: Separate Trading & Investing Accounts 📂**
Keep your delivery (investment) trades and your intraday/F&O trades in different accounts. This simplifies tax filing and categorization.

**Strategy 4: Maintain Proper Records 📝**
Keep a record of EVERY trade (your trading journal doubles as a tax record). Keep P&L statements from your broker. Store contract notes.

**Strategy 5: Hire a CA 🧑‍💼**
If you trade F&O or have complex tax situations, the ₹5,000-₹10,000 CA fee is an investment, not an expense. A good CA can save you multiples of their fee.
''',
          'keyPoints': [
            'Tax-loss harvesting reduces taxable gains before March 31',
            'Holding for 12+ months converts STCG (15%) to LTCG (10%)',
            'Separate accounts for trading and investing simplify tax filing',
            'A good CA is an investment, not an expense',
          ],
        },
        {
          'type': 'story',
          'title': 'The Tax Harvesting Trick',
          'emoji': '🌾',
          'content': '''
**Anita** held a portfolio of stocks for 5 years.
Stock A: +₹1,50,000 (LTCG)
Stock B: -₹80,000 (Loss)

It was March 25th. Anita wanted to sell Stock A to buy a car.
If she just sold Stock A:
She had ₹1,50,000 LTCG. The first ₹1,00,000 is tax-free.
She owes 10% tax on the remaining ₹50,000 = ₹5,000 tax.

**Her CA suggested "Tax-Loss Harvesting":**
She sold Stock A (booking the ₹1.5L gain).
*On the exact same day*, she sold Stock B (booking the ₹80K loss).
*The next day*, she bought back Stock B at roughly the same price because she still believed in the company.

**The Math:**
Realized Gain: ₹1,50,000
Realized Loss: -₹80,000
Net Taxable Gain: ₹70,000.
Because ₹70,000 is below the ₹1 Lakh exemption limit, her tax bill was **Zero.**

**Key lesson:** By booking her losing position before March 31st and buying it back, Anita legally wiped out her tax liability. This is why you should always review your portfolio in March.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'It is March 25. You have ₹50,000 in realized STCG gains. You also hold a stock with ₹30,000 in unrealized losses. What tax strategy can you use?',
          'options': [
            'Do nothing — unrealized losses don\'t affect taxes',
            'Sell the losing stock to book a ₹30K loss, reducing your taxable gain to ₹20K (saving ₹4,500 in STCG tax)',
            'Buy more of the losing stock to average down',
            'Sell the winning stocks to avoid tax',
          ],
          'correctIndex': 1,
          'explanation':
              'This is tax-loss harvesting. By selling the losing stock before March 31, you book a ₹30K loss. Net taxable gain = ₹50K - ₹30K = ₹20K. Tax saved = ₹4,500 (at 15% STCG). You can even buy back the stock after a few days if you still believe in it.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 5 Complete! 🎉',
          'keyPoints': [
            'Tax-loss harvesting is a powerful year-end strategy',
            'Holding for 12+ months is the most tax-efficient approach',
            'Maintain detailed records — your journal is your tax document',
            'Hire a CA if you trade F&O or have complex situations',
            'Next: Protecting yourself from scams and fraud.',
          ],
        },
      ],
    };
  }
}

class TradingSafetyContent {
  static Map<String, dynamic> getScamsFraudContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Wolves in Guru Clothing',
          'emoji': '🐺',
          'content':
              'The Indian trading ecosystem is infested with scams. From fake gurus selling ₹50,000 courses to pump-and-dump WhatsApp groups to phishing attacks on broker accounts. Your money is at risk from more than just bad trades.',
        },
        {
          'type': 'concept',
          'title': 'The Scam Encyclopedia',
          'emoji': '📕',
          'content': '''
**Scam Type 1: Fake Gurus 🎭**
Signs: "95% accuracy!", luxury car photos, Telegram premium groups.
Reality: They make money from course sales and subscriptions, not trading.
Defense: Ask for a SEBI-registered advisory license. If they don't have one, they are operating illegally.

**Scam Type 2: Pump & Dump 📢**
Signs: "Buy XYZ NOW! Target 5x in 1 week!" in WhatsApp groups.
Reality: Organizers bought first. You are the exit liquidity.
Defense: Never buy penny stocks based on tips. If it sounds too good to be true, it is.

**Scam Type 3: Phishing Attacks 🎣**
Signs: SMS/email saying "Your Zerodha account is blocked. Click here to verify."
Reality: The link takes you to a fake website that steals your credentials.
Defense: Never click links in SMS. Always type the broker URL directly. Enable 2FA.

**Scam Type 4: "Guaranteed Returns" Schemes 💎**
Signs: "Invest ₹1 Lakh, get ₹10,000/month guaranteed."
Reality: Ponzi scheme. Early investors are paid with later investors' money.
Defense: If returns are "guaranteed," it is 100% a scam. Markets do not guarantee anything.

---

**Key Insight:**
SEBI-registered advisors MUST display their registration number. Ask for it. If they can't provide it, leave immediately.
''',
          'keyPoints': [
            'Fake gurus sell courses, not profitable trading signals',
            'Pump-and-dump schemes use you as exit liquidity',
            'Never click broker-related links in SMS or email',
            '"Guaranteed returns" = 100% scam (Ponzi scheme)',
          ],
        },
        {
          'type': 'scenario',
          'title': 'The Course Temptation',
          'situation':
              'An Instagram influencer with 500K followers offers a "Complete Options Mastery" course for ₹49,999. He shows screenshots of ₹5 Lakh daily profits. 200 testimonials say "life-changing!" Should you buy it?',
          'choices': [
            {
              'text': 'Yes — 500K followers can\'t be wrong',
              'isCorrect': false,
              'feedback':
                  '❌ Followers can be bought. Screenshots can be faked in Photoshop. Testimonials can be paid or from friends. Ask: if he makes ₹5L/day trading, why sell a ₹50K course? Because the course IS his income.',
            },
            {
              'text':
                  'No. Check if he is SEBI-registered. Use free resources (like FinlearnPro!) first. If paid education is needed, choose a SEBI-registered research analyst.',
              'isCorrect': true,
              'feedback':
                  '✅ Most of the education you need is available for free. If you want paid mentorship, ensure the person is a SEBI-registered Research Analyst (RA) or Investment Advisor (IA). Ask for the registration number and verify on SEBI\'s website.',
            },
            {
              'text': 'Buy the course but ask for a refund if it doesn\'t work',
              'isCorrect': false,
              'feedback':
                  '❌ Most of these courses have a "no refund" policy buried in fine print. You will not get your ₹49,999 back.',
            },
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Which of the following is a red flag for a trading scam?',
          'options': [
            'A SEBI-registered advisor charging ₹5,000 for annual advisory',
            'A Telegram channel promising "guaranteed 50% monthly returns"',
            'A free webinar by a broker explaining options basics',
            'An index fund with 12% average annual returns',
          ],
          'correctIndex': 1,
          'explanation':
              '"Guaranteed 50% monthly returns" is mathematically absurd and legally impossible to promise. Even the best hedge funds in the world average 15-25% annually. Anyone guaranteeing 50% monthly is running a Ponzi scheme or a scam.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Fake gurus, pump-and-dump, phishing, and Ponzi schemes are everywhere',
            'Always verify SEBI registration of anyone offering paid trading advice',
            'Never click broker links in SMS/email — type the URL directly',
            '"Guaranteed returns" in the market = 100% scam',
            'Next: The final exam on real-world trading setup.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getFinalChallengeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Real-World Knowledge Test',
          'emoji': '🎓',
          'content':
              'You have learned about brokers, fees, regulations, taxes, and scams. Let\'s test if you are ready to operate safely in the real market.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Broker Safety',
          'question':
              'What is the FIRST thing you should verify before opening an account with any broker?',
          'options': [
            'Their app store rating',
            'Their social media following',
            'Their SEBI registration number (verifiable on sebi.gov.in)',
            'The number of free features they offer',
          ],
          'correctIndex': 2,
          'explanation':
              'SEBI registration is the only legal requirement. An unregistered broker can disappear with your money, and you will have no legal recourse. Always verify at sebi.gov.in.',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: Tax Knowledge',
          'question':
              'You made ₹80,000 from intraday trading and ₹50,000 from long-term stock sales (held >12 months). How are they taxed?',
          'options': [
            'Both at 15% flat rate',
            'Intraday at your income slab rate (up to 30%); LTCG at 0% (below ₹1L exemption)',
            'Both at 10%',
            'Intraday is tax-free; LTCG at 10%',
          ],
          'correctIndex': 1,
          'explanation':
              'Intraday profits are speculative business income, taxed at your slab rate (could be 20-30%). LTCG of ₹50,000 is below the ₹1 Lakh annual exemption, so tax = ₹0. This shows how long-term investing is far more tax-efficient.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: Scam Detection',
          'question':
              'A social media "trader" shows you a screenshot of a ₹10 Lakh profit from a single day. They offer a mentorship for ₹1 Lakh. What is the most likely reality?',
          'options': [
            'They are a genuine expert willing to share knowledge',
            'The screenshot is likely fake or cherry-picked, and the mentorship is their real income source',
            'You should invest ₹1 Lakh immediately',
            'SEBI has verified their claims',
          ],
          'correctIndex': 1,
          'explanation':
              'Screenshots can be photoshopped in 30 seconds. Even if genuine, one day\'s profit means nothing — ask for 3 years of audited returns. The ₹1L mentorship IS their business model. Real profitable traders don\'t need to sell mentorship.',
        },
        {
          'type': 'scenario',
          'title': 'The Complete Setup Check',
          'situation':
              'You are ready to start real trading. You have ₹1.5L savings (which is also your emergency fund). You found a broker with amazing reviews but it is NOT registered with SEBI. They offer 50x leverage. What do you do?',
          'choices': [
            {
              'text': 'Open an account — the reviews are great',
              'isCorrect': false,
              'feedback':
                  '❌ An unregistered broker can legally steal your money. Great reviews can be fake. 50x leverage will wipe you out on the first volatility spike.',
            },
            {
              'text':
                  'Use a SEBI-registered broker. Don\'t trade with your emergency fund — first build a separate risk capital pool. Start with paper trading.',
              'isCorrect': true,
              'feedback':
                  '✅ Three critical corrections: (1) Only SEBI-registered brokers, (2) Never trade with your emergency fund, (3) Paper trade first to build skills. You are not yet ready for real money.',
            },
            {
              'text': 'Open a small account with ₹20,000 to test the broker',
              'isCorrect': false,
              'feedback':
                  '❌ Even ₹20K with an unregistered broker is at risk. There is no "safe" amount to test an illegal operation.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Congratulations! 🎓🏦',
          'keyPoints': [
            'Always verify SEBI registration before trusting any broker or advisor',
            'Understand the 6 layers of trading costs to calculate real profit',
            'Tax structure rewards long-term investing over active trading',
            'Scams are everywhere — verify, verify, verify',
            'Your infrastructure should be reliable, not expensive',
            'You are now equipped to set up a safe, legal trading practice.',
          ],
        },
      ],
    };
  }
}
