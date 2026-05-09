/// Chapter 4: Types of Crypto Assets
/// Coins, tokens, stablecoins — not all crypto is equal
class CryptoAssetsTypesContent {
  // Lesson 4.1: Coins vs Tokens
  static Map<String, dynamic> getCoinsVsTokensContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Not All Crypto is the Same',
          'emoji': '🪙',
          'content':
              'People say "crypto" like it\'s one thing. It\'s not. There are coins, tokens, stablecoins, NFTs, and more. Confusing them is like confusing gold with a gift card. Let\'s sort this out.',
        },
        {
          'type': 'concept',
          'title': 'Coins: The Native Currencies',
          'emoji': '🏛️',
          'content': '''
**A "Coin" has its own blockchain.** Think of it as a country's official currency.

**Examples:**
• **Bitcoin (BTC)** — runs on the Bitcoin blockchain
• **Ether (ETH)** — runs on the Ethereum blockchain
• **SOL** — runs on the Solana blockchain

**What do Coins do?**
• Pay transaction fees (like toll tax on a highway)
• Reward miners/validators who secure the network
• Act as the "fuel" that powers the blockchain

**Analogy:**
Bitcoin is to the Bitcoin network what the Rupee is to India. You NEED Rupees to do business in India. You NEED ETH to do anything on Ethereum.

---

**A "Token" lives on SOMEONE ELSE's blockchain.** It's like a casino chip — it has value inside the casino, but it doesn't run the casino.

**Examples (all built on Ethereum):**
• **USDT** — a stablecoin token
• **UNI** — Uniswap's governance token
• **SHIB** — Shiba Inu meme token

**Key Difference:**
Creating a new Coin = Building a new country (hard).
Creating a new Token = Printing a new casino chip (easy — takes 5 minutes).

---

**Key Insight:**
When you invest in a Coin, you're betting on the blockchain infrastructure itself. When you invest in a Token, you're betting on one specific application built on that infrastructure.
''',
          'keyPoints': [
            'Coins have their own blockchain (BTC, ETH, SOL)',
            'Tokens live on existing blockchains (USDT, UNI, SHIB on Ethereum)',
            'Creating tokens is trivially easy — which is why 99% of scams are tokens',
            'Coins = infrastructure investment; Tokens = application investment',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Why are most crypto scams built as tokens rather than coins?',
          'options': [
            'Because tokens are illegal and coins are legal',
            'Because creating a token takes minutes using existing blockchain infrastructure, while building a coin requires creating an entire new network',
            'Because tokens are more expensive than coins',
            'Because SEBI only regulates coins, not tokens',
          ],
          'correctIndex': 1,
          'explanation':
              'Creating a token on Ethereum takes a developer about 5 minutes using a standard template. Creating a coin requires building an entire blockchain network, attracting miners/validators, and writing complex code. The near-zero barrier to entry for tokens is why scammers love them.',
        },
        {
          'type': 'interactive',
          'title': 'Coin vs Token: Side by Side',
          'emoji': '📊',
          'content': '''
**Feature Comparison:**

**Bitcoin (Coin):**
• Own blockchain: ✅ Yes (Bitcoin network)
• Created by: Building an entire decentralized network
• Primary use: Store of value, transaction settlement
• Supply: Fixed at 21 million
• Market Cap: ~₹100 Lakh Crore

**Shiba Inu (Token):**
• Own blockchain: ❌ No (lives on Ethereum)
• Created by: Deploying a smart contract on Ethereum (~5 min)
• Primary use: Meme, community, speculation
• Supply: 589 TRILLION tokens
• Market Cap: ~₹50,000 Crore

**The Difference in Investment:**
• Buying BTC = Investing in the world's most secure decentralized network
• Buying SHIB = Betting on community hype and meme culture

**Key Lesson:**
Price per coin/token means NOTHING. SHIB costs ₹0.001 but that doesn't make it "cheap." What matters is market cap, utility, and fundamentals.
''',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Coins have their own blockchain; tokens are built on existing blockchains',
            'Creating tokens is trivially easy — be extremely cautious with new tokens',
            'Price per unit is meaningless — always look at market cap and utility',
            'Investing in coins = betting on infrastructure; tokens = betting on applications',
            'Next: What about stablecoins — the most used crypto you\'ve never heard of?',
          ],
        },
      ],
    };
  }

  // Lesson 4.2: Stablecoins: The Bridge
  static Map<String, dynamic> getStablecoinsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Boring Crypto That Runs Everything',
          'emoji': '🏦',
          'content':
              'Bitcoin swings 10% daily. Ethereum can crash 30% in a week. How can anyone actually USE crypto for business? Enter stablecoins — the most important and most boring crypto innovation.',
        },
        {
          'type': 'concept',
          'title': 'What Are Stablecoins?',
          'emoji': '⚓',
          'content': '''
**A stablecoin is a crypto token pegged to a stable asset** — usually the US Dollar.

**Goal:** 1 USDT = 1 USD. Always. No volatility.

**Why They Exist:**
• Traders need a "safe parking spot" during volatility
• Businesses can't accept Bitcoin if the price changes 10% before they convert it
• Cross-border payments need stable value, not speculative assets

**The Big Two:**
• **USDT (Tether):** Largest stablecoin. ~₹8 Lakh Crore market cap. Run by Tether Ltd.
• **USDC (USD Coin):** Second largest. Regulated, audited. Run by Circle.

**How They Stay Stable:**
For every 1 USDT in circulation, Tether claims to hold \$1 in reserves (cash + treasury bills). If everyone redeems at once, the reserves should cover it.

---

**Key Insight:**
Stablecoins are the "blood" of the crypto ecosystem. Over 70% of all crypto trading volume involves USDT. Without stablecoins, crypto markets would be far less functional.
''',
          'keyPoints': [
            'Stablecoins are pegged to fiat currencies (usually USD)',
            'USDT and USDC dominate — used in 70%+ of all crypto trades',
            'They provide stability for trading, payments, and DeFi',
            'They\'re backed by reserves — but the quality of reserves matters',
          ],
        },
        {
          'type': 'story',
          'title': 'The Terra/Luna Disaster',
          'emoji': '🚨',
          'content': '''
**May 2022: The Biggest Crypto Crash in History.**

**UST (TerraUSD)** was an "algorithmic" stablecoin. Unlike USDT, it wasn't backed by real dollars in a bank. Instead, it used a mathematical algorithm linked to another coin called **LUNA** to maintain its \$1 peg.

**The Promise:**
"We don't need banks or dollars. Math alone will keep UST at \$1."
They offered 20% interest to people who deposited UST. **Too good to be true.**

**The Collapse:**
• A large sell-off broke the algorithm.
• UST dropped from \$1 to \$0.10.
• LUNA crashed from \$80 to \$0.0001.
• **₹3.5 Lakh Crore wiped out in 72 hours.**

**Real Victims:**
• **Karthik** in Chennai deposited his ₹15 Lakh life savings for the 20% yield.
• In 3 days, his ₹15 Lakhs became ₹1.5 Lakhs. A 90% loss.
• He couldn't eat. He couldn't sleep. His family's trust in him shattered.

**Lesson:**
If a stablecoin offers unrealistic yields (20%!), ask: WHERE is this money coming from? If the answer is "an algorithm," run. Real stability requires real reserves.
''',
        },
        {
          'type': 'scenario',
          'title': 'What Would You Do?',
          'situation':
              'A DeFi platform offers 18% APY on your USDT deposits. Your friend says: "Banks give 7%. This gives 18%. No-brainer!" What do you do?',
          'choices': [
            {
              'text': 'Deposit all savings — 18% is amazing!',
              'isCorrect': false,
              'feedback':
                  '❌ Terra/Luna also offered 20%. Ask: WHERE does the 18% come from? If it\'s from lending to borrowers at 22%+, maybe it\'s real. If the source is unclear, it\'s likely unsustainable or a Ponzi.',
            },
            {
              'text':
                  'Research the platform\'s revenue source, audit reports, and history before depositing anything',
              'isCorrect': true,
              'feedback':
                  '✅ Smart! High yields should always be investigated. Check: Is the platform audited? How long has it been running? Where does the yield come from? If you can\'t answer these, don\'t deposit.',
            },
            {
              'text': 'Avoid DeFi entirely — it\'s all scams',
              'isCorrect': false,
              'feedback':
                  '❌ Not all DeFi is a scam. Aave and Compound have processed billions safely. But yields above 10% on stablecoins should be heavily scrutinized. Blanket rejection means missing genuine innovation.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Stablecoins are pegged to USD — designed for stability, not speculation',
            'USDT and USDC are backed by real reserves (cash + treasury bills)',
            'Algorithmic stablecoins (like TerraUST) can collapse catastrophically',
            'If yields sound too good to be true — they ARE too good to be true',
            'Always verify: What backs this stablecoin? Where does the yield come from?',
          ],
        },
      ],
    };
  }

  // Lesson 4.3: NFTs, DeFi & Beyond
  static Map<String, dynamic> getNftsDeFiContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Expanding Universe',
          'emoji': '🌌',
          'content':
              'Crypto isn\'t just about money anymore. It\'s become an entire ecosystem of digital ownership, automated finance, and programmable agreements. Let\'s take a quick tour.',
        },
        {
          'type': 'concept',
          'title': 'NFTs, DeFi & DAOs Explained Simply',
          'emoji': '🎨',
          'content': '''
**1. NFTs (Non-Fungible Tokens) 🎨**
A unique digital certificate of ownership. Like a property deed, but for digital items.
• **Use:** Digital art, event tickets, certificates, gaming items
• **Reality:** The 2021 NFT craze saw a ₹5 Crore ape JPEG. Most NFTs are now worth ₹0.
• **Legit use cases:** Concert tickets that can't be counterfeited, academic certificates on-chain.

**2. DeFi (Decentralized Finance) 🏦**
Banking without banks. Lending, borrowing, trading — all done by code (smart contracts).
• **Example:** Deposit ETH on Aave → Earn interest automatically. No bank manager, no paperwork.
• **Risk:** Smart contract bugs can be exploited. Billions have been lost to DeFi hacks.

**3. DAOs (Decentralized Autonomous Organizations) 🗳️**
A company run by code and community votes instead of a CEO and board.
• Token holders vote on decisions (like shareholders, but more direct).
• **Example:** MakerDAO manages a ₹60,000 Crore stablecoin entirely through community governance.

---

**Key Insight:**
Most of these innovations are still experimental. 90% will fail. But the 10% that succeed could reshape finance entirely. Your job as an investor: learn, observe, wait, then act.
''',
          'keyPoints': [
            'NFTs = digital ownership certificates (mostly speculative currently)',
            'DeFi = banking without banks (real utility, real risks)',
            'DAOs = community-governed organizations (still experimental)',
            'Most innovations are early-stage — approach with curiosity, not FOMO',
          ],
        },
        {
          'type': 'story',
          'title': 'The Yield Farming Trap',
          'emoji': '🌾',
          'content': '''
**Siddharth** found a new DeFi protocol offering 1,000% APY on stablecoins.
He couldn't believe it. "The bank gives me 6%, this gives me 1,000%! I'll be rich."
He deposited ₹5 Lakh into the protocol's liquidity pool.

**Week 1:** He made ₹10,000 in interest. He was thrilled.
**Week 2:** He tried to withdraw his money to show his friends. But the transaction failed.
**Week 3:** He went to the protocol's website. It was gone. The Twitter account was deleted.

Siddharth had fallen victim to a **"Rug Pull."**
The anonymous developers had simply taken all the deposited funds and vanished. The 1,000% APY was just the bait to get people to deposit their money.

**Key lesson:** In DeFi, if you don't know where the yield is coming from, YOU are the yield. Never chase astronomical APYs, especially on unaudited, anonymous protocols. Start with established platforms like Aave or Compound where returns are realistic (2-5%).
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'What is the biggest risk of using a DeFi lending protocol like Aave or Compound?',
          'options': [
            'The government will shut it down immediately',
            'A bug in the smart contract code could be exploited, draining all deposited funds',
            'You need to visit a physical bank to withdraw your crypto',
            'DeFi platforms only work during business hours',
          ],
          'correctIndex': 1,
          'explanation':
              'DeFi protocols are code. Code can have bugs. Hackers actively search for vulnerabilities in smart contracts. Billions of dollars have been stolen through DeFi exploits. Always check if a protocol has been audited by reputable firms before depositing funds.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 4 Complete! 🎉',
          'keyPoints': [
            'Coins have their own blockchain; tokens are built on existing ones',
            'Stablecoins provide USD-pegged stability — essential for trading and payments',
            'Algorithmic stablecoins are extremely risky (TerraUST: ₹3.5L Cr wiped out)',
            'NFTs, DeFi, and DAOs are expanding crypto beyond just "money"',
            'Most crypto innovations are still experimental — invest only what you can lose',
            'Next: How does crypto trading actually work? Pairs, order books, and wallets.',
          ],
        },
      ],
    };
  }
}
