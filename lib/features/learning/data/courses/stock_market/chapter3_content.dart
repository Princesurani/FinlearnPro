/// Chapter 3: Know Your Stocks
/// Types of stocks - Market Cap, Cap categories, Sectors
class SMChapter3Content {
  // Lesson 1: Market Capitalization Explained
  static Map<String, dynamic> getMarketCapContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Size Tells a Story',
          'emoji': '🐘',
          'content':
              'A stock priced at ₹50 can be MORE valuable than a stock at ₹5,000. How? Because price alone tells you nothing. You need to understand Market Capitalization — the single number that reveals a company\'s true size.',
        },
        {
          'type': 'concept',
          'title': 'The Formula',
          'emoji': '🧮',
          'content': '''
**Market Cap = Share Price × Total Number of Shares**

**Example 1: MRF Limited**
Share Price: ₹1,25,000 (expensive!)
Total Shares: 42 Lakh
Market Cap: ₹1,25,000 × 42L = **₹52,500 Crore**

**Example 2: Reliance Industries**
Share Price: ₹2,500 (cheaper!)
Total Shares: 676 Crore
Market Cap: ₹2,500 × 676 Cr = **₹16,90,000 Crore**

**Surprise!**
Reliance at ₹2,500 is **32x bigger** than MRF at ₹1,25,000.
**Share price is misleading. Market Cap is the truth.**

**Key Rule:**
Never judge a company by its share price.
Always check Market Cap to understand the real size.
''',
          'keyPoints': [
            'Market Cap = Price × Total Shares Outstanding',
            'Share price alone is meaningless without total shares',
            'A ₹50 stock can be bigger than a ₹5,000 stock',
            'Market Cap reveals the company\'s true valuation',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Price vs Value Trap',
          'emoji': '🪤',
          'content': '''
**Which company is bigger?**

**Company A: "CheapStock Ltd"**
Price: ₹10 per share
Total shares: 100 Crore
Market Cap: ₹10 × 100 Cr = **₹1,000 Crore**

**Company B: "PriceKing Ltd"**
Price: ₹5,000 per share
Total shares: 10 Lakh
Market Cap: ₹5,000 × 10L = **₹500 Crore**

**Answer:** CheapStock at ₹10 is **TWICE** the size of PriceKing at ₹5,000!

**This is the #1 beginner trap.**
New investors think ₹10 stocks are "cheap" and ₹5,000 stocks are "expensive."
**Wrong.** Check Market Cap, not price.
''',
        },
        {
          'type': 'quiz',
          'title': 'Market Cap Quiz',
          'question':
              'Company X has 50 Crore shares at ₹200 each. Company Y has 5 Crore shares at ₹1,000 each. Which is bigger?',
          'options': [
            'Company Y (higher share price)',
            'Company X (₹10,000 Cr vs ₹5,000 Cr)',
            'Both are the same size',
            'Can\'t determine without more information',
          ],
          'correctIndex': 1,
          'explanation':
              'Company X: 50 Cr × ₹200 = ₹10,000 Crore. Company Y: 5 Cr × ₹1,000 = ₹5,000 Crore. Company X is twice as big despite having a lower share price!',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Market Cap = Share Price × Total Shares',
            'Never judge a stock by price alone',
            'A ₹10 stock can be bigger than a ₹10,000 stock',
            'Market Cap is the standard measure of company size',
            'Always check Market Cap before comparing stocks',
          ],
        },
      ],
    };
  }

  // Lesson 2: Large Cap, Mid Cap & Small Cap
  static Map<String, dynamic> getCapCategoriesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Pick Your Fighter',
          'emoji': '🥊',
          'content':
              'Large Cap, Mid Cap, Small Cap — you\'ll hear these terms everywhere. They determine how risky or stable a stock is. Think of it as choosing between a luxury car, a sports car, and a motorbike.',
        },
        {
          'type': 'concept',
          'title': 'The Three Categories',
          'emoji': '📊',
          'content': '''
**1. Large Cap (The Elephants) 🐘**
Market Cap: > ₹20,000 Crore (Top 100 companies)
Examples: Reliance, TCS, HDFC Bank, Infosys.
**Risk:** Low. These are market leaders.
**Return:** Steady (10-15% per year).
**Best for:** Safety and stability.

**2. Mid Cap (The Horses) 🐎**
Market Cap: ₹5,000 - ₹20,000 Crore (Rank 101-250)
Examples: Polycab, Trent, Voltas, Coforge.
**Risk:** Medium. They can grow fast OR fall hard.
**Return:** Higher potential (15-25% per year).
**Best for:** Growth-oriented investors.

**3. Small Cap (The Rabbits) 🐇**
Market Cap: < ₹5,000 Crore (Rank 251+)
Examples: Newer or niche companies.
**Risk:** High. Many fail or stay stagnant.
**Return:** Can be explosive (50%+) or devastating (-80%).
**Best for:** Risk-takers with patience.
''',
          'keyPoints': [
            'Large Cap = Safe, Stable, Slow growth',
            'Mid Cap = Moderate risk, Good growth potential',
            'Small Cap = High risk, High reward (or high loss)',
            'SEBI defines these based on ranking by Market Cap',
          ],
        },
        {
          'type': 'story',
          'title': 'Kavita\'s Portfolio Journey',
          'emoji': '👩‍💼',
          'content': '''
**Kavita** invests ₹3 Lakhs across categories:

**₹1.5L in Large Cap (HDFC Bank)**
2020: ₹1,200/share → 2024: ₹1,650/share
Return: **+37% in 4 years.** Slow but steady.
She slept peacefully every night. 😌

**₹1L in Mid Cap (Trent Ltd)**
2020: ₹600/share → 2024: ₹5,000/share
Return: **+733% in 4 years!** 🚀
But in 2022, it dropped 40%. She almost panic-sold.

**₹50K in Small Cap (Random tip from friend)**
2020: ₹150/share → 2024: ₹45/share
Return: **-70%.** The company had governance issues.
She lost ₹35,000. 😰

**Her Takeaway:**
"Large Caps protect my capital. Mid Caps grow my wealth. Small Caps taught me an expensive lesson about doing research."
''',
        },
        {
          'type': 'scenario',
          'title': 'Portfolio Allocation',
          'situation':
              'You have ₹1 Lakh to invest and want moderate risk. How should you allocate?',
          'choices': [
            {
              'text': '₹1L in a single Small Cap stock',
              'isCorrect': false,
              'feedback':
                  '❌ Extremely risky! One small cap stock can drop 80%. Never put all your money in a single small cap.',
            },
            {
              'text': '₹60K Large Cap, ₹30K Mid Cap, ₹10K Small Cap',
              'isCorrect': true,
              'feedback':
                  '✅ Smart! This is a balanced moderate-risk portfolio. Large Caps protect your base, Mid Caps add growth, Small Caps add a little spice.',
            },
            {
              'text': '₹50K in Large Cap, ₹50K in Fixed Deposit',
              'isCorrect': true,
              'feedback':
                  '✅ Also sensible for someone very risk-averse. But you may miss higher returns from mid caps. Consider adding some mid-cap exposure over time.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Large Cap = Safety net (Top 100 companies)',
            'Mid Cap = Growth engine (Rank 101-250)',
            'Small Cap = High risk, high reward (Rank 251+)',
            'Diversify across all three based on your risk appetite',
            'Never put 100% in small caps — most beginners regret it',
          ],
        },
      ],
    };
  }

  // Lesson 3: Sectors & Stock Classification
  static Map<String, dynamic> getSectorsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Don\'t Put All Eggs in One Basket',
          'emoji': '🧺',
          'content':
              'Owning 10 IT stocks is NOT diversification. If the IT sector crashes, all 10 will fall together. To truly reduce risk, you need to understand Sectors — the industries that drive the stock market.',
        },
        {
          'type': 'concept',
          'title': 'Major Indian Sectors',
          'emoji': '🏭',
          'content': '''
**1. BFSI (Banking, Financial Services & Insurance)**
HDFC Bank, ICICI Bank, SBI, Bajaj Finance.
The backbone of the economy. When India grows, banks grow.

**2. IT (Information Technology)**
TCS, Infosys, Wipro, HCL Tech.
Earns in **Dollars** → benefits when Rupee weakens.

**3. FMCG (Fast Moving Consumer Goods)**
HUL, ITC, Nestle, Britannia.
**Defensive:** People buy soap and biscuits even in a recession.

**4. Auto (Automobile)**
Tata Motors, Maruti, Bajaj Auto, M&M.
**Cyclical:** Sales boom when economy booms, crash when it slows.

**5. Pharma (Healthcare)**
Sun Pharma, Dr. Reddy's, Cipla.
**Defensive:** People need medicines regardless of the economy.
''',
          'keyPoints': [
            'BFSI = Economy backbone (grows with India)',
            'IT = Export-driven (earns in Dollars)',
            'FMCG & Pharma = Defensive (recession-proof)',
            'Auto & Realty = Cyclical (linked to economic cycles)',
          ],
        },
        {
          'type': 'story',
          'title': 'The COVID Test',
          'emoji': '🦠',
          'content': '''
**March 2020.** COVID lockdown begins. Nifty crashes 40%.

**But not all sectors fell equally:**

**Auto sector: -45%** 📉
Nobody bought cars during lockdown.
Maruti revenue: nearly zero for 2 months.

**IT sector: -30% then recovered fast** 📈
Work-from-home → Companies needed MORE IT services.
TCS and Infosys reached all-time highs by December 2020.

**Pharma sector: +25%** 🚀
Demand for medicines and vaccines skyrocketed.
Pharma stocks were the winners of 2020.

**FMCG: -15% only** 😌
People still bought Maggi, soap, and tea.
HUL barely dropped. Defensive stocks lived up to their name.

**Lesson:**
If your entire portfolio was Auto stocks, you'd have lost 45%.
If it was spread across sectors, the damage was much smaller.
**This is the power of sectoral diversification.**
''',
        },
        {
          'type': 'interactive',
          'title': 'Cyclical vs Defensive',
          'emoji': '🔄',
          'content': '''
**Quick Classification:**

**Cyclical Sectors** (ride the economic wave):
🚗 Auto — People buy cars in good times
🏗️ Real Estate — Construction booms when economy booms
✈️ Travel — People travel more when they earn more
🏦 Banks — More loans when economy is growing

**Defensive Sectors** (survive bad times):
💊 Pharma — People need medicine always
🧴 FMCG — People need soap and food always
⚡ Utilities — Electricity is non-negotiable
🔌 Telecom — Nobody cancels their phone plan

**Rule of Thumb:**
In a **bull market** (everything rising) → Cyclical stocks outperform.
In a **bear market** (everything falling) → Defensive stocks protect you.
''',
        },
        {
          'type': 'quiz',
          'title': 'Sector Sense',
          'question':
              'India enters a recession. GDP growth slows. Which stock is the SAFEST bet?',
          'options': [
            'Tata Motors (Auto)',
            'DLF (Real Estate)',
            'Hindustan Unilever (FMCG)',
            'IndiGo Airlines (Travel)',
          ],
          'correctIndex': 2,
          'explanation':
              'HUL is a defensive FMCG company. People buy soap, detergent, and tea regardless of the economy. Auto, Real Estate, and Travel all suffer badly in a recession.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Stocks are grouped into Sectors (BFSI, IT, FMCG, etc.)',
            'Cyclical sectors boom with the economy, crash with it',
            'Defensive sectors survive recessions (Pharma, FMCG)',
            'True diversification = spreading across SECTORS, not just stocks',
            'COVID proved why sectoral diversity protects your portfolio',
          ],
        },
      ],
    };
  }
}
