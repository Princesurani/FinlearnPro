/// Chapter 4: Options Basics
/// The right but not the obligation
class OptionsBasicsContent {
  // Lesson 4.1: What Is an Option?
  static Map<String, dynamic> getWhatIsOptionContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Movie Ticket Analogy',
          'emoji': '🎟️',
          'content':
              'An Option is a contract that gives you the RIGHT to buy or sell something at a specific price — but you are NOT forced to. Think of it like buying a movie ticket: you have the right to watch the movie, but if something comes up, you can skip it.',
        },
        {
          'type': 'concept',
          'title': 'Options in Plain Language',
          'emoji': '📝',
          'content': '''
**The Real Estate Analogy:**
You find a house worth ₹50 Lakh. You want to buy it but need 2 months to arrange the loan.

You pay the owner ₹1 Lakh as a **"token" (non-refundable)** and sign an agreement:
"I have the RIGHT to buy this house at ₹50 Lakh within the next 2 months."

**Scenario A: House price rises to ₹60 Lakh**
You exercise your right! You buy at ₹50L (saving ₹10L). Net profit: ₹10L - ₹1L token = ₹9 Lakh.

**Scenario B: House price drops to ₹40 Lakh**
You DON'T exercise. You walk away. You lose the ₹1 Lakh token, but you saved yourself from overpaying by ₹10 Lakh.

**In Options Language:**
• Token = **Premium** (the price you pay for the option)
• ₹50 Lakh = **Strike Price** (the locked-in buying price)
• 2 Months = **Expiry** (the deadline)
• Your choice to buy = **Call Option**
• Your ability to walk away = **Limited Risk** (you only lose the premium)

---

**Key Insight:**
Options are asymmetric: your maximum loss is LIMITED to the premium, but your profit potential can be very large. This is why options attract traders.
''',
          'keyPoints': [
            'An Option gives the right but NOT the obligation to buy/sell',
            'Premium = the cost of this right (your maximum risk)',
            'Strike Price = the locked-in price for the transaction',
            'Expiry = the deadline by which you must decide',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Futures vs Options Risk',
          'emoji': '⚖️',
          'content': '''
**Futures Buyer (Nifty at 22,000):**
• Margin paid: ₹1,10,000
• If Nifty goes to 22,500: Profit = ₹12,500 ✅
• If Nifty crashes to 20,000: Loss = ₹50,000 ❌ (+ possible margin call)
• **Maximum loss: UNLIMITED**

**Options Buyer (Nifty 22,000 Call at ₹200 premium):**
• Premium paid: ₹200 × 25 (lot) = ₹5,000
• If Nifty goes to 22,500: Profit = (500 - 200) × 25 = ₹7,500 ✅
• If Nifty crashes to 20,000: Loss = ₹5,000 (just the premium) ❌
• **Maximum loss: ₹5,000 (the premium you paid)**

---

**The Trade-Off:**
Futures give you MORE profit for the same move, but expose you to UNLIMITED loss.
Options give you LESS profit, but cap your maximum loss at the premium.

**Which is Safer for Beginners?**
Buying Options (if done wisely). Never selling naked Options as a beginner.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You buy a Call Option for ₹8,000 premium. The trade goes horribly wrong. What is the maximum amount you can lose?',
          'options': [
            'Your entire trading account',
            '₹8,000 (the premium paid)',
            'It depends on how far the market falls',
            'Double the premium (₹16,000)',
          ],
          'correctIndex': 1,
          'explanation':
              'When you BUY an option (Call or Put), your maximum loss is ALWAYS limited to the premium you paid. This is the fundamental advantage of buying options. However, when you SELL options, your loss can be unlimited — a critical distinction.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Options give the right but not the obligation to buy/sell',
            'Premium is the cost of this right — and your maximum risk',
            'Options have limited downside (premium) but significant upside potential',
            'Futures have unlimited risk in both directions; Options buyers have capped risk',
            'Next: Understanding the three pillars — Premium, Strike Price, and Expiry.',
          ],
        },
      ],
    };
  }

  // Lesson 4.2: Premium, Strike Price & Expiry
  static Map<String, dynamic> getPremiumStrikeExpiryContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Three Pillars',
          'emoji': '🏛️',
          'content':
              'Every options contract has three critical variables: the Premium (how much you pay), the Strike Price (the locked-in price), and the Expiry (the deadline). Understanding these three determines whether you make or lose money.',
        },
        {
          'type': 'concept',
          'title': 'Premium — The Cost of the Right',
          'emoji': '💰',
          'content': '''
**What Determines Premium?**
The premium is the market price of the option. It changes every second.

**Two Components:**
1. **Intrinsic Value:** How much "in the money" the option already is.
   • Nifty at 22,200. A 22,000 Call has ₹200 of intrinsic value.
   • It is already profitable by ₹200.

2. **Time Value:** The "hope premium" — the chance that the option becomes more profitable before expiry.
   • More time = more hope = higher premium
   • As expiry approaches, time value DECAYS (Theta decay)
   • On expiry day, time value = ₹0. Only intrinsic value remains.

---

**The Ice Cream Analogy 🍦:**
An option is like an ice cream cone on a hot day. The moment you buy it, it starts melting (losing time value). By the end of the day (expiry), if you haven't eaten it (exercised it), all you have left is a soggy cone (zero value).

---

**Key Insight:**
When you buy an option, time is your ENEMY. Every day, your option loses value due to Theta decay — even if the market doesn't move at all.
''',
          'keyPoints': [
            'Premium = Intrinsic Value + Time Value',
            'Intrinsic value is how much profit the option already has',
            'Time value decays daily — options lose value as expiry approaches',
            'Time is the ENEMY of option buyers (Theta decay)',
          ],
        },
        {
          'type': 'concept',
          'title': 'Strike Price & Moneyness',
          'emoji': '🎯',
          'content': '''
**Strike Price = The locked-in execution price.**

**Moneyness — Where Is the Strike Relative to the Market?**

If Nifty is currently at 22,000:

**In-The-Money (ITM) 💚:**
• Call with Strike 21,500 → Already profitable by ₹500
• Higher premium (more expensive) but safer

**At-The-Money (ATM) 🟡:**
• Call with Strike 22,000 → Right at the current price
• Moderate premium. Most actively traded.

**Out-of-The-Money (OTM) 🔴:**
• Call with Strike 22,500 → Not profitable yet. Needs ₹500 move.
• Cheapest premium. Highest risk of expiring worthless.

---

**The Lottery Ticket Trap:**
OTM options are cheap (₹5-₹20). Beginners buy hundreds of them thinking "if it hits, I'll make lakhs!"
Reality: 80%+ of OTM options expire worthless. It's a lottery ticket disguised as trading.

---

**Key Insight:**
Cheaper options are NOT "better deals." They are cheap because the probability of profit is very low.
''',
          'keyPoints': [
            'ITM options are already profitable; ATM are at current price; OTM need a big move',
            'OTM options are cheap but have 80%+ chance of expiring worthless',
            'Buying cheap OTM options is the lottery ticket trap',
            'Cheaper ≠ better deal — it means lower probability of profit',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Nifty is at 22,000. You buy a 22,500 Call Option expiring this Thursday for ₹10 premium (1 lot = 25). What must happen for you to make a profit?',
          'options': [
            'Nifty must go above 22,000',
            'Nifty must go above 22,500',
            'Nifty must go above 22,510 (Strike + Premium)',
            'Nifty must stay exactly at 22,000',
          ],
          'correctIndex': 2,
          'explanation':
              'Your breakeven = Strike Price (22,500) + Premium paid (10) = 22,510. Nifty must move 510 points (2.3%) in a few days for you to break even. This is why cheap OTM options are a trap — they require massive moves to be profitable.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 4 Complete! 🎉',
          'keyPoints': [
            'Premium = Intrinsic Value + Time Value; time value decays daily',
            'Strike Price determines "moneyness": ITM, ATM, or OTM',
            'OTM options are cheap but 80%+ expire worthless (lottery ticket trap)',
            'Breakeven = Strike Price + Premium paid (for Calls)',
            'Time is the enemy of option buyers — every day costs you money',
            'Next: How Calls and Puts work in simple, practical terms.',
          ],
        },
      ],
    };
  }
}
