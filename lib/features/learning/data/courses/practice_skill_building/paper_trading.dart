/// Chapter 2: Paper Trading
/// Executing simulated trades with absolute seriousness
class PaperTradingContent {
  // Lesson 2.1: What is Paper Trading?
  static Map<String, dynamic> getWhatIsPaperTradingContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Sandbox',
          'emoji': '🎮',
          'content':
              'Paper trading (or simulated trading) is the act of executing trades using live market data but with virtual money. It looks and feels exactly like real trading, but your bank account is perfectly safe.',
        },
        {
          'type': 'story',
          'title': 'Neha\'s Smart Start',
          'emoji': '🧠',
          'content': '''
**Neha**, 26, a data analyst in Hyderabad earning ₹8 Lakh/year.

After completing her financial education, she had ₹1 Lakh saved for trading. Her colleagues at work were opening Zerodha accounts and trading immediately. They mocked her: "Paper trading is a waste of time."

**Neha's approach:**
She opened a TradingView account, set her virtual balance to exactly ₹1,00,000, and paper traded for 4 months.

**Month 1:** +3% (₹3,000). "This is easier than I thought."
**Month 2:** -5% (₹5,000 loss). The market went sideways. She learned her breakout strategy failed in choppy markets.
**Month 3:** She adjusted her entry filter. +4% (₹3,800).
**Month 4:** She refined further. +6% (₹5,700).

**Her colleagues' results after 4 months of REAL trading:**
• Rahul: -₹38,000 (-38% of his capital). Quit.
• Siddharth: -₹22,000 (-22%). Still "hoping" for recovery.

**Neha's results after switching to real money in Month 5:**
• She deposited ₹1,00,000 and made +₹7,200 in her first real month.
• She already knew exactly how to handle her strategy in choppy vs trending markets.

**Key lesson:** Neha's 4 "wasted" months of paper trading saved her from ₹20,000+ in losses AND gave her a tested, profitable system.
''',
        },
        {
          'type': 'concept',
          'title': 'How to Paper Trade',
          'emoji': '💻',
          'content': '''
**The Tools:**
Almost all modern charting platforms offer paper trading.
• **TradingView:** The gold standard. They have a built-in "Paper Trading" broker. You get \$100,000 of virtual money.
• **Sensibull (India):** Excellent for paper trading options.
• **FrontPage / Neostox:** Indian platforms specifically built for virtual trading.

**The Mechanics:**
1. You connect your virtual broker account.
2. You see a setup on the live chart.
3. You place a buy order with a stop loss and target.
4. The platform tracks your P&L exactly as if it were real.
5. Your virtual account balance grows or shrinks based on your decisions.

**Why it's essential:**
• You learn the mechanics of placing orders (Limit vs Market vs Stop orders).
• You test if your technical analysis actually works in real-time.
• You build the habit of calculating position sizes quickly.
''',
          'keyPoints': [
            'Paper trading uses live market data with virtual money',
            'Platforms like TradingView and Sensibull offer excellent simulators',
            'It teaches you the mechanics of order execution without financial risk',
            'It proves whether your strategy has a mathematical edge',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'What is the MOST important benefit of paper trading for a beginner?',
          'options': [
            'Learning which stocks will go up',
            'Building execution habits and testing strategy without financial risk',
            'Impressing friends with virtual profits',
            'Getting access to premium charting features',
          ],
          'correctIndex': 1,
          'explanation':
              'Paper trading\'s #1 value is building HABITS. It trains you to calculate position size, place stops, follow your plan, and journal trades — all without the fear of real money interfering. The strategy testing is a bonus; the habit-building is the core benefit.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Paper trading is your sandbox — make your mistakes here, not with real money',
            'Neha\'s 4 months of paper trading saved her ₹20,000+ and built a tested system',
            'Use tools like TradingView, Sensibull, or Neostox for simulation',
            'Practice placing complex orders (bracket orders, trailing stops)',
            'Next: The psychological trap that ruins most paper traders.',
          ],
        },
      ],
    };
  }

  // Lesson 2.2: The Paper Trading Trap
  static Map<String, dynamic> getPaperTradingTrapContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Simulation Illusion',
          'emoji': '🪤',
          'content':
              'Paper trading has one massive flaw: It cannot simulate the fear of losing real money. Because of this, many people build terrible, reckless habits in the simulator that instantly destroy their real accounts later.',
        },
        {
          'type': 'interactive',
          'title': 'Amateur vs Professional Simulator',
          'emoji': '⚖️',
          'content': '''
**The Amateur's Simulator:**
• Account size: ₹10 Crores (Virtual)
• Strategy: Buys random stocks with full leverage
• Risk per trade: "Whatever, it's fake money" (50%+ of account!)
• Reaction to loss: Hits "Reset Account" and starts over
• After 3 months: Zero discipline. Zero usable data.
**Result:** Will blow up real account on Day 1. 💥

---

**The Professional's Simulator:**
• Account size: ₹50,000 (exact amount they plan to trade in reality)
• Strategy: Follows a strict trading plan with written entry/exit rules
• Risk per trade: 1% of virtual balance (₹500 per trade)
• Reaction to loss: Journals the mistake. Adjusts the strategy.
• After 3 months: 180+ logged trades with real statistical data.
**Result:** Enters real market with confidence AND data. 📈

---

**The Difference:**
The amateur treats paper trading as a video game.
The professional treats it as a dress rehearsal for opening night.
Which one do you want to be?
''',
        },
        {
          'type': 'concept',
          'title': 'Rules of Serious Paper Trading',
          'emoji': '⚠️',
          'content': '''
**Rule 1: Match Your Future Reality**
Set your virtual balance to the exact amount of real cash you have saved for trading. If you only have ₹20,000 to trade, do NOT paper trade with ₹1 Crore. You need to learn how to compound small amounts.

**Rule 2: Never Hit "Reset"**
If you blow up your virtual account, force yourself to wait a month before resetting it. There are consequences in the real world; create consequences in the simulation.

**Rule 3: Act Like It's Real**
If you wouldn't take a trade with your hard-earned salary, do not take it in the simulator.

**Rule 4: Journal EVERY Trade**
Date, entry price, stop loss, target, position size, reasoning, emotional state, outcome. This data is GOLD when you switch to real money.

**Rule 5: Follow Your Time Commitment**
If you plan to trade 9:15-11:30 AM in real life, only paper trade during those hours. Don't paper trade at midnight — you're building habits that won't translate.

---

**Key Insight:**
Your paper trading journal is your resume for real money trading. If you can show 3 months of disciplined, profitable entries — you're ready.
''',
          'keyPoints': [
            'Paper trading lacks emotional pressure, leading to reckless habits if unchecked',
            'Always set your virtual balance to your actual planned starting capital',
            'Never hit the "Reset Account" button casually — treat virtual losses seriously',
            'Journal every paper trade — this data becomes your real-money roadmap',
          ],
        },
        {
          'type': 'scenario',
          'title': 'The Simulation Decision',
          'situation':
              'You are paper trading an options strategy. You enter a trade, and it immediately drops 30%. Your stop loss rule says you must exit. But because it\'s fake money, you think: "I\'ll just hold it and see if it recovers, just for fun." What happens next?',
          'choices': [
            {
              'text': 'It\'s fine, the goal of simulation is to experiment.',
              'isCorrect': false,
              'feedback':
                  '❌ Experimenting with STRATEGIES is fine. Experimenting with BREAKING RULES is toxic. If you build the habit of holding losers in the simulator, your brain will automatically do the same thing with real money.',
            },
            {
              'text':
                  'You must exit immediately, honoring the stop loss exactly as if it were real money.',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect. The goal of paper trading is to build MUSCLE MEMORY. You are training your brain to execute a stop loss without hesitation. Every time you break a rule in simulation, you weaken your discipline for reality.',
            },
            {
              'text': 'Average down by buying more to see if it works.',
              'isCorrect': false,
              'feedback':
                  '❌ Averaging down a loser is a toxic habit. Practicing toxic habits in a simulator guarantees you will deploy them in reality.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 2 Complete! 🎉',
          'keyPoints': [
            'Paper trading lets you test strategies with zero financial risk',
            'The biggest danger is treating it like a video game instead of a dress rehearsal',
            'Set your virtual balance to your actual planned capital',
            'Never casually reset your account after a loss',
            'Train your discipline by honoring stops as if it were real cash',
            'Next: How to build a pre-trade plan so you never guess in the market.',
          ],
        },
      ],
    };
  }
}
