/// Chapter 8: Overtrading & Revenge Trading
/// The destructive cycles that drain accounts
class OvertradingRevengeContent {
  // Lesson 8.1: Overtrading
  static Map<String, dynamic> getOvertradingContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Death by a Thousand Cuts',
          'emoji': '🔪',
          'content':
              'In most jobs, the more you work, the more you earn. In trading, the opposite is true. More trades usually mean more losses, higher fees, and mental exhaustion. Overtrading is the silent killer of retail accounts.',
        },
        {
          'type': 'concept',
          'title': 'The Overtrading Trap',
          'emoji': '🕸️',
          'content': '''
**What is Overtrading?**
Taking trades that don't strictly meet your plan's criteria just because you want to "be in the market."

**The Three Types of Overtrading:**
1. **Boredom Trading:** The market is flat. You are bored. You force a trade just to feel the excitement.
2. **Frequency Trading:** Taking 20 trades a day on 1-minute charts, thinking "more trades = more chances to win."
3. **Sizing Overtrading:** Trading too large for your account (covered in Position Sizing).

**The Mathematical Reality of Overtrading:**
Every trade carries two costs:
1. Spread/Brokerage fees (Guaranteed loss)
2. Risk of the trade failing (Probable loss)

If your system generates 3 high-quality setups a day with a 60% win rate...
And you take 15 trades a day...
Those extra 12 trades are "low quality." They drag your win rate down to 40% or worse.

---

**The Professional Approach:**
• **The Sniper vs Machine Gunner:** Amateurs spray bullets (trades) everywhere, hoping to hit something. Professionals wait for hours, take one high-probability shot, and leave.
• **Rule of 3:** Many professionals limit themselves to a maximum of 3 trades per day. If they win, they stop. If they lose 3, they stop.

**Key Insight:**
"Sitting on your hands" is an active trading decision. Sometimes, doing nothing is the most profitable action you can take.
''',
          'keyPoints': [
            'In trading, more effort (more trades) usually leads to worse results',
            'Overtrading destroys your statistical edge by mixing good trades with bad ones',
            'Brokerage fees from overtrading quietly drain accounts',
            'Sometimes, doing nothing is the most profitable action',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The Cost of Overtrading',
          'emoji': '💸',
          'content': '''
**Let's look at the math of brokerage fees (The Silent Drain):**

Assume you pay ₹50 total per trade (brokerage + taxes/fees).

**Trader A (The Sniper):**
• 2 trades per day
• 20 trading days per month = 40 trades
• Total monthly fees: **₹2,000**
• Total yearly fees: **₹24,000**

**Trader B (The Machine Gunner):**
• 15 trades per day
• 20 trading days per month = 300 trades
• Total monthly fees: **₹15,000**
• Total yearly fees: **₹1,80,000**

**The Reality Check:**
Trader B has to make ₹1.8 Lakh in PROFIT every year *just to break even*. Trader A only needs to make ₹24,000 to break even.

By taking 15 trades a day, you are essentially working to make your broker rich, not yourself.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You\'ve been watching the charts for 3 hours. The market is chopping sideways. No setup from your plan has appeared. What should you do?',
          'options': [
            'Switch to a 1-minute chart to find smaller opportunities',
            'Take a small position just to stay engaged',
            'Close the charts and come back later. No setup = no trade.',
            'Buy a random stock and put a tight stop loss',
          ],
          'correctIndex': 2,
          'explanation':
              'Close the charts. This is the ultimate test of discipline. The market is not obligated to provide you with opportunities every day. Forcing a trade in a choppy market is the definition of boredom overtrading.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Overtrading is taking setups outside your plan just to be active',
            'The "Sniper" waits for high probability; the "Machine Gunner" wastes capital',
            'Limit yourself to a set number of trades per day (e.g., maximum 3)',
            'Patience pays — wait for the trade to come to you',
            'Next: The darker side of overtrading — Revenge Trading.',
          ],
        },
      ],
    };
  }

  // Lesson 8.2: Revenge Trading
  static Map<String, dynamic> getRevengeTradingContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Emotional Spiral',
          'emoji': '🌪️',
          'content':
              'You take a loss. It hurts. You immediately enter another trade to "win the money back from the market." Congratulations, you are now Revenge Trading — the fastest way to blow up an account.',
        },
        {
          'type': 'concept',
          'title': 'The Anatomy of Revenge',
          'emoji': '🔥',
          'content': '''
**How Revenge Trading Starts:**
1. A painful loss (often because you broke a rule or got stopped out to the exact tick).
2. The Ego triggers: "The market stole my money. I'm going to get it back right now."
3. Logic shuts down. The "fight or flight" response activates.

**The Symptoms:**
• Entering a new trade within seconds of a loss.
• Doubling the position size ("Martingale") to recover the loss faster.
• Trading a completely random asset you haven't analyzed.
• Abandoning stop losses.

**Why It Always Fails:**
The market doesn't know you exist. It doesn't know it "took" your money. You are fighting an ocean. When you revenge trade, your analysis is zero, your risk is double, and your emotions are peaking. It's a guaranteed path to a massive drawdown.

---

**How to Break the Spiral:**

**1. The 15-Minute Rule ⏱️**
After ANY loss, force yourself to step away from the screen for 15 minutes. Walk around. Get water. Let the adrenaline subside.

**2. The "Acceptance" Paradigm 🧘‍♂️**
Stop treating losses as "stolen money." Treat them as **business expenses**.
A restaurant owner doesn't get angry when they have to pay for electricity. A trader shouldn't get angry when they pay for a stop loss. It's the cost of doing business.

**Key Insight:**
You cannot "get back" at the market. The moment you try to punish the market, the market will punish you. Accept the loss, reset your mind, and look for the NEXT independent probability.
''',
          'keyPoints': [
            'Revenge trading is trying to win back a loss immediately, driven by anger/ego',
            'Symptoms: immediate re-entry, doubled size, random assets',
            'The market doesn\'t know you exist — you are fighting your own emotions',
            'Cure: The 15-minute walk-away rule after any loss',
            'Treat losses as routine business expenses, not personal attacks',
          ],
        },
        {
          'type': 'story',
          'title': 'Pooja\'s "One More Trade"',
          'emoji': '🔁',
          'content': '''
**Pooja**, 29, was trading Bank Nifty options.

**1:15 PM:** She took a perfectly planned breakout trade. The market spiked up, missed her target by 2 points, then violently reversed. She got stopped out. Loss: ₹3,000.

**1:20 PM:** Pooja was furious. "I was right! The market just manipulated the price." She immediately bought Puts (the opposite direction). No plan. Double the quantity.

**1:35 PM:** The market chopped sideways. Time decay destroyed the option premium. She exited in frustration. Loss: ₹4,500.

**1:40 PM:** Total loss: ₹7,500. Now she was desperate. She bought Calls again, maximum leverage.

**2:15 PM:** A sudden drop. Loss: ₹11,000.

**Total damage:** ₹18,500 in one hour.
The first ₹3,000 was a standard business expense. The remaining ₹15,500 was an "ego tax" paid entirely out of revenge.

**Key lesson:** The market did not take Pooja's money. Pooja gave it away because her ego couldn't accept a normal statistical loss.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Spiral Decision',
          'situation':
              'You got stopped out of Nifty calls for a ₹2,000 loss. Literally 10 seconds later, Nifty shoots up in the direction you predicted. You are furious. Your mouse is hovering over the "Buy" button with double the quantity to make it back. What do you do?',
          'choices': [
            {
              'text':
                  'Buy immediately — you were right all along, the market just shook you out!',
              'isCorrect': false,
              'feedback':
                  '❌ This is textbook revenge trading fueled by FOMO. The entry is impulsive, the size is doubled, and the risk is uncalculated. If it reverses again, you lose ₹4,000, and your account enters a death spiral.',
            },
            {
              'text': 'Buy immediately, but with normal quantity',
              'isCorrect': false,
              'feedback':
                  '❌ Better than doubling size, but still an emotional, impulsive entry. You have no plan for this new entry.',
            },
            {
              'text':
                  'Stand up, walk away from the computer for 15 minutes. The trade is gone. Accept the "business expense."',
              'isCorrect': true,
              'feedback':
                  '✅ This is what saves careers. Getting stopped out right before a move happens is the most painful experience in trading. But revenge entering is how you lose capital. Walk away, let the anger fade, and live to trade tomorrow.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 8 Complete! 🎉',
          'keyPoints': [
            'Overtrading destroys your edge by forcing low-quality setups',
            'Patience (doing nothing) is a highly profitable action',
            'Revenge trading is the fastest way to blow an account',
            'Enforce the 15-minute walk-away rule after painful losses',
            'Treat every loss as a normal business expense, not a personal failure',
            'Next: How to build the discipline to actually follow these rules.',
          ],
        },
      ],
    };
  }
}
