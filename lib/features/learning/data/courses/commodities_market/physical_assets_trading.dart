/// Chapter 1: Physical Assets Trading
/// The oldest markets in human history
class PhysicalAssetsTradingContent {
  // Lesson 1.1: Trading the Real World
  static Map<String, dynamic> getTradingRealWorldContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Before Stocks, There Were Sacks of Wheat',
          'emoji': '🌾',
          'content':
              'Long before Sensex and Nifty existed, humans traded gold, grain, and oil. Commodity markets are the OLDEST financial markets — dating back 6,000 years to ancient Mesopotamia. Today, they trade \$20+ trillion annually. Let\'s explore.',
        },
        {
          'type': 'story',
          'title': 'How Gold Changed Meera\'s Portfolio',
          'emoji': '✨',
          'content': '''
**Meera**, a 33-year-old doctor in Ahmedabad, had her entire savings in stocks and fixed deposits.

**March 2020: COVID Crash.**
Nifty crashed 40% in one month. Meera's stock portfolio: ₹15L → ₹9L. 😰
Her FDs were safe but earning only 5.5%.

**What she didn't own: Gold.**
While stocks crashed 40%, gold ROSE 28% during the same period.
Gold went from ₹38,000/10g to ₹48,700/10g.

**The Math:**
If Meera had put 20% of her portfolio in gold:
• Stocks (80%): ₹12L → ₹7.2L (lost ₹4.8L)
• Gold (20%): ₹3L → ₹3.84L (gained ₹84,000)
• **Net loss: ₹3.96L instead of ₹6L.** Gold cushioned the blow by ₹2L.

**After COVID, Meera restructured:**
• 60% Stocks, 15% Gold, 15% Fixed Income, 10% Cash
• When the next correction came, her portfolio barely flinched.

**Lesson:**
Commodities aren't just for "traders." Gold acts as insurance for your stock portfolio. When stocks crash, gold typically rises. This negative correlation is the #1 reason every portfolio needs some commodity exposure.
''',
        },
        {
          'type': 'concept',
          'title': 'What Are Commodity Markets?',
          'emoji': '📊',
          'content': '''
**Commodities = Raw materials that are interchangeable regardless of producer.**

1 kg of 24-karat gold from India = 1 kg of 24-karat gold from South Africa.
1 barrel of Brent crude from Saudi Arabia ≈ 1 barrel from Norway.
**This interchangeability is called "fungibility."**

**Why Trade Commodities?**
• **Hedging:** Farmers lock in wheat prices before harvest to protect against price drops.
• **Speculation:** Traders bet on oil prices moving up or down.
• **Portfolio diversification:** Gold protects against stock market crashes.
• **Inflation hedge:** When ₹ loses value, gold typically gains.

**India's Commodity Exchanges:**
• **MCX (Multi Commodity Exchange):** Gold, silver, crude oil, natural gas, copper, zinc
• **NCDEX (National Commodity Exchange):** Agricultural — wheat, soybean, cotton, sugar

---

**Key Insight:**
Commodity prices affect EVERYTHING. Oil price rises = petrol costs more = transport costs more = every product costs more = inflation. Understanding commodities is understanding the economy's engine.
''',
          'keyPoints': [
            'Commodities are fungible raw materials — gold is gold regardless of origin',
            'MCX trades metals and energy; NCDEX trades agricultural commodities',
            'Gold acts as a portfolio hedge — typically rises when stocks crash',
            'Commodity prices drive inflation and affect your daily cost of living',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'During the 2020 COVID crash, Nifty fell 40%. What happened to gold prices during the same period?',
          'options': [
            'Gold also crashed 40% — all assets fall together in a crisis',
            'Gold rose approximately 28% — acting as a safe haven',
            'Gold stayed flat — it doesn\'t react to stock market moves',
            'Gold was banned from trading during COVID',
          ],
          'correctIndex': 1,
          'explanation':
              'Gold is a "safe haven" asset. During crises, investors sell risky assets (stocks) and buy safe assets (gold, government bonds). This is why gold and stocks often move in opposite directions — called "negative correlation." This makes gold excellent portfolio insurance.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Commodity markets are the oldest financial markets — 6,000+ years old',
            'Commodities are fungible raw materials traded on MCX and NCDEX',
            'Gold acts as portfolio insurance — rises when stocks crash (negative correlation)',
            'Commodity prices directly affect inflation and your daily cost of living',
            'Next: How do commodity prices affect YOUR wallet every single day?',
          ],
        },
      ],
    };
  }

  // Lesson 1.2: Why Commodities Matter to You
  static Map<String, dynamic> getWhyCommoditiesMatterContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'You\'re Already in the Commodity Market',
          'emoji': '🛒',
          'content':
              'Every time you fill petrol, buy cooking oil, or wear gold jewelry, you\'re interacting with commodity prices. You may not trade commodities, but commodities trade YOU. Let\'s see how.',
        },
        {
          'type': 'interactive',
          'title': 'Commodity Prices in Your Daily Life',
          'emoji': '📊',
          'content': '''
**When CRUDE OIL rises from \$70 to \$90/barrel:**
• Petrol: ₹95 → ₹108/litre
• Your monthly fuel bill: ₹5,000 → ₹5,700
• Delivery charges on Swiggy/Zomato increase
• Flight tickets become more expensive
• **Everything that moves by truck costs more**

**When GOLD rises from ₹55,000 to ₹70,000/10g:**
• Your mother's gold jewelry becomes more valuable
• Wedding costs skyrocket
• Gold loan interest rates may change
• Gold ETFs in your portfolio appreciate

**When WHEAT prices rise 30%:**
• Atta: ₹40/kg → ₹52/kg
• Bread, biscuits, and packaged food prices climb
• RBI starts worrying about food inflation
• Government may ban wheat exports (India did in 2022!)

**When COTTON prices spike:**
• Your t-shirts and jeans cost ₹200-500 more
• Textile company margins get squeezed
• Fashion brands delay new launches

**Key Lesson:**
You don't need to trade commodities to be affected by them. Understanding why gold or oil moves helps you make better decisions about timing purchases, investments, and even career choices.
''',
        },
        {
          'type': 'scenario',
          'title': 'What Would You Do?',
          'situation':
              'It\'s October. Oil prices are rising sharply due to a Middle East conflict. Analysts predict ₹120/litre petrol by December. How do you respond as a financially aware person?',
          'choices': [
            {
              'text': 'Ignore it — commodity prices don\'t affect me',
              'isCorrect': false,
              'feedback':
                  '❌ Oil prices affect EVERYTHING: transport, food delivery, plastics, flights, and manufactured goods. Ignoring it means being blindsided when your monthly expenses jump ₹3,000-5,000.',
            },
            {
              'text':
                  'Reduce non-essential travel, consider carpooling, and possibly add some energy stocks or oil ETFs to your portfolio as a hedge',
              'isCorrect': true,
              'feedback':
                  '✅ Smart! You\'re thinking both defensively (reduce costs) and offensively (hedge with energy investments). When oil rises, oil companies profit — owning their stocks/ETFs can offset your higher fuel bills.',
            },
            {
              'text': 'Buy as much petrol as possible now to save later',
              'isCorrect': false,
              'feedback':
                  '❌ You can\'t stockpile petrol safely at home. But you CAN hedge financially by investing in energy-related assets that benefit from higher oil prices. Think beyond physical purchases.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 1 Complete! 🎉',
          'keyPoints': [
            'Commodity prices affect you daily — petrol, food, clothing, gold jewelry',
            'Oil prices drive inflation — when oil rises, almost everything gets expensive',
            'You can hedge commodity price exposure by investing in related assets',
            'Understanding commodities helps you anticipate and prepare for price changes',
            'Commodity knowledge is practical financial literacy, not just for traders',
            'Next: What exactly qualifies as a commodity? Let\'s define and classify.',
          ],
        },
      ],
    };
  }
}
