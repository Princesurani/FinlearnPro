/// Chapter 2: From Startup to Stock Exchange
/// How companies issue shares - IPO, Listing, and Markets
class SMChapter2Content {
  // Lesson 1: Why Companies Sell Shares
  static Map<String, dynamic> getWhyCompaniesSellContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Why Give Up Ownership?',
          'emoji': '🤔',
          'content':
              'If you built a successful business, would you give away 25% of it to strangers? Companies do this all the time. Why? Because sometimes growth requires more money than any single person has.',
        },
        {
          'type': 'story',
          'title': 'Ananya\'s App Startup',
          'emoji': '💡',
          'content': '''
**Ananya** built a food delivery app in Bengaluru.
Year 1: 10,000 users. Revenue: ₹30 Lakhs.
Year 2: 1,00,000 users. Revenue: ₹3 Crores.

**The Problem:**
To scale to 10 Lakh users, she needs:
• ₹50 Crores for tech infrastructure
• ₹30 Crores for marketing
• ₹20 Crores for hiring

**Her bank says:** "Max loan: ₹5 Crores."
That's not even close.

**The Solution:**
She approaches **Venture Capital (VC) firms**.
A VC offers ₹100 Crores for 30% ownership.

**The Trade-off:**
Ananya now owns 70% instead of 100%.
But 70% of a ₹300 Crore company > 100% of a ₹3 Crore company.

**Lesson:**
Companies sell shares to raise money for growth.
The founder gives up ownership % but grows the total pie.
''',
        },
        {
          'type': 'concept',
          'title': '4 Ways Companies Raise Money',
          'emoji': '💰',
          'content': '''
**1. Bootstrapping (Self-funding)**
Use your own savings.
*Limit: ₹10-50 Lakhs for most people.*

**2. Bank Loan (Debt)**
Borrow and pay interest.
*Problem: Must repay even if business fails.*

**3. Angel/VC Investment (Private Equity)**
Sell shares to a few rich investors.
*Only available to high-growth startups.*

**4. IPO (Public Equity) ⭐**
Sell shares to the **general public** via the stock exchange.
*Available to established companies. Anyone can invest.*

**Why IPO is special:**
It's the only method where **YOU** — a regular person with a Demat account — can become an owner of companies like Zomato, Nykaa, or Tata Motors.
''',
          'keyPoints': [
            'Companies sell shares to raise money for growth',
            'Debt (loans) requires repayment; Equity (shares) does not',
            'IPO lets regular people invest in companies',
            'Founders trade ownership % for a bigger company',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Funding Check',
          'question':
              'Why would a founder prefer selling equity (shares) over taking a bank loan?',
          'options': [
            'Loans have lower interest rates',
            'Equity doesn\'t require repayment — no debt pressure',
            'Banks give unlimited money',
            'Equity is always cheaper than debt',
          ],
          'correctIndex': 1,
          'explanation':
              'When you sell equity, investors share your risk. If the company fails, you don\'t owe them anything. With a loan, you must repay the bank regardless of whether your business succeeds or not.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Companies sell shares to fund massive growth',
            'IPO is the gateway for public investors like you',
            'Equity = sharing risk; Debt = guaranteed repayment',
            'Founders give up ownership % but grow the total value',
          ],
        },
      ],
    };
  }

  // Lesson 2: The IPO Journey
  static Map<String, dynamic> getIPOJourneyContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Going Public',
          'emoji': '🚀',
          'content':
              'How does a private company like Zomato suddenly appear on your Zerodha app? It goes through a massive, regulated event called an IPO. Let\'s follow the entire journey.',
        },
        {
          'type': 'concept',
          'title': 'IPO: Step by Step',
          'emoji': '📋',
          'content': '''
**IPO = Initial Public Offering**
The first time a company sells its shares to the public.

**Step 1: Decision**
The board of directors decides: "We need ₹5,000 Crores. Let's go public."

**Step 2: Hire Experts**
Investment banks (e.g., Kotak, Morgan Stanley) are hired to manage the IPO. They decide the **price range**.

**Step 3: DRHP Filing**
Company files a **Draft Red Herring Prospectus** with SEBI.
This document reveals everything — profits, losses, risks, debts.

**Step 4: Roadshow**
Company pitches to big investors (mutual funds, FIIs).
If big players are interested, the IPO is likely to succeed.

**Step 5: IPO Opens**
You apply for shares through your broker app. Bidding happens for 3-5 days.

**Step 6: Allotment**
If oversubscribed, not everyone gets shares. A lottery decides who does.
''',
          'keyPoints': [
            'IPO = First time company sells shares to public',
            'DRHP is the company\'s financial confession document',
            'SEBI approval is mandatory before any IPO',
            'Oversubscription means demand > supply — lottery decides allotment',
          ],
        },
        {
          'type': 'story',
          'title': 'Listing Day: Zomato\'s Big Debut',
          'emoji': '🎆',
          'content': '''
**July 23, 2021.** Zomato's listing day.

**IPO Price:** ₹76 per share.
**Subscribed:** 38 times (massive demand!).

**9:15 AM — Market Opens:**
Zomato lists at ₹116.
**Listing gain: 53%!** 🚀
If you invested ₹10,000, it became ₹15,300 in minutes.

**But the story didn't end there...**

By January 2022, Zomato hit ₹169.
By July 2022, it crashed to ₹41.
Investors who bought on listing day at ₹116 were sitting on -65% loss. 😨

**Two years later (2024):**
Zomato climbed back to ₹250+.
Patient investors who held through the crash made 3x returns.

**Lesson:**
Listing gains are exciting but short-term.
Real wealth comes from holding quality companies through volatility.
''',
        },
        {
          'type': 'scenario',
          'title': 'IPO Decision',
          'situation':
              'A new IPO is launching. The company has zero profits, ₹2,000 Crore debt, but Twitter influencers are calling it "the next Zomato." What do you do?',
          'choices': [
            {
              'text': 'Apply for maximum shares — the hype is real!',
              'isCorrect': false,
              'feedback':
                  '❌ Dangerous! Hype without fundamentals is a recipe for disaster. Remember Paytm IPO? Listed at ₹2,150, crashed to ₹500. Always check profitability and debt before investing.',
            },
            {
              'text': 'Read the DRHP first, then decide based on financials',
              'isCorrect': true,
              'feedback':
                  '✅ Smart! The DRHP tells you the real story. Check revenue growth, profitability, debt levels, and promoter holding. Never invest based on social media hype alone.',
            },
            {
              'text': 'Skip it — no profits means no investment',
              'isCorrect': true,
              'feedback':
                  '✅ Also valid! Many successful investors avoid IPOs of loss-making companies entirely. As Warren Buffett says: "Never invest in a business you cannot understand."',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'IPO is the process of a private company going public',
            'DRHP is the single most important document to read',
            'Listing day gains can be massive but are unpredictable',
            'Long-term value matters more than listing day hype',
            'Never invest in an IPO based on social media tips',
          ],
        },
      ],
    };
  }

  // Lesson 3: Primary vs Secondary Market
  static Map<String, dynamic> getPrimarySecondaryContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Two Marketplaces, One Goal',
          'emoji': '🔄',
          'content':
              'When you buy shares, are you buying from the company or from another person? The answer depends on WHICH market you\'re in. There are two — and confusing them is a common beginner mistake.',
        },
        {
          'type': 'concept',
          'title': 'Primary Market',
          'emoji': '🏭',
          'content': '''
**Primary Market = The Factory**

This is where **new shares are created** and sold for the first time.

**When does it happen?**
During an **IPO** or **FPO** (Follow-on Public Offer).

**Who sells?** The company itself.
**Who buys?** Investors (you, mutual funds, FIIs).
**Where does the money go?** Directly to the **company**.

**Example:**
Zomato IPO at ₹76/share.
You apply. If allotted, you buy directly from Zomato.
Those ₹76 go to **Zomato's bank account** for business growth.

**Frequency:** Rare. A company does 1 IPO in its lifetime.
''',
          'keyPoints': [
            'Primary Market = new shares sold by the company',
            'Money goes to the company for growth',
            'Happens during IPO or FPO only',
            'You apply through your broker — allotment by lottery if oversubscribed',
          ],
        },
        {
          'type': 'concept',
          'title': 'Secondary Market',
          'emoji': '🔁',
          'content': '''
**Secondary Market = The Resale Market**

This is where **existing shares** are bought and sold between investors.

**When does it happen?**
Every trading day, 9:15 AM to 3:30 PM.

**Who sells?** Another investor (not the company).
**Who buys?** You (or any other investor).
**Where does the money go?** To the **seller's account**.

**Example:**
After Zomato gets listed, you buy 100 shares at ₹150 from the market.
That ₹150 goes to whoever **sold** those shares — **NOT to Zomato**.

**Frequency:** Daily. This is where 99% of all trading happens.
''',
          'keyPoints': [
            'Secondary Market = trading existing shares between investors',
            'Company gets ZERO money from secondary market trades',
            'This is where you trade every day via apps like Zerodha/Groww',
            'Prices change every second based on supply and demand',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Where Does the Money Go?',
          'emoji': '💸',
          'content': '''
**Trace the money in each scenario:**

**Scenario 1: IPO Application**
You invest ₹50,000 in Tata Technologies IPO.
→ ₹50,000 goes to **Tata Technologies** (Primary Market).
→ Tata uses it to build factories.

**Scenario 2: Buying on NSE**
You buy 10 shares of TCS at ₹3,500 each (₹35,000).
→ ₹35,000 goes to the **person who sold** those shares.
→ TCS gets **₹0** from this transaction.

**Scenario 3: Mutual Fund Buying**
SBI Mutual Fund buys 1 Lakh shares of Infosys.
→ Money goes to **sellers** in the secondary market.
→ Infosys gets **₹0**.

**Key Insight:**
When people say "₹10,000 Cr invested in the stock market today," that money went to **other investors** — not to the companies themselves.
''',
        },
        {
          'type': 'quiz',
          'title': 'Market Check',
          'question':
              'You buy 50 shares of Reliance on your Zerodha app today. Who receives your money?',
          'options': [
            'Reliance Industries',
            'SEBI (the regulator)',
            'The person who sold those shares',
            'The National Stock Exchange',
          ],
          'correctIndex': 2,
          'explanation':
              'When you buy on the secondary market (NSE/BSE), your money goes to the seller — another investor. Reliance gets ₹0 from this trade. The company only receives money during the IPO (primary market).',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Primary Market = New shares from the company (IPO)',
            'Secondary Market = Trading between investors (NSE/BSE)',
            'Company gets money only in the Primary Market',
            'Daily trading on your app is Secondary Market activity',
            'Understanding this distinction is crucial for every investor',
          ],
        },
      ],
    };
  }
}
