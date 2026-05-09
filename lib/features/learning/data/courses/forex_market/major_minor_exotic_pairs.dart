/// Chapter 4: Major, Minor & Exotic Pairs
/// Which pairs to trade and which to avoid as a beginner
class MajorMinorExoticPairsContent {
  // Lesson 4.1: The Big Seven (Major Pairs)
  static Map<String, dynamic> getMajorPairsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Superstars of Forex',
          'emoji': '⭐',
          'content':
              'There are 180+ currencies in the world. But just 7 pairs account for over 70% of all forex trading. They\'re called the "Majors." They have the tightest spreads, deepest liquidity, and most predictable behavior.',
        },
        {
          'type': 'concept',
          'title': 'The 7 Major Pairs',
          'emoji': '🏆',
          'content': '''
**All Major Pairs include the US Dollar (USD).**

**1. EUR/USD (Euro/Dollar)** — "The Fiber"
• Most traded pair in the world (~24% of volume)
• Tightest spreads. Best for beginners.
• Driven by: ECB policy, US Fed rates, EU/US economic data

**2. USD/JPY (Dollar/Yen)** — "The Ninja"
• Second most traded. Japan is a massive economy.
• Driven by: Bank of Japan policy, risk sentiment

**3. GBP/USD (Pound/Dollar)** — "Cable"
• Volatile and fast-moving. Higher risk, higher reward.
• Driven by: Bank of England, Brexit aftermath

**4. USD/CHF (Dollar/Swiss Franc)** — "The Swissie"
• Swiss Franc = safe haven currency during crises
• When the world panics, money flows to CHF

**5. AUD/USD, USD/CAD, NZD/USD** — Commodity currencies
• Tied to commodity exports: gold (AUD), oil (CAD), dairy (NZD)

---

**Key Insight:**
As a beginner, stick to EUR/USD and USD/JPY. They have the tightest spreads (lowest trading cost) and most research available. Master two pairs before exploring more.
''',
          'keyPoints': [
            'All 7 major pairs include the US Dollar',
            'EUR/USD is the most traded — best for beginners',
            'Major pairs have the tightest spreads and deepest liquidity',
            'Each pair is driven by specific economic forces and central banks',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Why should beginners start with EUR/USD instead of an exotic pair like USD/TRY (Turkish Lira)?',
          'options': [
            'Because EUR/USD is cheaper to buy',
            'Because EUR/USD has tight spreads, high liquidity, and extensive research — making it more predictable and cheaper to trade',
            'Because the Euro is a stronger currency than the Lira',
            'Because exotic pairs are banned for retail traders',
          ],
          'correctIndex': 1,
          'explanation':
              'EUR/USD has the tightest spreads (0.1-1 pip) versus exotic pairs (10-50+ pips). Higher liquidity means better price execution. And there\'s vastly more analysis and educational content available. The "cost" of each trade is lower, and the behavior is more predictable.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Major pairs = USD paired with 6 other strong currencies',
            'EUR/USD is the king — highest volume, tightest spread, most beginner-friendly',
            'Each major pair is driven by specific central bank policies and economic data',
            'Stick to 1-2 major pairs until you\'re consistently profitable',
            'Next: What about pairs without USD? And the dangerous "exotics"?',
          ],
        },
      ],
    };
  }

  // Lesson 4.2: Minors, Exotics & USD/INR
  static Map<String, dynamic> getMinorsExoticsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Beyond the Majors',
          'emoji': '🗺️',
          'content':
              'Not all currency pairs are created equal. Minor pairs skip the Dollar entirely. Exotic pairs involve emerging market currencies. And USD/INR? That\'s YOUR home pair. Let\'s understand the full spectrum.',
        },
        {
          'type': 'concept',
          'title': 'Minors, Crosses & Exotics',
          'emoji': '📋',
          'content': '''
**Minor Pairs (Crosses) — No USD involved:**
• EUR/GBP (Euro vs Pound)
• EUR/JPY (Euro vs Yen)
• GBP/JPY (Pound vs Yen — "The Dragon," extremely volatile!)
Spreads: 1-5 pips. Decent liquidity but less than majors.

**Exotic Pairs — USD + Emerging Market currency:**
• USD/INR (Dollar vs Indian Rupee) — YOUR pair!
• USD/TRY (Dollar vs Turkish Lira)
• USD/ZAR (Dollar vs South African Rand)
• USD/BRL (Dollar vs Brazilian Real)

**Why Exotics Are Dangerous:**
• **Wide spreads:** 10-50+ pips (expensive to enter/exit)
• **Low liquidity:** Hard to exit during crisis
• **Political risk:** Government interventions, capital controls
• **Wild swings:** USD/TRY moved 100% in 2021 due to Turkey's political crisis

---

**USD/INR for Indian Traders:**
• Regulated by SEBI/RBI
• Tradable on NSE and BSE (currency derivatives segment)
• Leverage: Limited to ~50x (regulatory caps)
• Spread: 0.25-1 pip (decent for an exotic)
• Advantage: You understand Indian economics — that's your edge!

---

**Key Insight:**
Trade what you understand. Indian traders have a natural edge in USD/INR because they live the Indian economy daily. Don't trade USD/TRY because you saw a YouTube video — trade what you know.
''',
          'keyPoints': [
            'Minor pairs exclude USD — decent liquidity but wider spreads',
            'Exotic pairs involve emerging market currencies — high risk, wide spreads',
            'USD/INR is tradable on NSE/BSE — regulated and accessible for Indians',
            'Trade what you understand — your knowledge of India is an edge in USD/INR',
          ],
        },
        {
          'type': 'scenario',
          'title': 'Choosing Your Pair',
          'situation':
              'You\'re a beginner with ₹1 Lakh. A YouTube guru says: "Trade GBP/JPY — it moves 200+ pips daily! More pips = more profit!" Should you follow this advice?',
          'choices': [
            {
              'text': 'Yes — more pips = more opportunity to make money!',
              'isCorrect': false,
              'feedback':
                  '❌ GBP/JPY is called "The Dragon" for a reason — it\'s extremely volatile and has wide spreads. 200 pips of movement means 200 pips of RISK too. Beginners get destroyed on this pair. Wider spreads eat your profits faster.',
            },
            {
              'text':
                  'No — start with EUR/USD or USD/INR, pairs with tight spreads and lower volatility',
              'isCorrect': true,
              'feedback':
                  '✅ Smart choice! EUR/USD moves 50-80 pips on a typical day — enough opportunity with manageable risk. USD/INR gives you a home-field advantage. Master calm waters before swimming in a tsunami.',
            },
            {
              'text':
                  'Trade GBP/JPY but with smaller position sizes to manage risk',
              'isCorrect': false,
              'feedback':
                  '❌ While smaller positions help, the wide spread on GBP/JPY (3-5 pips) means you\'re paying a much higher "entry fee" per trade. As a beginner learning the basics, this cost adds up and erodes your capital faster.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 4 Complete! 🎉',
          'keyPoints': [
            'Majors (EUR/USD, USD/JPY) = safest for beginners, tightest spreads',
            'Minors (EUR/GBP, GBP/JPY) = no USD, decent liquidity, higher volatility',
            'Exotics (USD/TRY, USD/ZAR) = dangerous — wide spreads, political risk',
            'USD/INR is your home pair — regulated, accessible, and you understand the economy',
            'Master 1-2 pairs before exploring — depth beats breadth in forex',
            'Next: How does a forex trade actually work from start to finish?',
          ],
        },
      ],
    };
  }
}
