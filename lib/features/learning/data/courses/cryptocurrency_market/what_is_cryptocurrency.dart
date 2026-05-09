/// Chapter 2: What is Cryptocurrency
/// The origins, mechanics, and evolution of digital money
class WhatIsCryptocurrencyContent {
  // Lesson 2.1: The Birth of Bitcoin
  static Map<String, dynamic> getBirthOfBitcoinContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Money Revolution',
          'emoji': '📜',
          'content':
              'In 2008, the world\'s biggest banks collapsed. Governments printed trillions to save them. In that chaos, a mysterious person published a 9-page paper that would change finance forever. This is the story of Bitcoin.',
        },
        {
          'type': 'story',
          'title': 'The Crisis That Started It All',
          'emoji': '🏦',
          'content': '''
**2008: The Global Financial Meltdown.**

Lehman Brothers — a 158-year-old bank — goes bankrupt.
Stock markets crash 50%. People lose homes, jobs, savings.

**The Cause?**
Banks gave risky loans to people who couldn't pay back. They packaged these bad loans and sold them as "safe investments." When the house of cards collapsed, taxpayers paid the price.

**The Outrage:**
• Banks got **bailouts** worth trillions of taxpayer money.
• Bank CEOs kept their bonuses.
• Regular people lost everything.

**October 31, 2008:**
An anonymous person (or group) named **Satoshi Nakamoto** publishes a paper: "Bitcoin: A Peer-to-Peer Electronic Cash System."

**The Core Idea:**
"What if we could have money that no bank controls? No government can print more of? No CEO can manipulate?"

**January 3, 2009:**
Satoshi mines the first Bitcoin block. In it, he embeds a newspaper headline:
**"The Times 03/Jan/2009 Chancellor on brink of second bailout for banks"**

A permanent reminder of WHY Bitcoin was created.

**Lesson:**
Bitcoin wasn't born from greed. It was born from broken trust. Understanding this is key to understanding its value.
''',
        },
        {
          'type': 'concept',
          'title': 'What Makes Bitcoin Special?',
          'emoji': '🔑',
          'content': '''
**Bitcoin solved the "Double-Spend Problem":**

Before Bitcoin, digital money had one fatal flaw: you could copy it.
If money is just a file, what stops you from sending the same ₹100 to two people?

Banks solve this by keeping a central ledger. But that means trusting the bank.

**Bitcoin's solution:**
Replace the bank with **math and code**.

**Key Properties:**
• **Decentralized:** No single company or government controls it. Run by thousands of computers worldwide.
• **Limited Supply:** Only 21 million Bitcoin will EVER exist. No government can "print more."
• **Transparent:** Every transaction is visible on the public blockchain. Anyone can verify.
• **Immutable:** Once recorded, transactions cannot be changed or reversed.
• **Permissionless:** Anyone with internet can use it. No KYC, no bank approval needed.

---

**Key Insight:**
Bitcoin is "digital gold." It's not designed for buying chai — it's designed to be a store of value that no government can inflate away. That's its entire value proposition.
''',
          'keyPoints': [
            'Bitcoin solved the double-spend problem without needing a bank',
            'Only 21 million BTC will ever exist — engineered scarcity',
            'It\'s decentralized — no single entity controls it',
            'Every transaction is public and permanent on the blockchain',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Why did Satoshi Nakamoto embed a newspaper headline about bank bailouts in Bitcoin\'s first block?',
          'options': [
            'To timestamp when the block was created',
            'As a political statement that Bitcoin was born from distrust in the banking system',
            'It was a random headline with no meaning',
            'To advertise the newspaper',
          ],
          'correctIndex': 1,
          'explanation':
              'The headline "Chancellor on brink of second bailout for banks" was deliberately chosen. It serves as both a timestamp AND a permanent statement about WHY Bitcoin was created — as an alternative to a banking system that failed ordinary people.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Bitcoin was created in 2008 as a response to the global banking crisis',
            'Satoshi Nakamoto\'s identity remains unknown to this day',
            'The core innovation: decentralized money with no single point of control',
            'Only 21 million Bitcoin will ever exist — unlike fiat currencies that can be printed endlessly',
            'Bitcoin is "digital gold" — a store of value, not a payment method',
            'Next: How does cryptocurrency actually work under the hood?',
          ],
        },
      ],
    };
  }

  // Lesson 2.2: How Cryptocurrency Actually Works
  static Map<String, dynamic> getHowCryptoWorksContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Under the Hood',
          'emoji': '⚙️',
          'content':
              'You press "Send." ₹10,000 worth of Bitcoin moves from India to Japan in 10 minutes. No bank involved. How? Let\'s break down the actual mechanics.',
        },
        {
          'type': 'concept',
          'title': 'How a Crypto Transaction Works',
          'emoji': '🔄',
          'content': '''
**Step 1: You Initiate a Transfer**
You tell the network: "Send 0.01 BTC from my address to Kenji's address."
You sign this with your **Private Key** (like a digital signature).

**Step 2: Broadcasting**
Your transaction is broadcast to thousands of computers (nodes) worldwide.
It enters a "waiting room" called the **Mempool**.

**Step 3: Verification**
Miners/Validators pick up your transaction and verify:
• Does your address actually have 0.01 BTC? ✅
• Is the digital signature valid? ✅
• Is this a double-spend attempt? ❌ Not allowed.

**Step 4: Block Creation**
Your transaction is bundled with hundreds of others into a **Block**.
The block is added to the chain. **Done. Irreversible.**

**Step 5: Confirmation**
Kenji in Japan sees the BTC in his wallet.
No bank approved it. No government allowed it. Math verified it.

---

**Key Insight:**
In traditional banking, you trust people (bank employees, regulators). In crypto, you trust math (cryptography, consensus algorithms). That's the fundamental shift.
''',
          'keyPoints': [
            'Transactions are signed with private keys (like a digital signature)',
            'Thousands of computers verify every transaction independently',
            'Once confirmed in a block, transactions are permanent and irreversible',
            'Trust shifts from people/institutions to mathematics and code',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Bank Transfer vs Bitcoin Transfer',
          'emoji': '📊',
          'content': '''
**Sending ₹10,000 from India to Japan:**

**NEFT/SWIFT (Bank):**
• Intermediaries: Your Bank → RBI → Correspondent Bank → Japanese Bank
• Time: 1-5 business days
• Fee: ₹1,500-₹3,000
• Working Hours: Mon-Fri, 9 AM - 5 PM
• Can be frozen: Yes (by any bank in the chain)

**Bitcoin:**
• Intermediaries: None (peer-to-peer)
• Time: 10-60 minutes
• Fee: ₹50-₹500 (varies by network congestion)
• Working Hours: 24/7/365
• Can be frozen: No (unless you lose your private key)

**The Tradeoff:**
• Bank: Slower & expensive, but reversible if fraud occurs.
• Bitcoin: Faster & cheaper, but if you send to wrong address = gone forever.

**Key Lesson:**
Freedom comes with responsibility. In crypto, YOU are your own bank. There's no "customer care" to call.
''',
        },
        {
          'type': 'scenario',
          'title': 'What Would You Do?',
          'situation':
              'You want to send ₹50,000 to your brother studying in Germany. He needs it urgently for rent (due tomorrow). The bank says wire transfer will take 3-5 days. A friend suggests sending USDT via crypto. What do you do?',
          'choices': [
            {
              'text': 'Wait for the bank wire — crypto is too risky',
              'isCorrect': false,
              'feedback':
                  '❌ Your brother needs the money tomorrow. The bank won\'t deliver in time. In this specific situation, a stablecoin transfer (which doesn\'t fluctuate in value) could be the practical solution — IF you know how to do it safely.',
            },
            {
              'text':
                  'Send USDT — but only if both of you understand how wallets work',
              'isCorrect': true,
              'feedback':
                  '✅ Smart approach! USDT is pegged to the dollar, so no price fluctuation risk. The key is that both sender and receiver must know how to handle wallets, addresses, and the correct network. Education before action.',
            },
            {
              'text': 'Send Bitcoin instead — it might appreciate in value!',
              'isCorrect': false,
              'feedback':
                  '❌ Your brother needs rent money, not an investment. Bitcoin can drop 10% overnight. For urgent payments, use stablecoins (USDT/USDC), not volatile assets.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Crypto transactions are verified by thousands of independent computers, not banks',
            'Private keys are like your ATM PIN + signature combined — lose it, lose everything',
            'Transactions are irreversible once confirmed on the blockchain',
            'Crypto is faster and cheaper than banking — but you bear full responsibility',
            'Use stablecoins for payments, Bitcoin for long-term value storage',
          ],
        },
      ],
    };
  }

  // Lesson 2.3: Crypto Reality Check (Quiz)
  static Map<String, dynamic> getCryptoRealityCheckContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Reality Check',
          'emoji': '🧠',
          'content':
              'You\'ve learned about Bitcoin\'s origin and how crypto transactions work. Now let\'s test your understanding. Remember — every wrong answer here is a mistake you WON\'T make with real money.',
        },
        {
          'type': 'quiz',
          'title': 'Question 1: Origins',
          'question': 'Bitcoin was primarily created to:',
          'options': [
            'Help people buy things online faster than credit cards',
            'Provide a decentralized alternative to the banking system that failed in 2008',
            'Make its creator Satoshi Nakamoto rich',
            'Replace the Indian Rupee as the national currency',
          ],
          'correctIndex': 1,
          'explanation':
              'Bitcoin was born from the 2008 financial crisis. Its whitepaper describes a "peer-to-peer electronic cash system" — designed to work without trusted third parties (banks) that had just failed millions of people.',
        },
        {
          'type': 'quiz',
          'title': 'Question 2: Supply',
          'question':
              'What happens when all 21 million Bitcoin have been mined (estimated around 2140)?',
          'options': [
            'The Bitcoin network shuts down permanently',
            'Satoshi will create more Bitcoin to keep the system running',
            'Miners will earn fees from transactions instead of new Bitcoin rewards',
            'The price will automatically go to zero',
          ],
          'correctIndex': 2,
          'explanation':
              'Bitcoin\'s design ensures that even after all coins are mined, the network continues. Miners will be incentivized by transaction fees paid by users. The hard cap of 21 million can NEVER be changed — it\'s written in the code.',
        },
        {
          'type': 'quiz',
          'title': 'Question 3: Irreversibility',
          'question':
              'You accidentally send 1 BTC (₹50 Lakhs) to the wrong wallet address. What can you do?',
          'options': [
            'Contact Bitcoin customer support to reverse it',
            'Ask your bank to file a chargeback',
            'Nothing — the transaction is irreversible on the blockchain',
            'Call SEBI to investigate and recover your funds',
          ],
          'correctIndex': 2,
          'explanation':
              'There IS no Bitcoin customer support. No bank. No regulator. Blockchain transactions are final and irreversible. This is why you must ALWAYS double-check the wallet address before sending. Freedom = Responsibility.',
        },
        {
          'type': 'scenario',
          'title': 'The Dinner Table Debate',
          'situation':
              'At a family dinner, your uncle says: "Bitcoin is a scam — it\'s not backed by anything! At least the Rupee is backed by the government." How do you respond?',
          'choices': [
            {
              'text':
                  '"You\'re right uncle, it\'s all a scam. I\'m staying away."',
              'isCorrect': false,
              'feedback':
                  '❌ Dismissing all crypto as a "scam" is as uninformed as calling it a guaranteed investment. Bitcoin has survived 15+ years, multiple crashes, and is now held by governments and hedge funds. It\'s worth understanding.',
            },
            {
              'text':
                  '"The Rupee isn\'t backed by gold either — it\'s backed by trust in the government. Bitcoin is backed by trust in mathematics and code."',
              'isCorrect': true,
              'feedback':
                  '✅ Excellent point! The Rupee left the gold standard decades ago. Its value comes from government trust. Bitcoin\'s value comes from mathematical scarcity (21M cap), network security, and global adoption. Neither is "backed" by anything physical.',
            },
            {
              'text':
                  '"Bitcoin will replace the Rupee soon — you should buy now!"',
              'isCorrect': false,
              'feedback':
                  '❌ Overhyping crypto is as bad as dismissing it. Bitcoin is NOT designed to replace national currencies. It\'s a different asset class — more like digital gold than digital cash.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 2 Complete! 🎉',
          'keyPoints': [
            'Bitcoin was born from the 2008 banking crisis — a response to broken trust',
            'Only 21 million BTC will ever exist — artificial scarcity by design',
            'Crypto transactions are verified by math, not by banks or governments',
            'Irreversibility is both a feature (no censorship) and a risk (no undo)',
            'Bitcoin is "digital gold" — not a replacement for your bank account',
            'Next: How does the blockchain actually work? Let\'s decode the technology.',
          ],
        },
      ],
    };
  }
}
