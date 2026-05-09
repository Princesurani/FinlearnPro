/// Chapter 2: What Are Commodities
/// Definition, characteristics, and market structure
class WhatAreCommoditiesContent {
  // Lesson 2.1: The Building Blocks of the Economy
  static Map<String, dynamic> getBuildingBlocksContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Foundation of Everything',
          'emoji': '🏗️',
          'content':
              'Your phone needs copper. Your car needs steel and oil. Your breakfast needs wheat and sugar. Before any product reaches you, raw materials are mined, grown, drilled, and traded. These raw materials are commodities.',
        },
        {
          'type': 'concept',
          'title': 'What Makes a Commodity?',
          'emoji': '📋',
          'content': '''
**A commodity must have these properties:**

**1. Fungibility (Interchangeability) 🔄**
1 kg of 24k gold = any other 1 kg of 24k gold. No brand, no preference.
Unlike stocks (Reliance ≠ TCS), commodities are standardized.

**2. Physical Existence 📦**
Commodities are real, tangible goods. You can touch, weigh, and store them.
(Bitcoin is NOT a commodity by this traditional definition.)

**3. Natural Origin 🌍**
They're extracted (mined, drilled) or grown (farmed, harvested).
Manufactured goods (phones, cars) are NOT commodities.

**4. Standardized Quality Grades 📏**
Crude oil is graded as Brent or WTI. Gold as 999 or 995 purity.
These grades ensure buyers know exactly what they're getting.

---

**Two Categories:**

**Hard Commodities:**
Mined or extracted from the earth.
Examples: Gold, silver, crude oil, natural gas, copper, zinc.

**Soft Commodities:**
Grown or raised.
Examples: Wheat, cotton, sugar, coffee, soybean, cattle.

---

**Key Insight:**
Commodities are the INPUTS for every industry. Copper goes into wiring, oil into fuel, wheat into bread. When commodity prices rise, EVERY industry feels the pressure — which is why commodity traders have an outsized impact on the global economy.
''',
          'keyPoints': [
            'Commodities are fungible, physical, natural, and standardized',
            'Hard commodities are mined (gold, oil); Soft are grown (wheat, cotton)',
            'They are the raw inputs for every industry on Earth',
            'Rising commodity prices cause inflation across all sectors',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question': 'Which of the following is NOT a commodity?',
          'options': [
            'Crude oil (Brent grade)',
            '24-karat gold',
            'iPhone 16 Pro Max',
            'MCX-grade cotton',
          ],
          'correctIndex': 2,
          'explanation':
              'An iPhone is a manufactured product, not a commodity. It has brand value, design differentiation, and is NOT fungible (iPhone ≠ Samsung Galaxy). Commodities are raw, standardized, natural materials — oil, gold, and cotton all qualify because one unit equals any other unit of the same grade.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Commodities are fungible, physical, naturally sourced, and graded by quality',
            'Hard commodities (metals, energy) are mined; soft commodities (agri) are grown',
            'They are the raw inputs for every product and industry',
            'Commodity price movements cause inflation — affecting everyone',
            'Next: Where are commodities traded in India? Meet MCX and NCDEX.',
          ],
        },
      ],
    };
  }

  // Lesson 2.2: India's Commodity Exchanges
  static Map<String, dynamic> getIndiaExchangesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'India\'s Commodity Bazaar',
          'emoji': '🇮🇳',
          'content':
              'While NSE and BSE are famous for stocks, India has dedicated exchanges just for commodities. MCX for metals and energy, NCDEX for agriculture. Let\'s understand how they work.',
        },
        {
          'type': 'concept',
          'title': 'MCX & NCDEX Explained',
          'emoji': '🏛️',
          'content': '''
**MCX (Multi Commodity Exchange) — Mumbai:**
India's largest commodity exchange. Founded 2003.
• **Trades:** Gold, silver, crude oil, natural gas, copper, zinc, lead, aluminum, nickel
• **Trading Hours:** 9:00 AM - 11:30 PM (extended for global alignment!)
• **Regulator:** SEBI (since 2015)
• **Daily Volume:** ~₹30,000-50,000 Crore

**NCDEX (National Commodity & Derivatives Exchange):**
Focused on agricultural commodities.
• **Trades:** Soybean, cotton, guar seed, castor seed, sugar
• **Trading Hours:** 10:00 AM - 5:00 PM
• **Target Users:** Farmers, agricultural businesses, traders

**Key Differences from Stock Exchanges:**
• Commodity contracts have **expiry dates** (monthly/bi-monthly)
• Many contracts can result in **physical delivery** (actual gold!)
• Trading hours extend into the night (global markets influence)
• **Lot sizes are standardized:** Gold = 1 kg, Silver = 30 kg, Crude = 100 barrels

---

**Key Insight:**
Unlike stocks where you own a piece of a company, commodity futures are CONTRACTS to buy/sell a specific quantity at a future date. You rarely take physical delivery — most traders close positions before expiry.
''',
          'keyPoints': [
            'MCX handles metals and energy; NCDEX handles agricultural commodities',
            'Both are regulated by SEBI — same as stock exchanges',
            'Trading hours extend to 11:30 PM on MCX for global alignment',
            'Commodity contracts have expiry dates — unlike stocks which you hold indefinitely',
          ],
        },
        {
          'type': 'interactive',
          'title': 'MCX Contract Specifications',
          'emoji': '📊',
          'content': '''
**What You Actually Trade on MCX:**

**Gold (Regular):**
• Lot Size: 1 kg (yes, a full kilogram!)
• Margin: ~₹4-5 Lakhs per lot
• Tick Size: ₹1 per 10g
• Contract Value: ~₹60-70 Lakhs per lot

**Gold Mini:**
• Lot Size: 100 grams
• Margin: ~₹40,000-50,000
• **Best for retail traders!**

**Gold Petal:**
• Lot Size: 1 gram
• Margin: ~₹500-600
• **Perfect for beginners to learn**

**Crude Oil:**
• Lot Size: 100 barrels
• Margin: ~₹1-2 Lakhs
• Contract Value: ~₹5-6 Lakhs

**Silver:**
• Lot Size: 30 kg
• Margin: ~₹1-2 Lakhs
• Silver Mini: 5 kg (more accessible)

**Key Lesson:**
MCX offers "mini" and "petal" contracts specifically for retail traders. Don't start with the regular 1 kg gold contract (₹60L exposure!). Start with Gold Petal (1 gram, ~₹6,000 exposure) to learn the mechanics.
''',
        },
        {
          'type': 'summary',
          'title': 'Chapter 2 Complete! 🎉',
          'keyPoints': [
            'MCX is India\'s primary commodity exchange for metals and energy',
            'NCDEX specializes in agricultural commodities',
            'Commodity contracts have expiry dates — unlike stocks',
            'Mini and Petal contracts make commodity trading accessible for beginners',
            'Both exchanges are SEBI-regulated — same protection as stock trading',
            'Next: Let\'s dive deep into each type — metals, energy, and agriculture.',
          ],
        },
      ],
    };
  }
}
