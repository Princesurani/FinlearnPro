/// Chapter 6: Crypto Fundamentals
/// Use cases, tokenomics, and project evaluation
class CryptoFundamentalsContent {
  // Lesson 6.1: Evaluating Crypto Projects
  static Map<String, dynamic> getEvaluatingProjectsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Beyond "Number Go Up"',
          'emoji': '🔍',
          'content':
              'There are 20,000+ cryptocurrencies. 95% will go to zero. The 5% that survive will generate life-changing returns. How do you separate the winners from the scams? Not by looking at price charts — by understanding FUNDAMENTALS.',
        },
        {
          'type': 'concept',
          'title': 'The Crypto Evaluation Framework',
          'emoji': '📋',
          'content': '''
**Unlike stocks, crypto doesn't have P/E ratios or balance sheets. Instead, evaluate:**

**1. Use Case: What Problem Does It Solve? 🎯**
• Does it have a REAL use case beyond speculation?
• Bitcoin: Digital gold / store of value ✅
• Ethereum: Platform for smart contracts and DApps ✅
• Meme coin with no utility: ❌

**2. Team & Development 👥**
• Who built it? Are developers active?
• Check GitHub activity (is code being updated?)
• Anonymous founders? Higher risk.
• Ex-Google/Meta/IIT founders? More credible.

**3. Community & Adoption 📊**
• How many active users/wallets?
• Is adoption GROWING or stagnant?
• Developer ecosystem: Are people building ON this platform?
• Partnerships: Which companies are using it?

**4. Competitive Advantage (Moat) 🏰**
• What does this project do BETTER than alternatives?
• Network effects: More users → More value → More users (Bitcoin, Ethereum)
• First-mover advantage, technology superiority, brand recognition

**5. Red Flags to Run From 🚩**
• Guaranteed returns promised (Ponzi scheme!)
• Anonymous team with no track record
• No working product — only a fancy website
• Celebrity endorsements as the main marketing strategy
• Token has no utility beyond "holding and hoping"

---

**Key Insight:**
Apply the same SKEPTICISM to crypto that you'd apply to a ₹10,000 investment in a friend's "guaranteed" business idea. If you can't explain what the project DOES in one sentence, you probably shouldn't invest.
''',
          'keyPoints': [
            'Evaluate: use case, team, adoption, competitive advantage, red flags',
            'Real utility + active development + growing adoption = strong fundamentals',
            'Anonymous teams, guaranteed returns, and no working product = red flags',
            'If you can\'t explain what it does in one sentence, don\'t invest',
          ],
        },
        {
          'type': 'interactive',
          'title': 'The Whitepaper Test',
          'emoji': '📄',
          'content': '''
**Every crypto project has a "Whitepaper" (a document explaining what it does). Let's evaluate two real-world examples.**

**Project A (Chainlink - LINK):**
*Use Case:* "Smart contracts can't access real-world data (like stock prices or weather). We provide a decentralized oracle network to feed external data into smart contracts securely."
*Verdict:* **Pass.** It solves a massive, real technical problem holding back the entire blockchain industry. It has actual utility.

**Project B (SafeMoon):**
*Use Case:* "SafeMoon is a community-driven DeFi token. Three functions occur during each trade: Reflection, LP Acquisition, and Burn. Holding it guarantees you earn more tokens passively."
*Verdict:* **Fail.** Notice what's missing? It doesn't solve any real-world or technical problem. The *only* utility is a complex mechanism designed to trap people into holding it while the founders sell.

**The Golden Rule:**
If the whitepaper sounds like an engineering manual solving a problem, it might be legit. If it sounds like a multi-level marketing pitch focused on "passive income," run away.
''',
        },
        {
          'type': 'scenario',
          'title': 'Project Evaluation',
          'situation':
              'A friend recommends "MoonRocket Token." It has: celebrity endorsements on Instagram, promises 100x returns, anonymous founders, a flashy website but no working product, and its only use case is "holding for price appreciation." Should you invest?',
          'choices': [
            {
              'text': 'Yes — the celebrity endorsements prove it\'s legitimate',
              'isCorrect': false,
              'feedback':
                  '❌ Celebrity endorsements are PAID promotions, not investment advice. Celebrities endorsed BitConnect (Ponzi scheme that collapsed), FTX (fraud), and dozens of rug-pulls. If the main marketing is celebrity endorsements, it\'s almost certainly a scam.',
            },
            {
              'text':
                  'AVOID — every single indicator screams scam: anonymous team, no product, promised returns, and no utility beyond speculation',
              'isCorrect': true,
              'feedback':
                  '✅ Perfect evaluation! You identified ALL the red flags: (1) Anonymous founders, (2) No working product, (3) Guaranteed returns = Ponzi language, (4) No real use case, (5) Celebrity marketing is a manipulation tactic. This is a textbook scam/rug-pull setup.',
            },
            {
              'text': 'Invest a small amount — what if it actually does 100x?',
              'isCorrect': false,
              'feedback':
                  '❌ The "small amount" argument is how scams work. ₹5,000 from millions of people = ₹Crores for the scammers. Also, investing in something you KNOW is fundamentally worthless trains your brain to gamble, not invest. Discipline means saying NO.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Evaluate crypto projects like businesses: use case, team, adoption, moat',
            'Real use case + active development + growing users = potentially legitimate',
            'Guaranteed returns, anonymous teams, and no product = almost certainly a scam',
            '95% of crypto projects will fail — rigorous evaluation is essential',
            'Next: Tokenomics — the economic design that determines a token\'s long-term value.',
          ],
        },
      ],
    };
  }

  // Lesson 6.2: Tokenomics
  static Map<String, dynamic> getTokenomicsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Economics of Digital Money',
          'emoji': '🪙',
          'content':
              'Tokenomics = Token + Economics. It\'s how a crypto project designs its token\'s supply, distribution, and demand mechanics. Great tokenomics = sustainable value growth. Bad tokenomics = inevitable price collapse.',
        },
        {
          'type': 'concept',
          'title': 'Tokenomics Fundamentals',
          'emoji': '📊',
          'content': '''
**Supply Mechanics (How many tokens exist?):**

**1. Maximum Supply Cap 🔢**
• Bitcoin: 21 million BTC (EVER). No more can be created.
• Scarcity → As demand grows, limited supply pushes price up
• Like gold — finite supply = store of value potential

**2. Inflationary vs Deflationary 📈📉**
• **Inflationary:** New tokens are continuously created (like Dogecoin — 14M new DOGE daily)
  → Constant selling pressure → Price struggles long-term
• **Deflationary:** Tokens are burned/destroyed (like Ethereum post-EIP-1559)
  → Supply decreases → Price pressure upward

**3. Circulating vs Total Supply 🔄**
• Circulating Supply: Tokens currently tradeable in the market
• Total Supply: All tokens that will EVER exist
• If only 10% is circulating and 90% will unlock later → Massive future selling pressure!

---

**Distribution (Who holds the tokens?):**
• **Team/Founders:** Healthy = 10-20%. Red flag = 40%+
• **Investors/VCs:** Watch for large unlock events ("cliff" dates)
• **Community/Public:** Higher community share = healthier distribution
• **Locked/Vesting:** Tokens that release over time — check the schedule!

---

**Demand Mechanics (Why would anyone BUY this token?):**
• **Utility:** Required to use the platform (ETH for gas fees) ✅
• **Staking:** Lock tokens to earn rewards → Reduces selling pressure ✅
• **Governance:** Vote on project decisions → Active community ✅
• **Pure speculation:** Only reason to hold is "price go up" → Unsustainable ❌

---

**Key Insight:**
Good tokenomics: Capped supply + real utility + fair distribution + staking.
Bad tokenomics: Unlimited supply + no utility + team holds 50% + no lock-up.
''',
          'keyPoints': [
            'Capped supply (like Bitcoin\'s 21M) creates scarcity → price appreciation',
            'Check circulating vs total supply — large future unlocks = selling pressure',
            'Team/founder allocation > 30% is a red flag — they might dump on you',
            'Good tokens have real utility (gas fees, staking, governance) beyond speculation',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Tokenomics Comparison',
          'emoji': '📊',
          'content': '''
**Bitcoin (BTC) — Gold Standard Tokenomics:**
• Max Supply: 21 million (forever)
• Circulating: ~19.5 million (93%)
• New Supply: "Halving" every 4 years (reduces new BTC by 50%)
• Founder Allocation: Satoshi holds ~1M BTC (locked, never moved)
• Utility: Store of value, payment, collateral
• **Verdict: Excellent tokenomics — deflationary, fair distribution ✅**

**Dogecoin (DOGE) — Inflationary Meme:**
• Max Supply: Unlimited! (no cap)
• New Supply: ~14.4 million DOGE created EVERY DAY
• Inflation Rate: ~5% per year (and never stops)
• Utility: Tipping, memes, Elon tweets
• **Verdict: Poor tokenomics — infinite supply, no scarcity ❌**

**Ethereum (ETH) — The Evolution:**
• Max Supply: No hard cap, BUT...
• Post-EIP-1559: ETH is BURNED with every transaction
• Net result: ETH has become deflationary (more burned than created)
• Utility: Gas fees for entire DeFi/NFT/DApp ecosystem
• **Verdict: Strong tokenomics — real utility + deflationary mechanism ✅**

**Key Lesson:**
Bitcoin's tokenomics are the reason it went from \$0 to \$70,000+. Dogecoin's tokenomics are the reason it needs constant hype (Elon tweets) to maintain price. Design matters more than marketing.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'A new gaming token "GamerCoin" launches. The total supply is 1 Billion. Only 5% (50 million) is circulating today. The other 95% unlocks over the next 2 years. The token price is \$1 today. What is the major risk?',
          'options': [
            'There is no risk; 1 Billion is a small supply compared to Dogecoin',
            'The massive future unlocks (95% of supply) will create constant, overwhelming selling pressure over the next 2 years, likely crashing the price.',
            'The low circulating supply makes it a great buy because it\'s rare right now',
            'Gaming tokens are always good investments regardless of tokenomics',
          ],
          'correctIndex': 1,
          'explanation':
              'This is the classic "low float, high fully-diluted-valuation" trap. While the 5% circulating supply might pump the price temporarily, the incoming flood of 95% new tokens means early investors and VCs will constantly be dumping their unlocked tokens on retail buyers. The inflation rate of the circulating supply will crush the price.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 6 Complete! 🎉',
          'keyPoints': [
            'Tokenomics = supply mechanics + distribution + demand drivers',
            'Capped supply + real utility + fair distribution = strong fundamentals',
            'Watch for large token unlocks — they create selling pressure',
            'Bitcoin = gold standard tokenomics; Dogecoin = cautionary tale',
            'If a token\'s only demand driver is speculation, it will eventually crash',
            'Next: The final chapter — when do fundamentals matter MORE than charts?',
          ],
        },
      ],
    };
  }
}
