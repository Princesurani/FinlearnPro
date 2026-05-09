/// Chapter 3: Blockchain Basics
/// The technology explained simply — no CS degree needed
class BlockchainBasicsContent {
  // Lesson 3.1: The Public Ledger
  static Map<String, dynamic> getPublicLedgerContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The World\'s Most Honest Notebook',
          'emoji': '📒',
          'content':
              'Imagine a notebook that everyone in the world can read, but nobody can erase or edit. Every transaction ever made is written in it permanently. That\'s a blockchain. Let\'s understand how.',
        },
        {
          'type': 'story',
          'title': 'Raju\'s Village Ledger',
          'emoji': '🏘️',
          'content': '''
**Raju** runs a small money-lending business in a village.

**The Old Way:**
He keeps all records in ONE notebook. Only HE has it.
• Gave ₹5,000 to Suresh? Written in Raju's notebook.
• Suresh paid back ₹3,000? Updated in Raju's notebook.

**The Problem:**
Suresh claims he paid ₹4,000, not ₹3,000. It's Raju's word against Suresh's.
Raju could easily change the notebook. Nobody would know.

**The Blockchain Way:**
What if EVERY person in the village had a copy of the same notebook?
• Raju lends ₹5,000 to Suresh → Written in EVERYONE's copy.
• Suresh pays back ₹3,000 → Updated in EVERYONE's copy.
• If Raju tries to change his copy to ₹2,000, the other 100 copies say ₹3,000.
• **Raju's fake entry gets rejected.**

**The Result:**
Nobody can cheat because everyone has the same truth. No single person controls the records.

**Lesson:**
This is exactly how blockchain works. Instead of one bank keeping records, thousands of computers worldwide keep identical copies. Cheating becomes mathematically impossible.
''',
        },
        {
          'type': 'concept',
          'title': 'How Blocks Form a Chain',
          'emoji': '🔗',
          'content': '''
**Think of blockchain as a chain of sealed envelopes:**

**Block = One Envelope**
• Contains a batch of transactions (e.g., "A sent 2 BTC to B").
• Has a unique **fingerprint** called a **Hash** (e.g., "a3f7b2...").
• Also contains the previous block's hash.

**The Chain:**
Block 1 (Hash: abc) → Block 2 (Prev: abc, Hash: def) → Block 3 (Prev: def, Hash: ghi)

**Why This Matters:**
If a hacker changes Block 1, its hash changes from "abc" to "xyz."
Now Block 2 says "Prev: abc" but Block 1's hash is "xyz." **Mismatch! Chain broken!**
The hacker would need to recalculate EVERY block after it — across thousands of computers simultaneously. **Practically impossible.**

---

**Key Insight:**
This chaining of hashes is what makes blockchain "immutable." It's not that no one CAN change it — it's that the cost of changing it exceeds any possible benefit. Math protects the truth.
''',
          'keyPoints': [
            'Each block contains transactions + a unique hash + the previous block\'s hash',
            'Changing one block breaks every subsequent block in the chain',
            'Thousands of computers hold identical copies — no single point of failure',
            'Immutability comes from math, not from laws or regulations',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Hash Demo: The Magic Fingerprint',
          'emoji': '🔍',
          'content': '''
**A Hash Function turns any input into a fixed-length "fingerprint":**

**Input → Hash Output (SHA-256):**
• "Hello" → 2cf24dba...
• "hello" → 2c26b46b... (completely different!)
• "Hello!" → 33ae4c2c... (completely different again!)

**Key Properties:**
1. **Same input = Same output** (always reproducible)
2. **Tiny change = Completely different output** (no patterns)
3. **One-way:** You can't reverse-engineer the input from the hash
4. **Fixed length:** Whether you hash a word or an entire book, the output is always 64 characters

**Why This Matters for Blockchain:**
Every block's hash is calculated from its contents. Change one comma in the transaction data, and the entire hash changes. The next block immediately knows something was tampered with.

**Real-World Analogy:**
It's like sealing an envelope with wax. If someone opens it and reseals it, you can see the broken seal. Except with hashing, the "seal" is mathematically perfect.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Why is it practically impossible to hack a blockchain and change a past transaction?',
          'options': [
            'Because the blockchain is protected by government firewalls',
            'Because changing one block breaks all subsequent blocks, and you\'d need to overpower thousands of computers simultaneously',
            'Because only Satoshi Nakamoto has the password to edit it',
            'Because blockchain data is stored in a secret location',
          ],
          'correctIndex': 1,
          'explanation':
              'Each block\'s hash depends on the previous block. Changing one transaction changes the hash, which invalidates every subsequent block. To succeed, a hacker would need to recalculate millions of hashes faster than the entire global network — which requires more computing power than exists on Earth.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Blockchain = a shared notebook that everyone can read but nobody can edit',
            'Each block contains transactions + a unique hash + the previous block\'s hash',
            'Changing one block breaks the entire chain — making fraud practically impossible',
            'Hash functions create unique "fingerprints" — any tiny change produces a totally different result',
            'Next: Who actually maintains this network? Meet the miners and stakers.',
          ],
        },
      ],
    };
  }

  // Lesson 3.2: Mining, Staking & Consensus
  static Map<String, dynamic> getMiningStakingContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Who Runs the Network?',
          'emoji': '⛏️',
          'content':
              'If there\'s no bank and no company behind Bitcoin, who verifies transactions? Who adds new blocks? And why would anyone volunteer to do it? The answer involves fascinating economics.',
        },
        {
          'type': 'concept',
          'title': 'Proof-of-Work: The Bitcoin Model',
          'emoji': '💪',
          'content': '''
**The Problem:**
Thousands of strangers need to agree on which transactions are valid. How?

**Bitcoin's Solution: Proof-of-Work (PoW)**
Miners compete to solve a complex math puzzle. The first to solve it gets to add the next block and earns a **reward**.

**How it works:**
1. Miners collect pending transactions from the mempool.
2. They race to find a special number (nonce) that produces a hash starting with many zeros.
3. This requires MASSIVE computing power — billions of guesses per second.
4. First miner to solve it broadcasts the block.
5. Other nodes verify the solution (easy to verify, hard to solve).
6. Winner earns: **3.125 BTC** (currently ~₹1.5 Crore!) + transaction fees.

**Why This Works:**
Cheating would require more computing power than all honest miners combined — costing billions of dollars in hardware and electricity. It's cheaper to play honestly.

---

**Key Insight:**
Proof-of-Work turns electricity into trust. The energy cost IS the security. That's why people say "Bitcoin is backed by energy."
''',
          'keyPoints': [
            'Miners solve math puzzles to earn the right to add blocks',
            'Bitcoin reward halves every 4 years (next halving ~2028)',
            'Cheating costs more than honest mining — economic incentive to be honest',
            'PoW consumes significant energy — a feature, not a bug (security)',
          ],
        },
        {
          'type': 'concept',
          'title': 'Proof-of-Stake: The Ethereum Model',
          'emoji': '🥩',
          'content': '''
**The Criticism of PoW:**
Bitcoin mining uses more electricity than some countries. That's expensive and environmentally controversial.

**Ethereum's Solution: Proof-of-Stake (PoS)**
Instead of solving puzzles with electricity, validators "stake" (lock up) their ETH as collateral.

**How it works:**
1. To become a validator, you lock up 32 ETH (~₹80 Lakhs) as a security deposit.
2. The network randomly selects a validator to propose the next block.
3. Other validators check the work and vote "yes" or "no."
4. Honest validators earn rewards (~4-5% annually).
5. **Dishonest validators lose their staked ETH** (called "slashing"). 💸

**PoW vs PoS Comparison:**
• **Energy:** PoW = massive; PoS = 99.95% less
• **Hardware:** PoW = expensive ASICs; PoS = regular computer
• **Security model:** PoW = electricity cost; PoS = financial risk
• **Criticism:** PoW = waste; PoS = "rich get richer"

---

**Key Insight:**
Neither is "better." PoW is battle-tested security (Bitcoin). PoS is energy-efficient and accessible (Ethereum). Different goals, different tradeoffs.
''',
          'keyPoints': [
            'PoS validators lock up crypto as collateral instead of using electricity',
            'Dishonest validators lose their stake (slashing)',
            'PoS uses 99.95% less energy than PoW',
            'Both achieve the same goal: agreement without a central authority',
          ],
        },
        {
          'type': 'scenario',
          'title': 'What Would You Do?',
          'situation':
              'A friend says: "Bitcoin is terrible for the environment — it wastes so much electricity! Ethereum is way better because it uses Proof-of-Stake." How do you respond?',
          'choices': [
            {
              'text':
                  '"You\'re right — Bitcoin should switch to Proof-of-Stake too"',
              'isCorrect': false,
              'feedback':
                  '❌ Bitcoin\'s PoW is a deliberate design choice. The energy cost IS the security. Changing it would fundamentally alter Bitcoin\'s security model. Bitcoin maximalists argue the energy is "worth it" for a censorship-resistant global monetary network.',
            },
            {
              'text':
                  '"Both have tradeoffs. PoW prioritizes security; PoS prioritizes efficiency. Neither is universally better."',
              'isCorrect': true,
              'feedback':
                  '✅ Nuanced answer! PoW provides the strongest security guarantees through physical energy expenditure. PoS is more efficient but introduces different risks (centralization of wealth). Understanding tradeoffs is key.',
            },
            {
              'text':
                  '"Crypto is bad for the environment. We should avoid all of it."',
              'isCorrect': false,
              'feedback':
                  '❌ This ignores that many blockchains (Ethereum, Solana, Polygon) use minimal energy. Also, Bitcoin mining increasingly uses renewable energy. The picture is more nuanced than "all crypto = bad for environment."',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 3 Complete! 🎉',
          'keyPoints': [
            'Proof-of-Work: Miners compete using computing power to earn block rewards',
            'Proof-of-Stake: Validators lock up crypto as collateral to earn staking rewards',
            'PoW = security through energy cost; PoS = security through financial risk',
            'Bitcoin uses PoW (battle-tested); Ethereum switched to PoS (energy-efficient)',
            'Neither consensus mechanism is universally "better" — both have tradeoffs',
            'Next: Not all crypto assets are the same. Coins, tokens, stablecoins — let\'s sort them out.',
          ],
        },
      ],
    };
  }
}
