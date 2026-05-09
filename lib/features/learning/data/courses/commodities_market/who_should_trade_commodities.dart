/// Chapter 8: Who Should Trade Commodities
/// Honest self-assessment and final challenge
class WhoShouldTradeCommoditiesContent {
  // Lesson 8.1: The Commodity Readiness Checklist
  static Map<String, dynamic> getReadinessChecklistContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Is This Market for You?',
          'emoji': '🪞',
          'content':
              'Commodity trading isn\'t for everyone. The leverage is high, the hours are long (9 AM to 11:30 PM!), and global events can destroy positions while you sleep. Let\'s honestly assess whether this market fits you.',
        },
        {
          'type': 'concept',
          'title': 'Commodity Trading Readiness Checklist',
          'emoji': '📋',
          'content': '''
**Financial Prerequisites:**
✅ Emergency fund of 6+ months (commodities can draw down accounts fast)
✅ Zero high-interest debt
✅ Stable income — commodity trading is NOT a primary income source
✅ Minimum ₹2-3 Lakhs for a commodity account (lower = too much leverage)
✅ This is money you can 100% afford to lose

**Knowledge Prerequisites:**
✅ Understand futures, margin, and expiry mechanics
✅ Can read commodity charts and understand basic technical analysis
✅ Follow global macroeconomics (oil, Dollar, interest rates)
✅ Know MCX/NCDEX contract specifications and lot sizes
✅ Have practiced on a demo/paper trading account

**Lifestyle Prerequisites:**
✅ Can monitor positions during MCX extended hours (9 AM - 11:30 PM)
✅ Willing to wake up to overnight gaps without panicking
✅ Can follow US data releases (often at 6:30-8:30 PM IST)
✅ Disciplined enough to reduce positions before market close

---

**Who SHOULD Consider Commodities:**
• Stock traders wanting portfolio diversification
• Gold enthusiasts wanting leveraged gold exposure beyond ETFs
• People who follow global economics and geopolitics
• Anyone with a disciplined, rules-based trading approach

**Who Should NOT:**
• Complete investment beginners (start with stocks/mutual funds first)
• People who can't handle 5-10% daily portfolio swings
• Anyone who needs this money for goals within 1-2 years
• People who can't trade/monitor during evening hours
''',
          'keyPoints': [
            'Minimum ₹2-3 Lakhs recommended for commodity trading account',
            'Extended hours (9 AM - 11:30 PM) require lifestyle commitment',
            'Global awareness is essential — you\'re trading world events, not companies',
            'Start with stocks/mutual funds BEFORE attempting commodities',
          ],
        },
        {
          'type': 'story',
          'title': 'Suresh vs Anita: Two Approaches',
          'emoji': '👫',
          'content': '''
**Suresh (The Gambler) — Lost ₹4.5 Lakhs:**
• Heard from a friend: "Gold always goes up!"
• Opened MCX account with ₹2 Lakhs (his only savings after FD)
• Bought 4 lots of Gold Mini (used nearly full margin)
• Gold dropped ₹800 in 2 days. Loss: ₹32,000. Margin call.
• Deposited ₹1L more. "It'll come back."
• Gold dropped another ₹500. Total loss: ₹52,000. Another margin call.
• Deposited ₹1.5L from his wife's savings without telling her.
• Gold recovered ₹200 but he panicked and sold. Net loss: ₹4.5 Lakhs.
• **Marriage strained. Savings destroyed. Trust broken.** 😔

**Anita (The Professional) — Steady 18% annual returns:**
• Traded stocks for 3 years first. Built foundation.
• Studied commodity markets for 6 months. Paper traded.
• Opened account with ₹5 Lakhs (10% of her total savings).
• Only trades Gold Mini and Crude Oil (knows them well).
• Uses 2% risk rule. Maximum 2 lots at a time.
• Closes all positions by 11 PM (avoids overnight risk).
• Monthly returns: Some months +₹15K, some months -₹8K. Net positive.
• **Annual return: ~₹90,000 on ₹5L account (18%). Boring but profitable.** 😊

**The Difference:**
Suresh had no foundation, no risk rules, and used money he couldn't afford to lose.
Anita had years of stock experience, strict rules, and played with risk capital only.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Honest Assessment',
          'situation':
              'You\'ve been trading stocks for 1 year. You\'ve made some money. Your colleague at work trades crude oil and brags about ₹30,000 profit days. You\'re tempted. You have ₹1,50,000 in savings (your only savings). Should you start commodity trading?',
          'choices': [
            {
              'text':
                  'Yes — your stock experience means you\'re ready for commodities',
              'isCorrect': false,
              'feedback':
                  '❌ 1 year of stock trading is insufficient foundation. Commodities have leverage, expiry, overnight gaps, and global factors that don\'t exist in stocks. Also, ₹1.5L as your ONLY savings means you can\'t afford to lose it. Build more capital first.',
            },
            {
              'text':
                  'Not yet — build more savings, study commodity markets for 6 months, then start with Gold Petal (₹500 margin) to learn',
              'isCorrect': true,
              'feedback':
                  '✅ Perfectly disciplined! Build your savings to where ₹2-3L is risk capital (not essential money). Study MCX mechanics. Start with Gold Petal (1 gram, ~₹500 margin) to learn expiry, rollover, and gap behavior without risking real money.',
            },
            {
              'text': 'Start with just ₹30,000 to test the waters',
              'isCorrect': false,
              'feedback':
                  '❌ ₹30,000 on MCX is extremely tight. Even Gold Petal requires monitoring and understanding. More importantly, ₹30,000 from your only ₹1.5L savings = 20% at risk. The minimum should be 5-10% of savings, and ONLY after proper education.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Commodity trading requires financial, knowledge, AND lifestyle readiness',
            'Minimum ₹2-3 Lakhs as dedicated risk capital (not essential savings)',
            'Build stock trading experience FIRST — commodities are harder, not easier',
            'Start with Gold Petal to learn mechanics before risking real capital',
            'Boring, disciplined approaches (2% rule, early close) beat exciting gambling',
          ],
        },
      ],
    };
  }

  // Lesson 8.2: Final Challenge: Commodity Pro
  static Map<String, dynamic> getFinalChallengeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Final Test',
          'emoji': '🏆',
          'content':
              'You\'ve completed the entire Commodities Market course. Gold, oil, wheat, futures, spot, risk management — it\'s all in your toolkit now. Let\'s see if you can call yourself Commodity-Ready.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Commodity Basics',
          'question':
              'What is the key property that makes gold a "commodity" but an iPhone NOT a commodity?',
          'options': [
            'Gold is expensive and iPhones are cheap',
            'Gold is fungible (interchangeable) — any 1 kg of 24k gold is identical. iPhones are differentiated products with brand value.',
            'Gold is physical and iPhones are digital',
            'Gold is regulated by SEBI and iPhones are not',
          ],
          'correctIndex': 1,
          'explanation':
              'Fungibility is the defining characteristic. 1 kg of 24k gold from India = 1 kg from South Africa. But an iPhone 16 ≠ Samsung Galaxy S25 — they\'re differentiated by brand, design, and features. Commodities must be standardized and interchangeable.',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: Trading Mechanics',
          'question':
              'You buy 1 lot of MCX Gold Mini at ₹63,000/10g. Gold moves to ₹63,800. What\'s your profit? (1 Gold Mini lot = 100 grams = 10 units of 10g)',
          'options': [
            '₹800',
            '₹8,000 (₹800 × 10 units)',
            '₹80,000',
            '₹800 × leverage ratio',
          ],
          'correctIndex': 1,
          'explanation':
              'Gold moved ₹800 per 10g. One Gold Mini lot = 100 grams = 10 units of 10g. Profit = ₹800 × 10 = ₹8,000. With a margin of ~₹45,000, that\'s roughly an 18% return on margin — from just a 1.27% move in gold price. That\'s the power of leveraged futures.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: Risk Management',
          'question':
              'You have ₹4,00,000 in your commodity account. Using the 2% risk rule and keeping 50% as free margin, how many Gold Mini lots can you trade?',
          'options': [
            '8 lots (use full margin)',
            '4 lots (use all available margin)',
            '2-3 lots (leaves 50%+ as buffer, keeps risk under 2% per trade)',
            '1 lot (be extra cautious)',
          ],
          'correctIndex': 2,
          'explanation':
              'With ₹4L account: Usable margin = ₹2L (50% kept as buffer). Gold Mini margin ≈ ₹45-50K per lot. Max lots = 2L / 50K = 4 lots. But with 2% risk rule (max ₹8,000 loss per trade), 2-3 lots with appropriate stop losses is the sweet spot. Never max out your margin.',
        },
        {
          'type': 'scenario',
          'title': 'The Ultimate Commodity Scenario',
          'situation':
              'It\'s Friday evening. You\'re holding 2 lots of MCX Crude Oil in profit. Over the weekend, OPEC has a critical meeting that could cut OR increase production. The outcome is unpredictable. MCX will be closed all weekend. What do you do?',
          'choices': [
            {
              'text':
                  'Hold through the weekend — OPEC usually cuts production, so oil should go up',
              'isCorrect': false,
              'feedback':
                  '❌ "Usually" is not a strategy. OPEC has surprised markets multiple times. A production increase over the weekend could gap crude oil down ₹200-400 at Monday open. Your profit could turn into a large loss before you can react.',
            },
            {
              'text':
                  'Close at least 1 lot to reduce risk, and keep 1 lot with a wider mental stop for Monday',
              'isCorrect': true,
              'feedback':
                  '✅ The professional play! You bank profit on 1 lot (guaranteed) and maintain exposure on 1 lot (captures upside if OPEC cuts). If OPEC increases production, only 1 lot takes the hit. Risk is halved while opportunity is maintained.',
            },
            {
              'text':
                  'Close both lots — never hold commodities over weekends with binary events',
              'isCorrect': true,
              'feedback':
                  '✅ Also excellent! The safest approach. Taking profits before a binary, unpredictable event is textbook risk management. You can re-enter Monday after the OPEC decision is known. Certainty is worth more than potential gains.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Congratulations! 🎉',
          'keyPoints': [
            'You understand commodity types: metals, energy, and agriculture',
            'You know how MCX/NCDEX work — futures, margins, expiry, and lot sizes',
            'You can differentiate spot, futures, options, and ETF approaches',
            'You understand what drives commodity prices — supply, demand, geopolitics, Dollar',
            'You have a risk management toolkit: 2% rule, overnight reduction, expiry tracking',
            'You\'re now equipped to explore the commodity market with knowledge and discipline 💪',
          ],
        },
      ],
    };
  }
}
