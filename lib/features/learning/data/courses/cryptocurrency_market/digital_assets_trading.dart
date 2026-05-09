/// Chapter 1: Digital Assets & Blockchain-Based Trading
/// The evolution of money into programmable digital value
class DigitalAssetsTradingContent {
  // Lesson 1.1: The Digital Revolution
  static Map<String, dynamic> getDigitalRevolutionContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Money is Changing',
          'emoji': '🌐',
          'content':
              'For thousands of years, humans traded gold, silver, and paper money. Then came credit cards. Then UPI. Now, a new evolution is happening — money is becoming programmable, borderless, and decentralized. Let\'s understand this shift.',
        },
        {
          'type': 'story',
          'title': 'Ananya\'s Cross-Border Problem',
          'emoji': '💸',
          'content': '''
**Ananya**, a 30-year-old freelance designer in Pune, lands a ₹5 Lakh project from a client in Canada.

**The Payment Nightmare:**
• Client sends \$6,000 via bank wire transfer.
• Bank charges \$35 wire fee + 3% forex markup.
• Takes 4 business days to arrive.
• Ananya receives only ₹4,72,000 after all deductions.
• **Lost: ₹28,000 in fees and conversion costs.**

**Her Friend Priya's Experience:**
Same project, same amount. But Priya asks for payment in USDC (a stablecoin).
• Client sends \$6,000 in USDC on Polygon network.
• Transaction fee: ₹2 (yes, two rupees).
• Arrives in **45 seconds**.
• Priya converts to INR on WazirX: gets ₹4,98,000.
• **Saved: ₹26,000 compared to Ananya.**

**The Lesson:**
Digital assets aren't just "internet money for nerds." They solve real, expensive problems. Cross-border payments is just one example — the technology is being used for lending, insurance, supply chains, and more.

**But here's the catch:**
Priya spent 3 months learning how crypto works before using it. Ananya heard "crypto" and thought "scam." Knowledge made the difference.
''',
        },
        {
          'type': 'concept',
          'title': 'What Are Digital Assets?',
          'emoji': '📊',
          'content': '''
**DIGITAL ASSETS** are any form of value that exists purely in digital/electronic form and can be owned, transferred, and traded.

**Types of Digital Assets:**
• **Cryptocurrencies** — Bitcoin, Ethereum (digital money)
• **Tokens** — Utility tokens, governance tokens (digital tools)
• **Stablecoins** — USDT, USDC (digital dollars)
• **NFTs** — Digital art, collectibles (digital ownership)

---

**How are they different from UPI/Net Banking?**

When you send ₹100 via UPI, your bank updates its database. The money doesn't "move" — numbers change in a centralized ledger controlled by your bank and RBI.

With crypto, the value actually moves across a **decentralized network**. No bank, no RBI, no middleman. The code IS the bank.

---

**Key Insight:**
Digital assets aren't trying to replace UPI for buying chai. They're trying to rebuild the entire financial infrastructure — lending, insurance, cross-border trade — without needing banks as middlemen.
''',
          'keyPoints': [
            'Digital assets = value that exists purely in electronic form',
            'Crypto removes middlemen (banks) from financial transactions',
            'Stablecoins bridge the gap between fiat and crypto',
            'The technology solves real problems beyond just speculation',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Priya saved ₹26,000 on a cross-border payment using USDC instead of a bank wire. What made this possible?',
          'options': [
            'USDC is backed by the Indian government',
            'The blockchain network processes transfers without bank intermediaries, reducing fees drastically',
            'Cryptocurrency prices went up during the transfer',
            'Priya used a VPN to avoid taxes',
          ],
          'correctIndex': 1,
          'explanation':
              'Blockchain networks process peer-to-peer transfers without banks, correspondent banks, or forex desks taking cuts at every step. The technology itself reduces friction and cost — that\'s the core value proposition.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Digital assets are a new category of programmable, borderless value',
            'They solve real-world problems: cheaper transfers, faster settlement, financial access',
            'Crypto is NOT just speculation — it has genuine utility in payments, lending, and more',
            'Understanding the technology before investing separates winners from losers',
            'Next: Why do digital assets actually matter for YOU?',
          ],
        },
      ],
    };
  }

  // Lesson 1.2: Why Digital Assets Matter
  static Map<String, dynamic> getWhyDigitalAssetsMatterContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Beyond the Hype',
          'emoji': '🔍',
          'content':
              'Everyone talks about "Bitcoin going to the moon." But strip away the hype — why do digital assets actually matter? What real problems do they solve? And why are billion-dollar companies investing in them?',
        },
        {
          'type': 'interactive',
          'title': 'Traditional Finance vs Crypto',
          'emoji': '⚖️',
          'content': '''
**Comparison: Sending ₹1 Lakh Internationally**

**Traditional Banking:**
• Route: Your Bank → RBI → Correspondent Bank → Foreign Bank
• Time: 2-5 business days
• Fees: ₹3,000-₹5,000 (wire + forex markup)
• Hours: Only during banking hours (Mon-Fri, 9-5)
• Reversibility: Bank can freeze/reverse anytime

**Cryptocurrency (USDC on Polygon):**
• Route: Your Wallet → Recipient's Wallet (direct)
• Time: 15-60 seconds
• Fees: ₹1-₹5
• Hours: 24/7/365 (even on Diwali at 3 AM)
• Reversibility: Irreversible once confirmed

**The Tradeoff:**
Crypto is faster and cheaper, BUT if you send to a wrong address, nobody can help you. Traditional banking is slow and expensive, BUT your bank can reverse fraud.

**Key Lesson:**
Each system has strengths. The future likely combines both — not replaces one entirely.
''',
        },
        {
          'type': 'concept',
          'title': 'Three Real Use Cases',
          'emoji': '🏗️',
          'content': '''
**1. Remittances (Cross-Border Payments) 💱**
India receives \$100+ billion in remittances annually.
Workers abroad send money home via Western Union (5-7% fees).
Crypto cuts this to near-zero. A worker in Dubai can send ₹50,000 home in 30 seconds for ₹5.

**2. DeFi (Decentralized Finance) 🏦**
Imagine getting a loan without going to a bank. No paperwork, no credit score, no waiting.
DeFi protocols like Aave and Compound let you lend/borrow crypto directly.
Interest rates are set by supply and demand, not by a bank manager.

**3. Financial Inclusion 🌍**
1.4 billion people worldwide have no bank account.
But many have smartphones. With crypto, anyone with internet can save, send, and receive money.

---

**Key Insight:**
The question isn't "will crypto survive?" — it's "which parts of crypto will become mainstream?" Understanding the useful parts from the scams is YOUR job as an investor.
''',
          'keyPoints': [
            'Remittances: ₹5 crypto fees vs ₹3,000+ bank fees for international transfers',
            'DeFi: Lending and borrowing without banks or paperwork',
            'Financial inclusion: Banking the 1.4 billion unbanked people globally',
            'The technology is real — but so are the risks and scams',
          ],
        },
        {
          'type': 'scenario',
          'title': 'What Would You Do?',
          'situation':
              'Your cousin in the US wants to send you ₹2 Lakhs as a wedding gift. He says: "I can wire it through the bank (₹4,000 in fees, 3 days) or send USDC to your wallet (₹5 fee, 1 minute). Which do you prefer?"',
          'choices': [
            {
              'text': 'Bank wire — crypto sounds risky and complicated',
              'isCorrect': false,
              'feedback':
                  '❌ You\'d lose ₹4,000 in fees for no reason. USDC is a stablecoin pegged to the US Dollar — its value doesn\'t fluctuate like Bitcoin. If you learn the basics, you can save significantly.',
            },
            {
              'text':
                  'USDC — but only after learning how to use a wallet safely',
              'isCorrect': true,
              'feedback':
                  '✅ Smart! USDC is stable (1 USDC = 1 USD always), fast, and cheap. But you need to know how to receive it safely. Education first, then action — the right approach.',
            },
            {
              'text': 'Ask him to convert to Bitcoin instead — it might go up!',
              'isCorrect': false,
              'feedback':
                  '❌ Bad idea! Bitcoin can drop 20% in a day. Your wedding gift of ₹2L could become ₹1.6L overnight. Use stablecoins for transfers, not volatile assets.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 1 Complete! 🎉',
          'keyPoints': [
            'Digital assets solve real problems: cheaper transfers, open finance, global access',
            'Crypto is faster and cheaper than banking — but with different risks',
            'Stablecoins (USDC/USDT) are designed for stability, not speculation',
            'DeFi is rebuilding banking without banks — a massive innovation',
            '1.4 billion unbanked people could gain financial access through crypto',
            'Next Chapter: What exactly IS cryptocurrency? Let\'s go deeper.',
          ],
        },
      ],
    };
  }
}
