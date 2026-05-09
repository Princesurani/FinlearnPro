/// Chapters 3-4: Fees & Costs + Regulations & Compliance
class FeesAndCostsContent {
  static Map<String, dynamic> getTrueCostContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Invisible Tax on Traders',
          'emoji': '🔍',
          'content':
              'You bought a stock, made ₹1,000 profit, and celebrated. But after brokerage, STT, GST, stamp duty, exchange charges, and SEBI fees, your real profit was ₹650. Every trade has at least 6 layers of costs.',
        },
        {
          'type': 'concept',
          'title': 'The Six Layers of Trading Costs',
          'emoji': '🧅',
          'content': '''
**Layer 1: Brokerage 💳**
The fee your broker charges. Discount brokers: ₹20/trade or free for delivery.

**Layer 2: Securities Transaction Tax (STT) 🏛️**
Government tax on every exchange transaction. Equity delivery: 0.1% on buy AND sell side. F&O: 0.05% on sell side only. You CANNOT avoid this.

**Layer 3: Exchange Transaction Charges 📊**
NSE charges: ~0.00345% of turnover. BSE charges: ~0.00375%. Tiny per trade, but adds up.

**Layer 4: GST (18%) 📋**
Applied on brokerage + exchange charges. If brokerage is ₹20, GST = ₹3.60.

**Layer 5: SEBI Charges 🛡️**
₹10 per crore of turnover. Negligible for small traders.

**Layer 6: Stamp Duty 📬**
State-level duty on buy-side transactions. Typically 0.015% for delivery, 0.003% for intraday.

---

**Example: ₹1,00,000 Intraday Buy + Sell**
• Brokerage: ₹20 × 2 = ₹40
• STT (sell): ~₹50
• Exchange: ~₹7
• GST: ~₹8.50
• Stamp Duty: ~₹3
**Total cost: ~₹108.50 for a ₹1L round trip.**
If you do this 200 times/year: **₹21,700/year in costs.**
''',
          'keyPoints': [
            '6 layers: Brokerage, STT, Exchange, GST, SEBI, Stamp Duty',
            'STT is the largest cost and cannot be avoided',
            '₹1L round trip costs ~₹108 in total fees',
            'Active traders pay ₹20,000+ per year in hidden costs',
          ],
        },
        {
          'type': 'story',
          'title': 'The Death by a Thousand Cuts',
          'emoji': '🩸',
          'content': '''
**Vikram thought he was making money.**
He day-traded Bank Nifty options. He traded 20 times a day, trying to catch 5-point moves.

At the end of the month, his trading journal showed:
Winning trades: ₹50,000
Losing trades: -₹40,000
**Gross Profit: ₹10,000** (He was happy!)

Then he looked at his broker's ledger:
Total Brokerage (20 trades x 20 days x ₹40): ₹16,000
STT, Exchange Fees, GST: ₹6,000
**Total Costs: ₹22,000**

**Net Result: -₹12,000 (A Loss).**

**Key lesson:** Vikram wasn't trading for himself; he was working full-time to generate revenue for his broker and the government. If your strategy relies on tiny profits, the fixed costs of trading will bleed you dry.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Which trading cost is the LARGEST for an active equity trader?',
          'options': [
            'Brokerage (₹20/trade)',
            'Securities Transaction Tax (STT)',
            'GST',
            'SEBI charges',
          ],
          'correctIndex': 1,
          'explanation':
              'STT is typically the largest cost. At 0.1% of trade value, a ₹1L trade incurs ₹100 in STT alone. Brokerage is only ₹20. This is why even "zero brokerage" brokers still have costs — because STT is a government tax, not a broker fee.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Every trade has 6 layers of costs beyond brokerage',
            'STT is the largest and cannot be avoided',
            'Active traders lose ₹20K+ per year to costs alone',
            'These costs matter most for scalpers with small per-trade profits',
            'Next: How to minimize your overall trading costs.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getMinimizingCostsContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Keep More of Your Profits',
          'emoji': '💰',
          'content':
              'You can not eliminate trading costs, but you can minimize them. The strategies are simple: trade less frequently, use delivery instead of intraday when possible, and choose the right broker.',
        },
        {
          'type': 'concept',
          'title': 'Cost Reduction Strategies',
          'emoji': '📉',
          'content': '''
**Strategy 1: Trade Less, Trade Better 🎯**
Fewer trades = fewer costs. If you take 3 quality trades/week instead of 20, you reduce costs by 85%.

**Strategy 2: Use Delivery for Swing Trades 📦**
Most discount brokers charge ZERO brokerage for delivery (buy and hold) trades. Use delivery mode for swing trades lasting 2+ days.

**Strategy 3: Avoid F&O Unless Necessary ⚠️**
F&O STT rates are different and can be higher on certain transactions. Use cash equity when possible.

**Strategy 4: Use Limit Orders, Not Market Orders 📊**
Market orders often fill at slightly worse prices (slippage). Limit orders give you exact price control. Over 200 trades, the slippage savings add up.

**Strategy 5: Consolidate Position Sizes 📏**
Instead of buying 3 small positions, buy 1 calculated position. Fewer order executions = fewer brokerage charges.

---

**Key Insight:**
The biggest cost reduction is not about finding cheaper brokers — it is about taking FEWER, BETTER trades. Quality over quantity reduces costs AND improves performance.
''',
          'keyPoints': [
            'Fewer trades = lower costs AND better performance',
            'Use delivery mode (free brokerage) for swing trades',
            'Limit orders save money vs. market orders (slippage)',
            'Quality over quantity is the ultimate cost reduction strategy',
          ],
        },
        {
          'type': 'story',
          'title': 'The Switch to Swing Trading',
          'emoji': '🔄',
          'content': '''
**Neha** was an active day trader losing ₹15,000 a month to brokerage and STT.

**Her shift:** She switched to Swing Trading (buying and holding for 3-10 days).
She went from taking 50 trades a week to just 3 trades a week.
She started taking delivery of stocks instead of using intraday leverage.

**The Impact:**
1. Her broker charged ₹0 for delivery trades.
2. She paid STT only on 6 transactions a week instead of 100.
3. Her costs dropped by 95%.
4. Because she was forced to be selective, her win rate improved from 40% to 60%.

**Key lesson:** You cannot negotiate STT or exchange fees, but you have 100% control over how often you trade. Slower trading styles (swing/positional) are mathematically cheaper than fast trading styles (scalping/intraday).
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question': 'Which order type typically gets a WORSE fill price?',
          'options': [
            'Limit Order (you set the exact price)',
            'Market Order (fills at whatever price is available)',
            'Both are identical',
            'Stop Loss Order',
          ],
          'correctIndex': 1,
          'explanation':
              'Market orders execute immediately at the best available price, which may be slightly worse than expected (slippage). Limit orders only execute at YOUR specified price or better. For large orders in volatile markets, the slippage on market orders can be significant.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 3 Complete! 🎉',
          'keyPoints': [
            'Trading has 6 layers of costs — STT is the largest',
            'Fewer, better trades reduce costs dramatically',
            'Use delivery mode for free brokerage on swing trades',
            'Limit orders prevent slippage costs',
            'Next: How regulations protect you and what you must follow.',
          ],
        },
      ],
    };
  }
}

class RegulationsComplianceContent {
  static Map<String, dynamic> getSebiProtectionContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Watchdog',
          'emoji': '🛡️',
          'content':
              'SEBI (Securities and Exchange Board of India) is the regulator that keeps markets fair. They protect you from fraud, ensure brokers are honest, and set rules that prevent market manipulation. Understanding SEBI is understanding your rights.',
        },
        {
          'type': 'concept',
          'title': 'How SEBI Protects You',
          'emoji': '⚖️',
          'content': '''
**SEBI's Key Protections:**

**1. Broker Registration 📋**
Every broker MUST be registered with SEBI. Check the registration number on SEBI's website before opening an account.

**2. Investor Protection Fund 🛡️**
If your broker goes bankrupt, the exchanges (NSE/BSE) have an Investor Protection Fund that compensates you (up to ₹25 Lakh).

**3. Margin Rules 📏**
SEBI sets minimum margin requirements to prevent excessive leverage. Peak margin rules require brokers to collect margin upfront.

**4. Disclosure Requirements 📊**
Listed companies MUST disclose financial results quarterly. Insider trading is a criminal offense.

**5. Grievance Redressal 📞**
SCORES (SEBI Complaints Redress System): File complaints against brokers, companies, or market participants at scores.gov.in.

---

**Key Insight:**
SEBI is not your enemy — it is your bodyguard. Every regulation exists because someone got scammed or lost money unfairly in the past. Follow the rules, and the rules protect you.
''',
          'keyPoints': [
            'SEBI registration is mandatory for all brokers',
            'Investor Protection Fund covers up to ₹25 Lakh if a broker defaults',
            'SCORES is the free grievance portal for filing complaints',
            'Every regulation exists because of past fraud — they protect you',
          ],
        },
        {
          'type': 'story',
          'title': 'The Unregistered "Advisor"',
          'emoji': '🕵️',
          'content': '''
**Anil** found a Telegram channel called "SureShot Profits."
The admin asked Anil to deposit ₹1 Lakh into a bank account, promising a guaranteed 10% return per month.

Anil checked the admin's profile. There was no SEBI Registration number.
Anil remembered the rule: *Never give money to an unregistered entity.*
He declined.

Three months later, the "SureShot Profits" channel disappeared. Thousands of people lost their capital. The police struggled to trace the funds because the bank accounts were fake.

**Key lesson:** The stock market is full of predators. SEBI registration is your first line of defense. If someone is managing your money or giving you financial advice, ask for their SEBI RIA (Registered Investment Advisor) or PMS number. If they don't have one, it's a scam.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'Your broker suddenly stops letting you withdraw funds. What is your first step?',
          'options': [
            'Wait and hope they fix it',
            'Complain on Twitter',
            'File a complaint on SCORES (scores.gov.in) — SEBI\'s official grievance portal',
            'Open a new account with another broker',
          ],
          'correctIndex': 2,
          'explanation':
              'SCORES is SEBI\'s official complaint system. They investigate broker misconduct and have the legal authority to act. Twitter complaints are public pressure but have no legal standing. Always use official channels first.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'SEBI is the market regulator that protects investors',
            'Always verify broker SEBI registration before opening an account',
            'Use SCORES for formal complaints against market participants',
            'Regulations protect you — follow them, don\'t fight them',
            'Next: Activities that are ILLEGAL in the markets.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getMarketRulesContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Red Lines',
          'emoji': '🚫',
          'content':
              'Some activities in the stock market are not just unethical — they are criminal offenses punishable by jail time and crores in fines. Make sure you never cross these lines, even accidentally.',
        },
        {
          'type': 'concept',
          'title': 'Illegal Market Activities',
          'emoji': '⚠️',
          'content': '''
**1. Insider Trading 🕵️**
Trading based on material, non-public information.
• Example: Your friend works at TCS and tells you earnings will beat estimates. You buy TCS stock before the announcement.
• Penalty: Up to ₹25 Crore fine OR 10 years imprisonment.

**2. Front-Running 🏃**
A broker/advisor trading BEFORE their client's large order to profit from the price impact.
• Example: A fund manager knows a ₹100 Crore buy order is coming. He buys personally first, then places the client order, pushing the price up.
• Penalty: Disgorgement of profits + heavy fines.

**3. Market Manipulation (Pump & Dump) 📣**
Artificially inflating a stock price through false information, then selling.
• Example: A WhatsApp group says "XYZ stock will double!" Members buy, price rises. The organizer sells at the top. Price crashes.
• Penalty: Criminal prosecution.

**4. Circular Trading 🔄**
Buying and selling between related accounts to create fake volume.

---

**Key Insight:**
If someone offers you "inside information" or asks you to participate in "guaranteed" schemes — run. These are crimes, and SEBI is getting increasingly sophisticated at detecting them.
''',
          'keyPoints': [
            'Insider trading can result in ₹25 Crore fine or 10 years jail',
            'Pump-and-dump schemes on WhatsApp/Telegram are criminal activity',
            'Front-running by brokers is aggressively prosecuted',
            'If someone offers "guaranteed returns" or insider info, report them',
          ],
        },
        {
          'type': 'story',
          'title': 'The Martha Stewart Mistake',
          'emoji': '🏛️',
          'content': '''
**The famous case of Martha Stewart (USA, 2001):**

Martha Stewart was a billionaire. She owned shares in a medical company called ImClone.
Her broker called her with a tip: The CEO of ImClone was secretly selling all his shares because their new drug had just been rejected by the government. (This news was not public yet).

Martha sold her shares immediately, saving roughly \$45,000.
The next day, the news went public, and the stock crashed 16%.

**The result:** The SEC (US equivalent of SEBI) investigated the trade. Martha Stewart went to federal prison for 5 months. A billionaire went to jail to save \$45,000 because she acted on non-public information.

**Key lesson:** Insider trading is a serious crime globally. The regulators have sophisticated software that flags any unusual trading activity right before major news announcements. You will get caught.
''',
        },
        {
          'type': 'scenario',
          'title': 'The WhatsApp Tip',
          'situation':
              'A cousin adds you to a WhatsApp group. The admin says: "Buy 10,000 shares of ABC company at ₹5. It will hit ₹50 next week. My friend on the board confirmed big news is coming." What do you do?',
          'choices': [
            {
              'text': 'Buy immediately — insider info is a goldmine!',
              'isCorrect': false,
              'feedback':
                  '❌ This is a potential pump-and-dump scheme. The admin and his friends buy first, get others to pump the price, then sell (dump) on you. You are also at risk of an insider trading investigation if SEBI detects unusual buying.',
            },
            {
              'text':
                  'Ignore it and leave the group. This is potentially illegal insider trading and/or a pump-and-dump scheme.',
              'isCorrect': true,
              'feedback':
                  '✅ Correct. Leave the group. Even RECEIVING and ACTING on insider information is a criminal offense. The "big news" is almost certainly false (pump-and-dump) or if real, acting on it is insider trading.',
            },
            {
              'text': 'Buy a small amount to test if the tip is real',
              'isCorrect': false,
              'feedback':
                  '❌ Even a small amount based on insider information is illegal. There is no "safe" amount for insider trading.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 4 Complete! 🎉',
          'keyPoints': [
            'Insider trading, front-running, and pump-and-dump are criminal offenses',
            'SEBI can impose fines up to ₹25 Crore and prison sentences',
            'WhatsApp/Telegram "tip groups" are often pump-and-dump schemes',
            'If it sounds too good to be true, it is illegal or a scam',
            'Next: How to handle taxes on your trading income.',
          ],
        },
      ],
    };
  }
}
