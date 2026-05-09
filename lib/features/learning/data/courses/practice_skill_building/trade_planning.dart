/// Chapter 3: Trade Planning
/// If you fail to plan, you plan to fail
class TradePlanningContent {
  // Lesson 3.1: The Pre-Trade Plan
  static Map<String, dynamic> getPreTradePlanContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Blueprint',
          'emoji': '🗺️',
          'content':
              'Amateurs look at a chart, feel excited, and click "Buy." Professionals write a script for the trade before it happens. If you don\'t have a written plan BEFORE entering, you are gambling, not trading.',
        },
        {
          'type': 'concept',
          'title': 'The Four Components of a Plan',
          'emoji': '📋',
          'content': '''
**A valid trade plan MUST have these four elements written down BEFORE entry:**

**1. The Trigger (Why am I entering?) 🎯**
• "I will buy IF the price breaks above ₹500 on a 15-minute candle with above-average volume."
• It must be specific. Not "if it looks bullish," but a measurable condition.

**2. The Invalidation Point (Stop Loss) 🛑**
• "My thesis is proven wrong if the price drops below ₹485 (previous swing low)."
• This dictates your position size.

**3. The Target (Take Profit) 💰**
• "The next major resistance is at ₹540. I will exit 50% here and trail the rest."
• Is the reward (₹40) at least 1.5x the risk (₹15)? Yes (2.6x R:R).

**4. The Management Rules ⚙️**
• "If price reaches ₹520, I will move my stop loss to breakeven (₹500)."
• Define exactly how you will handle the trade while it is active.

---

**Why write it down?**
When you are in a trade, your heart rate increases and your IQ drops by 20 points. You become emotionally compromised. A written plan is your "sober" brain telling your "drunk" brain what to do.
''',
          'keyPoints': [
            'A plan must have: Trigger, Stop Loss, Target, and Management Rules',
            'Triggers must be specific and measurable, not vague feelings',
            'Management rules dictate how you handle the trade while it\'s active',
            'Your written plan overrides your emotions during the trade',
          ],
        },
        {
          'type': 'story',
          'title': 'The Mid-Trade Panic',
          'emoji': '😨',
          'content': '''
**Suresh** bought ITC at ₹400 because he read a good article. He had no written plan.
**10:30 AM:** ITC drops to ₹395. Suresh feels anxious. "Should I sell? Let me wait a bit."
**11:00 AM:** ITC drops to ₹390. Suresh is sweating. "I can't take this loss. I'll sell." He sells at ₹390.
**12:00 PM:** ITC bounces from a major support at ₹388 and rallies to ₹410.

**Why did Suresh lose?**
He made his decisions *during* the stress of the trade.

**A Professional's approach:**
*Written Plan before entry:* "Buy at ₹400. Stop loss at ₹385 (below the ₹388 support). Target ₹420."
When the price hit ₹390, the professional would look at their plan, see the stop is ₹385, and do absolutely nothing. They let the plan work.

**Key lesson:** Your brain is highly logical *before* a trade and highly emotional *during* a trade. Write the plan with your logical brain, and force your emotional brain to follow it.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Which of the following is a professional pre-trade plan?',
          'options': [
            '"HDFC looks strong today. I\'ll buy 100 shares and sell when I make ₹2,000 profit. If it drops, I\'ll hold until it recovers."',
            '"Buy HDFC if it breaks ₹1550 on high volume. Stop loss at ₹1530. Target 1 at ₹1590. Move stop to breakeven when price hits ₹1570."',
            '"RSI is low on HDFC. I will buy now. Stop loss at 5%. Target at 10%."',
            '"Market is opening gap up. I will buy whatever is moving fastest in the first 5 minutes."',
          ],
          'correctIndex': 1,
          'explanation':
              'Option B is the only professional plan. It has a specific trigger (break ₹1550 + volume), a technical stop loss (₹1530), a logical target (₹1590), and clear management rules (move to breakeven at ₹1570). The others rely on feelings, hope, or arbitrary percentages.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Never enter a trade without a written plan',
            'Define your trigger, stop loss, target, and management rules in advance',
            'Specific conditions beat vague feelings every time',
            'Next: How to plan for market surprises and black swan events.',
          ],
        },
      ],
    };
  }

  // Lesson 3.2: Contingency Planning
  static Map<String, dynamic> getContingencyPlanningContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Expect the Unexpected',
          'emoji': '⚡',
          'content':
              'Your plan tells you what to do when things go normally. A contingency plan tells you what to do when the market throws a grenade at you. Professional traders are never surprised.',
        },
        {
          'type': 'concept',
          'title': 'Handling Market Chaos',
          'emoji': '🌪️',
          'content': '''
**The "What If" Game:**
Before entering, ask yourself how you will handle these scenarios:

**Scenario 1: The Massive Gap Down 📉**
You hold a stock overnight with a stop loss at ₹100. Bad news hits. The market opens the next day at ₹85 (way below your stop).
• *Amateur:* Freezes. Hopes it recovers. Sells at ₹70 in a panic three days later.
• *Professional Contingency:* "If it gaps below my stop, I will sell immediately at the market open, regardless of the price. Capital protection is absolute."

**Scenario 2: The Flash Crash ⚡**
You are day trading. The RBI governor unexpectedly raises rates. Nifty drops 200 points in 1 minute.
• *Professional Contingency:* "If unexpected macro news hits during a trade, I exit all positions at market price immediately and wait for the dust to settle."

**Scenario 3: The Broken Platform 💻**
Your broker's app crashes while you are in a live trade.
• *Professional Contingency:* "I always place hard stop-loss orders in the system immediately upon entry. If the app crashes, the exchange still holds my stop order. I am protected."

---

**Key Insight:**
Panic is just a lack of preparation. If you have already decided what to do in a worst-case scenario, you won't panic when it happens. You will just execute the contingency plan.
''',
          'keyPoints': [
            'Contingency plans handle gap downs, flash crashes, and platform failures',
            'If a stock gaps below your stop loss, sell immediately at market open',
            'Always place hard stops in the system to protect against internet/broker crashes',
            'Panic is a symptom of lack of preparation',
          ],
        },
        {
          'type': 'story',
          'title': 'The Yes Bank Gap Down',
          'emoji': '📉',
          'content': '''
**March 2020:** Yes Bank was already struggling, but many retail traders held it around ₹35, hoping for a turnaround.

**Thursday Night:** The RBI suddenly seized control of the bank and imposed withdrawal limits.
**Friday Morning (The Crisis):** Yes Bank opened straight at ₹16 — a massive 50% gap down.

**Trader A (Amateur):**
Had a stop loss at ₹30. When the market opened at ₹16, he froze. "I can't take a 50% loss. I'll wait for it to bounce back to ₹30." (It never did. It went to ₹5).

**Trader B (Professional):**
Had a contingency plan: *If a stock gaps below my stop, sell immediately at market open.*
Trader B sold at ₹16 at 9:15 AM. He took a painful 50% loss, but he saved the remaining 50% of his capital from going to zero.

**Key lesson:** A gap down is the market telling you your thesis is completely destroyed. When your stop loss is bypassed by a gap, your new job is to exit instantly at the best available price. Hope is not a contingency plan.
''',
        },
        {
          'type': 'scenario',
          'title': 'The Broker Outage',
          'situation':
              'You enter a day trade without placing a stop-loss order in the system (you planned to use a "mental stop"). Suddenly, your internet drops, and your broker\'s app goes down for 45 minutes. The market is highly volatile. What is your status?',
          'choices': [
            {
              'text':
                  'Safe — the broker will refund any losses caused by their app crashing.',
              'isCorrect': false,
              'feedback':
                  '❌ Brokers almost never refund losses due to technical glitches (read their terms of service). You are completely exposed to unlimited risk right now.',
            },
            {
              'text': 'It\'s fine, the market usually chops around anyway.',
              'isCorrect': false,
              'feedback':
                  '❌ Assuming the market won\'t move is gambling. A flash crash could wipe out your account in those 45 minutes.',
            },
            {
              'text':
                  'Completely exposed to catastrophic loss. This is why hard stop-loss orders MUST be placed into the exchange\'s system immediately upon entry.',
              'isCorrect': true,
              'feedback':
                  '✅ Exactly. If your stop loss is registered at the exchange, it doesn\'t matter if your phone dies, your internet drops, or your broker\'s app crashes. The exchange will execute the stop and protect your capital.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 3 Complete! 🎉',
          'keyPoints': [
            'A trade plan requires a trigger, stop loss, target, and management rules',
            'Write the plan down to override emotional decision-making mid-trade',
            'Build contingency plans for gap downs and flash crashes',
            'Always use hard system stops to protect against technical failures',
            'Next: How to prove your strategy works using historical data (Backtesting).',
          ],
        },
      ],
    };
  }
}
