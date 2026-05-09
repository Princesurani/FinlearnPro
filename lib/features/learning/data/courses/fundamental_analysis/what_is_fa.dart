/// Chapter 2: What Is Fundamental Analysis
/// The science of evaluating intrinsic value
class WhatIsFundamentalAnalysisContent {
  // Lesson 2.1: The Fundamental Framework
  static Map<String, dynamic> getFundamentalFrameworkContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Two Schools of FA',
          'emoji': '🏫',
          'content':
              'Fundamental analysts approach markets from two directions: top-down (start with the economy, narrow to companies) and bottom-up (start with companies, check if the economy supports them). Let\'s learn both.',
        },
        {
          'type': 'story',
          'title': 'Vivek\'s Two Winning Trades',
          'emoji': '🔍',
          'content': '''
**Vivek**, 29, a financial analyst in Mumbai, used BOTH FA approaches in the same year.

**Trade 1 (Top-Down): April 2024**
Vivek read that India's monsoon forecast was excellent. He thought:
"Good monsoon → Higher agricultural output → Rural spending increases → FMCG companies benefit."

He narrowed to ITC (strong rural distribution). Bought at ₹425.
Monsoon arrived. Rural consumption surged. ITC hit ₹470. **+₹45/share (+10.6%).**

**Trade 2 (Bottom-Up): August 2024**
While screening stocks, he found Deepak Nitrite:
• Revenue growing 18% year-over-year
• ROE of 22% (excellent)
• P/E of 24 (reasonable for a chemical company)
• Zero long-term debt

He checked the macro: Chemical sector was recovering from a destocking cycle. Tailwinds confirmed.
Bought at ₹2,150. It reached ₹2,580 in 4 months. **+₹430/share (+20%).**

**Key lesson:** Both approaches work. Top-Down caught a macro trend. Bottom-Up found a fundamentally strong company. Vivek used BOTH to diversify his edge.
''',
        },
        {
          'type': 'concept',
          'title': 'Top-Down vs Bottom-Up',
          'emoji': '🔄',
          'content': '''
**Top-Down Approach 🔭 (Macro → Micro)**
Start with the biggest picture, narrow down step by step:

1. **Global Economy:** Is the world growing or shrinking?
2. **India Economy:** GDP growth, inflation, policy direction?
3. **Sector Selection:** Which sectors benefit from current conditions?
4. **Stock Selection:** Best companies within the winning sectors?

**Example:**
"India's GDP is growing 7%+ → Infrastructure spending is booming → Cement sector will benefit → UltraTech Cement is the market leader → BUY UltraTech."

---

**Bottom-Up Approach 🔬 (Micro → Macro)**
Start with individual companies, then check context:

1. **Find great companies:** Strong financials, competitive advantage
2. **Check valuation:** Is the current price below fair value?
3. **Verify sector health:** Is the industry growing?
4. **Confirm macro:** Does the economy support the thesis?

**Example:**
"HDFC Bank has the best ROE in banking → P/E is reasonable at 18 → Banking sector benefits from credit growth → India's economy is growing → BUY HDFC Bank."

---

**Which Approach Is Better?**
• **Top-Down** works best when macro events dominate (elections, rate changes, wars)
• **Bottom-Up** works best in stable economies (stock-picking matters more)
• **Best practice: Use BOTH.** Top-down for direction, bottom-up for selection.

---

**Key Insight:**
Warren Buffett is bottom-up: "I pick great businesses regardless of the economy." George Soros is top-down: "I bet on macro trends." Both are billionaires. The key is having a CONSISTENT framework.
''',
          'keyPoints': [
            'Top-Down: Economy → Sector → Company (macro-first approach)',
            'Bottom-Up: Company → Sector → Economy (quality-first approach)',
            'Use both: Top-Down for direction, Bottom-Up for stock selection',
            'Buffett = Bottom-Up; Soros = Top-Down — both approaches work',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'India\'s government announces a massive ₹10 Lakh Crore infrastructure spending plan. Using a top-down approach, which sector would you research FIRST?',
          'options': [
            'IT sector — tech stocks always go up',
            'Infrastructure, cement, and steel — direct beneficiaries of government spending',
            'Pharma — healthcare always matters',
            'FMCG — people will always buy soap and toothpaste',
          ],
          'correctIndex': 1,
          'explanation':
              'Top-down logic: Government spending → Infrastructure → Who builds infrastructure? → Cement (UltraTech, Ambuja), Steel (Tata Steel, JSW), Construction (L&T). These sectors directly receive the ₹10 Lakh Crore. Then you pick the best companies WITHIN these sectors using bottom-up analysis.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Top-Down starts with the economy and narrows to companies',
            'Bottom-Up starts with great companies and checks macro context',
            'Professional investors combine both approaches for best results',
            'Having a consistent framework matters more than which approach you choose',
            'Next: How does FA differ across stocks, crypto, forex, and commodities?',
          ],
        },
      ],
    };
  }

  // Lesson 2.2: FA Across Asset Classes
  static Map<String, dynamic> getFaAcrossAssetsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Different Assets, Different Fundamentals',
          'emoji': '🗂️',
          'content':
              'You can\'t evaluate Bitcoin the same way you evaluate Reliance stock. Each asset class has its own fundamental drivers. Let\'s build a mental model for each.',
        },
        {
          'type': 'interactive',
          'title': 'FA by Asset Class',
          'emoji': '📊',
          'content': '''
**Stocks — Company Analysis 📈**
• Revenue, profit, cash flow growth
• P/E ratio, P/B ratio, ROE
• Management quality and competitive advantage ("moat")
• Industry position and market share
• **Key Question: "Is this company worth more than its current price?"**

**Crypto — Project & Token Analysis 🪙**
• Use case: What real problem does it solve?
• Team: Who built it? Track record?
• Tokenomics: Supply, inflation, demand mechanics
• Adoption: How many users? Growing?
• **Key Question: "Does this project have real utility and growing adoption?"**

**Forex — Country Analysis 💱**
• GDP growth, inflation rates, interest rates
• Trade balance (exports vs imports)
• Central bank policy (RBI, US Fed, ECB)
• Political stability and fiscal policy
• **Key Question: "Is this economy stronger or weaker relative to others?"**

**Commodities — Supply/Demand Analysis 🛢️**
• Production levels (OPEC for oil, mine output for metals)
• Demand drivers (economic growth, seasonal patterns)
• Inventory levels and storage data
• Geopolitical risks affecting supply
• **Key Question: "Is there more supply or demand coming?"**

**Key Lesson:**
The fundamental QUESTION is always the same: "What is this asset truly worth?"
The DATA you use to answer it changes completely by asset class.
''',
        },
        {
          'type': 'story',
          'title': 'The Sugar Shortage',
          'emoji': '🍬',
          'content': '''
**Rahul** was trading sugar futures.
He saw the chart going down and decided to short-sell sugar.

**Amit** was looking at fundamentals.
He read a report that the monsoon had failed in Brazil and India (the two largest sugar producers). The sugarcane crop was destroyed. A massive global shortage was coming in 3 months.

Amit bought sugar futures.
For a week, the chart kept trickling down. Rahul mocked Amit.
Then, the official harvest data came out. The shortage was real. Sugar prices exploded up 40% in two weeks.

Rahul's technical stop-loss was hit. He lost money.
Amit made a fortune.

**Key lesson:** Charts show you what happened yesterday. Fundamentals tell you what must inevitably happen tomorrow based on the laws of supply and demand.
''',
        },
        {
          'type': 'scenario',
          'title': 'Which FA Approach?',
          'situation':
              'You hear on the news that crude oil prices have surged 30% due to Middle East tensions. You want to find trading opportunities. Which FA approach should you use FIRST?',
          'choices': [
            {
              'text':
                  'Bottom-Up: Screen for the best individual oil companies regardless of macro',
              'isCorrect': false,
              'feedback':
                  '❌ This misses the macro context. Oil price surges affect different companies differently — some benefit (upstream producers like ONGC), some suffer (airlines, paint companies). You need the macro lens first.',
            },
            {
              'text':
                  'Top-Down: Oil surge → Who benefits? (ONGC, Oil India) → Who suffers? (IndiGo, Asian Paints) → Then pick the best company',
              'isCorrect': true,
              'feedback':
                  '✅ Classic Top-Down! Start with the macro event (oil surge), identify the winning and losing sectors, THEN use bottom-up analysis to pick the best company within each sector. This is how professional fund managers react to macro events.',
            },
            {
              'text': 'Ignore fundamentals — just look at the stock charts',
              'isCorrect': false,
              'feedback':
                  '❌ Pure TA without FA context is like driving with only a speedometer. You know HOW FAST the price is moving, but not WHY. The "why" matters because it determines if the move is sustainable or temporary.',
            },
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'What is the KEY fundamental question for evaluating a cryptocurrency project?',
          'options': [
            'What is the current market cap?',
            'Does this project have real utility and growing adoption?',
            'How many exchanges list this token?',
            'What does the chart look like?',
          ],
          'correctIndex': 1,
          'explanation':
              'Market cap tells you size, not value. Exchange listings tell you accessibility, not quality. Charts show price history, not fundamentals. The CORE question for crypto FA is: "Does this solve a real problem, and are people actually using it?" Projects with real utility (Ethereum for smart contracts, Chainlink for oracles) survive bear markets. Meme coins without utility don\'t.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 2 Complete! 🎉',
          'keyPoints': [
            'FA for stocks = company financials (P/E, revenue, profit, moat)',
            'FA for crypto = use case, team, tokenomics, adoption metrics',
            'FA for forex = comparing two countries\' economic health',
            'FA for commodities = supply vs demand balance',
            'The question is always the same: "What is this truly worth?"',
            'Next: The heart of stock FA — reading company financial statements.',
          ],
        },
      ],
    };
  }
}
