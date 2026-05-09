/// Chapter 5: How Crypto Trading Works
/// From trading pairs to placing your first order
class HowCryptoTradingWorksContent {
  // Lesson 5.1: Trading Pairs & Order Books
  static Map<String, dynamic> getTradingPairsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Speaking the Language of Crypto Trading',
          'emoji': '📈',
          'content':
              'You open a crypto exchange and see: BTC/USDT, ETH/INR, SOL/BTC. What do these mean? Why can\'t you just "buy Bitcoin" like you buy a stock? Let\'s decode the trading interface.',
        },
        {
          'type': 'concept',
          'title': 'Understanding Trading Pairs',
          'emoji': '🔀',
          'content': '''
**A trading pair tells you WHAT you're buying and WHAT you're paying with.**

**Format: BASE / QUOTE**
• **Base** = What you're buying or selling
• **Quote** = What you're paying with

**Example: BTC/USDT**
• Base: BTC (you're buying Bitcoin)
• Quote: USDT (you're paying with Tether dollars)
• Price: 50,00,000 means 1 BTC costs 50 Lakh USDT

**Example: ETH/INR**
• Base: ETH (you're buying Ethereum)
• Quote: INR (you're paying with Rupees)
• Price: 2,50,000 means 1 ETH costs ₹2.5 Lakhs

**Example: ETH/BTC**
• Base: ETH (you're buying Ethereum)
• Quote: BTC (you're paying with Bitcoin!)
• Price: 0.05 means 1 ETH costs 0.05 BTC

---

**Key Insight:**
In crypto, you can trade anything against anything. You don't always need Rupees. Professional traders often trade crypto-to-crypto pairs to avoid banking delays entirely.
''',
          'keyPoints': [
            'BASE/QUOTE: Buy the Base, pay with the Quote',
            'BTC/USDT = Buy Bitcoin with Tether',
            'ETH/INR = Buy Ethereum with Rupees',
            'Crypto-to-crypto pairs let you trade without touching fiat currency',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Reading the Order Book',
          'emoji': '📋',
          'content': '''
**An Order Book shows all pending buy and sell orders:**

**BTC/USDT Order Book:**

**🟢 Buy Orders (Bids) — Buyers waiting:**
• ₹49,90,000 → 0.5 BTC wanted
• ₹49,85,000 → 1.2 BTC wanted
• ₹49,80,000 → 3.0 BTC wanted

**🔴 Sell Orders (Asks) — Sellers waiting:**
• ₹50,10,000 → 0.3 BTC available
• ₹50,15,000 → 0.8 BTC available
• ₹50,20,000 → 2.0 BTC available

**The Gap (Spread):**
Highest bid: ₹49,90,000 | Lowest ask: ₹50,10,000
**Spread = ₹20,000** (the cost of instant execution)

**If you Market Buy:** You pay ₹50,10,000 (lowest ask).
**If you Limit Buy at ₹49,95,000:** Your order sits in the book until a seller matches.

**Key Lesson:**
Tight spreads = liquid market (easy to trade). Wide spreads = illiquid (expensive to trade). Always check the spread before trading small or new coins.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'In the pair ETH/BTC with a price of 0.05, what does it mean?',
          'options': [
            'Ethereum costs ₹0.05',
            '1 ETH can be bought for 0.05 BTC',
            'You need 50 ETH to buy 1 BTC',
            'Ethereum is 5% of Bitcoin\'s market cap',
          ],
          'correctIndex': 1,
          'explanation':
              'In ETH/BTC, ETH is the Base (what you buy) and BTC is the Quote (what you pay with). Price of 0.05 means 1 ETH = 0.05 BTC. This is a crypto-to-crypto pair — no fiat involved.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Trading pairs follow BASE/QUOTE format — buy the Base, pay with the Quote',
            'Order books show all pending buy and sell orders with prices and volumes',
            'Spread = gap between highest bid and lowest ask (your cost of instant execution)',
            'Tight spread = good liquidity; Wide spread = expensive to trade',
            'Next: How to store your crypto safely. This is the MOST important lesson.',
          ],
        },
      ],
    };
  }

  // Lesson 5.2: Wallets & Security
  static Map<String, dynamic> getWalletsSecurityContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'You Are Your Own Bank',
          'emoji': '🔐',
          'content':
              'In crypto, if you lose your password, nobody can help you. No customer care. No "forgot password" email. This lesson could save you lakhs — or cost you everything if you skip it.',
        },
        {
          'type': 'story',
          'title': 'Vikram\'s Expensive Lesson',
          'emoji': '😱',
          'content': '''
**Vikram**, a 27-year-old developer in Hyderabad, bought 2 ETH for ₹3 Lakhs.

**His Approach:**
He left everything on the exchange (WazirX). "It's like a bank — my money is safe there."

**November 2022:**
A major crypto exchange (FTX) collapsed. ₹60,000 Crore in customer funds — gone. Not hacked. The CEO had secretly used customer deposits for risky bets.

**Vikram panicked.**
He tried to withdraw from WazirX. But WazirX had frozen withdrawals due to regulatory issues.
His 2 ETH were stuck. For months.

**What Vikram should have done:**
• Bought a hardware wallet (Ledger/Trezor) for ₹5,000.
• Transferred his ETH to the hardware wallet.
• Written down his 24-word seed phrase on paper and stored it in a safe.
• **His ETH would have been under HIS control — not the exchange's.**

**The Mantra:**
"Not your keys, not your coins."
If you don't hold the private key, you don't own the crypto. You're trusting a company — and companies can fail.
''',
        },
        {
          'type': 'concept',
          'title': 'Hot Wallets vs Cold Wallets',
          'emoji': '🌡️',
          'content': '''
**Hot Wallet (Connected to Internet) 🔥**
• **Examples:** MetaMask, Trust Wallet, Exchange accounts (Binance, WazirX)
• **Pros:** Convenient, instant access, easy for trading
• **Cons:** Vulnerable to hacking, phishing, exchange bankruptcy
• **Use for:** Small amounts you actively trade (like a physical wallet)

**Cold Wallet (Offline Storage) ❄️**
• **Examples:** Ledger Nano, Trezor (hardware devices)
• **Pros:** Private keys never touch the internet. Immune to hacking.
• **Cons:** Cost ₹5,000-₹15,000. Less convenient for quick trades.
• **Use for:** Large holdings you plan to keep long-term (like a bank vault)

**The Seed Phrase (CRITICAL):**
When you create any wallet, you get a **12 or 24-word recovery phrase**.
This IS your wallet. Whoever has these words controls your funds.

**NEVER:**
• Take a screenshot of your seed phrase ❌
• Store it in Google Drive or iCloud ❌
• Share it with anyone — not even "support agents" ❌

**ALWAYS:**
• Write it on paper ✅
• Store in a fireproof safe ✅
• Make 2 copies in different locations ✅

---

**Key Insight:**
Your seed phrase is worth more than the device it's stored on. Treat it like a ₹50 Lakh diamond — because that's exactly what it could be worth.
''',
          'keyPoints': [
            'Hot wallets = convenient but vulnerable (like a pocket wallet)',
            'Cold wallets = secure but less convenient (like a bank vault)',
            'Seed phrase = master key to ALL your crypto. Never share it.',
            '"Not your keys, not your coins" — always self-custody large holdings',
          ],
        },
        {
          'type': 'scenario',
          'title': 'The Phishing Attack',
          'situation':
              'You receive an email that looks exactly like it\'s from MetaMask. It says: "Your wallet has been compromised! Click here to verify your seed phrase immediately to secure your funds." What do you do?',
          'choices': [
            {
              'text':
                  'Click the link and enter your seed phrase to protect your funds',
              'isCorrect': false,
              'feedback':
                  '❌ SCAM! This is a phishing attack. MetaMask (or any wallet provider) will NEVER ask for your seed phrase. The moment you enter it on a fake website, hackers drain your wallet in seconds. Delete the email immediately.',
            },
            {
              'text':
                  'Ignore the email completely — no legitimate service ever asks for your seed phrase',
              'isCorrect': true,
              'feedback':
                  '✅ Correct! NO legitimate wallet, exchange, or service will EVER ask for your seed phrase. Not by email, not by chat, not by phone. This is the #1 rule of crypto security. When in doubt, go directly to the official website — never click email links.',
            },
            {
              'text': 'Reply to the email asking if it\'s legitimate',
              'isCorrect': false,
              'feedback':
                  '❌ The scammer will reply "Yes, it\'s urgent!" Engaging with phishing emails only confirms your email is active, leading to more attacks. Delete and block.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            '"Not your keys, not your coins" — always control your private keys',
            'Hot wallets (MetaMask, exchanges) for trading; Cold wallets (Ledger) for storage',
            'Your seed phrase is everything — write it on paper, store in a safe, NEVER share',
            'No legitimate service will ever ask for your seed phrase — that\'s always a scam',
            'Exchange bankruptcy can lock your funds — self-custody removes this risk',
          ],
        },
      ],
    };
  }

  // Lesson 5.3: Your First Crypto Trade
  static Map<String, dynamic> getFirstTradeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Let\'s Do This!',
          'emoji': '🚀',
          'content':
              'You understand the theory. Now let\'s walk through a real trade step-by-step. From creating an account to owning your first crypto. No fear — we\'ll go slow.',
        },
        {
          'type': 'interactive',
          'title': 'Step-by-Step: Buying Your First Crypto',
          'emoji': '📱',
          'content': '''
**Step 1: Choose an Exchange 🏪**
In India: WazirX, CoinDCX, CoinSwitch, ZebPay
• Look for: SEBI/FIU compliance, low fees, INR support
• Start with a well-known exchange, not some random app

**Step 2: Complete KYC 🪪**
• Upload Aadhaar + PAN (mandatory in India)
• Selfie verification
• Takes 24-48 hours usually

**Step 3: Deposit INR 💰**
• UPI or bank transfer to your exchange account
• Start small: ₹500-₹1,000 (your "tuition fee")

**Step 4: Choose What to Buy 🎯**
• **For beginners:** BTC or ETH only. Nothing else.
• Don't buy random altcoins because they're "cheap"

**Step 5: Place the Order 📊**
• Select BTC/INR pair
• Choose "Limit Order" at a price you're comfortable with
• Or "Market Order" for instant execution

**Step 6: Secure Your Purchase 🔒**
• If holding long-term → Transfer to cold wallet
• If trading actively → Keep on exchange (with 2FA enabled)

**Important: Indian Tax Reality**
• 30% flat tax on crypto profits (no deductions)
• 1% TDS on all transactions above ₹10,000
• You CANNOT offset crypto losses against gains
''',
        },
        {
          'type': 'story',
          'title': 'The Unit Bias Trap',
          'emoji': '🪙',
          'content': '''
**Rohan** wanted to buy his first crypto.
He looked at Bitcoin. Price: ₹50,00,000. "I only have ₹10,000. I can't afford a whole Bitcoin, so it's too expensive."
Then he saw "ShibaDogeMoon" token. Price: ₹0.0001.
"Wow! For ₹10,000, I can get 10,00,00,000 (10 Crore) tokens! If it reaches ₹1, I'll be a billionaire!"

He bought the 10 Crore tokens.
Six months later, ShibaDogeMoon went to zero. The developers abandoned it.

**Why did Rohan fail?** Unit Bias.
He thought owning *millions* of something worthless was better than owning a *fraction* of something valuable. In crypto, you can buy fractions of coins (like 0.002 BTC). The number of coins you own is irrelevant; only the total value and quality of the project matter.

**Key lesson:** Don't buy cheap tokens just because you can get millions of them. Buy fractions of strong assets like BTC or ETH.
''',
        },
        {
          'type': 'scenario',
          'title': 'Your First Purchase Decision',
          'situation':
              'You have ₹5,000 to invest in crypto for the first time. You see: BTC at ₹50 Lakhs (you can buy ₹5,000 worth), a new token "MoonRocket" at ₹0.001 (you can buy 50 Lakh tokens!). Which do you choose?',
          'choices': [
            {
              'text':
                  'MoonRocket — I can get 50 Lakh tokens! That\'s way more than 0.0001 BTC!',
              'isCorrect': false,
              'feedback':
                  '❌ The number of units you own doesn\'t matter! MoonRocket has no proven utility, no security, and could go to ₹0 overnight. Buying 50 Lakh worthless tokens is still ₹0. Price per unit is IRRELEVANT.',
            },
            {
              'text':
                  'BTC — it\'s proven over 15 years and has real institutional adoption',
              'isCorrect': true,
              'feedback':
                  '✅ Smart! You can buy a fraction of BTC (₹5,000 worth = ~0.0001 BTC). Bitcoin has survived 15 years, multiple 80% crashes, and is held by governments and corporations. Start with the safest asset.',
            },
            {
              'text': 'Split 50-50 between both',
              'isCorrect': false,
              'feedback':
                  '❌ As a beginner, putting 50% into an unproven token is extremely risky. Master the basics with BTC/ETH first. You can explore altcoins after gaining experience and knowledge.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 5 Complete! 🎉',
          'keyPoints': [
            'Always start with a KYC-compliant Indian exchange',
            'Begin with ₹500-₹1,000 — treat it as tuition, not an investment',
            'Buy only BTC or ETH as a beginner — avoid random altcoins',
            'Remember: 30% tax on crypto profits in India + 1% TDS',
            'Transfer long-term holdings to a cold wallet for security',
            'Next: CEX vs DEX — where should you actually trade?',
          ],
        },
      ],
    };
  }
}
