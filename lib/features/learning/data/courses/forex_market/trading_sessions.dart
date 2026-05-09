/// Chapter 6: Trading Sessions & Liquidity
/// When to trade and when to stay away
class TradingSessionsContent {
  // Lesson 6.1: The Three Sessions
  static Map<String, dynamic> getThreeSessionsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Follow the Sun',
          'emoji': '🌅',
          'content':
              'Forex trades 24 hours. But NOT all hours are equal. Some hours have massive liquidity and tight spreads. Others are dead zones where spreads widen and traps appear. Timing matters enormously.',
        },
        {
          'type': 'concept',
          'title': 'The Three Global Sessions',
          'emoji': '🕐',
          'content': '''
**The forex day follows the sun across three major sessions:**

**1. Asian Session (Tokyo) 🇯🇵**
• IST: 5:30 AM - 2:30 PM
• Character: Quiet, range-bound, low volatility
• Best pairs: USD/JPY, AUD/USD, NZD/USD
• Volume: ~20% of daily total

**2. European Session (London) 🇬🇧**
• IST: 1:30 PM - 10:30 PM
• Character: HIGH volatility, big moves begin here
• Best pairs: EUR/USD, GBP/USD, EUR/GBP
• Volume: ~35% of daily total (LARGEST session!)

**3. American Session (New York) 🇺🇸**
• IST: 6:30 PM - 3:30 AM
• Character: Volatile, especially during London-NY overlap
• Best pairs: EUR/USD, USD/CAD, USD/JPY
• Volume: ~25% of daily total

---

**The Golden Window: London-New York Overlap**
• IST: 6:30 PM - 10:30 PM
• The BEST 4 hours to trade — maximum liquidity, tightest spreads, biggest moves.

---

**Key Insight:**
For Indian traders, the European and early American sessions (1:30 PM - 11:00 PM IST) are prime time. Trading during the Asian session or late US session means wider spreads and less opportunity.
''',
          'keyPoints': [
            'Asian (quiet) → European (volatile) → American (volatile)',
            'London-NY overlap (6:30-10:30 PM IST) is the best trading window',
            'European session accounts for 35% of daily volume — the biggest',
            'Indian traders: 1:30 PM - 11:00 PM IST is your prime window',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You want to trade EUR/USD with the tightest spreads and best liquidity. When should you trade (IST)?',
          'options': [
            '6:00 AM - 10:00 AM (Asian session)',
            '6:30 PM - 10:30 PM (London-New York overlap)',
            '1:00 AM - 5:00 AM (Late US / Pacific session)',
            'Any time — forex is 24 hours so it doesn\'t matter',
          ],
          'correctIndex': 1,
          'explanation':
              'The London-New York overlap (6:30-10:30 PM IST) has the highest volume, tightest spreads, and biggest moves for EUR/USD. Trading during the Asian session means wider spreads and lower liquidity for European pairs. Timing is critical in forex.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Three sessions: Asian (quiet), European (biggest), American (volatile)',
            'London-NY overlap = best 4 hours of the forex day (6:30-10:30 PM IST)',
            'Trading the wrong session means wider spreads and less predictable moves',
            'Indian traders have a convenient prime window in the evening hours',
            'Next: Why does liquidity matter so much — and how does it affect your wallet?',
          ],
        },
      ],
    };
  }

  // Lesson 6.2: Liquidity, Spreads & Timing
  static Map<String, dynamic> getLiquiditySpreadsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Hidden Cost of Bad Timing',
          'emoji': '💸',
          'content':
              'You place the same trade on EUR/USD at 7 AM and 7 PM. Same pair, same direction, same lot size. But one costs you 3x more in spreads. Timing doesn\'t just affect opportunity — it affects COST.',
        },
        {
          'type': 'interactive',
          'title': 'Spread Comparison Across Sessions',
          'emoji': '📊',
          'content': '''
**EUR/USD Spread at Different Times (IST):**

**7:00 AM (Asian Session — Dead Zone for EUR/USD):**
• Spread: 2.5 pips
• Cost per Standard Lot: ~\$25
• Liquidity: Very low — price can "gap"

**3:00 PM (European Session — Prime Time):**
• Spread: 0.5 pips
• Cost per Standard Lot: ~\$5
• Liquidity: Excellent — smooth execution

**8:00 PM (London-NY Overlap — Peak):**
• Spread: 0.1-0.3 pips
• Cost per Standard Lot: ~\$1-3
• Liquidity: Maximum — best execution possible

**11:30 PM (Late NY — Declining):**
• Spread: 1.5 pips
• Cost per Standard Lot: ~\$15
• Liquidity: Dropping — careful with large orders

**The Math:**
If you make 10 trades/day, bad timing costs you an extra \$200-\$400 in spreads EVERY DAY.
Over a month: \$4,000-\$8,000 in unnecessary costs. That's money straight out of your pocket.

**Key Lesson:**
Trading the right pair at the right time is as important as trading the right direction. Timing is a strategy, not a convenience.
''',
        },
        {
          'type': 'concept',
          'title': 'News Events: The Volatility Bombs',
          'emoji': '💣',
          'content': '''
**Certain economic releases cause massive, instant price moves:**

**High-Impact Events (Stay Alert or Stay Away):**
• **US Non-Farm Payrolls (NFP):** First Friday of every month. EUR/USD can move 100+ pips in seconds.
• **Central Bank Rate Decisions:** Fed, ECB, RBI — the single biggest market movers.
• **Inflation Data (CPI):** Higher than expected = currency strengthens.
• **GDP Reports:** Shows economic health of a country.

**What Happens During News:**
• Spreads widen dramatically (10-50x normal)
• Prices "gap" — jump from one level to another instantly
• Stop losses can be skipped (slippage)
• Algorithms dominate — retail traders are at a disadvantage

**Two Approaches:**
1. **Avoid news:** Close all positions 30 minutes before high-impact events. Re-enter after the dust settles.
2. **Trade news:** Only for experienced traders with instant execution and proper risk management.

---

**Key Insight:**
For beginners: treat high-impact news as a "market holiday." Don't trade 30 minutes before or after. The move might look like opportunity, but the spread widening and slippage make it extremely risky.
''',
          'keyPoints': [
            'NFP, rate decisions, and CPI are the biggest volatility triggers',
            'Spreads can widen 10-50x during major news releases',
            'Stop losses may not execute at your exact price (slippage)',
            'Beginners should avoid trading during high-impact news events',
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 6 Complete! 🎉',
          'keyPoints': [
            'Spreads vary massively across sessions — timing directly affects your trading cost',
            'London-NY overlap gives the tightest spreads for major pairs',
            'Bad timing can cost thousands in unnecessary spread costs per month',
            'High-impact news events cause extreme volatility and spread widening',
            'Beginners should avoid trading 30 minutes before/after major news',
            'Next: The most dangerous tool in forex — leverage. Understand it or get destroyed.',
          ],
        },
      ],
    };
  }
}
