/// Chapter 1: Value & Macro Understanding
/// The difference between price and value
class ValueMacroContent {
  // Lesson 1.1: Price vs Value
  static Map<String, dynamic> getPriceVsValueContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The ₹3,000 Stock That\'s Cheap',
          'emoji': '💎',
          'content':
              'Most beginners think a ₹30 stock is "cheap" and a ₹3,000 stock is "expensive." This is the #1 mistake in investing. Price and value are completely different things. Let\'s fix this thinking forever.',
        },
        {
          'type': 'story',
          'title': 'Rahul\'s Expensive ₹15 Stock',
          'emoji': '📉',
          'content': '''
**Rahul**, 25, a college graduate, gets his first salary: ₹40,000.

He decides to invest ₹10,000 in stocks. Opens Zerodha. Sorts by price: lowest first.

**His logic:**
"MRF costs ₹1,00,000 per share. Too expensive! I can only afford 0.1 share."
"This penny stock XYZ Ltd is only ₹15. I can buy 666 shares! When it becomes ₹100, I'll be rich!"

**What Rahul didn't check:**
• XYZ Ltd: Revenue declining 30% yearly, losses for 5 years, promoter pledging shares
• MRF: Revenue growing 15% yearly, consistent profits, zero debt, market leader

**6 months later:**
• XYZ Ltd (₹15 → ₹3): Rahul lost ₹8,000 (80% of his investment) 😱
• MRF (₹1,00,000 → ₹1,20,000): Up 20%. Even 0.1 share would have given ₹2,000 profit.

**The Lesson:**
₹15 was EXPENSIVE because the company was worthless.
₹1,00,000 was CHEAP because the company was worth much more.
**Price is what you pay. Value is what you get.**
— Warren Buffett
''',
        },
        {
          'type': 'concept',
          'title': 'Price vs Value: The Core Difference',
          'emoji': '⚖️',
          'content': '''
**Price = What the market is asking for right now.**
It changes every second based on supply and demand.
Driven by: emotions, news, FOMO, panic, algorithms.

**Value = What something is actually WORTH.**
Based on: earnings, assets, growth, cash flow, competitive advantage.
Changes slowly over quarters and years.

---

**The Three Scenarios:**

**1. Price < Value → UNDERVALUED (Buy zone) ✅**
Market is pessimistic. The stock is "on sale."
Example: A company earning ₹100/share trading at ₹800 (P/E of 8) while industry average is P/E 20.

**2. Price = Value → FAIRLY VALUED (Hold/Watch) 🟡**
Market has priced the stock correctly. No edge.

**3. Price > Value → OVERVALUED (Avoid/Sell) ❌**
Market is euphoric. The stock is "overpriced."
Example: A company earning ₹10/share trading at ₹1,000 (P/E of 100) with flat growth.

---

**Key Insight:**
Fundamental analysis is the science of estimating VALUE, then comparing it to PRICE. When you find a stock where Value >> Price, that's your opportunity. This is how Warren Buffett became the world's greatest investor.
''',
          'keyPoints': [
            'Price is what you pay; Value is what you get — they are different things',
            'Stock price alone tells you nothing — a ₹15 stock can be expensive',
            'Undervalued (Price < Value) = buying opportunity for long-term investors',
            'Fundamental analysis is the science of estimating intrinsic value',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The Price vs Value Calculator',
          'emoji': '🧮',
          'content': '''
**Let's evaluate two "Shoes" (Companies) to see which is the real bargain.**

**Shoe A (Company A):**
• Price Tag (Share Price): ₹50
• Quality (Earnings per share): ₹1
• **You are paying 50x for the quality (P/E = 50)**

**Shoe B (Company B):**
• Price Tag (Share Price): ₹2,000
• Quality (Earnings per share): ₹200
• **You are paying 10x for the quality (P/E = 10)**

**The Verdict:**
The amateur buys Shoe A because "₹50 is cheap!" and it feels good to own 100 shares instead of just 2 shares of B.
The professional buys Shoe B because they are getting ₹200 of earnings for every ₹2,000 spent (a 10% yield), whereas Shoe A only gives ₹1 for every ₹50 spent (a 2% yield).

**Value Investing Rule #1:** Never look at the share price in isolation. Always compare it to what the company earns.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Stock A costs ₹5,000/share with P/E of 12 and 20% profit growth. Stock B costs ₹50/share with P/E of 200 and declining profits. Which is CHEAPER?',
          'options': [
            'Stock B — it\'s only ₹50 per share',
            'Stock A — despite the higher price, its P/E of 12 with 20% growth makes it fundamentally cheaper',
            'Both are equally cheap — price doesn\'t matter',
            'Cannot determine without more data',
          ],
          'correctIndex': 1,
          'explanation':
              'Stock A at P/E 12 means you pay ₹12 for every ₹1 of earnings, and earnings are growing 20%. Stock B at P/E 200 means you pay ₹200 for every ₹1 of earnings, and earnings are DECLINING. Stock A is fundamentally much cheaper despite the higher share price. This is why price alone is meaningless.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Price ≠ Value. A ₹15 stock can be expensive; a ₹5,000 stock can be cheap.',
            'Fundamental analysis estimates intrinsic value and compares it to market price.',
            'Undervalued stocks (Price < Value) are buying opportunities.',
            'Warren Buffett built his fortune on this ONE concept: buy value, not price.',
            'Next: How the big picture — economy, policy, and global events — shapes everything.',
          ],
        },
      ],
    };
  }

  // Lesson 1.2: The Macro Lens
  static Map<String, dynamic> getMacroLensContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Economy Moves Everything',
          'emoji': '🌍',
          'content':
              'Even the best company struggles when the economy collapses. And even average companies soar when the economy booms. Understanding the macro picture is like knowing which way the river flows — it\'s easier to swim WITH the current.',
        },
        {
          'type': 'concept',
          'title': 'Top-Down Macro Framework',
          'emoji': '🔭',
          'content': '''
**The economy affects markets in layers:**

**Layer 1: Global Economy 🌐**
• US Fed raises interest rates → Global capital flows change → India affected
• China slowdown → Less demand for commodities → Metal stocks fall
• Oil prices spike → India's import bill rises → Rupee weakens

**Layer 2: Indian Economy 🇮🇳**
• GDP growth → Corporate earnings grow → Stock market rises
• Inflation high → RBI raises rates → Borrowing costs increase → Growth slows
• Government spending (infrastructure, defense) → Specific sectors benefit

**Layer 3: Industry/Sector 🏭**
• IT sector depends on US economy (dollar revenue)
• Banking sector depends on RBI interest rate decisions
• Pharma sector depends on USFDA approvals and regulatory changes

**Layer 4: Individual Company 🏢**
• Management quality, competitive advantage, market share
• Revenue growth, profitability, debt levels
• This is where company-specific fundamental analysis lives

---

**Key Insight:**
Even if you find a fundamentally great company, it can underperform if the macro environment is against it. Example: IT stocks fell 30% in 2022 not because companies became bad, but because US recession fears dried up tech spending globally.
''',
          'keyPoints': [
            'Macro flows: Global → India → Sector → Company',
            'US Fed policy affects India through capital flows and currency',
            'RBI interest rate decisions impact banking, real estate, and borrowing',
            'A great company in a bad macro environment can still underperform',
          ],
        },
        {
          'type': 'story',
          'title': 'The 2022 IT Sector Shock',
          'emoji': '💻',
          'content': '''
**In late 2021, Indian IT stocks (TCS, Infosys, Wipro) were the darlings of the market.** 
They had great management, zero debt, and massive cash reserves. "Safe as a bank," everyone said.

**Then the macro environment shifted.**
1. Inflation hit 40-year highs in the US.
2. The US Federal Reserve started raising interest rates aggressively.
3. Fear of a US recession grew.
4. US companies started cutting their tech budgets to save money.

**The Impact on India:**
Even though TCS and Infosys were fundamentally excellent companies, their clients were American. When US tech spending dried up, Indian IT revenue growth stalled.

**The Result:**
The Nifty IT index fell over 30% in 2022. 
Did the companies suddenly become bad? No. The *macro current* turned against them.

**Key lesson:** A top-down approach saves you from buying the best house in a bad neighborhood. If the macro winds are blowing against a sector, even the strongest companies will struggle to sail forward.
''',
        },
        {
          'type': 'scenario',
          'title': 'Macro Decision',
          'situation':
              'RBI announces a surprise 50 basis point rate hike (0.50%) to combat 7% inflation. You hold banking stocks and IT stocks. How should you think about this?',
          'choices': [
            {
              'text':
                  'Sell everything — rate hikes are always bad for all stocks',
              'isCorrect': false,
              'feedback':
                  '❌ Rate hikes affect sectors differently! Banks BENEFIT from higher rates (their lending margins improve). IT is relatively neutral (dollar earnings matter more). Real estate and auto get hurt (higher EMIs reduce demand). Don\'t paint all sectors with the same brush.',
            },
            {
              'text':
                  'Banks may benefit (higher lending margins), IT is neutral (dollar-driven). Hold both but monitor real estate and auto sectors for weakness.',
              'isCorrect': true,
              'feedback':
                  '✅ Excellent macro thinking! Rate hikes increase bank Net Interest Margins (NIM) — good for bank profits. IT depends more on US demand than Indian rates. But rate-sensitive sectors (real estate, auto, NBFCs) may suffer as borrowing costs rise.',
            },
            {
              'text':
                  'Ignore it — macro events don\'t affect individual stocks',
              'isCorrect': false,
              'feedback':
                  '❌ Macro events affect ENTIRE sectors simultaneously. When RBI hikes rates, EVERY bank stock reacts, EVERY real estate stock reacts. Individual company analysis matters, but ignoring macro is like ignoring the weather before sailing.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 1 Complete! 🎉',
          'keyPoints': [
            'Price ≠ Value — fundamental analysis bridges this gap',
            'Macro flows from Global → India → Sector → Company',
            'RBI policy, US Fed decisions, and global events shape the entire market',
            'Even great companies can underperform in hostile macro environments',
            'Understanding macro gives you the context that company analysis alone can\'t',
            'Next: What exactly IS fundamental analysis? The complete framework.',
          ],
        },
      ],
    };
  }
}
