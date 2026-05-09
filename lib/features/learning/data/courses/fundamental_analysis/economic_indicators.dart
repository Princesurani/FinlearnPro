/// Chapter 4: Economic Indicators
/// GDP, inflation, interest rates, and their market impact
class EconomicIndicatorsContent {
  // Lesson 4.1: GDP, Inflation & Interest Rates
  static Map<String, dynamic> getGdpInflationRatesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Three Pillars of Macro',
          'emoji': '🏛️',
          'content':
              'Three numbers control the fate of trillions of Rupees in the market: GDP growth rate, inflation rate, and RBI\'s interest rate. When these numbers change, entire sectors rise or fall. Understanding them gives you a massive edge.',
        },
        {
          'type': 'concept',
          'title': 'The Big Three Economic Indicators',
          'emoji': '📊',
          'content': '''
**1. GDP (Gross Domestic Product) Growth Rate 📈**
Total value of all goods and services produced in India.

• **GDP > 6%:** Economy booming → Corporate earnings grow → Stocks rise
• **GDP 3-6%:** Moderate growth → Selective sectors perform
• **GDP < 3%:** Economy struggling → Markets may fall → Defensive stocks win

**India's GDP:** ~₹300+ Lakh Crore (~\$3.5 Trillion). Growing at 6-7%.
When GDP surprises UPWARD, Nifty rallies. When it disappoints, Nifty falls.

---

**2. Inflation (CPI — Consumer Price Index) 🔥**
Rate at which prices of everyday goods increase.

• **Inflation 2-4%:** Goldilocks zone → Economy healthy, RBI happy
• **Inflation 4-6%:** Warming up → RBI starts worrying, may raise rates
• **Inflation > 6%:** Danger zone → RBI raises rates aggressively → Markets hurt

**Why inflation matters:**
• High inflation erodes purchasing power (your ₹100 buys less)
• RBI raises rates to fight inflation → Borrowing costs increase
• Rate hikes slow down corporate growth and consumer spending

---

**3. Interest Rate (Repo Rate — RBI's Key Rate) 🏦**
The rate at which RBI lends to banks.

• **Rates decrease:** Borrowing cheaper → Companies expand → Stocks rise → Real estate booms
• **Rates increase:** Borrowing expensive → Growth slows → Stock market may correct

**The Chain Reaction:**
RBI raises repo rate → Banks raise loan rates → EMIs increase → People spend less → Companies sell less → Earnings fall → Stock prices fall

---

**Key Insight:**
These three indicators are interconnected: High inflation → RBI raises rates → GDP growth slows. Understanding this cycle helps you anticipate market moves BEFORE they happen.
''',
          'keyPoints': [
            'GDP > 6% = economy booming, bullish for stocks',
            'Inflation > 6% = danger zone, RBI will raise rates (bearish)',
            'Rate hikes = expensive borrowing = slower growth = markets may fall',
            'All three are interconnected — inflation drives rates, rates drive growth',
          ],
        },
        {
          'type': 'story',
          'title': 'The Auto Sector Crash',
          'emoji': '🚗',
          'content': '''
**In 2022, inflation spiked globally.**

RBI was forced to raise interest rates aggressively to cool prices.
The repo rate went from 4% to 6.5%.

**The Chain Reaction for Maruti Suzuki:**
1. Car loans became expensive (EMIs went up).
2. Middle-class families postponed buying cars.
3. Maruti's sales volume dropped.
4. Profits shrank.
5. The stock price fell by 15%.

**The amateur trader** was confused: "Maruti is a great company! Why is it falling?"
**The macro trader** understood: "It's not about the company. The macro environment (interest rates) is hostile to auto sales."

**Key lesson:** You can pick the best company in the world, but if the macro environment turns against its sector, the stock will struggle. Macro always overrides micro.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'India\'s CPI inflation just came in at 7.5% (above RBI\'s 6% upper limit). What is the MOST LIKELY RBI response and its impact on markets?',
          'options': [
            'RBI will reduce rates to stimulate growth — bullish for markets',
            'RBI will raise rates to control inflation — this may hurt rate-sensitive stocks like real estate and auto',
            'RBI will do nothing — inflation doesn\'t affect monetary policy',
            'RBI will print more money — bullish for all assets',
          ],
          'correctIndex': 1,
          'explanation':
              'RBI\'s mandate is to keep inflation within 2-6%. At 7.5%, they MUST act. They\'ll raise the repo rate, which makes borrowing more expensive. Rate-sensitive sectors (real estate, auto, NBFCs) suffer most because they depend on loans. IT and pharma are less affected. Banking can benefit from higher Net Interest Margins.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'GDP growth, inflation, and interest rates are the three macro pillars',
            'High inflation → RBI rate hikes → slower growth → markets correct',
            'GDP surprises drive big market moves — beat = rally, miss = sell-off',
            'The three indicators form a cycle: inflation → rates → growth → back to inflation',
            'Next: How RBI policy decisions specifically move Nifty, bonds, and the Rupee.',
          ],
        },
      ],
    };
  }

  // Lesson 4.2: RBI Policy & Market Reactions
  static Map<String, dynamic> getRbiPolicyContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Most Powerful Person in Indian Markets',
          'emoji': '🏦',
          'content':
              'Every 2 months, the RBI Governor announces the Monetary Policy decision. Markets hold their breath. A single word change — "hawkish" vs "dovish" — can move Nifty 500 points in minutes. Let\'s decode RBI-speak.',
        },
        {
          'type': 'concept',
          'title': 'RBI Policy Decoded',
          'emoji': '🗝️',
          'content': '''
**Key Terms:**

**Hawkish 🦅 = Tight/Restrictive**
• Focused on FIGHTING inflation
• Likely to RAISE interest rates
• Bearish for stocks, bullish for bonds and Rupee
• Example: "Inflation remains a concern. We remain vigilant."

**Dovish 🕊️ = Easy/Accommodative**
• Focused on SUPPORTING growth
• Likely to CUT interest rates
• Bullish for stocks, bearish for bonds
• Example: "Growth needs support. We will maintain adequate liquidity."

---

**How Different Assets React to RBI Decisions:**

**Rate HIKE (+25 bps):**
• Nifty: Falls 0.5-2% (growth concerns) 📉
• Bank stocks: Short-term fall, but NIMs improve over time
• Real estate/Auto: Falls (higher EMIs reduce demand) 📉
• Bond prices: Fall (new bonds offer higher yields) 📉
• Rupee: Strengthens (higher rates attract foreign capital) 📈
• Gold: Falls (higher rates increase opportunity cost of holding gold) 📉

**Rate CUT (-25 bps):**
• Nifty: Rallies 1-3% (growth optimism) 📈
• Bank stocks: Initial rally, but NIMs may compress
• Real estate/Auto: Rallies (cheaper EMIs boost demand) 📈
• Bond prices: Rise (existing bonds become more valuable) 📈
• Rupee: Weakens (lower rates reduce foreign capital inflow) 📉
• Gold: Rises (lower rates reduce opportunity cost of gold) 📈

---

**Key Insight:**
The REACTION depends not just on what RBI does, but whether it was EXPECTED. A rate cut when everyone expected a HOLD causes a bigger rally than an expected rate cut. Surprises move markets most.
''',
          'keyPoints': [
            'Hawkish = fighting inflation (rate hikes); Dovish = supporting growth (rate cuts)',
            'Rate hikes hurt stocks, real estate, and auto; strengthen the Rupee',
            'Rate cuts boost stocks and real estate; weaken the Rupee',
            'Market reaction depends on surprise factor — expected moves are already priced in',
          ],
        },
        {
          'type': 'story',
          'title': 'The RBI Surprise Rally',
          'emoji': '🚀',
          'content': '''
**February 2019:** The market was bearish. Growth was slowing.

Most analysts expected the RBI to hold interest rates steady because inflation was still a minor concern. The consensus was a "neutral" stance.

**10:00 AM:** RBI Governor Shaktikanta Das announced the policy.
Not only did RBI cut rates by 25 bps, but they also changed their stance from "calibrated tightening" to "neutral."

**The Result:**
This was a massive SURPRISE.
Within minutes, Bank Nifty shot up 400 points. Real estate stocks rallied 3-5%. 

**Why?**
Because the market had priced in a HOLD. When the CUT happened, all the algorithms and traders rushed to adjust their positions to the new, more bullish reality.

**Key lesson:** The market doesn't trade on facts; it trades on surprises. If the market expects a rate cut and gets a rate cut, nothing happens. It's the deviation from expectation that creates opportunity.
''',
        },
        {
          'type': 'scenario',
          'title': 'RBI Day Trading',
          'situation':
              'It\'s RBI policy day. The market EXPECTS a rate hold (no change). But RBI surprises with a 25 bps rate CUT. You hold Bank Nifty futures and a Gold ETF. What happens?',
          'choices': [
            {
              'text':
                  'Bank Nifty falls and Gold falls — rate cuts are bad for everything',
              'isCorrect': false,
              'feedback':
                  '❌ Rate cuts are BULLISH for stocks (cheaper borrowing → growth). And rate cuts are BULLISH for gold (lower opportunity cost of holding gold). Both your positions should benefit from a surprise rate cut.',
            },
            {
              'text':
                  'Bank Nifty rallies (cheaper credit, growth optimism) AND Gold rallies (lower rates favor gold). Double win since the cut was a SURPRISE.',
              'isCorrect': true,
              'feedback':
                  '✅ A SURPRISE rate cut is extremely bullish for both stocks and gold. Bank Nifty benefits from growth optimism and potential loan growth. Gold benefits because lower interest rates reduce the opportunity cost of holding non-yielding gold. The surprise factor amplifies the move.',
            },
            {
              'text': 'Nothing happens — markets don\'t react to RBI decisions',
              'isCorrect': false,
              'feedback':
                  '❌ RBI policy decisions are among the biggest market-moving events in India. Nifty has moved 2-3% on RBI days. A SURPRISE cut when HOLD was expected would cause significant moves across stocks, bonds, and currencies.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 4 Complete! 🎉',
          'keyPoints': [
            'GDP, inflation, and interest rates are the three interconnected macro pillars',
            'Hawkish RBI = rate hikes = bearish stocks, bullish Rupee',
            'Dovish RBI = rate cuts = bullish stocks, bullish gold, bearish Rupee',
            'Surprises move markets most — expected decisions are already priced in',
            'Follow RBI policy calendar — these are the biggest pre-scheduled market events',
            'Next: How corporate earnings, elections, and black swan events move markets.',
          ],
        },
      ],
    };
  }
}
