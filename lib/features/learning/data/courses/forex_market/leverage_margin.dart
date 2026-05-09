/// Chapter 7: Leverage & Margin Basics
/// The most dangerous tool in forex — understand it or lose
class LeverageMarginContent {
  // Lesson 7.1: What is Leverage?
  static Map<String, dynamic> getWhatIsLeverageContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Double-Edged Sword',
          'emoji': '⚔️',
          'content':
              'Imagine you could control ₹10 Lakhs with just ₹10,000. Sounds like a superpower? It is — but the same superpower that can make you 100% in a day can also wipe you out completely. This is leverage.',
        },
        {
          'type': 'story',
          'title': 'Rohan\'s 100x Nightmare',
          'emoji': '💀',
          'content': '''
**Rohan**, 26, a software developer in Bangalore, opens a forex account with an offshore broker.

**The Temptation:**
The broker offers 100x leverage. Rohan deposits ₹50,000.
With 100x leverage, he can control ₹50,00,000 (₹50 Lakhs!) worth of currency.

**The Trade:**
Rohan BUYs EUR/USD at 1.1000 with his full ₹50 Lakh position.
"If EUR/USD goes up just 1%, I'll make ₹50,000 — I'll DOUBLE my account!"

**The Reality:**
EUR/USD drops 0.5% (just 50 pips). A tiny move in the real world.
• Loss on ₹50 Lakh position: ₹25,000
• Rohan's account: ₹50,000 - ₹25,000 = ₹25,000

**EUR/USD drops another 0.5%:**
• Additional loss: ₹25,000
• Rohan's account: ₹0
• **MARGIN CALL. Account liquidated. ₹50,000 gone in hours.**

**What Happened:**
A 1% move against Rohan = 100% loss because of 100x leverage.
Without leverage, the same move would have cost him ₹500 (1% of ₹50,000).

**Lesson:**
Leverage doesn't increase your profit potential — it increases your RISK. A 1% move with 100x leverage is the same as a 100% move without leverage. The math is brutal.
''',
        },
        {
          'type': 'concept',
          'title': 'How Leverage Works',
          'emoji': '🔢',
          'content': '''
**Leverage = Borrowing money from your broker to trade bigger.**

**The Math:**
• Your money: ₹1,00,000
• Leverage: 50x
• Position you control: ₹1,00,000 × 50 = ₹50,00,000

**What "50x Leverage" Really Means:**
You put up 2% of the total position. The broker "lends" the other 98%.
• Your ₹1L is the **margin** (collateral/security deposit).
• The broker lends ₹49L.
• If the trade goes well, you keep all the profits.
• If the trade goes badly, you lose your margin FIRST.

**Leverage Comparison:**
• **No leverage (1x):** ₹1L controls ₹1L. 1% move = ₹1,000 gain/loss.
• **10x leverage:** ₹1L controls ₹10L. 1% move = ₹10,000.
• **50x leverage:** ₹1L controls ₹50L. 1% move = ₹50,000.
• **100x leverage:** ₹1L controls ₹1Cr. 1% move = ₹1,00,000. 🔥

**At 100x:** A 1% move against you = your ENTIRE account. Gone.

---

**Key Insight:**
Professional forex traders rarely use more than 5-10x leverage. The 50x-500x offered by brokers is designed to make you trade bigger (and blow up faster). The broker profits from your trading volume — they WANT you to use high leverage.
''',
          'keyPoints': [
            'Leverage = borrowing from broker to control larger positions',
            'Margin = your collateral (security deposit) for the leveraged position',
            '100x leverage means 1% move against you = 100% loss',
            'Professionals rarely exceed 5-10x leverage — ignore broker marketing',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You have ₹1,00,000 and use 50x leverage. How much does the market need to move against you to lose everything?',
          'options': [
            '50% — half the market value',
            '10% — a significant correction',
            '2% — a normal daily fluctuation',
            '0.1% — barely anything',
          ],
          'correctIndex': 2,
          'explanation':
              'With 50x leverage, a 2% move against your position = 100% of your capital. In forex, 2% moves happen regularly. This is why high leverage is so dangerous — normal market fluctuations become account-destroying events.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Leverage lets you control large positions with small capital — but amplifies losses equally',
            'At 100x leverage, a 1% adverse move wipes out your entire account',
            'Professional traders use 5-10x max — brokers offer 100x+ to increase their fee revenue',
            'The higher the leverage, the smaller the margin for error',
            'Next: What happens when your losses exceed your margin? The dreaded margin call.',
          ],
        },
      ],
    };
  }

  // Lesson 7.2: Margin Calls & Liquidation
  static Map<String, dynamic> getMarginCallsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Phone Call Nobody Wants',
          'emoji': '📞',
          'content':
              'In the old days, brokers would literally call you: "Sir, deposit more money or we close your trades." Today, algorithms do it automatically — and much faster. By the time you see the notification, your money may already be gone.',
        },
        {
          'type': 'concept',
          'title': 'Margin Call Explained',
          'emoji': '🚨',
          'content': '''
**Key Terms:**

**Used Margin:** The amount locked as collateral for your open positions.
**Free Margin:** Account balance minus used margin. This is your "safety buffer."
**Margin Level:** (Account Equity / Used Margin) × 100%

**The Danger Zones:**

**Margin Level > 200%:** ✅ Safe. Plenty of buffer.
**Margin Level 100-200%:** ⚠️ Warning. Reduce positions or add funds.
**Margin Level < 100%:** 🚨 **MARGIN CALL!** Broker warns you to deposit more.
**Margin Level < 50%:** 💀 **STOP OUT!** Broker FORCEFULLY closes your trades.

**Example:**
• Account: ₹1,00,000
• You open a position requiring ₹50,000 margin
• Free Margin: ₹50,000 | Margin Level: 200% ✅
• Trade goes against you, losing ₹30,000
• Account Equity: ₹70,000 | Margin Level: 140% ⚠️
• Trade loses another ₹30,000
• Account Equity: ₹40,000 | Margin Level: 80% 🚨 MARGIN CALL!
• If you don't deposit more, broker starts closing your positions automatically.

---

**Key Insight:**
Margin calls are not suggestions — they're warnings before forced liquidation. The broker will close your trades at the WORST possible price to protect themselves. You bear all the loss.
''',
          'keyPoints': [
            'Margin Level = (Equity / Used Margin) × 100%',
            'Below 100% = Margin Call. Below 50% = Forced liquidation.',
            'Brokers close YOUR trades at the worst possible time to protect themselves',
            'Free margin is your safety buffer — never let it shrink to zero',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Leverage vs Margin Call Speed',
          'emoji': '⏱️',
          'content': '''
**How fast can you get margin called?**

**Scenario: ₹1,00,000 account, 80-pip adverse move on USD/INR**

**At 10x Leverage (Conservative):**
• Position: ₹10 Lakhs (10 lots)
• Loss: 80 pips × ₹10 = ₹800
• Remaining: ₹99,200
• Margin Level: Still very safe ✅

**At 50x Leverage (Moderate):**
• Position: ₹50 Lakhs (50 lots)
• Loss: 80 pips × ₹50 = ₹4,000
• Remaining: ₹96,000
• Margin Level: Comfortable ✅

**At 200x Leverage (Reckless):**
• Position: ₹2 Crore (200 lots)
• Loss: 80 pips × ₹200 = ₹16,000
• Remaining: ₹84,000
• One bad day (200 pips): ₹40,000 loss → Margin Call zone 🚨

**At 500x Leverage (Suicidal):**
• Position: ₹5 Crore (500 lots)
• Loss: 80 pips × ₹500 = ₹40,000
• **One normal move wipes 40% of your account.** 💀

**Key Lesson:**
Higher leverage doesn't make you richer — it makes you margin-called faster. Professional traders survive because they trade SMALL relative to their account.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Margin Call',
          'situation':
              'It\'s 2 AM. You wake up to a notification: "MARGIN CALL — deposit ₹30,000 within 4 hours or positions will be liquidated." You have a losing EUR/USD trade open. What do you do?',
          'choices': [
            {
              'text':
                  'Deposit ₹30,000 immediately to keep the trade alive — it will recover!',
              'isCorrect': false,
              'feedback':
                  '❌ This is "throwing good money after bad." If the trade has moved far enough to trigger a margin call, your analysis was wrong. Adding more money just means more money at risk. Professional traders never add to a losing position.',
            },
            {
              'text':
                  'Let the broker close the position — accept the loss and learn from the mistake',
              'isCorrect': true,
              'feedback':
                  '✅ Painful but correct. The margin call means the trade has moved significantly against you. Accept the loss, review what went wrong, and reduce position size next time. A controlled loss is better than a total wipeout.',
            },
            {
              'text':
                  'Deposit ₹30,000 AND open another position in the opposite direction to hedge',
              'isCorrect': false,
              'feedback':
                  '❌ This is a panic reaction, not a strategy. Hedging a losing trade at 2 AM during a margin call creates more complexity and more risk. The simplest answer is often the best: accept the loss.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 7 Complete! 🎉',
          'keyPoints': [
            'Leverage amplifies both profits AND losses equally',
            'Margin calls happen when your equity drops below the required margin level',
            'Stop Out = broker forcefully closes your trades at the worst possible price',
            'Higher leverage = faster margin call — not higher profits',
            'NEVER deposit more money to "save" a margin-called trade',
            'Next: The full spectrum of forex risks — and how to protect yourself.',
          ],
        },
      ],
    };
  }
}
