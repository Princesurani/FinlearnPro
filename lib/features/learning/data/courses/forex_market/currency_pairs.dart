/// Chapter 3: How Currencies Are Traded in Pairs
/// Base, quote, pips, and lots decoded
class CurrencyPairsContent {
  // Lesson 3.1: Reading a Currency Pair
  static Map<String, dynamic> getReadingPairsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Decoding EUR/USD',
          'emoji': '🔤',
          'content':
              'In stocks, you buy "Reliance" with Rupees. Simple. In forex, you\'re always buying ONE currency and selling ANOTHER simultaneously. EUR/USD = 1.10 looks simple, but there\'s a lot packed into those numbers.',
        },
        {
          'type': 'concept',
          'title': 'Base & Quote Currency',
          'emoji': '📐',
          'content': '''
**Every forex price is a PAIR: BASE / QUOTE**

**BASE** = The currency you're buying or selling (first one)
**QUOTE** = The currency you're using to measure the price (second one)

**Example: EUR/USD = 1.1000**
• "1 Euro costs 1.10 US Dollars"
• **Buying EUR/USD:** You're buying Euros, paying with Dollars
• **Selling EUR/USD:** You're selling Euros, receiving Dollars

**Example: USD/INR = 83.50**
• "1 US Dollar costs 83.50 Indian Rupees"
• **Buying USD/INR:** You're buying Dollars, paying Rupees
• **Selling USD/INR:** You're selling Dollars, receiving Rupees

**The Tricky Part:**
When you "buy EUR/USD," you're doing TWO things at once:
1. Buying Euros (going long on Euro)
2. Selling Dollars (going short on Dollar)

---

**Key Insight:**
In forex, you never buy or sell in isolation. You always bet that one currency will strengthen RELATIVE to another. If EUR/USD goes up, the Euro got stronger OR the Dollar got weaker (or both).
''',
          'keyPoints': [
            'BASE/QUOTE: Base is what you buy, Quote is what you pay with',
            'EUR/USD = 1.10 means 1 Euro costs 1.10 Dollars',
            'Buying a pair = buying Base, selling Quote (simultaneously)',
            'Currency strength is always relative — never absolute',
          ],
        },
        {
          'type': 'story',
          'title': 'Priya\'s First Forex Trade',
          'emoji': '💡',
          'content': '''
**Priya** is a macro analyst who follows global economics.

**Her Analysis:**
India's economy is booming. FII (Foreign Institutional Investor) money is flowing in. She believes the Rupee will strengthen against the Dollar.

**The Trade:**
She wants to bet: "Rupee will go UP (strengthen) vs Dollar."

**Confusion:**
Should she BUY or SELL USD/INR?
• If Rupee strengthens, USD/INR goes DOWN (Dollars become cheaper in Rupees).
• So she needs to **SELL USD/INR**.

**Entry:** SELL USD/INR at 84.00
**Exit (1 week later):** BUY USD/INR at 83.20

**Profit Calculation:**
• She sold at 84.00 and bought back at 83.20.
• Movement: 80 pips in her favor.
• If she traded 1 lot (1,000 units): Profit = 80 × ₹1 = ₹80.
• If she traded 10 lots: ₹800.
• If she traded with 50x leverage on 100 lots: ₹8,000.

**Lesson:**
Forex requires thinking in pairs. "Rupee will strengthen" = "Dollar will weaken vs Rupee" = "SELL USD/INR." It's counterintuitive at first but becomes natural with practice.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You believe the Euro will weaken against the US Dollar. Which trade should you make?',
          'options': [
            'Buy EUR/USD (going long)',
            'Sell EUR/USD (going short)',
            'Buy USD/EUR',
            'It doesn\'t matter — buy whatever is cheaper',
          ],
          'correctIndex': 1,
          'explanation':
              'If you think the Euro will weaken, EUR/USD will go DOWN. To profit from a falling price, you SELL (go short). You sell EUR/USD at 1.1000, and if it drops to 1.0800, you buy it back for a 200-pip profit.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Forex prices are always pairs: BASE/QUOTE',
            'Buying a pair = buying the Base, selling the Quote simultaneously',
            'EUR/USD going up = Euro stronger / Dollar weaker',
            'To bet AGAINST a currency, sell the pair where it\'s the Base',
            'Next: What are pips and lots — and how do they determine your actual profit or loss?',
          ],
        },
      ],
    };
  }

  // Lesson 3.2: Pips, Lots & Position Sizing
  static Map<String, dynamic> getPipsLotsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Math of Forex',
          'emoji': '🧮',
          'content':
              'A pip. A lot. A standard lot. Micro lot. These words sound intimidating, but they\'re just the measurement system of forex — like centimeters for length or grams for weight. Let\'s master them.',
        },
        {
          'type': 'concept',
          'title': 'What is a Pip?',
          'emoji': '📏',
          'content': '''
**PIP = Percentage In Point (the smallest price movement)**

For most pairs, 1 pip = the 4th decimal place.

**Example: EUR/USD**
• Price moves from 1.1000 to 1.1001 = **1 pip** move
• Price moves from 1.1000 to 1.1050 = **50 pips** move
• Price moves from 1.1000 to 1.1100 = **100 pips** move

**Exception: JPY pairs**
For Japanese Yen pairs, 1 pip = 2nd decimal place.
• USD/JPY moves from 150.00 to 150.01 = **1 pip**

**For USD/INR:**
• USD/INR moves from 83.5000 to 83.5100 = **1 pip** (4th decimal)
• But in India, many quote to 4 decimals, so 83.5000 to 83.5025 = **0.25 pips**

---

**Key Insight:**
A pip seems tiny. But combined with leverage and large lot sizes, a 50-pip move can mean thousands of Rupees in profit OR loss. Pips are how you measure success and failure in forex.
''',
          'keyPoints': [
            '1 pip = 4th decimal place for most pairs (0.0001)',
            'JPY pairs: 1 pip = 2nd decimal place (0.01)',
            'A 50-pip move sounds small but can be huge with leverage',
            'Pips measure your profit and loss in forex',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Lot Sizes & Pip Values',
          'emoji': '📊',
          'content': '''
**Lot = The quantity of currency you trade.**

**Standard Lot Sizes:**
• **Standard Lot:** 1,00,000 units of base currency
• **Mini Lot:** 10,000 units (1/10th)
• **Micro Lot:** 1,000 units (1/100th)

**How Much is 1 Pip Worth?**

**EUR/USD (Standard Lot = 1,00,000 EUR):**
• 1 pip (0.0001) = \$10
• 50 pips = \$500 profit or loss!

**EUR/USD (Micro Lot = 1,000 EUR):**
• 1 pip = \$0.10
• 50 pips = \$5

**USD/INR (Standard Lot = 1,00,000 USD):**
• 1 pip (0.0001) = ₹10
• 50 pips = ₹500

**The Real Danger:**
With 100x leverage, you can open a Standard Lot with only ₹83,000 margin.
But a 100-pip move against you = ₹1,000 loss on a Standard Lot = your margin gets eaten fast.

**Key Lesson:**
Beginners should ALWAYS start with micro lots. A 50-pip loss = ₹5 instead of ₹500. Learn the game with small money first.
''',
        },
        {
          'type': 'scenario',
          'title': 'Position Sizing Decision',
          'situation':
              'You have ₹50,000 in your forex account. You want to trade USD/INR. Your broker offers 50x leverage. Should you open a Standard Lot (₹1,00,000 units)?',
          'choices': [
            {
              'text': 'Yes — with 50x leverage, ₹50,000 can control ₹25 Lakhs!',
              'isCorrect': false,
              'feedback':
                  '❌ Just because you CAN doesn\'t mean you SHOULD. A Standard Lot on USD/INR means a 50-pip move = ₹500. A bad day (200 pips against you) = ₹2,000 loss = 4% of your capital on ONE trade. That\'s reckless.',
            },
            {
              'text':
                  'No — start with micro lots (1,000 units) and risk only 1-2% of capital per trade',
              'isCorrect': true,
              'feedback':
                  '✅ Professional money management! With micro lots, a 50-pip loss = ~₹5. You can afford to make 100 mistakes while learning. The 1% rule means risking max ₹500 per trade on a ₹50,000 account.',
            },
            {
              'text': 'Open a mini lot — it\'s a good middle ground',
              'isCorrect': false,
              'feedback':
                  '❌ A mini lot (10,000 units) is still too big for a ₹50,000 account. A 100-pip move = ₹100 loss. With 50x leverage, a bad streak of 5 trades could wipe 10% of your capital. Start smaller.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 3 Complete! 🎉',
          'keyPoints': [
            '1 pip = smallest price movement (4th decimal for most pairs)',
            'Lot sizes: Standard (1L units), Mini (10K), Micro (1K) — start with Micro',
            'Pip value depends on lot size — bigger lots mean bigger gains AND losses',
            'The 1% rule: never risk more than 1% of your account on a single trade',
            'Leverage makes small pips look like big money — in both directions',
            'Next: Which currency pairs should you actually trade?',
          ],
        },
      ],
    };
  }
}
