/// Chapter 8: Who Should Trade Crypto
/// Honest self-assessment before you invest a single rupee
class WhoShouldTradeCryptoContent {
  // Lesson 8.1: The Crypto Readiness Checklist
  static Map<String, dynamic> getReadinessChecklistContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Honest Question',
          'emoji': '🪞',
          'content':
              'Before you invest ₹1 in crypto, ask yourself: Am I financially ready? Am I emotionally ready? Am I educated enough? This lesson gives you an honest checklist. No hype. No FOMO. Just truth.',
        },
        {
          'type': 'concept',
          'title': 'Financial Readiness Checklist',
          'emoji': '📋',
          'content': '''
**Before crypto, you MUST have:**

**✅ Emergency Fund (6 months of expenses)**
If you lose your job AND crypto crashes 50% at the same time, can you survive?
No emergency fund = No crypto investing.

**✅ Zero High-Interest Debt**
Credit card debt at 36% interest > Any crypto return.
Pay off ALL high-interest debt before investing in anything.

**✅ Stable Income Source**
Crypto is NOT a replacement for salary. It's a speculative allocation.
If you're counting on crypto gains to pay rent, you've already lost.

**✅ Money You Can Lose 100%**
Not "money I can afford to lose 20%." 100%.
Crypto can go to zero. If losing this amount changes your life, don't invest it.

---

**Mental Readiness Checklist:**

**✅ Can you watch a 50% portfolio drop without selling?**
If no → You'll panic-sell at every dip and lose money.

**✅ Can you resist FOMO when friends brag about gains?**
If no → You'll buy at tops based on hype and sell at bottoms in fear.

**✅ Will you NOT check prices every 5 minutes?**
If no → You'll be a nervous wreck. Crypto trades 24/7 — you need to sleep.

---

**Key Insight:**
The best crypto investors are BORING. They buy monthly, store in cold wallets, ignore prices for months, and only sell based on pre-set rules. No excitement. No drama. Just discipline.
''',
          'keyPoints': [
            'Emergency fund (6 months) is mandatory BEFORE any crypto investment',
            'Clear all high-interest debt first — 36% guaranteed "return"',
            'Only invest money you can 100% afford to lose',
            'Mental discipline matters as much as financial readiness',
          ],
        },
        {
          'type': 'story',
          'title': 'Two Colleagues, Two Paths',
          'emoji': '👬',
          'content': '''
**Arjun and Kavya** both earn ₹80,000/month. Both want to invest in crypto.

**Arjun (Not Ready):**
• No emergency fund. Spent it all on a new phone.
• Has ₹1.5L credit card debt (36% interest).
• Borrows ₹30,000 from his parents to "invest in Solana."
• Solana drops 40% in a week. Arjun panic-sells.
• Now he owes parents ₹30K + credit card debt + crypto losses.
• **Total disaster. Relationships strained. Sleep destroyed.** 😰

**Kavya (Ready):**
• ₹4.8L emergency fund (6 months saved).
• Zero debt. Cleared everything first.
• Starts ₹5,000/month SIP into Bitcoin via CoinDCX.
• Bitcoin drops 30%. She buys MORE (lower price = more sats).
• After 2 years: Her ₹1.2L invested is worth ₹1.9L.
• She checks her portfolio once a month. **Sleeps like a baby.** 😌

**The Difference:**
Kavya built her financial foundation first. Arjun skipped the boring steps and went straight to the "exciting" part.

**Lesson:**
The boring foundation (emergency fund → debt clearance → stable income) is what allows you to survive the exciting volatility. Skip it, and the market will teach you the hard way.
''',
        },
        {
          'type': 'scenario',
          'title': 'Are YOU Ready?',
          'situation':
              'You have ₹2 Lakhs in savings. ₹50,000 credit card debt at 36% interest. No emergency fund. Your friend just made ₹80,000 in a week trading Ethereum. You feel the FOMO. What\'s the RIGHT first step?',
          'choices': [
            {
              'text':
                  'Invest ₹1 Lakh in ETH — if it works, you can pay off the debt AND build an emergency fund',
              'isCorrect': false,
              'feedback':
                  '❌ STOP! You\'re gambling with money you can\'t afford to lose. If ETH drops 50%, you now have ₹50K in crypto + ₹50K credit card debt + no emergency fund. Triple disaster.',
            },
            {
              'text':
                  'Pay off ₹50K credit card debt first, then build a ₹3L emergency fund, then start with ₹5K/month into BTC',
              'isCorrect': true,
              'feedback':
                  '✅ Textbook correct! Step 1: Kill the 36% interest debt (guaranteed ₹18K annual "return"). Step 2: Build 6-month emergency fund. Step 3: THEN start small monthly crypto investments with surplus cash.',
            },
            {
              'text':
                  'Put all ₹2 Lakhs in a Fixed Deposit and forget about crypto',
              'isCorrect': false,
              'feedback':
                  '❌ Better than gambling, but not optimal. FDs at 6-7% barely beat inflation. The right order is: Debt → Emergency Fund → Diversified Investments (including a small crypto allocation).',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Financial readiness: Emergency fund → Zero debt → Stable income → Risk capital',
            'Mental readiness: Can you handle 50% drops without panic-selling?',
            'The best crypto investors are boring — monthly buys, cold wallets, no drama',
            'FOMO is your worst enemy — your friend\'s gains don\'t change YOUR financial situation',
            'Next: The final exam — can you call yourself crypto-ready?',
          ],
        },
      ],
    };
  }

  // Lesson 8.2: Final Challenge: Crypto Pro
  static Map<String, dynamic> getFinalChallengeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Final Test',
          'emoji': '🏆',
          'content':
              'You\'ve completed the entire Cryptocurrency Market course. From blockchain basics to scam detection to risk management. Let\'s see if you\'re truly ready to navigate the crypto world. 20 lessons down — can you pass the final challenge?',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Blockchain',
          'question':
              'Why is it practically impossible to alter a past transaction on the Bitcoin blockchain?',
          'options': [
            'Because Satoshi Nakamoto personally monitors all transactions',
            'Because each block\'s hash depends on the previous block — changing one breaks the entire chain across thousands of computers',
            'Because the Indian government protects the Bitcoin network',
            'Because Bitcoin uses a centralized database with strong passwords',
          ],
          'correctIndex': 1,
          'explanation':
              'Each block contains the hash of the previous block. Altering one transaction changes that block\'s hash, which invalidates every subsequent block. To succeed, an attacker would need to recalculate millions of hashes faster than the entire global network — practically impossible.',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: Coins vs Tokens',
          'question':
              'Why are 99% of crypto scams built as tokens rather than coins?',
          'options': [
            'Because tokens are illegal and attract criminals',
            'Because tokens are more powerful than coins',
            'Because creating a token takes minutes on an existing blockchain, while building a coin requires creating an entire new network',
            'Because SEBI only regulates coins, not tokens',
          ],
          'correctIndex': 2,
          'explanation':
              'Creating a token on Ethereum takes about 5 minutes using standard templates. Creating a coin requires building an entire blockchain, attracting validators, and massive engineering effort. The near-zero barrier to creating tokens makes them the vehicle of choice for scammers.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: Security',
          'question':
              'You receive a DM on Twitter from "MetaMask Support" asking you to "verify your seed phrase to secure your account." What should you do?',
          'options': [
            'Enter your seed phrase immediately to secure your account',
            'Ask them to verify they are real MetaMask support first',
            'Ignore and block — no legitimate service EVER asks for your seed phrase',
            'Give them only 12 of the 24 words as a compromise',
          ],
          'correctIndex': 2,
          'explanation':
              'This is a phishing scam. MetaMask does NOT have DM support on Twitter. NO legitimate wallet or exchange will EVER ask for your seed phrase. Not by email, DM, phone, or any other means. Giving even partial seed words is dangerous.',
        },
        {
          'type': 'quiz',
          'title': 'Question 4: Risk Management',
          'question':
              'You have ₹10 Lakhs total savings. How much should you allocate to cryptocurrency as a beginner?',
          'options': [
            '₹8 Lakhs — crypto gives the best returns',
            '₹5 Lakhs — balanced 50-50 split',
            '₹50,000 to ₹1 Lakh — only 5-10% of portfolio',
            '₹10 Lakhs — go all in for maximum returns',
          ],
          'correctIndex': 2,
          'explanation':
              'As a beginner, 5-10% of your total portfolio is the maximum recommended crypto allocation. That\'s ₹50,000-₹1,00,000. This ensures that even if crypto goes to zero, your financial life continues normally. You can increase allocation as your knowledge and experience grow.',
        },
        {
          'type': 'scenario',
          'title': 'The Ultimate Scenario',
          'situation':
              'It\'s 2 AM. You wake up and check your phone. Bitcoin has crashed 35% overnight due to a regulatory crackdown in a major country. Your ₹50,000 crypto portfolio is now worth ₹32,500. Twitter is full of "crypto is dead" posts. Your heart is racing. What do you do?',
          'choices': [
            {
              'text': 'Sell everything immediately before it drops to zero',
              'isCorrect': false,
              'feedback':
                  '❌ Panic selling at 2 AM during a crash is the worst possible decision. Every major Bitcoin crash (2018: -84%, 2020: -50%, 2022: -65%) was followed by a recovery to new highs. Selling in panic locks in your loss permanently.',
            },
            {
              'text':
                  'Put the phone down, go back to sleep, and review your pre-set exit rules in the morning with a clear mind',
              'isCorrect': true,
              'feedback':
                  '✅ This is the hardest but smartest move. You invested only 5% of your portfolio (₹50K). A 35% drop = ₹17,500 loss = 1.75% of your total savings. It\'s uncomfortable, but survivable. Review your rules when you\'re calm, not at 2 AM in panic mode.',
            },
            {
              'text':
                  'Buy more Bitcoin immediately — "Be greedy when others are fearful"',
              'isCorrect': false,
              'feedback':
                  '❌ While the Buffett quote is famous, buying during a crash at 2 AM without understanding WHY the crash happened is reckless. Wait for clarity. If the crash is sentiment-driven, buying may make sense later. If there\'s a fundamental regulatory threat, caution is warranted.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Congratulations! 🎉',
          'keyPoints': [
            'You understand blockchain, consensus, and why crypto has value',
            'You can tell the difference between coins, tokens, and stablecoins',
            'You know how to trade safely on CEXs and understand DEX mechanics',
            'You can spot scams: rug pulls, phishing, pump & dumps, and Ponzi schemes',
            'You have a risk management framework: DCA, portfolio limits, exit rules',
            'You\'re now equipped to enter the crypto market with knowledge, not just hope 💪',
          ],
        },
      ],
    };
  }
}
