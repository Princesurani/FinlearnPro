/// Chapter 6: Centralized vs Decentralized Exchanges
/// Where to trade — and the tradeoffs of each
class CexVsDexContent {
  // Lesson 6.1: CEX: The Familiar Path
  static Map<String, dynamic> getCexBasicsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Mall vs The Street Market',
          'emoji': '🏬',
          'content':
              'Trading crypto on a CEX (Centralized Exchange) is like shopping in a mall — comfortable, secure guards, CCTV cameras, but the mall owner controls everything. Let\'s explore.',
        },
        {
          'type': 'concept',
          'title': 'How Centralized Exchanges Work',
          'emoji': '🏢',
          'content': '''
**A CEX is a company that operates a crypto trading platform.** You trust them with your money.

**Popular CEXs:**
• **Global:** Binance, Coinbase, Kraken
• **India:** WazirX, CoinDCX, CoinSwitch, ZebPay

**How They Work:**
1. You deposit INR or crypto into YOUR account on THEIR platform.
2. The exchange matches buyers and sellers using their internal order book.
3. You trade. Your balances update on their database.
4. You withdraw whenever you want (usually).

**Important Reality:**
When your crypto is on a CEX, it's in THEIR wallet, not yours. They give you an IOU. If the company collapses (FTX) or freezes withdrawals (WazirX), you can't access your funds.

**Pros:**
• Easy to use (like a banking app)
• Fast execution, deep liquidity
• Customer support available
• INR deposit/withdrawal (fiat on-ramp)

**Cons:**
• You don't control your private keys
• Can freeze your account/withdrawals
• Hackable (Mt. Gox lost 850,000 BTC)
• KYC required (no privacy)

---

**Key Insight:**
CEXs are great for beginners — but think of them as a trading desk, not a vault. Trade there, store elsewhere.
''',
          'keyPoints': [
            'CEX = a company that runs a trading platform (like a stock broker)',
            'You trust them with your funds — they hold the private keys',
            'Great for beginners: easy UI, INR support, customer service',
            'Risk: exchange bankruptcy, hacks, or withdrawal freezes',
          ],
        },
        {
          'type': 'story',
          'title': 'The FTX Collapse',
          'emoji': '💀',
          'content': '''
**FTX** was the 2nd largest crypto exchange in the world. Worth ₹2.5 Lakh Crore.

**The Image:**
• Celebrity endorsements (Tom Brady, Steph Curry)
• Super Bowl ads
• CEO Sam Bankman-Fried on magazine covers
• "The most trusted exchange in crypto"

**The Reality (November 2022):**
Sam had secretly transferred **\$10 Billion** of customer funds to his hedge fund, Alameda Research, for risky bets.

When customers tried to withdraw: **"Withdrawals paused."**
3 days later: **FTX filed for bankruptcy.**

**₹60,000 Crore in customer funds — gone.**

**The Victims:**
• Professional traders who kept millions on FTX
• Ordinary people who treated FTX like a bank account
• Indian traders who had deposited via international transfers

**Lesson:**
It doesn't matter how big, famous, or "trusted" an exchange appears. **If you don't hold the private keys, you don't own the crypto.** FTX proved this in the most devastating way possible.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'What is the safest way to use a CEX like WazirX or Binance?',
          'options': [
            'Keep all your crypto on the exchange for easy access',
            'Use it for trading, then withdraw to your personal wallet for long-term storage',
            'Deposit your entire savings since big exchanges are too big to fail',
            'Only trade on exchanges that have celebrity endorsements',
          ],
          'correctIndex': 1,
          'explanation':
              'Use the CEX as a trading desk, not a vault. Buy your crypto, then transfer to a personal wallet (preferably cold storage) for anything you plan to hold long-term. FTX was "too big to fail" — until it wasn\'t.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'CEXs are companies — they can fail, get hacked, or freeze your funds',
            'Great for beginners: easy interface, INR support, customer service',
            'Use CEXs for active trading — withdraw to personal wallets for storage',
            'FTX collapse: ₹60,000 Crore lost because customers trusted the exchange',
            'Next: What if you could trade WITHOUT trusting any company at all?',
          ],
        },
      ],
    };
  }

  // Lesson 6.2: DEX: Trading Without Middlemen
  static Map<String, dynamic> getDexBasicsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Street Market',
          'emoji': '🌐',
          'content':
              'What if you could trade crypto directly from your wallet — no company, no KYC, no CEO who might steal your money? Welcome to Decentralized Exchanges. It sounds utopian. It\'s also complicated.',
        },
        {
          'type': 'concept',
          'title': 'How DEXs Work',
          'emoji': '⚡',
          'content': '''
**A DEX is a trading protocol that runs on blockchain smart contracts.** No company. No employees. Just code.

**Popular DEXs:**
• **Uniswap** (Ethereum)
• **PancakeSwap** (BSC)
• **Jupiter** (Solana)

**How They Work:**
1. Connect your wallet (MetaMask/Trust Wallet) directly to the DEX website.
2. Your crypto stays in YOUR wallet the entire time.
3. The smart contract swaps tokens directly: your ETH → someone else's USDC.
4. Trade completes. Tokens arrive in your wallet. No middleman touched anything.

**Liquidity Pools (The Magic Sauce):**
DEXs don't use traditional order books. Instead, users deposit crypto pairs into "pools."
Example: A pool of ETH + USDC. When you swap ETH for USDC, you take USDC from the pool and add ETH to it. The price adjusts automatically based on the ratio.

**Pros:**
• You always control your private keys
• No KYC — anyone with a wallet can trade
• No company can freeze your funds or go bankrupt
• Access to new tokens before they hit CEXs

**Cons:**
• Confusing for beginners
• Higher transaction fees on some networks
• No customer support — make a mistake, it's permanent
• Fake/scam tokens are common

---

**Key Insight:**
DEXs give you ultimate freedom AND ultimate responsibility. There is no "undo" button and no "customer care" number.
''',
          'keyPoints': [
            'DEXs are trading protocols — no company, no CEO, just smart contract code',
            'Your crypto never leaves your wallet during a trade',
            'No KYC, no account freezes, no bankruptcy risk',
            'But: no customer support, easy to encounter scam tokens, and user errors are permanent',
          ],
        },
        {
          'type': 'interactive',
          'title': 'CEX vs DEX: Full Comparison',
          'emoji': '⚖️',
          'content': '''
**Feature-by-Feature Comparison:**

**Control:**
• CEX: Exchange holds your crypto (their wallet) ❌
• DEX: You hold your crypto (your wallet) ✅

**Ease of Use:**
• CEX: Simple app, like a banking app ✅
• DEX: Complex, requires wallet setup ❌

**KYC Required:**
• CEX: Yes (Aadhaar, PAN mandatory in India) ✅
• DEX: No (just connect a wallet) ✅

**Customer Support:**
• CEX: Available (email, chat) ✅
• DEX: None — you're on your own ❌

**Security Risk:**
• CEX: Exchange hack or bankruptcy
• DEX: Smart contract bugs or scam tokens

**Fiat On-Ramp (INR deposit):**
• CEX: Yes — UPI, bank transfer ✅
• DEX: No — you need crypto first ❌

**Best For:**
• CEX: Beginners, INR trading, regular users
• DEX: Advanced users, DeFi, new token access

**Key Lesson:**
Start with a CEX to buy your first crypto. Graduate to DEXs as you gain experience and understand wallet security.
''',
        },
        {
          'type': 'scenario',
          'title': 'What Would You Do?',
          'situation':
              'You want to buy a new DeFi token that\'s only available on Uniswap (DEX). You\'ve never used a DEX before. The token is up 500% this week. Your friend says "Buy now before it\'s too late!"',
          'choices': [
            {
              'text':
                  'Rush to Uniswap and buy immediately — 500% gains can\'t be missed!',
              'isCorrect': false,
              'feedback':
                  '❌ DANGER! Tokens that are up 500% often crash 90% the next week. Also, fake tokens with identical names are common on DEXs. Rushing without experience = high chance of buying a scam token or losing funds to a wrong contract address.',
            },
            {
              'text':
                  'Learn how DEXs work first with a small test transaction, verify the token\'s contract address on CoinGecko, then decide',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect approach! Always verify token contract addresses on trusted sources (CoinGecko/CoinMarketCap). Start with a tiny test transaction to learn the process. If the opportunity is real, it\'ll still be there after you do your homework.',
            },
            {
              'text':
                  'Avoid DEXs entirely — they\'re too complicated and dangerous',
              'isCorrect': false,
              'feedback':
                  '❌ DEXs are a powerful tool when used correctly. Avoiding them entirely means missing out on genuine DeFi innovation. The key is learning at your own pace, not avoiding the technology forever.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 6 Complete! 🎉',
          'keyPoints': [
            'CEXs are beginner-friendly but come with counterparty risk (exchange failure)',
            'DEXs give you full control but require technical knowledge',
            'Start with CEXs for buying crypto, graduate to DEXs for DeFi access',
            'ALWAYS verify token contract addresses on trusted sites before buying on DEXs',
            'The tradeoff is always: convenience vs control, simplicity vs sovereignty',
            'Next: The elephant in the room — why does crypto crash 50% regularly?',
          ],
        },
      ],
    };
  }
}
