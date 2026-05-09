/// Chapter 4: Position Sizing Basics
/// How much to risk on each trade
class PositionSizingContent {
  // Lesson 4.1: The 1-2% Rule
  static Map<String, dynamic> getOneTwoPercentContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Iron Rule of Trading',
          'emoji': '📏',
          'content':
              'If you only remember one rule from this entire app, make it this one: Never risk more than 1% to 2% of your total trading capital on a single trade. This rule alone will ensure you survive your first year of trading.',
        },
        {
          'type': 'concept',
          'title': 'The Math of Survival',
          'emoji': '🛡️',
          'content': '''
**What does "Risking 1%" mean?**
It does NOT mean buying shares worth 1% of your capital.
It means if your STOP LOSS hits, the amount of money you lose equals 1% of your total capital.

**Why 1% to 2%?**
Because trading involves losing streaks. Even the best traders lose 5, 6, or 7 times in a row.

**Scenario A: Risking 10% per trade (The Amateur)**
• Capital: ₹1,00,000
• Trade 1 loses: -₹10,000 (Capital = ₹90,000)
• Trade 2 loses: -₹9,000 (Capital = ₹81,000)
• Trade 3 loses: -₹8,100 (Capital = ₹72,900)
• Trade 4 loses: -₹7,290 (Capital = ₹65,610)
• Trade 5 loses: -₹6,561 (Capital = ₹59,049)
**Result:** 5 losses wiped out 41% of the account. Panic sets in.

**Scenario B: Risking 1% per trade (The Professional)**
• Capital: ₹1,00,000
• Trade 1 loses: -₹1,000 (Capital = ₹99,000)
• Trade 2 loses: -₹990 (Capital = ₹98,010)
• Trade 3 loses: -₹980 (Capital = ₹97,030)
• Trade 4 loses: -₹970 (Capital = ₹96,060)
• Trade 5 loses: -₹960 (Capital = ₹95,100)
**Result:** 5 losses only reduced the account by 5%. Completely calm.

---

**Key Insight:**
The 1% rule guarantees you stay in the game long enough to let your edge play out. At 1% risk, it takes almost 100 consecutive losses to blow up your account — which is mathematically almost impossible.
''',
          'keyPoints': [
            'Risking 1% means if stop loss hits, you lose 1% of total capital',
            'Even professionals suffer losing streaks of 5-7 trades',
            'Risking 10% per trade leads to rapid account blowout during streaks',
            'Risking 1-2% ensures emotional calmness and mathematical survival',
          ],
        },
        {
          'type': 'story',
          'title': 'Rohit\'s Sizing Disaster',
          'emoji': '💥',
          'content': '''
**Rohit**, 27, a startup founder in Bangalore, started trading with ₹3,00,000.

He knew about the 1% rule but thought: "I have a great strategy. I'll risk 5% to grow faster."

**Week 1:** 3 winners at 5% risk each → +₹45,000. "See? 1% is for cowards."

**Week 3:** The market turned choppy. He hit a losing streak.
• Trade 1: -₹15,000 (5% of ₹3,00,000)
• Trade 2: -₹14,250 (5% of ₹2,85,000)
• Trade 3: -₹13,537 (5% of ₹2,70,750)
• Trade 4: -₹12,860 (5% of ₹2,57,213)
• Trade 5: -₹12,217 (5% of ₹2,44,353)
• Trade 6: -₹11,606 (5% of ₹2,32,136)

**6 consecutive losses = -₹79,470 (26.5% of capital gone)**

Rohit panicked. Doubled his size on Trade 7 to "recover." Lost again. -₹22,066.

**Final damage: -₹1,01,536 in 3 weeks.** Capital went from ₹3,00,000 to ₹1,98,464.

**If Rohit had risked 1%:**
Same 6 losing streak would have cost only ₹17,851 (5.9%). He would have calmly waited for his strategy to work again.

**Key lesson:** The 1% rule isn't about limiting profits. It's about SURVIVING the losing streaks that WILL come.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Your trading capital is ₹1,00,000 and you risk 2% per trade. What is the MAXIMUM amount you can lose if your stop loss is hit?',
          'options': [
            '₹500',
            '₹1,000',
            '₹2,000',
            '₹10,000',
          ],
          'correctIndex': 2,
          'explanation':
              '2% of ₹1,00,000 = ₹2,000. This is your MAXIMUM ALLOWABLE LOSS per trade. When calculating position size, you work backwards from this number: ₹2,000 ÷ (Entry - Stop Loss) = number of shares. If you cannot fit a proper position with ₹2,000 risk, the stop loss is too far — skip the trade.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'The 1-2% rule is the ultimate defense mechanism in trading',
            'Rohit lost ₹1 Lakh in 3 weeks by risking 5% — the same streak at 1% would have cost only ₹18K',
            'Capital preservation is your #1 job — profits are a byproduct',
            'Losing streaks are inevitable; the 1% rule neutralizes their impact',
            'Next: How to actually calculate the exact number of shares to buy.',
          ],
        },
      ],
    };
  }

  // Lesson 4.2: Calculating Position Size
  static Map<String, dynamic> getCalculatingSizeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Position Size Formula',
          'emoji': '🧮',
          'content':
              'Now we put the 1% rule into action. Before every trade, you must calculate exactly how many shares (or lots) to buy. Never guess this number. Use the formula.',
        },
        {
          'type': 'concept',
          'title': 'The 3-Step Formula',
          'emoji': '📝',
          'content': '''
**The Formula:**
Position Size (Quantity) = Risk Amount ÷ Trade Risk per Share

**Let's break it down into 3 steps:**

**Step 1: Calculate Risk Amount 💰**
Total Capital × 1% (or 2%)
• Capital: ₹1,00,000
• Risk Amount: ₹1,00,000 × 1% = **₹1,000**
*(If this trade hits stop loss, I will lose exactly ₹1,000)*

**Step 2: Calculate Trade Risk per Share 📉**
Entry Price - Stop Loss Price
• Entry Price: ₹500
• Stop Loss: ₹480
• Risk per share = ₹500 - ₹480 = **₹20**
*(If stop loss hits, I lose ₹20 on every single share I bought)*

**Step 3: Calculate Quantity 🔢**
Risk Amount ÷ Trade Risk per Share
• Quantity = ₹1,000 ÷ ₹20 = **50 shares**

**Verification:**
If you buy 50 shares at ₹500 and the price falls to your ₹480 stop loss...
You lose ₹20 per share.
50 shares × ₹20 = ₹1,000 loss.
Exactly 1% of your capital! Magic.

---

**Why this is powerful:**
If your stop loss was tighter (e.g., ₹490), your risk per share is only ₹10.
Quantity = ₹1,000 ÷ ₹10 = 100 shares.
You buy MORE shares when the stop is tighter, but your total risk ALWAYS remains exactly 1% (₹1,000).
''',
          'keyPoints': [
            'Step 1: Define total risk amount (1% of capital)',
            'Step 2: Find risk per share (Entry price minus Stop Loss price)',
            'Step 3: Divide Risk Amount by Risk per Share to get Quantity',
            'Tighter stop loss = larger position size; Wider stop loss = smaller position size',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Position Size Calculator',
          'emoji': '🧮',
          'content': '''
**Let's practice the formula!**

**Scenario 1: Wider Stop Loss**
• Capital: ₹5,00,000
• Max Risk: 1% (₹5,000)
• Entry: ₹1,000
• Stop Loss: ₹900 (Risk per share = ₹100)
• Quantity = ₹5,000 ÷ ₹100 = **50 shares**
• Capital deployed = 50 × ₹1,000 = ₹50,000 (10% of capital)

**Scenario 2: Tighter Stop Loss**
• Capital: ₹5,00,000
• Max Risk: 1% (₹5,000)
• Entry: ₹1,000
• Stop Loss: ₹980 (Risk per share = ₹20)
• Quantity = ₹5,000 ÷ ₹20 = **250 shares**
• Capital deployed = 250 × ₹1,000 = ₹2,50,000 (50% of capital)

**Notice the difference?**
In both trades, the maximum loss is exactly ₹5,000.
But because Trade 2 has a tighter stop, you can safely deploy 5x more capital.
**Position size is determined by STOP LOSS distance, not by conviction.**
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Your capital is ₹2,00,000. You risk 1% per trade. You want to buy a stock at ₹200. Your technical analysis says the stop loss MUST be at ₹190. How many shares should you buy?',
          'options': [
            '1,000 shares (invest the full ₹2,00,000)',
            '200 shares',
            '100 shares',
            '50 shares',
          ],
          'correctIndex': 1,
          'explanation':
              'Step 1: Risk Amount = 1% of ₹2,00,000 = ₹2,000. Step 2: Risk per share = Entry(200) - SL(190) = ₹10. Step 3: Quantity = ₹2,000 ÷ ₹10 = 200 shares. If you buy 200 shares and the stop hits, you lose exactly ₹2,000 (1% of capital).',
        },
        {
          'type': 'summary',
          'title': 'Chapter 4 Complete! 🎉',
          'keyPoints': [
            'Position Size = (Total Capital × 1%) ÷ (Entry Price - Stop Loss Price)',
            'Never guess your quantity — calculate it before every trade',
            'Position size is determined by the distance to your stop loss',
            'A wider stop loss requires a smaller quantity; a tighter stop requires a larger quantity',
            'Your total risk remains constant at 1% regardless of the stop loss distance',
            'Next: Why stop losses are non-negotiable and how to place them.',
          ],
        },
      ],
    };
  }
}
