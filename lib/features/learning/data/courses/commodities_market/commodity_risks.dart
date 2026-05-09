/// Chapter 7: Risks in Commodity Trading
/// Unique dangers of trading physical assets
class CommodityRisksContent {
  // Lesson 7.1: The Six Commodity Risks
  static Map<String, dynamic> getSixRisksContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Risks That Don\'t Exist in Stocks',
          'emoji': '⚠️',
          'content':
              'Commodity trading carries all the risks of stock trading PLUS unique risks that come from dealing with physical goods, leverage, and global geopolitics. Let\'s identify each one so you can protect yourself.',
        },
        {
          'type': 'concept',
          'title': 'The Six Commodity-Specific Risks',
          'emoji': '🎯',
          'content': '''
**1. Leverage Risk ⚔️**
MCX margin is 5-15% of contract value = 7-20x leverage.
A 5% gold move on 15x leverage = 75% of your margin gone.
Most stock traders aren't prepared for this level of amplification.

**2. Expiry & Rollover Risk ⏰**
Commodity contracts expire monthly/bi-monthly.
If you forget to close or roll over, you face physical delivery.
Rolling over (closing current, opening next month) costs money (spread + slippage).

**3. Gap Risk (Overnight & Weekend) 🌙**
MCX closes at 11:30 PM but global markets (COMEX, NYMEX) continue trading.
Gold can move ₹500-1,000 while MCX is closed. You open to an instant loss.

**4. Physical Delivery Risk 📦**
If you hold to expiry, you may receive (or have to deliver) the physical commodity.
Getting 30 kg of silver delivered to your demat account is not fun.

**5. Geopolitical Risk 🌍**
Unlike stocks (company-level risk), commodities are exposed to COUNTRY-level risk.
A war, sanction, or coup in a major producer can move prices 20%+ overnight.

**6. Liquidity Risk 💧**
Not all commodity contracts have deep liquidity.
Far-month contracts or niche commodities may have wide spreads and poor execution.

---

**Key Insight:**
The combination of leverage + overnight gaps + geopolitical shocks makes commodity trading riskier than stock trading. The same ₹1,00,000 account faces dramatically different risk profiles in stocks vs commodities.
''',
          'keyPoints': [
            'Leverage on MCX is 7-20x — small price moves cause large P&L swings',
            'Contracts expire — forgetting to close can trigger physical delivery',
            'Overnight gaps from global markets can create instant losses at open',
            'Geopolitical events affect entire commodity classes, not just one company',
          ],
        },
        {
          'type': 'story',
          'title': 'Vikram\'s Crude Oil Disaster',
          'emoji': '💀',
          'content': '''
**Vikram**, 35, a successful stock trader in Pune, decided to try commodity trading.

"I've been profitable in Nifty for 2 years. Commodities can't be that different."

**The Setup:**
• Vikram BUYs 2 lots of MCX Crude Oil at ₹5,800/barrel
• Margin used: ₹1,60,000 (from his ₹3 Lakh commodity account)
• "Oil is going up. Biden will sanction Russia more."

**10:30 PM: Vikram Goes to Sleep.**
MCX closes at 11:30 PM. He places no stop loss.
"I'll check in the morning."

**While Vikram Slept:**
• OPEC announced a surprise production INCREASE at 2 AM (not the expected cut)
• WTI Crude dropped 4% on NYMEX (US exchange)

**9:00 AM: MCX Opens.**
• Crude opens at ₹5,570 (₹230 below Vikram's entry)
• Loss: ₹230 × 100 barrels × 2 lots = ₹46,000 — instantly, at market open
• No stop loss could have helped — the gap happened while MCX was closed

**Vikram's Mistake:**
He treated commodity trading like stock trading. But stocks have circuit breakers and trade only 6 hours. Commodities gap based on 24-hour global markets. Different rules.

**Lesson:**
Commodity markets never truly "close." Global trading continues while MCX is shut. Always reduce position size overnight or use global brokers for after-hours hedging.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You hold a Gold futures position on MCX. Gold moves ₹800/10g on COMEX (international) at 3 AM while MCX is closed. When MCX opens at 9 AM, what happens?',
          'options': [
            'Nothing — MCX prices are independent of COMEX',
            'MCX Gold opens ₹800 higher/lower — reflecting the overnight COMEX move (gap)',
            'MCX will slowly adjust over the day, not immediately',
            'Your stop loss will protect you at your exact price',
          ],
          'correctIndex': 1,
          'explanation':
              'MCX Gold prices closely track COMEX. When COMEX moves ₹800 overnight, MCX opens at the adjusted price — creating a "gap." Your stop loss at ₹62,500 is useless if MCX opens at ₹61,700. This overnight gap risk is the #1 reason to reduce positions before market close.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Six commodity risks: leverage, expiry, gaps, delivery, geopolitics, liquidity',
            'Overnight gaps from global markets are the most dangerous unique risk',
            'Stock trading skills don\'t automatically transfer — different rules apply',
            'Always reduce position size before MCX close or set wider stop losses',
            'Next: How to manage these risks with a practical toolkit.',
          ],
        },
      ],
    };
  }

  // Lesson 7.2: Risk Management for Commodities
  static Map<String, dynamic> getRiskManagementContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Survival Rules',
          'emoji': '🛡️',
          'content':
              'Commodity markets are unforgiving. But with proper risk management, you can participate in this ₹20 trillion market without losing your shirt. Here are the rules professionals follow.',
        },
        {
          'type': 'concept',
          'title': 'The Commodity Trader\'s Toolkit',
          'emoji': '🧰',
          'content': '''
**Rule 1: The 2% Rule 🎯**
Never risk more than 2% of your commodity account on a single trade.
• Account: ₹3,00,000
• Max risk per trade: ₹6,000
• With Gold Mini (₹100/10g pip value), that's a 60-pip stop loss

**Rule 2: Reduce Before Close 🌙**
MCX closes at 11:30 PM but global markets continue.
Either close positions before 11 PM, or accept overnight gap risk.
Professional rule: Reduce to half position before close.

**Rule 3: Track Contract Expiry 📅**
Set calendar alerts for expiry dates.
Roll over (close current, open next month) at least 3-5 days before expiry.
Last-day liquidity is thin and spreads widen.

**Rule 4: Never Use Full Margin 💰**
If you have ₹3L and margin is ₹50K per Gold Mini lot, DON'T open 6 lots.
Keep at least 50% of your account as free margin (buffer for adverse moves).
Max 2-3 lots = ₹1-1.5L used, ₹1.5-2L buffer.

**Rule 5: Hedge When Possible 🔄**
If you're long gold, consider a small short position in silver (correlated but not identical).
If you're long crude, watch the Dollar — a rising Dollar can offset your trade.

---

**Key Insight:**
The professionals who survive decades in commodities are NOT the ones with the best predictions. They're the ones with the strictest risk management. Prediction is a guess. Risk management is a system.
''',
          'keyPoints': [
            '2% rule: max risk per trade to preserve capital through losing streaks',
            'Reduce positions before MCX close to avoid overnight gap risk',
            'Roll over contracts 3-5 days before expiry — avoid last-day chaos',
            'Keep 50% of account as free margin — buffer against adverse moves',
          ],
        },
        {
          'type': 'scenario',
          'title': 'Risk Management Decision',
          'situation':
              'You have ₹5,00,000 in your commodity account. You\'re holding 3 lots of Gold Mini (margin used: ₹1,50,000). Gold is up ₹300/10g in your favor. It\'s 10:45 PM and MCX closes in 45 minutes. US Non-Farm Payrolls data releases at 6:30 PM tomorrow (US time = after MCX opens). What do you do?',
          'choices': [
            {
              'text':
                  'Hold all 3 lots — you\'re in profit and NFP might push gold higher',
              'isCorrect': false,
              'feedback':
                  '❌ NFP data is the single most volatile event for gold. It can move gold ₹500-1,000 in minutes. Holding full position into high-impact data is gambling, not trading. The overnight gap risk alone could wipe your ₹300 profit and more.',
            },
            {
              'text':
                  'Close 2 lots (take profit), keep 1 lot with reduced risk exposure',
              'isCorrect': true,
              'feedback':
                  '✅ Professional approach! You lock in ₹20,000 profit (2 lots × ₹300 × 10) and maintain reduced exposure. If NFP moves gold in your favor, 1 lot captures upside. If it moves against you, only 1 lot takes the hit instead of 3.',
            },
            {
              'text': 'Close all 3 lots and re-enter tomorrow after NFP',
              'isCorrect': true,
              'feedback':
                  '✅ Also excellent! Booking ₹30,000 profit (3 lots × ₹300 × 10) and eliminating all risk is the safest play. You can always re-enter after NFP when the dust settles and direction is clearer.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 7 Complete! 🎉',
          'keyPoints': [
            'Six unique commodity risks: leverage, expiry, gaps, delivery, geopolitics, liquidity',
            'Overnight gap risk is the biggest danger — reduce before MCX close',
            'The 2% rule and 50% free margin rule keep you alive through losing streaks',
            'Roll over contracts early — don\'t wait until the last day',
            'Prediction is a guess; risk management is a system — trust the system',
            'Next: The final chapter — is commodity trading right for you?',
          ],
        },
      ],
    };
  }
}
