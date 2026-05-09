/// Chapters 1-2: Practical Execution & Choosing the Right Broker
class PracticalExecutionContent {
  static Map<String, dynamic> getBridgingTheoryContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'When Real Money Changes Everything',
          'emoji': '💰',
          'content':
              'You have studied 11 courses of theory. You have paper traded. You feel ready. But the moment you click "Buy" with real money, your brain chemistry changes completely. Let\'s prepare for that transition.',
        },
        {
          'type': 'story',
          'title': 'Amit\'s First Real Trade',
          'emoji': '😰',
          'content': '''
**Amit**, 26, had paper traded for 4 months. Win rate: 58%. He was confident.

**Day 1 with real money:**
He saw his perfect setup. Entry at ₹500. Stop at ₹490. Target at ₹520.
Paper Amit would have entered instantly. Real Amit hesitated for 5 minutes.
By the time he clicked "Buy," the price was ₹505. His R:R was now worse.

**The stock moved to ₹510.** In paper trading, he would have held calmly.
With real money, his heart was pounding. At ₹508, a red candle appeared.
He panicked and sold at ₹507. Profit: ₹2 per share (instead of ₹15).

The stock then went to ₹522 — his original target.

**What Amit Learned:**
Paper trading trains your STRATEGY. Real money trains your EMOTIONS.
The first 30 days with real money should use the absolute minimum position size. You are not trading for profit — you are building emotional muscle memory.
''',
        },
        {
          'type': 'concept',
          'title': 'The Real Money Transition',
          'emoji': '🌉',
          'content': '''
**Step 1: Start Microscopic 🔬**
Use the absolute minimum position size. If your capital is ₹1 Lakh, risk ₹200 per trade (0.2% instead of the normal 1%). The goal is to FEEL real money without the PRESSURE of losing meaningful amounts.

**Step 2: Focus on Process, Not Profit 📋**
For the first 30 trades, your only metric is: "Did I follow my rules?"
Not: "Did I make money?"

**Step 3: Scale Up Gradually 📈**
After 30 rules-following trades, increase to 0.5% risk. After another 30, increase to 1%.

---

**Key Insight:**
The transition from paper to real money is the most psychologically challenging phase. Treat it as a separate training period — not a money-making period.
''',
          'keyPoints': [
            'Start with 0.2% risk to build emotional muscle memory',
            'Focus on rule-following for the first 30 trades, not profit',
            'Scale up gradually: 0.2% → 0.5% → 1% over 60-90 trades',
            'Paper training teaches strategy; real money trains emotions',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'What should your #1 metric be for your first 30 real-money trades?',
          'options': [
            'Total profit in rupees',
            'Win rate percentage',
            '"Did I follow my rules?" (Yes/No)',
            'Number of trades per day',
          ],
          'correctIndex': 2,
          'explanation':
              'Process over outcome. If you follow your rules on 30 trades and the strategy is backtested, the profit will come automatically. If you focus on profit, you will start cutting winners early and holding losers — the exact opposite of what works.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Real money triggers entirely different emotions than paper trading',
            'Start with microscopic position sizes (0.2% risk)',
            'Focus on rule adherence for the first 30 trades',
            'Scale up gradually as emotional control strengthens',
            'Next: Setting up your physical trading workspace.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getInfrastructureContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Tools of the Trade',
          'emoji': '🖥️',
          'content':
              'A carpenter doesn\'t build a house with a butter knife. A trader shouldn\'t trade on a slow phone with laggy internet. Your infrastructure determines your execution quality.',
        },
        {
          'type': 'concept',
          'title': 'The Essential Setup',
          'emoji': '⚙️',
          'content': '''
**Internet Connection 🌐**
• Minimum: 50 Mbps broadband (wired, not WiFi)
• Backup: Mobile data hotspot on a different network
• Why: A 3-second internet lag during a volatile move can cost you thousands

**Devices 💻**
• Primary: Laptop/Desktop with charting software (TradingView)
• Secondary: Phone with broker app (for emergency exits)
• Avoid: Trading exclusively on a phone — the screen is too small

**Workspace 🏠**
• Quiet, distraction-free environment
• Comfortable chair (you will sit for hours)
• No TV, no YouTube, no social media during market hours

**Software Stack 📊**
• Charting: TradingView (Free tier is sufficient for beginners)
• Broker: Zerodha Kite / Groww / Angel One
• Journal: Google Sheets or Notion
• News: MoneyControl, Economic Times

---

**Key Insight:**
Your setup doesn't need to be expensive. A ₹30,000 laptop + ₹500/month internet + free TradingView is enough. What matters is that the setup is RELIABLE, not fancy.
''',
          'keyPoints': [
            'Wired internet (50 Mbps+) with mobile data backup',
            'Laptop/desktop for charts; phone for emergency exits only',
            'Quiet, distraction-free workspace is non-negotiable',
            'Free tools (TradingView, Google Sheets) are sufficient for beginners',
          ],
        },
        {
          'type': 'story',
          'title': 'The Wi-Fi Disaster',
          'emoji': '📶',
          'content': '''
**Ravi** was trading Bank Nifty options on his laptop using his home Wi-Fi.
He entered a large position right before a major RBI announcement.
Suddenly, a power cut happened. The Wi-Fi router went off.

**Panic set in:**
Ravi's phone was on the same Wi-Fi. He scrambled to turn on mobile data.
It took 45 seconds to get a signal, open the broker app, and log in.
In those 45 seconds, the RBI announcement caused a massive 300-point spike against his position.

Because he hadn't placed a hard stop loss in the system, he took a catastrophic loss of ₹40,000 in under a minute.

**The Fix:**
A professional trader connects their laptop to a wired broadband connection AND keeps a mobile hotspot (from a different provider) active on standby. They also place hard stop losses immediately.

**Key lesson:** You are trading against algorithms executing in milliseconds. A 45-second internet drop is an eternity in the markets.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question': 'Why should you have a backup internet connection?',
          'options': [
            'To trade from two devices simultaneously',
            'Because if your primary internet drops during a live trade, you need to be able to exit via the backup',
            'To download charts faster',
            'It is a SEBI requirement',
          ],
          'correctIndex': 1,
          'explanation':
              'If your internet dies while you are in a leveraged position with no hard stop loss in the system, you are completely exposed. A mobile hotspot on a different network ensures you can always access your broker app to exit.',
        },
        {
          'type': 'summary',
          'title': 'Chapter 1 Complete! 🎉',
          'keyPoints': [
            'Reliable internet and a dedicated workspace are essential',
            'You don\'t need expensive equipment — reliability beats luxury',
            'Always have a backup internet connection',
            'Never trade exclusively on a phone during active hours',
            'Next: How to choose the right broker for your style.',
          ],
        },
      ],
    };
  }
}

class ChoosingBrokerContent {
  static Map<String, dynamic> getTypesOfBrokersContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Your Market Gateway',
          'emoji': '🚪',
          'content':
              'A broker is the company that executes your buy and sell orders on the stock exchange. Choosing the wrong broker can cost you lakhs in hidden fees, slow execution, and poor customer support.',
        },
        {
          'type': 'concept',
          'title': 'Full-Service vs Discount Brokers',
          'emoji': '🏦',
          'content': '''
**Full-Service Brokers (Traditional) 🏢**
Examples: ICICI Direct, HDFC Securities, Kotak Securities
• Brokerage: 0.3-0.5% per trade (EXPENSIVE)
• Offer: Research reports, advisory, dedicated relationship manager
• Best for: Investors who want hand-holding and don't mind paying extra
• Drawback: High brokerage destroys active trading profits

**Discount Brokers (Modern) 💻**
Examples: Zerodha, Groww, Upstox, Angel One
• Brokerage: Flat ₹20 per trade (or even FREE for delivery)
• Offer: Clean apps, fast execution, basic research tools
• Best for: Active traders and self-directed investors
• Drawback: Minimal personal advisory and research support

---

**The Math:**
Buying ₹5 Lakh worth of stocks:
• Full-service broker (0.3%): ₹1,500 brokerage
• Discount broker (₹20 flat): ₹20 brokerage
**Difference: ₹1,480 per trade.** Over 100 trades/year: **₹1,48,000 saved.**

---

**Key Insight:**
For active traders, a discount broker is almost always the right choice. Full-service makes sense ONLY if you are a long-term investor who values personal advisory.
''',
          'keyPoints': [
            'Full-service: 0.3-0.5% per trade; Discount: flat ₹20',
            'Discount brokers save ₹1L+ per year for active traders',
            'Full-service offers research and advisory; discount offers speed',
            'Choose based on YOUR trading frequency and style',
          ],
        },
        {
          'type': 'story',
          'title': 'The ₹1 Lakh Lesson',
          'emoji': '💸',
          'content': '''
**Sanjay** opened his first trading account with a famous full-service bank broker because he trusted the brand name.
He started day trading with ₹2 Lakhs capital.

In his first year, he made ₹50,000 in gross trading profits. He felt great.
Then he looked at his P&L statement. His net profit was **negative ₹60,000.**

**How?**
The full-service broker was charging 0.5% brokerage on every trade.
On a ₹2 Lakh trade, that is ₹1,000 just to enter, and ₹1,000 to exit.
He had taken 55 trades. His brokerage alone was ₹1,10,000!

He switched to a discount broker charging flat ₹20 per trade.
The exact same 55 trades at the discount broker would have cost him ₹2,200 in brokerage instead of ₹1,10,000.

**Key lesson:** Unless you are buying stocks to hold for 10 years, full-service brokerage fees will destroy your active trading edge. The math makes it impossible to win in the long run.
''',
        },
        {
          'type': 'quiz',
          'title': 'Quick Check',
          'question':
              'You plan to take 200 trades per year. Full-service charges 0.3% on ₹50,000 avg trade. Discount charges ₹20 flat. How much do you save with the discount broker?',
          'options': ['₹5,000', '₹12,000', '₹26,000', '₹50,000'],
          'correctIndex': 2,
          'explanation':
              'Full-service: 0.3% × ₹50,000 × 200 = ₹30,000. Discount: ₹20 × 200 = ₹4,000. Savings: ₹26,000/year. Over 10 years, that is ₹2.6 Lakh saved — just from choosing the right broker.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Full-service = expensive + advisory; Discount = cheap + self-directed',
            'Active traders should almost always use discount brokers',
            'Savings compound: ₹26K/year × 10 years = ₹2.6 Lakh',
            'Next: Comparing popular Indian brokers side by side.',
          ],
        },
      ],
    };
  }

  static Map<String, dynamic> getBrokerComparisonContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Head-to-Head Comparison',
          'emoji': '⚖️',
          'content':
              'India has dozens of discount brokers. Here is an honest comparison of the four most popular ones to help you make an informed choice.',
        },
        {
          'type': 'interactive',
          'title': 'Indian Broker Comparison',
          'emoji': '📊',
          'content': '''
| Feature | Zerodha | Groww | Angel One | Upstox |
|---------|---------|-------|-----------|--------|
| **Equity Delivery** | Free | Free | Free | Free |
| **Intraday/F&O** | ₹20/order | ₹20/order | ₹20/order | ₹20/order |
| **Platform Quality** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Charting (Kite/etc)** | Excellent | Basic | Good | Good |
| **Account Opening** | Free | Free | Free | Free |
| **AMC (Demat)** | ₹300/year | Free | Free | Free |
| **Research/Advisory** | Limited | Limited | Good (SmartAPI) | Limited |
| **Customer Support** | Email-only | Good | Phone available | Email/Chat |
| **Best For** | Active traders | Beginners/Investors | API traders | Budget traders |

---

**The Honest Take:**
• **Zerodha** has the best charting (Kite) and most reliable platform, but charges ₹300/year AMC.
• **Groww** has the simplest UI — great if you are just starting with SIPs and stocks.
• **Angel One** has strong API support and phone-based customer care.
• **Upstox** is cost-competitive with decent features.

**Key Insight:** All four are SEBI-registered and safe. The "best" broker depends on YOUR priorities: charting quality, cost, support, or simplicity.
''',
        },
        {
          'type': 'concept',
          'title': 'What to Look For',
          'emoji': '🔍',
          'content': '''
**Non-Negotiable Requirements:**
1. **SEBI Registration:** Never use an unregistered broker/platform
2. **Exchange Membership:** Must be NSE and BSE members
3. **Funds in YOUR Name:** Your Demat account should be in your name at CDSL/NSDL
4. **Two-Factor Authentication:** Security of your funds is critical
5. **Uptime Reliability:** The platform should NOT crash during volatile sessions

**Nice-to-Have:**
• Good charting tools (TradingView integration)
• Bracket/Cover orders for automated stop losses
• Mobile app quality
• Margin calculator

---

**Key Insight:**
Your broker should be boring and reliable. If you are choosing a broker because they offer "free intraday leverage" or "guaranteed returns," you are choosing for the wrong reasons.
''',
          'keyPoints': [
            'SEBI registration and exchange membership are non-negotiable',
            'Funds must be in YOUR name at CDSL/NSDL',
            'Platform reliability during volatility is critical',
            'Choose for reliability and features, not promotional gimmicks',
          ],
        },
        {
          'type': 'story',
          'title': 'The App Crash Trap',
          'emoji': '📉',
          'content': '''
**March 2020 Crash:** Markets were falling 5% a day. Volatility was at all-time highs.
Traders rushed to sell their positions.

**The Problem:** Several new discount brokers' apps completely crashed due to the server load.
Traders could not log in. They watched helplessly on TV as their stocks plummeted, unable to hit the sell button.

**The Established Broker:** The largest discount broker (Zerodha) experienced slight lag but stayed online, allowing their clients to exit.

**Key lesson:** When comparing brokers, "Free account opening" or "Zero brokerage" doesn't matter if the app crashes when you need it most (during high volatility). Read reviews about platform stability during market crashes. Reliability is the ultimate feature.
''',
        },
        {
          'type': 'summary',
          'title': 'Chapter 2 Complete! 🎉',
          'keyPoints': [
            'All major Indian discount brokers charge ₹20/trade for intraday/F&O',
            'Zerodha has the best charting; Groww is simplest for beginners',
            'Check for SEBI registration, exchange membership, and security',
            'Choose based on YOUR needs, not marketing',
            'Next: Understanding ALL the fees hidden in your trades.',
          ],
        },
      ],
    };
  }
}
