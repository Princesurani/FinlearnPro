/// Chapter 5: Spot vs Derivative Trading
/// Physical delivery vs financial settlement
class SpotVsDerivativeContent {
  // Lesson 5.1: Spot Markets: Buy It Now
  static Map<String, dynamic> getSpotMarketsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Cash & Carry',
          'emoji': '🏪',
          'content':
              'When you walk into a jeweller and buy gold, that\'s a "spot" transaction — you pay today, you get the gold today. Spot markets are the simplest form of commodity trading. But they come with unique challenges.',
        },
        {
          'type': 'concept',
          'title': 'How Spot Markets Work',
          'emoji': '💰',
          'content': '''
**Spot Trading = Buy now, receive now (or within 2 days).**

**Where Spot Trading Happens:**
• **Jewellery shops:** Buy gold/silver at today's price
• **Wholesale markets (Mandis):** Farmers sell wheat, rice, cotton
• **International:** London Bullion Market (gold), Rotterdam (oil)
• **Digital:** Gold ETFs on NSE are essentially spot gold exposure

**Spot Price = The "Real" Price Right Now.**
When news says "Gold at ₹63,000" — that's the spot price.
Futures prices are typically slightly higher (called "premium" or "contango").

**Why Spot Exists:**
• Jewellers need gold TODAY to make jewelry
• Oil refineries need crude TODAY to make petrol
• Food companies need wheat TODAY to make flour
• **They can't wait for a futures contract to expire**

---

**Challenges of Spot Trading:**
• **Storage:** Where do you keep 100 kg of silver? Or 1,000 barrels of oil?
• **Quality verification:** Is this really 24k gold or 22k?
• **Transportation:** Moving physical commodities is expensive and risky
• **Perishability:** Agricultural goods can spoil

---

**Key Insight:**
Spot trading is for participants who actually NEED the physical commodity. As a retail investor, you'll almost always use derivatives (futures/options) or ETFs instead. You get price exposure without the headache of storage and delivery.
''',
          'keyPoints': [
            'Spot = buy now, receive now (or T+2 days)',
            'Spot prices are the benchmark "real" price for commodities',
            'Physical challenges: storage, quality, transport, perishability',
            'Retail investors use ETFs or futures for spot-like exposure',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You want exposure to gold prices without dealing with storage, purity verification, or theft risk. What\'s the best approach?',
          'options': [
            'Buy physical gold coins from a jeweller',
            'Buy Gold ETF units on NSE — digital gold exposure without physical hassles',
            'Buy gold futures on MCX and take physical delivery',
            'Buy gold jewelry — it\'s the same as investing in gold',
          ],
          'correctIndex': 1,
          'explanation':
              'Gold ETFs (like SBI Gold ETF, Nippon Gold ETF) track gold spot prices precisely. You buy/sell units on NSE like stocks. No storage, no purity risk, no theft worry. Each unit represents a specific weight of gold held in vaults. It\'s the cleanest way for retail investors to own gold.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Spot = immediate purchase and delivery of physical commodity',
            'Storage, quality, and transport are the big challenges of spot trading',
            'Gold ETFs provide spot price exposure without physical hassles',
            'Spot prices are the benchmark that futures prices derive from',
            'Next: How derivatives let you trade commodities without ever touching them.',
          ],
        },
      ],
    };
  }

  // Lesson 5.2: Derivatives: Trade the Price
  static Map<String, dynamic> getDerivativesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Trade the Idea, Not the Thing',
          'emoji': '📊',
          'content':
              'You believe oil prices will rise next month. Do you buy 100 barrels and store them in your garage? Of course not. Derivatives let you profit from price movements WITHOUT owning the physical commodity.',
        },
        {
          'type': 'concept',
          'title': 'Futures vs Options vs ETFs',
          'emoji': '⚖️',
          'content': '''
**1. Futures (Most Common on MCX) 📜**
• Agreement to buy/sell at a fixed price on a future date
• Leverage: High (~15x). Small margin controls large positions.
• Risk: Unlimited. Losses can exceed your margin.
• Best for: Active traders with commodity knowledge
• Example: BUY Gold August Futures at ₹63,000

**2. Options (Growing on MCX) 🎯**
• RIGHT to buy/sell, but no OBLIGATION
• You pay a premium upfront. Maximum loss = premium paid.
• Risk: Limited to premium for buyers; unlimited for sellers
• Best for: Defined-risk trades and hedging
• Example: BUY Gold 64,000 Call Option for ₹500 premium

**3. ETFs (On NSE/BSE) 📦**
• Tracks spot price. No leverage. No expiry.
• Buy/sell like stocks. Hold as long as you want.
• No margin calls. No delivery risk.
• Best for: Long-term investors and beginners
• Example: SBI Gold ETF, Nippon India Gold ETF

---

**Which One Should You Start With?**
• **Complete beginner:** Gold ETF (zero complexity)
• **Learning trading:** Gold Petal futures (₹500 margin, tiny risk)
• **Intermediate:** Gold Mini futures with proper risk management
• **Advanced:** Options strategies for defined-risk plays

---

**Key Insight:**
ETFs are investments. Futures are trades. Options are insurance. Each tool has a different purpose. Using futures when you should be using ETFs is like using a chainsaw to cut bread — technically possible, unnecessarily dangerous.
''',
          'keyPoints': [
            'Futures: leveraged, high risk, for active traders',
            'Options: limited risk for buyers, for hedging and defined-risk trades',
            'ETFs: no leverage, no expiry, simplest for beginners',
            'Match the instrument to your experience level — start with ETFs',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Side-by-Side Comparison',
          'emoji': '📊',
          'content': '''
**Scenario: You believe gold will rise from ₹63,000 to ₹65,000 (₹2,000 move)**

**Approach 1: Gold ETF (₹1,00,000 invested)**
• Buy ₹1L of Gold ETF at ₹63,000/10g equivalent
• Gold rises to ₹65,000 (3.17% increase)
• Your ETF: ₹1,00,000 → ₹1,03,170
• Profit: ₹3,170 (3.17%)
• Risk: ₹1,00,000 (but gold rarely goes to zero)

**Approach 2: Gold Mini Futures (₹50,000 margin)**
• BUY 1 lot Gold Mini at ₹63,000
• Gold rises to ₹65,000
• Profit: ₹2,000 × 10 = ₹20,000
• Return on margin: 40%! 🔥
• Risk: Potentially more than ₹50,000 if gold crashes

**Approach 3: Gold Call Option (₹8,000 premium)**
• BUY 1 lot Gold 63,500 Call for ₹800/10g premium
• Gold rises to ₹65,000
• Option value: ₹1,500/10g
• Profit: (₹1,500 - ₹800) × 10 = ₹7,000
• Return: 87.5%! 🔥🔥
• Risk: Maximum ₹8,000 (premium paid)

**Key Lesson:**
Higher returns always come with higher risk or complexity. ETF: safe but modest. Futures: leveraged and dangerous. Options: can be used smartly but require understanding. Choose wisely.
''',
        },
        {
          'type': 'summary',
          'title': 'Chapter 5 Complete! 🎉',
          'keyPoints': [
            'Spot = physical purchase; Derivatives = financial price exposure',
            'Futures are leveraged and risky; ETFs are simple and safe for beginners',
            'Options offer limited risk for buyers — good for hedging',
            'Same ₹2,000 gold move: ETF gives 3%, Futures give 40%, Options give 87%',
            'Higher returns = higher risk/complexity — always match to your skill level',
            'Next: What actually makes commodity prices move?',
          ],
        },
      ],
    };
  }
}
