/// Chapter 7: Volatility & Crypto-Specific Risks
/// The dangers that are unique to cryptocurrency
class VolatilityAndRisksContent {
  // Lesson 7.1: Why Crypto is So Volatile
  static Map<String, dynamic> getWhyVolatileContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Wild Roller Coaster',
          'emoji': '🎢',
          'content':
              'Bitcoin dropped 50% in May 2021. Then it doubled by November. Then crashed 65% again by June 2022. Why does crypto swing so wildly? And how do you survive it?',
        },
        {
          'type': 'story',
          'title': 'Deepak\'s Emotional Roller Coaster',
          'emoji': '😰',
          'content': '''
**Deepak**, 29, a marketing manager in Delhi, bought Bitcoin in April 2021 at ₹45 Lakhs.

**April-May 2021:**
Bitcoin rises to ₹50 Lakhs. Deepak is thrilled.
"I'm a genius! I should quit my job and trade full-time!"

**May 19, 2021 (The Crash):**
Elon Musk tweets that Tesla won't accept Bitcoin anymore.
China announces a mining ban.
Bitcoin crashes from ₹50L → ₹25L **in one week**. 📉

Deepak's ₹3 Lakh investment is now ₹1.5 Lakhs.
He can't sleep. Checks his phone every 10 minutes.
His hands literally shake when he opens the app.

**Deepak's Mistake:**
He panic-sells at ₹25L. Locks in a 50% loss.

**What Happened Next:**
Bitcoin climbs back to ₹50L by November 2021.
If Deepak had held, he'd have broken even.
Instead, he lost ₹1.5 Lakhs AND the recovery.

**Lesson:**
Volatility isn't the enemy. Your emotional reaction to volatility is the enemy. If you can't watch your portfolio drop 50% without panicking, crypto is not for you — yet.
''',
        },
        {
          'type': 'concept',
          'title': 'Five Reasons Crypto is So Volatile',
          'emoji': '📊',
          'content': '''
**1. Small Market (Compared to Stocks) 🐟**
Global stock market: ₹800 Lakh Crore.
Total crypto market: ₹150 Lakh Crore.
Crypto is 5x smaller. A ₹10,000 Crore trade barely moves stocks. The same amount in crypto causes earthquakes.

**2. 24/7 Trading 🌍**
Stocks trade 6.5 hours/day, 5 days/week.
Crypto trades 24 hours/day, 365 days/year.
Bad news at 3 AM? No circuit breakers. No cooling-off period. Panic sells immediately.

**3. Whale Manipulation 🐋**
Top 100 Bitcoin wallets hold ~15% of all BTC.
When a "whale" sells ₹5,000 Crore at once, the price tanks.
Small retail traders get crushed.

**4. Sentiment-Driven (Not Earnings-Driven) 💬**
Stocks have quarterly earnings, dividends, and cash flows.
Crypto has... tweets. When Elon Musk posts a meme, Bitcoin moves 10%.

**5. No Circuit Breakers ⚡**
Indian stock exchanges halt trading if Nifty drops 10%. This prevents crashes from spiraling.
Crypto has NO such safety net. Drops of 30-50% happen in hours.

---

**Key Insight:**
Volatility is the price you pay for potentially higher returns. If crypto were stable, it wouldn't offer the upside that attracts investors. Understand this tradeoff before investing.
''',
          'keyPoints': [
            'Crypto market is 5x smaller than stocks — easier to move prices',
            '24/7 trading means no breaks during panic — crashes can be brutal',
            'Whales (large holders) can manipulate prices significantly',
            'No circuit breakers or regulatory safety nets in crypto',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Bitcoin drops 30% overnight because of a tweet from a celebrity. Stocks never crash this hard from a tweet. What\'s the key structural reason?',
          'options': [
            'Bitcoin is a scam and stocks are not',
            'The crypto market is much smaller and trades 24/7 without circuit breakers — making it more susceptible to sentiment-driven moves',
            'The government protects stock investors but not crypto investors',
            'Bitcoin has no real value, so any tweet can destroy it',
          ],
          'correctIndex': 1,
          'explanation':
              'The crypto market is structurally different: smaller size means less liquidity to absorb large sells, 24/7 trading means panic can cascade without breaks, and no circuit breakers mean there\'s no automatic halt when prices drop too fast. These structural factors, not the "quality" of the asset, cause the extreme volatility.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Crypto is volatile because of small market size, 24/7 trading, and no circuit breakers',
            'Emotional reactions to volatility (panic selling) cause more losses than the crashes themselves',
            'Whale manipulation is real — top holders can move markets significantly',
            'Volatility is the COST of potentially higher returns — not a bug, a feature',
            'Next: Beyond volatility — the scams, hacks, and frauds that can wipe you out.',
          ],
        },
      ],
    };
  }

  // Lesson 7.2: Scams, Hacks & Rug Pulls
  static Map<String, dynamic> getScamsHacksContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Dark Side of Crypto',
          'emoji': '🚨',
          'content':
              'In 2022 alone, over ₹25,000 Crore was stolen through crypto scams and hacks worldwide. From fake tokens to Ponzi schemes, the crypto space is a minefield for the uninformed. Let\'s learn to spot the traps.',
        },
        {
          'type': 'concept',
          'title': 'Types of Crypto Scams',
          'emoji': '🕵️',
          'content': '''
**1. Rug Pull 🧶**
Developers create a new token, hype it on social media, attract investors, then drain all the money and disappear.
• Token launches at ₹1 → Influencers pump it to ₹10 → Developers sell everything → Price crashes to ₹0.
• **Red Flag:** Anonymous team, no audit, locked liquidity claims that can be removed.

**2. Ponzi/Pyramid Schemes 🔺**
"Deposit 1 BTC, earn 10% weekly — guaranteed!"
Early investors are paid with new investors' money. Works until new money stops flowing in.
• **Example:** BitConnect (2018) — ₹19,000 Crore lost globally.

**3. Phishing Attacks 🎣**
Fake websites/emails that look identical to real wallets or exchanges.
You enter your seed phrase → Hacker empties your wallet in seconds.
• **Example:** Fake MetaMask websites that appear in Google ads.

**4. Pump & Dump Groups 📱**
Telegram groups with 50,000+ members. Admin says: "Buy XYZ token at 3 PM." Price pumps 200%. Admin dumps. Members lose money.
• **Reality:** The admin bought hours before and sells INTO your buying.

---

**Key Insight:**
If someone is giving you a "guaranteed" return or telling you to "buy NOW before it's too late," you are the product, not the customer. Urgency and guaranteed returns are the two biggest scam indicators.
''',
          'keyPoints': [
            'Rug pulls: team creates token, hypes it, drains money, disappears',
            'Ponzi schemes: pay old investors with new investors\' money',
            'Phishing: fake websites steal your seed phrase',
            'Pump & dump: Telegram groups manipulate prices for admin profit',
          ],
        },
        {
          'type': 'story',
          'title': 'Neha\'s Telegram Nightmare',
          'emoji': '📱',
          'content': '''
**Neha**, a 26-year-old teacher in Jaipur, joined a "VIP Crypto Signals" Telegram group.

**The Pitch:**
"Our AI-powered signals have 95% accuracy! Join our premium group for ₹5,000."
"Last week's pick gave 300% returns!"

**The Trap:**
• Day 1: Admin says "Buy XYZTOKEN now!" Neha buys ₹10,000 worth.
• Price pumps 150% in 2 hours. Neha is thrilled. "This really works!"
• Day 3: Admin says "Buy ABCTOKEN now!" Neha goes bigger — ₹25,000.
• Price pumps 50%... then CRASHES 80% in 10 minutes.

**What Actually Happened:**
The admin bought ABCTOKEN hours before. When 10,000 group members bought at his signal, the price pumped. He sold INTO their buying. The members were his exit liquidity.

**Neha's Loss:**
₹5,000 (membership) + ₹25,000 (ABCTOKEN loss) = ₹30,000 gone.

**Lesson:**
If a "guru" can really make 300% returns consistently, why do they need your ₹5,000 membership fee? The membership fees ARE their business model, not trading.
''',
        },
        {
          'type': 'scenario',
          'title': 'Spot the Scam',
          'situation':
              'You discover a new token called "IndiaFinance." It promises to "revolutionize Indian banking." The website looks professional. It offers 50% APY for staking. The team is anonymous. There is no audit report. What do you do?',
          'choices': [
            {
              'text':
                  'Invest ₹50,000 — the website looks professional and the APY is amazing',
              'isCorrect': false,
              'feedback':
                  '❌ DANGER! Every red flag is present: anonymous team, no audit, unrealistic yields. Professional websites cost ₹10,000 to build — scammers invest in appearance. 50% APY is unsustainable without extreme risk.',
            },
            {
              'text':
                  'Walk away — anonymous team + no audit + 50% APY = classic rug pull indicators',
              'isCorrect': true,
              'feedback':
                  '✅ Excellent! You spotted all three red flags: (1) Anonymous team = no accountability, (2) No audit = code could have backdoors, (3) 50% APY = unsustainable/Ponzi. Walking away from "opportunities" is the most profitable skill in crypto.',
            },
            {
              'text': 'Invest ₹1,000 as a test — if it works, add more later',
              'isCorrect': false,
              'feedback':
                  '❌ Even "testing" gives the scam legitimacy in your mind. Rug pulls often work for weeks before disappearing. Your ₹1,000 "test" succeeding doesn\'t mean ₹50,000 is safe. The scam is designed to work initially.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Rug pulls, Ponzi schemes, phishing, and pump & dumps are the four major crypto scams',
            'Red flags: anonymous team, no audit, guaranteed returns, urgency to buy NOW',
            '"If it sounds too good to be true, it IS" — especially in crypto',
            'Telegram signal groups profit from YOUR buying, not from trading',
            'Next: How to actually manage risk and survive the crypto market long-term.',
          ],
        },
      ],
    };
  }

  // Lesson 7.3: Risk Management for Crypto
  static Map<String, dynamic> getRiskManagementContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Survival Guide',
          'emoji': '🛡️',
          'content':
              'The crypto market will try to take your money. Through crashes, scams, hacks, and your own emotions. Here are the rules that separate survivors from casualties.',
        },
        {
          'type': 'concept',
          'title': 'The 5 Rules of Crypto Survival',
          'emoji': '📋',
          'content': '''
**Rule 1: Only Invest What You Can Lose 💰**
Crypto can drop 80%. If losing that money would affect your rent, food, or EMI — DON'T invest it.
**Guideline:** Maximum 5-10% of your total investment portfolio.

**Rule 2: Diversify Across Assets 🧺**
Don't put everything in one coin.
• **Safe:** BTC (50%) + ETH (30%) + Stablecoins (20%)
• **Moderate:** BTC (40%) + ETH (25%) + Top 10 Alts (25%) + Cash (10%)
• **Risky:** Random altcoins (you'll probably lose money)

**Rule 3: DCA (Dollar-Cost Averaging) 📅**
Don't buy ₹1 Lakh of BTC at once. Buy ₹10,000 every month for 10 months.
This smooths out volatility. You buy some at highs, some at lows — averaging out.

**Rule 4: Set Exit Rules BEFORE You Buy 🚪**
"I'll sell 50% if it doubles. I'll sell everything if it drops 30%."
Write this down BEFORE buying. Emotions will cloud your judgment later.

**Rule 5: Secure Your Assets 🔒**
• Use hardware wallets for holdings > ₹50,000
• Enable 2FA on all exchange accounts
• Never share your seed phrase with ANYONE

---

**Key Insight:**
Risk management isn't exciting. It won't make you rich overnight. But it will keep you in the game long enough for your good decisions to compound.
''',
          'keyPoints': [
            'Never invest more than 5-10% of your portfolio in crypto',
            'DCA (buy monthly) beats trying to time the market',
            'Set exit rules BEFORE buying — writing them down prevents emotional decisions',
            'Security is non-negotiable — hardware wallet + 2FA + seed phrase safety',
          ],
        },
        {
          'type': 'interactive',
          'title': 'DCA vs Lump Sum: The Math',
          'emoji': '📊',
          'content': '''
**Scenario: Investing ₹60,000 in Bitcoin over 6 months.**

**Lump Sum Amit:**
Buys ₹60,000 of BTC at ₹50 Lakhs in January.

**DCA Priya:**
Buys ₹10,000 of BTC every month for 6 months.

**BTC Price Over 6 Months:**
• Jan: ₹50L → Feb: ₹40L → Mar: ₹35L → Apr: ₹42L → May: ₹48L → Jun: ₹52L

**Amit's Result:**
Bought at ₹50L. Now worth ₹52L.
**Return: +4%** (₹62,400)

**Priya's Result (DCA):**
• Jan: ₹10K at ₹50L (0.002 BTC)
• Feb: ₹10K at ₹40L (0.0025 BTC)
• Mar: ₹10K at ₹35L (0.00286 BTC)
• Apr: ₹10K at ₹42L (0.00238 BTC)
• May: ₹10K at ₹48L (0.00208 BTC)
• Jun: ₹10K at ₹52L (0.00192 BTC)
Total: 0.01374 BTC × ₹52L = ₹71,448
**Return: +19%** (₹71,448)

**Key Lesson:**
DCA gave Priya +19% vs Amit's +4% because she bought MORE when prices were LOW. DCA automatically buys the dips for you!
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You bought BTC at ₹50 Lakhs. It drops to ₹35 Lakhs (-30%). You had set a rule: "Sell if it drops 30%." What do you do?',
          'options': [
            'Hold and hope — it might come back',
            'Follow your pre-set rule and sell, even though it hurts',
            'Buy more to "average down"',
            'Ignore the rule — you know better now',
          ],
          'correctIndex': 1,
          'explanation':
              'Discipline is the hardest part of investing. You set the rule when you were thinking clearly. Now emotions are clouding your judgment. Following pre-set rules is what separates professionals from amateurs. The rule might cause a small loss now, but it prevents a catastrophic one later.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 7 Complete! 🎉',
          'keyPoints': [
            'Crypto volatility is structural — 50% drops are normal, not exceptional',
            'Scams (rug pulls, phishing, pump & dumps) are rampant — stay vigilant',
            'DCA beats lump-sum investing by automatically buying more at lower prices',
            'Set exit rules BEFORE you buy — discipline beats emotion every time',
            'Never invest more than 5-10% of your total portfolio in crypto',
            'Next: The final question — is crypto right for YOU?',
          ],
        },
      ],
    };
  }
}
