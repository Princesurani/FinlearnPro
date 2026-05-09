/// Chapter 3: Support & Resistance
/// The invisible floors and ceilings of price
class SupportResistanceContent {
  // Lesson 3.1: Finding Support & Resistance
  static Map<String, dynamic> getFindingSRContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Invisible Walls',
          'emoji': '🧱',
          'content':
              'Every chart has invisible floors and ceilings where prices repeatedly bounce. These are support and resistance — the two most important concepts in ALL of technical analysis. Master these and you\'re 50% of the way to becoming a competent trader.',
        },
        {
          'type': 'concept',
          'title': 'Support & Resistance Explained',
          'emoji': '📐',
          'content': '''
**Support = A price floor where buying pressure stops a decline.**
Think of it as a trampoline. Price falls, hits support, and bounces back up.

**Why does support form?**
• Buyers remember: "Last time price hit ₹1,500, it bounced. I'll buy there again."
• Thousands of traders place buy orders at the same level.
• The collective buying pressure creates a "floor."

---

**Resistance = A price ceiling where selling pressure stops a rise.**
Think of it as a glass ceiling. Price rises, hits resistance, and falls back down.

**Why does resistance form?**
• Sellers remember: "Last time price hit ₹2,000, it fell. I'll sell there again."
• Trapped buyers from the last time think: "I'll sell at breakeven."
• The collective selling pressure creates a "ceiling."

---

**How to Find Support & Resistance:**
1. Look for price levels where price has bounced **at least 2-3 times**
2. The MORE times price has bounced from a level, the STRONGER it is
3. Round numbers (₹100, ₹500, ₹1,000, ₹10,000) are natural S/R levels
4. Previous day's high/low are important short-term S/R

---

**Key Insight:**
Support and resistance are created by MEMORY. Traders remember where they bought, sold, or missed opportunities. These memories create collective behavior at specific price levels.
''',
          'keyPoints': [
            'Support = floor (buying pressure); Resistance = ceiling (selling pressure)',
            'S/R levels form because traders REMEMBER previous price reactions',
            'The more times a level is tested, the stronger it becomes',
            'Round numbers (₹100, ₹500, ₹1,000) are natural psychological S/R levels',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The Memory of the Market',
          'emoji': '🧠',
          'content': '''
**Imagine you bought a stock at ₹1,000.**

The next day, it crashes to ₹800. You are down 20%. You feel terrible. You look at your screen every day and think: *"Please God, just let it go back to ₹1,000 so I can sell and get my money back without a loss."*

**Six months later:** The stock slowly climbs back up.
₹850... ₹900... ₹950... and finally hits ₹1,000!

What do you do? You, and thousands of other trapped buyers, immediately hit the SELL button. 
This massive wave of "breakeven selling" stops the price from going higher.

**This is why ₹1,000 became RESISTANCE.** It's not magic. It's human psychology and the pain of holding a loss. Resistance is just a cluster of trapped buyers trying to escape.
''',
        },
        {
          'type': 'story',
          'title': 'Raj Trades Nifty Using Support',
          'emoji': '📱',
          'content': '''
**Raj**, a swing trader in Chennai, notices a pattern on Nifty:

**Nifty's Price Action (past 3 months):**
• March: Nifty falls to 22,000. Bounces to 22,800.
• April: Nifty falls again to 22,050. Bounces to 23,000.
• May: Nifty falls to 22,020. Bounces again.

**Raj's Observation:**
"22,000 is strong support. Price has bounced from there 3 times."

**His Trade Plan:**
• Wait for Nifty to approach 22,000 again
• BUY near 22,000-22,100 (at support)
• Stop loss: 21,850 (below support — if it breaks, the thesis is wrong)
• Target: 22,800 (previous bounce high)
• Risk: 200 points. Reward: 700 points. R:R = 1:3.5 ✅

**June: Nifty drops to 22,080.**
Raj buys. Nifty bounces to 22,700.
Profit: 620 points on Nifty Futures = ₹31,000 on 1 lot.

**Lesson:**
Raj didn't need complex indicators. He used ONE concept — support — and waited patiently for price to come to his level. Simple > complicated.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'A stock has bounced from ₹500 exactly four times in the past 6 months. Price is now approaching ₹500 again. What\'s your assessment?',
          'options': [
            '₹500 is strong support — likely to bounce again, making it a potential buy zone',
            '₹500 is weak because it\'s been tested too many times — it will break',
            '₹500 is irrelevant — previous price action doesn\'t predict the future',
            'You should sell at ₹500 because it\'s a resistance level',
          ],
          'correctIndex': 0,
          'explanation':
              '₹500 has held as support 4 times — that\'s strong support. It\'s a potential buy zone with a stop loss just below ₹500 (e.g., ₹490). However, note that support CAN eventually break — especially after many tests. Each test weakens it slightly because buying interest gets exhausted.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Support = buying zone (floor); Resistance = selling zone (ceiling)',
            'S/R forms from collective memory of previous price reactions',
            'More tests = stronger level, but eventually levels DO break',
            'Round numbers are natural psychological S/R levels',
            'Next: What happens when support breaks? The role reversal concept.',
          ],
        },
      ],
    };
  }

  // Lesson 3.2: Breakouts & Breakdowns
  static Map<String, dynamic> getBreakoutsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'When the Floor Breaks',
          'emoji': '💥',
          'content':
              'Support holds until it doesn\'t. When it breaks, the floor becomes a ceiling — and the move can be explosive. Understanding breakouts and breakdowns is how you catch the biggest moves in any market.',
        },
        {
          'type': 'concept',
          'title': 'The Role Reversal Principle',
          'emoji': '🔄',
          'content': '''
**The Most Important Rule in S/R:**
**When support BREAKS, it becomes resistance.**
**When resistance BREAKS, it becomes support.**

**Why This Happens:**
• Price breaks below ₹500 support.
• Everyone who bought at ₹500 is now losing money.
• When price recovers back to ₹500, those trapped buyers SELL to breakeven.
• Their selling turns ₹500 from support into resistance.

---

**Breakout (Price breaks ABOVE resistance):**
• Price pushes through a ceiling with high volume
• Previous resistance becomes new support
• Often leads to explosive upward moves
• **Signal: BUY on a confirmed breakout**

**Breakdown (Price breaks BELOW support):**
• Price crashes through a floor with high volume
• Previous support becomes new resistance
• Often leads to sharp declines
• **Signal: SELL or AVOID**

---

**How to Confirm a Breakout (Avoid Fakes!):**
1. **Volume:** Real breakouts have 2-3x normal volume. Low volume = likely fake.
2. **Candle close:** Price must CLOSE above resistance (not just wick above).
3. **Retest:** After breakout, price often comes back to test the level as new support.
4. **Time:** Give it at least 2-3 candles to confirm.

---

**Key Insight:**
Most "breakouts" are fake. 60-70% of breakouts fail and reverse. That's why confirmation (volume, candle close, retest) is essential. Never chase a breakout — wait for the retest.
''',
          'keyPoints': [
            'Broken support becomes resistance; broken resistance becomes support',
            'Real breakouts have high volume (2-3x normal) and strong candle closes',
            '60-70% of breakouts are fake — always wait for confirmation',
            'The retest (price coming back to test the broken level) is the safest entry',
          ],
        },
        {
          'type': 'story',
          'title': 'The Patient Professional',
          'emoji': '🧘',
          'content': '''
**Stock X has been facing resistance at ₹500 for a year.**

**10:15 AM:** The price breaks above ₹500, hitting ₹505 on huge volume.
**The Amateur:** "Breakout!" He buys immediately at ₹505. (FOMO).

**11:00 AM:** The price reverses back down to ₹490. The amateur is stopped out. Loss taken.

**Next Day:** The price rises again, crosses ₹500, and closes the day strongly at ₹515.
**The Professional:** Sees the strong daily close above resistance. He waits.

**Day 3:** The price pulls back to exactly ₹500. It bounces perfectly off ₹500 (Old Resistance is now New Support).
**The Professional:** Buys at ₹501. His stop loss is tight (₹490). 
The stock then rallies to ₹600 over the next week.

**Key lesson:** The amateur buys the *initial break* and gets chopped up. The professional buys the *retest of the broken level*. The retest offers the highest probability and the lowest risk. Let the amateurs clear the path for you.
''',
        },
        {
          'type': 'scenario',
          'title': 'Breakout or Trap?',
          'situation':
              'A stock has been stuck below ₹1,000 resistance for months. Today, it spikes to ₹1,015 on normal volume, but the daily candle closes at ₹995 (below resistance). Your friend says: "It broke out! Buy now!" What do you do?',
          'choices': [
            {
              'text':
                  'Buy immediately — it touched ₹1,015, that\'s a breakout!',
              'isCorrect': false,
              'feedback':
                  '❌ This is a classic "fake breakout" or "bull trap." The price wicked above ₹1,000 but CLOSED below it. And volume was normal, not elevated. No confirmation = no trade. This setup traps eager buyers who buy the wick and then watch it fall.',
            },
            {
              'text':
                  'Wait — the candle closed below ₹1,000 on normal volume. This is likely a fake breakout. Wait for a close ABOVE ₹1,000 on high volume.',
              'isCorrect': true,
              'feedback':
                  '✅ Textbook patience! A real breakout needs: (1) Close above resistance, (2) Above-average volume, (3) Ideally a retest of ₹1,000 as new support. None of these conditions were met. The smart money waits for confirmation.',
            },
            {
              'text': 'Short sell — fake breakouts often crash hard',
              'isCorrect': false,
              'feedback':
                  '❌ While fake breakouts can reverse, shorting at resistance is risky because the real breakout could still happen tomorrow. The safest approach is simply to WAIT — don\'t buy AND don\'t short. Let the market reveal its hand.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 3 Complete! 🎉',
          'keyPoints': [
            'Support and resistance are the foundation of all technical analysis',
            'Broken support → new resistance; Broken resistance → new support',
            'Real breakouts need high volume + candle close above the level',
            '60-70% of breakouts fail — patience and confirmation save you from traps',
            'The retest after a breakout is the highest-probability entry point',
            'Next: How to identify and trade with the trend — the most powerful force in markets.',
          ],
        },
      ],
    };
  }
}
