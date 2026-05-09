/// Chapter 1: High-Risk Instruments
/// Why this course comes with a WARNING label
class HighRiskInstrumentsContent {
  // Lesson 1.1: The Derivatives Warning
  static Map<String, dynamic> getDerivativesWarningContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'This Course Comes With a Warning',
          'emoji': '⚠️',
          'content':
              'Before you can trade Futures & Options on any Indian broker, SEBI forces you to sign a risk disclosure. Why? Because derivatives have destroyed more wealth than any market crash. This is the most dangerous course in the app.',
        },
        {
          'type': 'story',
          'title': 'Vikram\'s ₹8 Lakh Evaporation',
          'emoji': '💸',
          'content': '''
**Vikram**, 27, a data analyst in Pune. Salary: ₹1.2 Lakh/month.

He heard colleagues bragging about options trading profits. "I made ₹40,000 in one day!" one said.

**Week 1: The Bait.**
Vikram watched 3 YouTube videos titled "Option Trading for Beginners." He opened an F&O account on Zerodha.
He bought a Nifty Call Option for ₹150 (1 lot = 25 units). Cost: ₹3,750.
Next day Nifty jumped. He sold at ₹220. Profit: ₹1,750.
"This is SO easy!"

**Week 2-4: The Escalation.**
He started trading 5-10 lots at a time. Some wins, some losses. Net: up ₹15,000.
"If I trade bigger, I'll earn more."

**Month 2: The Catastrophe.**
He sold Nifty Puts (naked) thinking the market would stay flat.
One morning, global markets crashed. Nifty opened 400 points down.
His sold Puts exploded in value. His loss: ₹4.5 Lakh in ONE day.
He got a margin call from Zerodha. They auto-squared his position at the worst price.

**Month 3: The Denial.**
"I'll make it back." He borrowed ₹3 Lakh from his father.
Lost that too in 3 weeks selling Options to "collect premium."

**Final Count:** ₹8 Lakh lost. That was 8 months of his entire salary.

**The Lesson:**
Vikram's technical analysis was decent. His Options knowledge was ZERO. He was selling unlimited-risk instruments without understanding what he was doing.
''',
        },
        {
          'type': 'concept',
          'title': 'The SEBI Data',
          'emoji': '📊',
          'content': '''
**SEBI Study (2023) on F&O Trading:**
• 1.13 Crore unique individuals traded F&O
• **93% made net losses**
• Average loss: ₹1.2 Lakh per person per year
• Total retail losses: **₹75,000+ Crore** in a single year
• Only 1% of traders consistently profited over 3 years

**Why Are Derivatives So Dangerous?**
1. **Leverage:** You control 10-20x your actual capital. A 5% market move can wipe you out.
2. **Expiry:** Unlike stocks, derivatives have an expiration date. Time works AGAINST you.
3. **Complexity:** Options have multiple variables (Greeks) that most traders never learn.
4. **Speed:** Derivative prices can move ₹10,000 in minutes during volatile sessions.

---

**Key Insight:**
If 93% of F&O traders lose money, and you haven't even mastered the cash market yet, derivatives are a guaranteed path to account destruction. This course will teach you the concepts — but the responsibility to NOT trade them prematurely is yours.
''',
          'keyPoints': [
            '93% of Indian F&O traders lose money — SEBI verified data',
            'Leverage amplifies both profits and losses by 10-20x',
            'Derivatives have expiry dates — time actively works against buyers',
            'Only 1% of derivative traders are consistently profitable over 3 years',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'According to SEBI data, what percentage of Indian F&O traders made consistent profits over a 3-year period?',
          'options': ['About 25%', 'About 10%', 'About 7%', 'About 1%'],
          'correctIndex': 3,
          'explanation':
              'Only approximately 1% of F&O traders were consistently profitable over 3 years. The 7% figure is for annual profitability. When extended to consistent multi-year performance, the number drops dramatically to just 1%.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Derivatives are the highest-risk instruments in the market',
            'SEBI requires risk disclosures because 93% of F&O traders lose money',
            'Vikram lost ₹8L because he sold unlimited-risk Options without knowledge',
            'Leverage, expiry, and complexity make derivatives fundamentally different from stocks',
            'Next: How a small amount of money can control a massive position.',
          ],
        },
      ],
    };
  }

  // Lesson 1.2: The Leverage Illusion
  static Map<String, dynamic> getLeverageIllusionContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'The Magnifying Glass of Finance',
          'emoji': '🔍',
          'content':
              'Leverage is like a magnifying glass held over your portfolio. When pointed at the sun, it creates fire. When pointed at your hand, it burns YOU. In derivatives, leverage is always active — and most beginners point it at their own hand.',
        },
        {
          'type': 'interactive',
          'title': 'The Power (and Danger) of Leverage',
          'emoji': '⚡',
          'content': '''
**Without Leverage (Cash Market):**
• You have ₹1,00,000
• You buy 100 shares of Stock X at ₹1,000
• Stock goes up 5%: You make ₹5,000 (+5%)
• Stock goes down 5%: You lose ₹5,000 (-5%)

**With 10x Leverage (Futures):**
• You have ₹1,00,000 (margin money)
• You control ₹10,00,000 worth of Stock X
• Stock goes up 5%: You make ₹50,000 (+50% on your capital!)
• Stock goes down 5%: You lose ₹50,000 (-50% on your capital!)
• Stock goes down 10%: You lose ₹1,00,000 — **YOUR ENTIRE ACCOUNT IS WIPED OUT**

---

**The Asymmetry of Leverage:**
Without leverage: A 10% drop costs you ₹10,000. You survive.
With 10x leverage: A 10% drop costs you ₹1,00,000. You are FINISHED.

The upside is sexy. The downside is fatal.
''',
        },
        {
          'type': 'concept',
          'title': 'How Leverage Works in Indian Markets',
          'emoji': '🏦',
          'content': '''
**Margin = The Deposit You Put Up**
When trading Futures, you don't pay the full value. You pay a "margin" — typically 10-20% of the contract value.

**Example: Nifty Futures**
• Nifty at 22,000. Lot size = 25.
• Full contract value = 22,000 × 25 = **₹5,50,000**
• Margin required = ~₹1,10,000 (about 20%)
• So you control ₹5.5 Lakh with just ₹1.1 Lakh

**What SEBI Did:**
SEBI increased margin requirements in 2020 precisely because retail traders were using extreme leverage and losing everything. Higher margins = lower leverage = slightly safer.

---

**Key Insight:**
Leverage doesn't make you a better trader. It makes your EXISTING skills louder. If you are a losing trader without leverage, you will be a FASTER losing trader with leverage.
''',
          'keyPoints': [
            'Margin is the deposit you put up; leverage is the multiplier effect',
            'Nifty Futures control ₹5.5L with just ₹1.1L margin (~5x leverage)',
            'SEBI increased margins in 2020 to protect retail traders',
            'Leverage amplifies your existing skill level — good or bad',
          ],
        },
        {
          'type': 'scenario',
          'title': 'The Leverage Decision',
          'situation':
              'You have ₹2,00,000 saved for trading. A friend says: "Don\'t waste money in the cash market. Buy Nifty Futures — you can control ₹10 Lakh with just ₹2 Lakh!" What do you do?',
          'choices': [
            {
              'text':
                  'Buy Nifty Futures immediately — controlling ₹10L sounds amazing!',
              'isCorrect': false,
              'feedback':
                  '❌ If Nifty drops just 4% (which it does regularly), you lose ₹40,000 — 20% of your entire capital. Three bad days could wipe you out. This is how the 93% lose money.',
            },
            {
              'text':
                  'Start in the cash market with strict 1% risk. Consider derivatives ONLY after 12+ months of profitable cash market trading.',
              'isCorrect': true,
              'feedback':
                  '✅ Professional approach. You master position sizing, stop losses, and emotional control in the cash market FIRST, where a bad day costs you ₹2,000 (1%), not ₹40,000 (20%).',
            },
            {
              'text':
                  'Use half (₹1L) for Futures and keep half as backup margin.',
              'isCorrect': false,
              'feedback':
                  '❌ Slightly better, but still premature. Having backup margin doesn\'t fix the fundamental problem: you don\'t yet have the skill to manage leveraged positions.',
            },
          ],
        },
        {
          'type': 'summary',
          'title': 'Chapter 1 Complete! 🎉',
          'keyPoints': [
            'Derivatives come with a SEBI-mandated risk warning for a reason',
            '93% of F&O traders lose money — only 1% are consistently profitable',
            'Leverage magnifies both profits AND losses — a 10% move can wipe you out',
            'Master the cash market first before even considering derivatives',
            'Leverage amplifies existing skill, not magically creates profit',
            'Next: What exactly ARE derivatives? Let\'s define the beast.',
          ],
        },
      ],
    };
  }
}
