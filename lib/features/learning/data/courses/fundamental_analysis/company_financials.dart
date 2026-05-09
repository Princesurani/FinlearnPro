/// Chapter 3: Company Financial Basics (Stocks)
/// Reading the three financial statements
class CompanyFinancialsContent {
  // Lesson 3.1: The Three Financial Statements
  static Map<String, dynamic> getThreeStatementsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Company\'s Report Card',
          'emoji': '📄',
          'content':
              'Every listed company publishes three financial statements every quarter. These are the company\'s report card — they tell you if the business is growing, profitable, and financially healthy. Reading these is the most valuable skill in stock investing.',
        },
        {
          'type': 'story',
          'title': 'The Coffee Shop Illusion',
          'emoji': '☕',
          'content': '''
**Imagine you want to buy a friend's coffee shop.**

Your friend says, "It's a great business! We sold ₹10 Lakh worth of coffee last month!" (**Revenue / Income Statement**)

You are impressed. But then you ask a second question: "How much do you owe the bank?"
He replies, "We have a ₹50 Lakh loan we can't pay back." (**Liabilities / Balance Sheet**)

You then ask a third question: "Are you actually making cash right now?"
He says, "Well, we gave coffee on credit to a nearby office, so we haven't actually received any cash this month." (**Cash Flow Statement**)

**The reality:** The ₹10 Lakh revenue was an illusion. The business is heavily in debt and has no real cash coming in. If you only looked at the "sales," you would have bought a bankrupt business.

**Key lesson:** You MUST read all three statements together. One statement alone can lie. Three statements together reveal the truth.
''',
        },
        {
          'type': 'concept',
          'title': 'The Three Financial Statements',
          'emoji': '📊',
          'content': '''
**1. Income Statement (Profit & Loss) 💰**
**Shows: How much money the company made or lost.**

Revenue (Sales): ₹10,000 Cr (what customers paid)
- Cost of Goods: ₹6,000 Cr (raw materials, manufacturing)
= Gross Profit: ₹4,000 Cr
- Operating Expenses: ₹2,000 Cr (salaries, rent, marketing)
= Operating Profit (EBITDA): ₹2,000 Cr
- Interest & Tax: ₹500 Cr
= **Net Profit: ₹1,500 Cr** (the bottom line — what shareholders earn)

**Key Metrics:**
• Revenue growth rate (is the company selling more each year?)
• Net profit margin (₹1,500/₹10,000 = 15% — how much profit per rupee of sales)

---

**2. Balance Sheet 🏦**
**Shows: What the company owns and owes AT A POINT IN TIME.**

**Assets (What it owns):**
• Cash: ₹2,000 Cr
• Inventory: ₹1,500 Cr
• Property/Equipment: ₹5,000 Cr
• Total Assets: ₹8,500 Cr

**Liabilities (What it owes):**
• Debt (Loans): ₹3,000 Cr
• Payables: ₹1,000 Cr
• Total Liabilities: ₹4,000 Cr

**Equity (What belongs to shareholders):**
• Total Assets - Total Liabilities = ₹4,500 Cr

**Key Metrics:**
• Debt-to-Equity Ratio: ₹3,000/₹4,500 = 0.67 (below 1 = healthy)

---

**3. Cash Flow Statement 🌊**
**Shows: Actual cash moving in and out.**

A company can show "profit" on paper but have no cash!
• **Operating Cash Flow:** Cash from core business (should be positive)
• **Investing Cash Flow:** Cash spent on assets (usually negative — they're investing)
• **Financing Cash Flow:** Debt taken/repaid, dividends paid

**Key Metric:** Free Cash Flow = Operating CF - Capital Expenditure
**This is the REAL money available to shareholders.**
''',
          'keyPoints': [
            'Income Statement = revenue minus costs = profit (the report card)',
            'Balance Sheet = assets minus liabilities = equity (the health check)',
            'Cash Flow = actual cash moving in/out (the reality check)',
            'Free Cash Flow is the most important number — real money for shareholders',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'A company shows ₹500 Cr net profit but its Operating Cash Flow is negative (-₹200 Cr). What does this tell you?',
          'options': [
            'The company is doing great — ₹500 Cr profit is impressive',
            'The profit is likely on paper only — the company is not generating real cash. This is a major red flag.',
            'Cash flow doesn\'t matter — only profit matters',
            'This is normal for all companies',
          ],
          'correctIndex': 1,
          'explanation':
              'When profit is positive but cash flow is negative, it means the company is using accounting tricks to show profit (e.g., recognizing revenue before collecting cash, capitalizing expenses). Companies go BANKRUPT from running out of cash, not from running out of "profit." Cash is king.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Three statements: Income (profit), Balance Sheet (health), Cash Flow (reality)',
            'Revenue growth + profit margins = is the business growing profitably?',
            'Debt-to-Equity < 1 = healthy; > 2 = risky (too much debt)',
            'Free Cash Flow is the most honest number — it can\'t be manipulated easily',
            'Next: The key ratios that tell you if a stock is cheap or expensive.',
          ],
        },
      ],
    };
  }

  // Lesson 3.2: Key Ratios Every Investor Must Know
  static Map<String, dynamic> getKeyRatiosContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Numbers That Matter',
          'emoji': '🔢',
          'content':
              'Financial statements have hundreds of numbers. But professional investors focus on 5-6 key ratios that tell the complete story. Master these ratios and you can evaluate any stock in 10 minutes.',
        },
        {
          'type': 'concept',
          'title': 'The Essential Ratios',
          'emoji': '📐',
          'content': '''
**Valuation Ratios (Is it cheap or expensive?):**

**1. P/E Ratio (Price-to-Earnings) 📊**
P/E = Share Price / Earnings Per Share
• Tells you: How much you pay for each ₹1 of earnings
• Low P/E (< 15): Potentially undervalued (or low growth)
• High P/E (> 30): Potentially overvalued (or high growth expected)
• Compare within the SAME industry, not across industries

**2. P/B Ratio (Price-to-Book) 📚**
P/B = Share Price / Book Value Per Share
• Tells you: Are you paying more or less than the company's net assets?
• P/B < 1: You're paying LESS than what the company owns (potential bargain!)
• Most useful for: Banks and asset-heavy companies

---

**Profitability Ratios (Is it a good business?):**

**3. ROE (Return on Equity) 💰**
ROE = Net Profit / Shareholders' Equity × 100
• Tells you: How efficiently the company uses YOUR money
• ROE > 15%: Good. ROE > 20%: Excellent.
• Consistently high ROE = strong competitive advantage

**4. Net Profit Margin 📈**
NPM = Net Profit / Revenue × 100
• Tells you: How much profit per ₹100 of sales
• Higher margin = better pricing power and cost control

---

**Health Ratio:**

**5. Debt-to-Equity (D/E) ⚖️**
D/E = Total Debt / Shareholders' Equity
• D/E < 0.5: Very conservative (safe)
• D/E 0.5-1.0: Moderate (acceptable)
• D/E > 1.5: High debt (risky in downturns)

---

**Key Insight:**
No single ratio tells the whole story. A low P/E might mean the stock is cheap OR that the market expects earnings to decline. Always use 3-4 ratios together for the complete picture.
''',
          'keyPoints': [
            'P/E = how much you pay per ₹1 of earnings (lower = cheaper, same industry)',
            'ROE > 15% = company is using shareholder money efficiently',
            'D/E < 1 = healthy debt levels; D/E > 1.5 = risky',
            'No single ratio is enough — use 3-4 together for the full picture',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Ratio Comparison: Two Stocks',
          'emoji': '📊',
          'content': '''
**Stock A: Infosys**
• P/E: 22
• ROE: 32%
• Debt-to-Equity: 0.08 (almost zero debt!)
• Net Profit Margin: 18%
• Revenue Growth: 12%

**Stock B: Yes Bank**
• P/E: 45
• ROE: 4%
• Debt-to-Equity: 12.5 (massively leveraged — it's a bank)
• Net Profit Margin: 5%
• Revenue Growth: -8%

**Analysis:**

**Infosys:** Moderate P/E (22) justified by excellent ROE (32%), zero debt, strong margins (18%), and steady growth (12%). A quality business at a reasonable price. ✅

**Yes Bank:** High P/E (45) with terrible ROE (4%), declining revenue, and thin margins. You're paying a PREMIUM for a STRUGGLING business. ❌

**Key Lesson:**
Looking at ratios took us 2 minutes. Without ratios, you might have bought Yes Bank because "it's only ₹22 per share" while Infosys is "₹1,500 per share." Ratios reveal the truth that price alone hides.
''',
        },
        {
          'type': 'quiz',
          'title': 'Ratio Application',
          'question':
              'You are analyzing two FMCG companies. Company A has a P/E of 60 and ROE of 25%. Company B has a P/E of 10 and ROE of 5%. Which is the better business, and why?',
          'options': [
            'Company B is better because the P/E is only 10, making it very cheap.',
            'Company A is a much better business (25% ROE vs 5%), but you have to decide if paying a premium P/E of 60 is worth it.',
            'Company B is better because lower ROE means less risk.',
            'They are equally good businesses, but Company A is just more popular.',
          ],
          'correctIndex': 1,
          'explanation':
              'ROE measures the QUALITY of the business. 25% is excellent; 5% is terrible. Company A is a great business, which is exactly why the market is pricing it at a high P/E (60). Company B is cheap (P/E 10) because it\'s a bad business. A low P/E is often a "value trap" if the underlying business is poor.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'P/E and P/B tell you if the stock is cheap or expensive relative to earnings/assets',
            'ROE and Profit Margin tell you if the business is high-quality',
            'Debt-to-Equity tells you if the company can survive tough times',
            'Always compare ratios within the same industry — IT vs IT, not IT vs Banks',
            'Next: How to read an actual annual report like a professional.',
          ],
        },
      ],
    };
  }

  // Lesson 3.3: Reading an Annual Report
  static Map<String, dynamic> getAnnualReportContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The 200-Page Goldmine',
          'emoji': '📖',
          'content':
              'Annual reports are 200+ pages long. Most investors never read them. But hidden inside are clues about the company\'s future that no news article or YouTube video will tell you. Let\'s learn what to look for.',
        },
        {
          'type': 'story',
          'title': 'The Enron Warning Sign',
          'emoji': '🚨',
          'content': '''
**In 2000, Enron was the 7th largest company in America.** 
Wall Street analysts loved it. The stock was flying high.

But a few smart fundamental analysts actually read the footnotes in Enron's Annual Report. 

While the "Income Statement" showed massive profits, the **notes to the financial statements** revealed complex "special purpose entities" (shell companies) used to hide massive amounts of debt off the balance sheet. 

Furthermore, the **Cash Flow Statement** was deeply negative. Enron was reporting "profits" but bleeding real cash.

Those who read the annual report sold their shares. Those who just read the news headlines held on.

In 2001, Enron declared bankruptcy. The stock went to \$0.

**Key lesson:** The glossy front pages of an annual report are marketing. The boring, difficult-to-read footnotes at the back are where the actual truth is found. Always check the notes.
''',
        },
        {
          'type': 'concept',
          'title': 'The 5 Sections That Matter',
          'emoji': '🔍',
          'content': '''
**1. Chairman/MD Letter (First 5-10 pages) 📝**
• The management's own assessment of the year
• Look for: Honest discussion of challenges (good sign) vs only bragging (red flag)
• Key: Compare last year's promises with this year's results

**2. Management Discussion & Analysis (MD&A) 📊**
• Detailed breakdown of each business segment
• Look for: Revenue by segment, growth drivers, risks acknowledged
• **This is the MOST valuable section — read it carefully**

**3. Financial Statements (3 statements + notes) 📄**
• Income Statement, Balance Sheet, Cash Flow
• **Read the NOTES to financial statements** — this is where bodies are buried
• Related party transactions, contingent liabilities, accounting policy changes

**4. Auditor's Report 🔎**
• Independent auditor's opinion on the accounts
• "Clean" opinion = reliable financials ✅
• "Qualified" opinion = auditor found issues ⚠️
• "Adverse" opinion = major problems. RUN. ❌

**5. Shareholding Pattern 👥**
• Promoter holding: Is the founder increasing or decreasing stake?
• FII/DII holding: Are institutional investors buying or selling?
• Promoter pledging: Shares used as loan collateral (RED FLAG if high)

---

**Key Insight:**
Promoter BUYING shares = they believe the stock will rise (bullish).
Promoter SELLING shares = they want cash out (bearish or neutral).
Promoter PLEDGING shares = they're desperate for money (dangerous).
''',
          'keyPoints': [
            'MD&A section is the most valuable — read it carefully',
            'Auditor\'s report: clean = safe; qualified = caution; adverse = avoid',
            'Promoter buying = bullish; selling = caution; pledging = red flag',
            'Notes to financial statements hide important risks and disclosures',
          ],
        },
        {
          'type': 'scenario',
          'title': 'Annual Report Red Flags',
          'situation':
              'You\'re reading a company\'s annual report. The chairman\'s letter talks about "aggressive expansion" and "game-changing acquisitions." But in the financial notes, you find: (1) Debt-to-Equity jumped from 0.5 to 2.5, (2) Promoter pledging increased from 5% to 45%, (3) Auditor gave a "qualified" opinion. What do you conclude?',
          'choices': [
            {
              'text': 'The chairman\'s letter sounds exciting — buy the stock!',
              'isCorrect': false,
              'feedback':
                  '❌ The chairman\'s letter is MARKETING. The real story is in the numbers: D/E tripling means dangerous debt. 45% promoter pledging means the founder is using company shares as loan collateral. Qualified audit means the auditor found problems. These are classic warning signs of a potential collapse.',
            },
            {
              'text':
                  'AVOID — tripling debt, 45% pledging, and qualified audit are three massive red flags that contradict the rosy chairman\'s letter',
              'isCorrect': true,
              'feedback':
                  '✅ Exactly! This pattern (rosy narrative + deteriorating fundamentals) was seen in companies like DHFL, Yes Bank, and Vakrangee before they collapsed. When the story says one thing and the numbers say another, ALWAYS trust the numbers.',
            },
            {
              'text': 'Hold — wait for next quarter to see if things improve',
              'isCorrect': false,
              'feedback':
                  '❌ With three simultaneous red flags (debt explosion, high pledging, qualified audit), waiting is too risky. These companies can lose 80-90% of value before you react. The time to sell is when you FIRST see the red flags, not after the damage is done.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 3 Complete! 🎉',
          'keyPoints': [
            'Three financial statements = revenue (P&L), health (balance sheet), reality (cash flow)',
            'Key ratios: P/E, ROE, D/E, Profit Margin — use 3-4 together, never just one',
            'Annual report: focus on MD&A, auditor report, and shareholding pattern',
            'When the narrative and numbers disagree, ALWAYS trust the numbers',
            'Promoter pledging > 30% is a serious red flag — approach with extreme caution',
            'Next: The macro numbers that move ENTIRE markets — GDP, inflation, and interest rates.',
          ],
        },
      ],
    };
  }
}
