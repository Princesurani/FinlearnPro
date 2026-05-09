/// Chapter 3: Risk vs Reward
/// Thinking in probabilities, not certainties
class RiskVsRewardContent {
  // Lesson 3.1: Thinking in Probabilities
  static Map<String, dynamic> getProbabilitiesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Casino Mentality (The Good Kind)',
          'emoji': '🎲',
          'content':
              'Casinos don\'t predict the outcome of every spin. They don\'t care if you win or lose the next hand. They know their overall mathematical edge guarantees profit over thousands of hands. Professional traders think exactly like casinos.',
        },
        {
          'type': 'story',
          'title': 'Meera\'s Coin Flip Business',
          'emoji': '🪙',
          'content': '''
**Meera**, 27, a data scientist in Bangalore, applied her statistics training to trading.

She built a simple swing trading strategy:
• Buy at 200 EMA support with bullish engulfing candle
• Stop loss: Below the engulfing candle
• Target: 2x the risk (1:2 R:R)

After backtesting 200 trades, she knew:
• **Win rate: 45%** (she loses more often than she wins)
• **Average win: ₹4,000** | Average loss: ₹2,000

**Her friends laughed:** "You lose 55% of the time! That's terrible!"

**Meera's response:**
"Let me show you the math."

**Over 100 trades:**
• 45 wins × ₹4,000 = **+₹1,80,000**
• 55 losses × ₹2,000 = **-₹1,10,000**
• **Net profit: +₹70,000** 💰

**Meera's philosophy:**
"I don't care about individual trades. Each trade is just one flip of my weighted coin. I know that over 100 flips, I make ₹70,000. So my job is simple: keep flipping."

**Key lesson:** Meera never predicted the market. She never needed to. She just understood her edge and executed it repeatedly.
''',
        },
        {
          'type': 'concept',
          'title': 'Probabilistic Thinking',
          'emoji': '🧠',
          'content': '''
**Amateur Traders seek CERTAINTY.**
"I need to know what the market will do next."
"I need a strategy that wins 90% of the time."
"I can't take this trade because it might lose."

**Professional Traders seek PROBABILITIES.**
"I have no idea what the market will do next, and I don't need to."
"My edge wins 55% of the time. That's enough."
"This trade has a 60% chance of hitting the target. I'll take it."

---

**The Mark Douglas Paradigm:**
From the book *Trading in the Zone*, Mark Douglas explains:
1. Anything can happen.
2. You don't need to know what is going to happen next in order to make money.
3. There is a random distribution between wins and losses for any given set of variables that define an edge.
4. An edge is nothing more than an indication of a higher probability of one thing happening over another.
5. Every moment in the market is unique.

**Key Insight:**
Stop trying to predict the future. You can't. Instead, find a setup with a statistical edge, apply proper risk management, and execute it 100 times. The math will take care of the rest.
''',
          'keyPoints': [
            'Amateurs seek certainty; professionals seek probabilities',
            'You don\'t need to know the future to make money',
            'A trading edge is just a higher probability of one outcome over another',
            'Every trade outcome is independent of the previous one',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'A strategy wins 40% of the time with 1:3 R:R (risk ₹1,000, target ₹3,000). Over 50 trades, what is the expected net profit?',
          'options': [
            'Net loss — 40% win rate is too low',
            '+₹30,000 (20 wins × ₹3,000 = ₹60K, 30 losses × ₹1,000 = ₹30K)',
            '+₹60,000',
            'Cannot determine',
          ],
          'correctIndex': 1,
          'explanation':
              '20 wins × ₹3,000 = ₹60,000. 30 losses × ₹1,000 = ₹30,000. Net: +₹30,000. A 40% win rate with 1:3 R:R is HIGHLY profitable! This proves that win rate alone means nothing — the R:R determines whether you make money. You can be wrong 60% of the time and still earn ₹30K over 50 trades.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Meera makes ₹70,000 per 100 trades despite losing 55% of the time',
            'Think like a casino — rely on mathematical edge, not individual outcomes',
            'Accept that losses are a normal, statistical part of trading',
            'Stop trying to be "right" every time — aim to be profitable over 100 trades',
            'Next: The math that makes winning 40% of the time profitable — Risk:Reward.',
          ],
        },
      ],
    };
  }

  // Lesson 3.2: The Risk-Reward Ratio
  static Map<String, dynamic> getRiskRewardContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Holy Grail of Trading',
          'emoji': '⚖️',
          'content':
              'If there is a holy grail in trading, it\'s not an indicator or a chart pattern. It\'s the Risk-Reward Ratio (R:R). It\'s the mathematical formula that allows you to be wrong more often than you\'re right, and STILL make money.',
        },
        {
          'type': 'concept',
          'title': 'The Math of R:R',
          'emoji': '📐',
          'content': '''
**What is Risk-Reward Ratio (R:R)?**
It's the amount you risk losing compared to the amount you expect to gain.
Risk = Entry Price - Stop Loss Price
Reward = Target Price - Entry Price

**Example: 1:2 R:R**
You risk ₹1,000 to make ₹2,000.
If stop loss hits: Lose ₹1,000
If target hits: Gain ₹2,000

---

**Why R:R is Magic (The Math):**

Let's say you take 10 trades with a 1:2 R:R.
You have a TERRIBLE win rate of only 40%. You lose 6 trades and win 4.

**The Math:**
• 6 Losses × ₹1,000 = -₹6,000
• 4 Wins × ₹2,000 = +₹8,000
**Net Result: +₹2,000 PROFIT!**

You were wrong 60% of the time, and you still made money!
This is the secret of professional trading.

---

**The Amateur's Inverse R:R:**
Amateurs often take 2:1 risk-reward (risk ₹2,000 to make ₹1,000).
"I'll take small profits quickly to feel good, and I'll hold losers hoping they come back."
If you win 6 and lose 4 with this strategy:
• 6 Wins × ₹1,000 = +₹6,000
• 4 Losses × ₹2,000 = -₹8,000
**Net Result: -₹2,000 LOSS!**
You were right 60% of the time, but you LOST money!

**Key Insight:**
Aim for a minimum of 1:1.5 or 1:2 R:R on every trade. If a setup doesn't offer this, skip it.
''',
          'keyPoints': [
            'Risk-Reward (R:R) = potential loss vs potential gain',
            'With 1:2 R:R, you can win only 40% of the time and still be profitable',
            'Amateurs use inverse R:R — risking a lot to make a little',
            'Minimum acceptable R:R for professionals is usually 1:1.5 or 1:2',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The R:R Calculator',
          'emoji': '🧮',
          'content': '''
**Let's calculate R:R for real Indian market setups:**

**Setup 1: HDFC Bank Swing Trade**
• Entry: ₹1,650 (bounced off 200 EMA)
• Stop Loss: ₹1,610 (below recent swing low)
• Target: ₹1,730 (previous resistance level)
• Risk: ₹1,650 - ₹1,610 = **₹40**
• Reward: ₹1,730 - ₹1,650 = **₹80**
• **R:R = 1:2** ✅ Take this trade!

**Setup 2: Infosys Day Trade**
• Entry: ₹1,480 (breakout above range)
• Stop Loss: ₹1,460 (below breakout level)
• Target: ₹1,490 (minor resistance)
• Risk: ₹1,480 - ₹1,460 = **₹20**
• Reward: ₹1,490 - ₹1,480 = **₹10**
• **R:R = 2:1** ❌ Skip this trade! (Risking ₹20 to make ₹10)

---

**The Filter Test:**
Before EVERY trade, ask: "Am I risking ₹X to make at least ₹1.5X-2X?"
If yes → Proceed to entry criteria.
If no → Skip. Wait for a better setup. The market is open 252 days per year.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You find a trade setup. Entry is at ₹100. Stop loss must be at ₹95 (major support). Your target is ₹105 (major resistance). Should you take this trade?',
          'options': [
            'Yes — ₹5 profit is good',
            'No — the Risk-Reward ratio is 1:1 (risk ₹5 to make ₹5). You should look for better setups (at least 1:1.5 or 1:2).',
            'Yes — if you\'re sure it will hit ₹105',
            'No — stop loss is too far away',
          ],
          'correctIndex': 1,
          'explanation':
              'Risk = ₹5 (100-95). Reward = ₹5 (105-100). The R:R is 1:1. While a 1:1 R:R CAN be profitable if your win rate is very high (>55%), it leaves no room for error. Professional traders skip 1:1 setups and wait for opportunities where they can risk ₹5 to make ₹10 or ₹15 (1:2 or 1:3 R:R).',
        },
        {
          'type': 'scenario',
          'title': 'The Tempting Setup',
          'situation':
              'You see TCS breaking out above ₹4,200 with strong volume. Your analysis says the target is ₹4,250 (₹50 upside). But the only logical stop loss is at ₹4,120 (₹80 downside). R:R = 1:0.6. Your friend messages: "TCS is flying! Buy now!" What do you do?',
          'choices': [
            {
              'text':
                  'Buy it — TCS is a great company and the breakout looks strong',
              'isCorrect': false,
              'feedback':
                  '❌ Company quality doesn\'t fix bad math. You are risking ₹80 to make ₹50. Even if TCS is amazing, over 100 similar trades this R:R will drain your account. The chart pattern is irrelevant when the math doesn\'t work.',
            },
            {
              'text':
                  'Skip it. The R:R is 1:0.6 (inverse). Wait for a pullback to ₹4,150 where the R:R improves to 1:3',
              'isCorrect': true,
              'feedback':
                  '✅ Professional response! By waiting for a pullback to ₹4,150: Stop at ₹4,120 = ₹30 risk. Target at ₹4,250 = ₹100 reward. R:R = 1:3.3! Same stock. Same analysis. But 5x better math by being PATIENT.',
            },
            {
              'text':
                  'Buy with a tighter stop loss at ₹4,180 to improve the R:R',
              'isCorrect': false,
              'feedback':
                  '❌ Artificially tightening your stop loss doesn\'t improve the trade — it increases the chance of getting stopped out on normal price noise. Stop losses must be placed at technically significant levels, not at arbitrary points to make the math look better.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 3 Complete! 🎉',
          'keyPoints': [
            'Professional traders think in probabilities, not certainties',
            'Risk-Reward (R:R) is the math that allows you to be wrong and still win',
            'Aim for 1:2 R:R — risking ₹1 to make ₹2',
            'Never take trades with inverse R:R (risking ₹2 to make ₹1)',
            'Patience improves R:R — waiting for pullbacks transforms bad math into great math',
            'Next: How to actually calculate your position size for every trade.',
          ],
        },
      ],
    };
  }
}
