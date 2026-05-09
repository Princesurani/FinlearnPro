/// Chapter 1: Used in All Markets
/// Why technical analysis is the universal trading language
class UsedInAllMarketsContent {
  // Lesson 1.1: The Universal Language of Price
  static Map<String, dynamic> getUniversalLanguageContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'One Skill, Every Market',
          'emoji': '🌐',
          'content':
              'A "Double Top" pattern works the same whether you\'re looking at Reliance stock, Bitcoin, EUR/USD, or Gold. Technical analysis reads HUMAN BEHAVIOR through price — and humans behave the same way in every market.',
        },
        {
          'type': 'story',
          'title': 'Ananya\'s Cross-Market Edge',
          'emoji': '📈',
          'content': '''
**Ananya**, 28, a data analyst in Hyderabad, learned technical analysis through stocks.

**Year 1 (Stocks):**
She mastered support/resistance and candlestick patterns on Nifty.
Made consistent 15% annual returns.

**Year 2 (Crypto):**
A friend suggested Bitcoin. "But I don't understand crypto fundamentals!"
She opened a Bitcoin chart. Same candlesticks. Same support/resistance. Same patterns.
She applied the EXACT same strategy. Made ₹45,000 in 3 months.

**Year 3 (Gold):**
Gold was trending during the Ukraine war. Ananya recognized a "Bull Flag" pattern — the same pattern she'd seen 100 times in stocks.
She bought Gold Mini on MCX at ₹52,000. Sold at ₹55,000. Profit: ₹30,000.

**The Insight:**
Ananya never studied crypto fundamentals or gold economics deeply. She didn't need to — because her charts read HUMAN BEHAVIOR, not asset fundamentals.

**Lesson:**
Technical analysis is the only trading skill that transfers across ALL markets. Learn it once on Nifty, and you can read Bitcoin, Gold, EUR/USD — any price chart in the world.
''',
        },
        {
          'type': 'concept',
          'title': 'Why Charts Work Everywhere',
          'emoji': '🧠',
          'content': '''
**Technical analysis is based on three principles:**

**1. Price Discounts Everything 💰**
All information — earnings, news, rumors, sentiment — is already reflected in the current price. The chart IS the summary of everything the market knows.

**2. Price Moves in Trends 📈**
Markets don't move randomly. They trend up, down, or sideways. Once a trend starts, it's more likely to continue than to reverse.

**3. History Repeats Itself 🔁**
Human emotions (fear, greed, hope, panic) don't change. The same emotional cycle creates the same patterns on charts — century after century.

---

**Where TA Works:**
• **Stocks:** Nifty, Bank Nifty, Reliance, TCS
• **Crypto:** Bitcoin, Ethereum, Solana
• **Forex:** EUR/USD, USD/INR, GBP/USD
• **Commodities:** Gold, Crude Oil, Silver
• **Even non-financial:** Real estate price trends, salary market trends

---

**Key Insight:**
A chart of Reliance in 2024 looks structurally similar to a chart of the US stock market in 1920. The instruments change, the patterns don't. Because the underlying driver — human psychology — hasn't changed in 10,000 years.
''',
          'keyPoints': [
            'Price discounts everything — the chart is the summary of all known information',
            'Price moves in trends — trends continue until something breaks them',
            'History repeats — human emotions create the same patterns across centuries',
            'TA works on stocks, crypto, forex, commodities — any liquid market',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Why does a "Double Top" pattern work the same on both a Nifty chart and a Bitcoin chart?',
          'options': [
            'Because both markets are regulated by the same authority',
            'Because technical analysis reads human psychology through price — and humans behave the same way in every market',
            'Because Double Tops are programmed into trading algorithms',
            'Because stock traders and crypto traders use the same broker',
          ],
          'correctIndex': 1,
          'explanation':
              'A Double Top forms when buyers try twice to push price above a level and fail both times. This happens because human greed (buying near tops) and fear (selling after failure) are universal emotions. The pattern emerges from psychology, not from the specific asset being traded.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Technical analysis reads human behavior through price action',
            'Three principles: price discounts everything, trends persist, history repeats',
            'The same patterns appear in stocks, crypto, forex, and commodities',
            'Learn TA once — apply it across every market for your entire career',
            'Next: How does TA compare to fundamental analysis?',
          ],
        },
      ],
    };
  }

  // Lesson 1.2: Technical vs Fundamental Analysis
  static Map<String, dynamic> getTaVsFaContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Charts vs Balance Sheets',
          'emoji': '⚖️',
          'content':
              'Should you study company financials or read price charts? The answer isn\'t one OR the other — it\'s knowing WHEN to use each. Let\'s compare these two approaches.',
        },
        {
          'type': 'interactive',
          'title': 'TA vs FA: Side by Side',
          'emoji': '📊',
          'content': '''
**Technical Analysis (TA):**
• Looks at: Price, volume, patterns, indicators
• Answers: "WHEN should I buy or sell?"
• Time horizon: Minutes to months
• Works best for: Timing entries/exits, short-term trading
• Limitation: Ignores company quality — a bad company can have a good chart

**Fundamental Analysis (FA):**
• Looks at: Earnings, revenue, P/E ratio, management, industry
• Answers: "WHAT should I buy?"
• Time horizon: Months to years
• Works best for: Identifying undervalued assets, long-term investing
• Limitation: Bad at timing — a great stock can fall 30% before recovering

**The Professional Approach: Use BOTH.**
1. **FA tells you WHAT to buy** — identify fundamentally strong companies
2. **TA tells you WHEN to buy** — wait for a technical entry signal

**Example:**
• FA says: "HDFC Bank is fundamentally strong at current valuations"
• TA says: "But it's at resistance. Wait for a pullback to ₹1,550 (support) before buying"
• Result: You buy a great company at a better price

**Key Lesson:**
FA without TA = buying right things at wrong times.
TA without FA = buying wrong things at right times.
Combining both = buying right things at right times. That's the edge.
''',
        },
        {
          'type': 'scenario',
          'title': 'Which Tool Would You Use?',
          'situation':
              'You want to invest in a stock for 5+ years. You\'ve identified TCS as fundamentally strong. TCS is currently at ₹4,200 — an all-time high. Should you buy immediately or wait?',
          'choices': [
            {
              'text':
                  'Buy immediately — fundamentals are great, price doesn\'t matter for 5 years',
              'isCorrect': false,
              'feedback':
                  '❌ Even for long-term investors, entry price matters! Buying at an all-time high means you might sit through a 15-20% drawdown before recovery. TA can help you find a better entry point — saving you months of waiting and thousands of Rupees.',
            },
            {
              'text':
                  'Use TA to find a pullback/support level for a better entry — combine FA (what) with TA (when)',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect! FA confirmed TCS is worth buying. Now TA helps you find a better WHEN. Wait for a pullback to the 50-day moving average, or a support level around ₹3,900. You buy the same great company at a 7% discount.',
            },
            {
              'text':
                  'Skip TCS — if it\'s at an all-time high, it\'s too expensive',
              'isCorrect': false,
              'feedback':
                  '❌ All-time highs aren\'t automatically "expensive." Many great stocks make new highs repeatedly. The key is to use FA to confirm quality and TA to time entry. Dismissing a stock just because it\'s at ATH is a common beginner mistake.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 1 Complete! 🎉',
          'keyPoints': [
            'TA answers WHEN to buy; FA answers WHAT to buy — use both together',
            'TA reads price and psychology; FA reads financials and value',
            'Professional traders combine both for optimal entry on quality assets',
            'TA is a cross-market skill — learn it once, use it in every market',
            'Next: The foundation of everything — how to read price charts.',
          ],
        },
      ],
    };
  }
}
