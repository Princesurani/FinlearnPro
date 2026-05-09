/// Chapter 5: How Forex Trading Works
/// Brokers, platforms, and executing your first trade
class HowForexTradingWorksContent {
  // Lesson 5.1: Forex Brokers & Platforms
  static Map<String, dynamic> getForexBrokersContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Choosing Your Weapon',
          'emoji': '🛡️',
          'content':
              'In stocks, all brokers connect to NSE. In forex, your broker IS the exchange. A bad broker can literally trade against you. Choosing the right one could be the difference between profit and fraud.',
        },
        {
          'type': 'concept',
          'title': 'Types of Forex Brokers',
          'emoji': '🏢',
          'content': '''
**1. ECN/STP Brokers (The Good Guys) ✅**
• Pass your orders directly to the interbank market.
• They earn from commission/spread — NOT from your losses.
• Your interest and their interest are aligned.
• Examples: IC Markets, Pepperstone

**2. Market Maker Brokers (The Tricky Ones) ⚠️**
• They take the OTHER side of your trade.
• When YOU lose, THEY profit. Massive conflict of interest.
• They can widen spreads during volatility, delay execution, or "requote" prices.
• Not all are bad — but the incentive structure is dangerous.

**3. Indian Regulated Options (For USD/INR) 🇮🇳**
• Trade currency derivatives on NSE/BSE through Zerodha, Angel One, etc.
• Regulated by SEBI and RBI — strongest protection.
• Limited to INR pairs: USD/INR, EUR/INR, GBP/INR, JPY/INR.
• No exotic pairs, limited leverage — but safest for beginners.

---

**Red Flags in a Forex Broker:**
🚩 "Guaranteed profits" or "zero-risk trading"
🚩 No regulation from FCA (UK), ASIC (Australia), or SEBI (India)
🚩 Difficulty withdrawing your money
🚩 Pressure to deposit more after losses

---

**Key Insight:**
In India, the safest way to trade forex is through SEBI-regulated platforms on NSE/BSE. International brokers may offer more pairs and higher leverage, but you lose regulatory protection.
''',
          'keyPoints': [
            'ECN brokers pass orders to the market — aligned with your interests',
            'Market makers take the other side of your trade — conflict of interest',
            'SEBI-regulated brokers (Zerodha, Angel One) are safest for Indian traders',
            'Always check regulation: SEBI (India), FCA (UK), ASIC (Australia)',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'A forex broker offers 1000x leverage, guarantees monthly returns, and is registered in an unregulated offshore island. What should you do?',
          'options': [
            'Sign up immediately — high leverage means huge profits!',
            'Ask friends if they\'ve used it before deciding',
            'Avoid it completely — no regulation + guaranteed returns = classic scam indicators',
            'Deposit a small amount to test if withdrawals work',
          ],
          'correctIndex': 2,
          'explanation':
              'All three red flags are present: extreme leverage (1000x is reckless), guaranteed returns (impossible in trading), and no regulation. Offshore unregulated brokers can take your deposit and disappear. Even "testing with small amounts" gives scammers your banking details.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'ECN/STP brokers are transparent — they don\'t profit from your losses',
            'Market makers have a conflict of interest — be cautious',
            'SEBI-regulated NSE/BSE currency trading is the safest option for Indians',
            'Red flags: no regulation, guaranteed profits, extreme leverage, withdrawal issues',
            'Next: Let\'s walk through placing your first forex trade, step by step.',
          ],
        },
      ],
    };
  }

  // Lesson 5.2: Your First Forex Trade
  static Map<String, dynamic> getFirstForexTradeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Let\'s Place a Trade',
          'emoji': '🖱️',
          'content':
              'Theory is great. But nothing teaches like doing. Let\'s walk through a complete forex trade from analysis to execution to exit — on USD/INR, the pair you understand best.',
        },
        {
          'type': 'interactive',
          'title': 'Step-by-Step: A USD/INR Trade',
          'emoji': '📱',
          'content': '''
**Scenario: You believe the Rupee will strengthen (USD/INR will fall).**

**Step 1: Analysis 🔍**
• RBI just raised interest rates → Foreign money flows into India → Rupee strengthens
• USD/INR is currently at 84.00
• Your target: 83.50 (50 pips profit)
• Your stop loss: 84.30 (30 pips risk)

**Step 2: Position Sizing 📊**
• Account: ₹50,000
• Risk per trade: 1% = ₹500
• Pip value (1 lot of 1,000 units): ~₹0.10
• Lots needed: ₹500 / (30 pips × ₹0.10) = ~166 lots?
• Actually, let's keep it simple: 5 mini lots

**Step 3: Execute ⚡**
• Open Zerodha → Currency Derivatives → USDINR
• SELL 5 lots of USDINR Futures at 84.00
• Set Stop Loss at 84.30
• Set Target at 83.50

**Step 4: Wait & Manage ⏰**
• Price moves: 84.00 → 83.80 → 83.65 → 83.50 ✅
• Target hit! Position auto-closes.
• Profit: 50 pips × 5 lots × ₹1 = ₹250

**Key Lesson:**
The profit is small — ₹250. That's intentional. You're learning with controlled risk. ₹250 with ₹500 risk = 1:1.67 reward-to-risk. Not bad for a beginner trade!
''',
        },
        {
          'type': 'scenario',
          'title': 'Trade Management',
          'situation':
              'You\'re in a SELL USD/INR trade at 84.00, target 83.50, stop loss 84.30. The price drops to 83.70 (30 pips in your favor). But then a US jobs report comes out and USD/INR starts rising back toward 83.90. What do you do?',
          'choices': [
            {
              'text':
                  'Move your stop loss to 84.00 (breakeven) to protect your capital',
              'isCorrect': true,
              'feedback':
                  '✅ Excellent! Moving your stop to breakeven means you\'ve eliminated risk. Even if the price reverses completely, you lose nothing. This is called a "free trade" — professional traders do this constantly.',
            },
            {
              'text':
                  'Close the trade now at 83.90 — take the 10-pip profit and run',
              'isCorrect': true,
              'feedback':
                  '✅ Also valid! Taking profits when the momentum shifts is disciplined trading. A small profit is infinitely better than a loss. You can always re-enter if the setup reappears.',
            },
            {
              'text':
                  'Keep the original stop loss at 84.30 — trust your analysis',
              'isCorrect': false,
              'feedback':
                  '❌ While trusting your analysis is important, not adapting to new information (the jobs report) is stubbornness, not discipline. Moving your stop to breakeven costs you nothing and eliminates risk.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 5 Complete! 🎉',
          'keyPoints': [
            'Choose regulated brokers — SEBI for India, FCA/ASIC for international',
            'Always calculate position size based on the 1% risk rule BEFORE entering',
            'Set stop loss and target BEFORE entering — never trade without a plan',
            'Moving stop to breakeven when in profit = "free trade" (zero risk)',
            'Small, consistent profits beat one big lucky trade every time',
            'Next: When should you actually trade? The three sessions of forex.',
          ],
        },
      ],
    };
  }
}
