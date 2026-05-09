/// Chapter 5: Maintaining a Trade Journal
/// Your personal trading database
class MaintainingJournalContent {
  // Lesson 5.1: Setting Up the Journal
  static Map<String, dynamic> getSettingUpJournalContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Professional\'s Secret',
          'emoji': '📓',
          'content':
              'Amateurs trade, close the app, and hope for a better tomorrow. Professionals trade, open their spreadsheet, log the data, and guarantee a better tomorrow. The journal is what separates gamblers from business owners.',
        },
        {
          'type': 'story',
          'title': 'Deepa\'s ₹47,000 Discovery',
          'emoji': '💡',
          'content': '''
**Deepa**, 29, a product manager in Mumbai, had been trading for 4 months. She was net negative — down about ₹15,000. She thought her strategy was bad and was about to quit.

Then she started journaling. For the next 2 months, she logged every trade with emotions and rules.

**What the journal revealed after 60 trades:**
• Her "Calm" trades: **62% win rate, net +₹47,000**
• Her "FOMO" trades: **18% win rate, net -₹38,000**
• Her "Revenge" trades: **0% win rate, net -₹24,000**

**The revelation:**
Her strategy was FINE. It had a positive expectancy when executed calmly. The ENTIRE reason she was losing money was because of 22 emotional trades that she shouldn't have taken.

**Deepa's response:**
She created a simple rule: "Before every trade, I write down my current emotion. If it's anything other than Calm/Neutral, I close TradingView."

**Month 7:** +₹18,000. Her first profitable month.

**Key lesson:** Without the journal, Deepa would have quit trading forever, blaming her strategy. The journal proved her strategy worked — SHE was the problem.
''',
        },
        {
          'type': 'concept',
          'title': 'The Data You Must Collect',
          'emoji': '📊',
          'content': '''
**A trading journal is not a diary. It is a database.**
Whether you use Excel, Google Sheets, or Notion, your journal MUST contain these columns for every single trade:

**The Mechanics (The Math):**
• Date & Time (When did I enter?)
• Asset (Stock/Crypto ticker)
• Direction (Long/Buy or Short/Sell)
• Setup Name (e.g., "Bullish Engulfing at Support")
• Entry Price
• Stop Loss Price (Initial)
• Target Price (Initial)
• Risk:Reward Ratio
• Position Size (Quantity)
• Exit Price
• P&L (Profit/Loss Amount)

**The Process (The Psychology):**
• **Did I follow my rules?** (Yes/No)
• **Pre-Trade Emotion:** (Calm, FOMO, Anxious, Bored)
• **Management:** (Hit Target, Hit Stop, Exited Early manually)
• **Screenshot Link:** (A link to an image of the chart at the time of entry)

---

**Why this specific data?**
If you only log P&L, you know IF you are losing money, but you don't know WHY.
By logging setups, time, and rules, you can query your database later:
"Show me all trades where I felt FOMO." (Usually 100% losers).
"Show me all trades taken after 2:00 PM." (Usually choppy).
''',
          'keyPoints': [
            'A journal is a database of your trading business, not a diary',
            'Track mechanical data (prices, R:R, size) AND process data (rules, emotions)',
            'Include a screenshot of the chart for every entry',
            'The data allows you to find statistical patterns in your own behavior',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Sample Journal Entry',
          'emoji': '📝',
          'content': '''
**Here is a real journal entry from a professional swing trader:**

| Field | Entry |
|-------|-------|
| **Date** | April 15, 2026, 9:45 AM |
| **Asset** | Reliance (NSE) |
| **Direction** | Long (Buy) |
| **Setup** | Bullish Engulfing at 200 EMA support |
| **Entry Price** | ₹2,845 |
| **Stop Loss** | ₹2,790 (₹55 risk) |
| **Target** | ₹2,955 (₹110 reward) |
| **R:R** | 1:2 |
| **Position Size** | 18 shares (₹990 risk = 1% of ₹99,000) |
| **Pre-Trade Emotion** | Calm ✅ |
| **Rule Followed?** | Yes ✅ |
| **Exit Price** | ₹2,955 (Hit target) |
| **P&L** | +₹1,980 |
| **Execution Notes** | Entered on plan. No early exit temptation. Perfect trade. |

**Time to fill this out:** ~2 minutes per trade.
**Value of this data over 100 trades:** Priceless.

Notice how the emotion column and "Rule Followed?" tell you MORE about your growth than the P&L column does.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Which journal column provides the MOST insight into improving your trading performance?',
          'options': [
            'P&L (Profit/Loss Amount)',
            'Entry Price',
            '"Did I follow my rules?" and "Pre-Trade Emotion"',
            'Asset/Ticker name',
          ],
          'correctIndex': 2,
          'explanation':
              'P&L tells you the RESULT. But the "Rule Followed?" and "Emotion" columns tell you the CAUSE. Deepa\'s data proved that her strategy was profitable when she was calm and catastrophic when she was emotional. You cannot extract this insight from P&L alone.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Deepa discovered her strategy was fine — her emotions were the problem',
            'Set up a spreadsheet with BOTH mechanical and psychological columns',
            'Log every trade immediately after closing it — it takes 2 minutes',
            'The "Did I follow rules?" column is more important than the P&L column',
            'After 50-100 trades, your journal will reveal your exact behavioral leaks',
            'Next: Why journaling your emotional state is the key to unlocking profitability.',
          ],
        },
      ],
    };
  }

  // Lesson 5.2: Journaling Emotions
  static Map<String, dynamic> getJournalingEmotionsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Tracking the Invisible Variable',
          'emoji': '🧠',
          'content':
              'Two trades can look identical on the chart, but have completely different outcomes. Why? Because the trader\'s emotional state was different. If you don\'t track your feelings, you are missing half the data.',
        },
        {
          'type': 'concept',
          'title': 'The Emotional Columns',
          'emoji': '📝',
          'content': '''
**How to Log Emotions:**
Create two columns in your journal: "Pre-Trade Emotion" and "Post-Trade Mistake."

**Column 1: Pre-Trade Emotion (Select from dropdown)**
• *Calm/Neutral:* "I am executing my plan mechanically."
• *FOMO:* "It's moving fast, I have to get in!"
• *Revenge:* "I just lost, I need to make it back."
• *Boredom:* "Nothing is happening, let's just try this."
• *Overconfident:* "I can't lose today, doubling size."

**Column 2: Execution Mistakes (If any)**
• *None (Perfect Execution):* Let the system hit stop or target.
• *Cut Winner Early:* Fear took over, exited before target.
• *Moved Stop Loss Down:* Refused to accept the loss.
• *Averaged a Loser:* Added more size to a failing trade.

---

**The Revelation (After 50 Trades):**
When you look back at your journal, the data will speak to you loudly:
• "Every time I logged 'FOMO', I lost money."
• "Every time I 'Cut Winner Early', the trade eventually hit my target anyway."
• "My 'Calm' trades have a 60% win rate."

**Key Insight:**
You cannot fix an emotional problem with a technical indicator. If your journal shows you are losing money because you keep moving your stop loss, a new MACD setting won't help you. The journal diagnoses the REAL problem.
''',
          'keyPoints': [
            'Pre-trade emotions strongly correlate with trade outcomes',
            'Log execution mistakes (cutting early, moving stops) rigorously',
            'Data will eventually prove to your brain that emotional trading is mathematically unprofitable',
            'You cannot fix an emotional execution problem with a new technical strategy',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The Emotion-Profit Correlation',
          'emoji': '📈',
          'content': '''
**Real data from a trader's journal (100 trades over 3 months):**

| Emotion | Trades | Win Rate | Avg P&L/Trade | Total P&L |
|---------|--------|----------|---------------|-----------|
| **Calm** | 58 | 55% | +₹820 | +₹47,560 |
| **FOMO** | 22 | 18% | -₹1,700 | -₹37,400 |
| **Revenge** | 12 | 8% | -₹2,100 | -₹25,200 |
| **Bored** | 8 | 25% | -₹600 | -₹4,800 |

**Net P&L: -₹19,840**

**But look at this:**
If the trader had ONLY taken the "Calm" trades (58 out of 100), the P&L would be **+₹47,560**.

**The 42 emotional trades cost: ₹67,400 in losses.**

That's the equivalent of a ₹67,400 "emotional tax" over 3 months. Your journal is the only tool that makes this invisible tax VISIBLE.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Honest Journal Entry',
          'situation':
              'You entered a trade perfectly according to your plan. It went into profit, almost hit your target, then reversed sharply. You panicked and sold manually for a small loss. Ten minutes later, it rocketed back up and hit your original target. How do you journal this?',
          'choices': [
            {
              'text':
                  'Log it as a loss due to market volatility. The setup was good.',
              'isCorrect': false,
              'feedback':
                  '❌ This is lying to your journal. The market didn\'t cause the loss; your panic did. If you blame the market, you will never fix the behavior.',
            },
            {
              'text':
                  'Log: Setup=Valid. Pre-emotion=Calm. Mistake=Panic Exit/Cut early. P&L=Loss. Rule Followed=NO.',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect brutal honesty. The setup was good, but the execution failed due to fear. By tagging "Rule Followed=NO", you identify that the loss was your fault, not the strategy\'s fault. This is how you improve.',
            },
            {
              'text':
                  'Delete the trade from the journal. It was a stupid mistake and doesn\'t reflect the strategy.',
              'isCorrect': false,
              'feedback':
                  '❌ Never delete trades. Your stupid mistakes are exactly what the journal is designed to track and eliminate.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 5 Complete! 🎉',
          'keyPoints': [
            'A trading journal is a mechanical and psychological database',
            'The "emotional tax" from FOMO, revenge, and boredom trades can cost ₹60,000+ over 3 months',
            'Track setups, R:R, execution quality, and emotional states',
            'Brutal honesty in the journal is required for growth',
            'The data will eventually prove which emotions cost you the most money',
            'Next: How to use this journal data in your Weekly Review.',
          ],
        },
      ],
    };
  }
}
