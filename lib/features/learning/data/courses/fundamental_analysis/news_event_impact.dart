/// Chapter 5: News & Event Impact on Markets
/// Earnings, elections, wars, and sentiment shifts
class NewsEventImpactContent {
  // Lesson 5.1: Earnings Season & Corporate Events
  static Map<String, dynamic> getEarningsSeasonContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Quarterly Report Card',
          'emoji': '📋',
          'content':
              'Four times a year, every listed company reveals its quarterly results. These 2 weeks — called "earnings season" — create the biggest individual stock moves of the year. One earnings surprise can move a stock 10-20% in a single day.',
        },
        {
          'type': 'concept',
          'title': 'Earnings Season Decoded',
          'emoji': '📊',
          'content': '''
**India's Earnings Calendar:**
• **Q1 Results:** July-August (April-June quarter)
• **Q2 Results:** October-November (July-September quarter)
• **Q3 Results:** January-February (October-December quarter)
• **Q4 Results:** April-May (January-March quarter + full year)

**What Moves Stock Prices During Earnings:**

**Beat vs Miss vs In-Line:**
• **Earnings BEAT** (actual > expected): Stock rises 3-15% 📈
• **Earnings MISS** (actual < expected): Stock falls 5-20% 📉
• **In-Line** (matches expectations): Small move, focus shifts to guidance

**The Guidance is MORE Important Than the Number:**
• Company reports ₹1,000 Cr profit (beat by 5%) BUT guides for slower growth next quarter
• Stock may FALL despite the beat because guidance is weak
• **The market is always looking FORWARD, not backward**

---

**Other Corporate Events That Move Prices:**

**Dividend Announcement:** Cash to shareholders. Moderate positive.
**Stock Split:** More shares, same value. Psychological positive.
**Buyback:** Company buying its own shares. Strong positive.
**Merger/Acquisition:** Can go either way — depends on the deal.
**Management Change:** CEO exit can tank a stock if unexpected.

---

**Key Insight:**
Don't trade DURING earnings announcements — the gap up/down at open can be violent. Instead, use earnings as RESEARCH: analyze results, update your thesis, and trade AFTER the dust settles (2-3 days post-earnings).
''',
          'keyPoints': [
            'Earnings season: Q1 (Jul-Aug), Q2 (Oct-Nov), Q3 (Jan-Feb), Q4 (Apr-May)',
            'Beat expectations = rally; Miss expectations = crash; In-line = guidance matters',
            'Forward guidance is MORE important than the actual number',
            'Don\'t trade during earnings — trade 2-3 days after when volatility settles',
          ],
        },
        {
          'type': 'story',
          'title': 'Rohan\'s Earnings Trap',
          'emoji': '🪤',
          'content': '''
**Rohan**, 28, bought shares of a tech company 2 days before earnings.

**His thesis:** "Everyone knows they are having a great quarter. The stock will rocket."

**Earnings Day:** The company reports record-breaking profit (up 30%). Rohan celebrates.

**Next Morning:** The market opens. The stock **GAPS DOWN 8%** immediately. Rohan is stunned. "But the profits were amazing! Is the market rigged?"

**What really happened:**
1. "Buy the rumor, sell the news." Smart money had already bought the stock weeks ago, anticipating the good results. When the news came out, they sold to take profits.
2. The company's *forward guidance* said: "Next quarter growth will slow to 5%."
3. The market priced in the *future* 5% growth, completely ignoring the *past* 30% growth.

**Key lesson:** Holding through earnings is gambling. You are betting not just on the number, but on the *guidance* and the *market's reaction* to both. It's a triple-layered guess.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'A company reports 20% profit growth (beating expectations by 8%), but the CEO says "Next quarter will be challenging due to global slowdown." What happens to the stock?',
          'options': [
            'Rallies strongly — 20% growth and 8% beat is excellent',
            'Falls or stays flat — the weak forward guidance overshadows the good results',
            'No movement — companies always give cautious guidance',
            'Splits 50/50 — half the market buys, half sells',
          ],
          'correctIndex': 1,
          'explanation':
              'Markets are FORWARD-looking. Today\'s results are already in the past. The CEO\'s guidance about "challenging" next quarter tells investors that future earnings may decline. Stocks are priced on FUTURE expectations, so weak guidance typically causes a sell-off even after a strong quarter.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Earnings season creates the biggest stock-specific moves of the year',
            'Forward guidance matters more than the actual quarterly number',
            'Don\'t trade on earnings day — wait 2-3 days for volatility to settle',
            'Corporate events (buybacks, splits) also create trading opportunities',
            'Next: When global events override ALL fundamental and technical analysis.',
          ],
        },
      ],
    };
  }

  // Lesson 5.2: Geopolitics, Elections & Black Swans
  static Map<String, dynamic> getGeopoliticsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'When the World Explodes',
          'emoji': '🌊',
          'content':
              'COVID-19 crashed markets 40% in 30 days. Russia-Ukraine spiked oil 50%. Indian election results swing Nifty 2,000 points. Some events are so powerful they make ALL analysis — fundamental and technical — temporarily irrelevant.',
        },
        {
          'type': 'story',
          'title': 'Election Night 2024: Nifty\'s Wild Ride',
          'emoji': '🗳️',
          'content': '''
**June 4, 2024. Indian General Election results day.**

**Pre-result expectations:**
Exit polls predicted a massive BJP majority (350+ seats).
Markets were euphoric. Nifty rallied to all-time highs.

**9:00 AM: Counting begins.**
Early trends show BJP leading but not as strongly as expected.

**11:00 AM: The shock.**
BJP is below 300 seats. Coalition government becomes likely.
Nifty crashes 1,400 points (-5.9%) in 2 hours.
₹30 Lakh Crore of investor wealth wiped out in ONE morning.

**12:00 PM: Recovery begins.**
Markets realize: BJP-led NDA still has majority (even if narrower).
Nifty recovers 600 points from the low.

**By closing:**
Nifty still down 800 points. But individual stock moves were insane:
• Defense stocks: -15% to -25% (fear of policy shift)
• PSU banks: -10% to -15% (populist concerns)
• Some mid-caps: Circuit-locked at -20%

**Lesson:**
No amount of P/E analysis or RSI reading could have predicted this. Elections are binary events — the outcome is unknowable in advance. Smart traders REDUCE positions before such events. They don't gamble.
''',
        },
        {
          'type': 'concept',
          'title': 'Black Swan Events',
          'emoji': '🦢',
          'content': '''
**Black Swans = Rare, unpredictable events with massive impact.**

**Recent Black Swans:**
• **COVID-19 (2020):** Nifty fell 40% in 30 days. Nobody predicted a global pandemic.
• **9/11 (2001):** US markets closed for 4 days. Global markets crashed 10%+.
• **Demonetization (2016):** India-specific. Markets fell 6% in a week. Cash-dependent stocks cratered.
• **2008 Financial Crisis:** Nifty fell from 6,300 to 2,500 (-60%). Global banking system nearly collapsed.

**How to Survive Black Swans:**
1. **Never be 100% invested.** Keep 10-20% cash always.
2. **Diversify across assets.** Gold typically rises during crises.
3. **Use stop losses on ALL positions.** No exceptions.
4. **Don't panic sell at the bottom.** If you're diversified, you'll survive.
5. **Have a "crisis plan" written BEFORE the crisis.** Decide in advance.

---

**Key Insight:**
You can't PREDICT black swans. But you can PREPARE for them. The investors who survived 2008, 2020, and Ukraine were NOT smarter — they were better PREPARED. Preparation beats prediction every time.
''',
          'keyPoints': [
            'Black swans are rare, unpredictable events with massive market impact',
            'Elections, pandemics, and wars override ALL fundamental and technical analysis',
            'Always keep 10-20% cash — it\'s your crisis ammunition',
            'You can\'t predict black swans, but you can prepare for them',
          ],
        },
        {
          'type': 'scenario',
          'title': 'The Black Swan Decision',
          'situation':
              'You are fully invested in the market. Suddenly, news breaks that a major global conflict has started. Nifty crashes 4% in the first hour. Your portfolio is bleeding. What is your immediate action plan?',
          'choices': [
            {
              'text': 'Sell everything immediately to stop the bleeding — cash is king!',
              'isCorrect': false,
              'feedback':
                  '❌ Panic selling at the bottom of a massive gap-down is the worst thing you can do. You are selling into fear. Markets often overreact in the first 24 hours of a crisis.',
            },
            {
              'text': 'Buy the dip! Throw all your emergency cash into the market right now.',
              'isCorrect': false,
              'feedback':
                  '❌ Catching a falling knife during a black swan is extremely dangerous. The crisis might last for months. You don\'t know if this is a 5% correction or a 40% crash.',
            },
            {
              'text': 'Assess the damage, honor your pre-set stop losses, and wait for the volatility to settle before making major portfolio changes.',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect. You don\'t panic sell, but you also don\'t blindly buy. If individual stocks hit their technical stop losses, let them trigger (that\'s what they are for). For long-term holdings, wait for the emotional panic to subside (usually 2-3 days) before deciding if the fundamental thesis has changed.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 5 Complete! 🎉',
          'keyPoints': [
            'Earnings season creates stock-specific moves; geopolitics moves everything',
            'Elections are binary events — reduce positions, don\'t gamble',
            'Black swans (COVID, wars) make all analysis temporarily irrelevant',
            'Always keep cash, diversify, and have a crisis plan written in advance',
            'Preparation > Prediction — the best investors are the best prepared',
            'Next: How to evaluate crypto projects using fundamentals.',
          ],
        },
      ],
    };
  }
}
