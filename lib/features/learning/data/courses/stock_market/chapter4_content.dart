/// Chapter 4: How Stock Trading Works
/// Practical mechanics of stock trading in India
class SMChapter4Content {
  // Lesson 1: Your Trading Toolkit
  static Map<String, dynamic> getTradingToolkitContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Before You Trade',
          'emoji': '🧰',
          'content':
              'Before you can buy your first stock, you need 3 accounts. Not 1, not 2 — THREE. Miss any one, and you can\'t trade. Let\'s set up your toolkit.',
        },
        {
          'type': 'concept',
          'title': 'The 3-in-1 Account Setup',
          'emoji': '🔗',
          'content': '''
**1. Bank Account (Savings) 🏦**
Your regular bank account (SBI, HDFC, etc.).
Purpose: **Holds your cash.** Money moves from here to buy stocks.

**2. Trading Account 📱**
Opened with a stockbroker (Zerodha, Groww, Angel One).
Purpose: **Place buy/sell orders.** This is your gateway to the market.

**3. Demat Account 📦**
"Dematerialized" account — linked to your trading account.
Purpose: **Stores your shares** digitally. Like a digital locker.

**How they work together:**
You want to buy 10 shares of TCS...
1. Money moves from **Bank** → **Trading Account**
2. You place a buy order on the **Trading App**
3. Shares are delivered to your **Demat Account**

**The magic:** All three are usually opened together (3-in-1) in one application form with any broker.
''',
          'keyPoints': [
            'Bank Account = Cash storage',
            'Trading Account = Order placement',
            'Demat Account = Share storage',
            'Most brokers offer all 3 in one application',
          ],
        },
        {
          'type': 'story',
          'title': 'Vikram\'s First Setup',
          'emoji': '👨‍💻',
          'content': '''
**Vikram**, 23, decides to start investing.

**Step 1: Choose a Broker**
He compares options:
• **Zerodha** — ₹0 for delivery trades, ₹20/order for intraday.
• **Groww** — Free for stocks, simple interface.
• **Angel One** — Free trades + advisory.
He picks **Zerodha** (most popular in India).

**Step 2: Open Account**
• PAN Card ✅
• Aadhaar (for e-KYC) ✅
• Bank Details ✅
• Selfie + Signature ✅
**Time taken: 15 minutes. Account active in 24 hours.**

**Step 3: Add Money**
He transfers ₹10,000 from his SBI account to Zerodha.

**Step 4: First Trade**
Opens Zerodha Kite → Searches "TCS" → Buys 2 shares at ₹3,800.
Total cost: ₹7,600 + ₹0 brokerage.
**Shares appear in his Demat account the next day (T+1).**

Vikram is officially a stock market investor! 🎉
''',
        },
        {
          'type': 'quiz',
          'title': 'Account Check',
          'question': 'Where are your purchased shares physically stored?',
          'options': [
            'In your bank locker',
            'In your Demat account (digitally)',
            'At the NSE headquarters',
            'In your broker\'s office',
          ],
          'correctIndex': 1,
          'explanation':
              'Shares are stored electronically in your Demat (Dematerialized) account. They are registered in your name at the central depository (CDSL or NSDL). No physical certificates needed anymore.',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'You need 3 accounts: Bank + Trading + Demat',
            'Opening an account takes 15-30 minutes online',
            'You need PAN + Aadhaar + Bank Details',
            'Shares are stored digitally in Demat (not physically)',
            'Delivery trades are FREE on most Indian brokers',
          ],
        },
      ],
    };
  }

  // Lesson 2: Placing Your First Trade
  static Map<String, dynamic> getFirstTradeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Let\'s Buy a Stock',
          'emoji': '🛒',
          'content':
              'You\'ve got your accounts ready. Money is loaded. Now what? Let\'s walk through exactly how a stock trade happens — from the moment you click "Buy" to when shares land in your Demat account.',
        },
        {
          'type': 'concept',
          'title': 'Anatomy of a Trade',
          'emoji': '🔬',
          'content': '''
**Step 1: Search the Stock**
Open your broker app → Search "INFY" (Infosys).
You see: Price ₹1,500 | Day High ₹1,520 | Day Low ₹1,485.

**Step 2: Choose Order Type**
• **Market Order** — Buy at current price (fast, but risky in volatile stocks).
• **Limit Order** — Set YOUR price. Won't execute until price reaches it.

**Step 3: Choose Quantity**
You want 5 shares. Total: 5 × ₹1,500 = ₹7,500.

**Step 4: Choose Delivery vs Intraday**
• **Delivery (CNC)** — Buy and hold forever. Shares stay in your Demat.
• **Intraday (MIS)** — Buy and sell the SAME day. Must exit by 3:15 PM.

**Step 5: Place the Order**
Click "Buy" → Confirm → Order sent to NSE.
If a seller matches your price, trade is executed. ✅

**Step 6: Settlement (T+1)**
Shares appear in your Demat account the **next business day**.
''',
          'keyPoints': [
            'Market Order = Buy now at best available price',
            'Limit Order = Buy only at your specified price',
            'Delivery (CNC) = Long-term holding',
            'Intraday (MIS) = Same-day buy and sell',
            'Settlement happens T+1 (next day)',
          ],
        },
        {
          'type': 'interactive',
          'title': 'Trading Costs Breakdown',
          'emoji': '💳',
          'content': '''
**You buy 10 shares of Reliance at ₹2,500 (Delivery order)**

**Purchase Value:** 10 × ₹2,500 = ₹25,000

**Costs you pay:**
• Brokerage: **₹0** (delivery is free on Zerodha/Groww)
• STT (Securities Transaction Tax): ~₹25 (0.1%)
• Exchange charges: ~₹8
• GST on charges: ~₹3
• Stamp Duty: ~₹4

**Total Cost:** ₹25,000 + ~₹40 = **₹25,040**
**Effective fee: 0.16%** of trade value.

**For Intraday (buying and selling same day):**
• Brokerage: ₹20 per order (Zerodha)
• STT: Lower (0.025%)
• But you pay brokerage TWICE (buy + sell) = ₹40

**Takeaway:**
Delivery trading is almost free. Intraday has more hidden costs.
''',
        },
        {
          'type': 'story',
          'title': 'Neha\'s First Buy',
          'emoji': '📱',
          'content': '''
**Neha**, 28, places her first trade.

**9:30 AM:** She opens Groww, searches for "Asian Paints."
Price: ₹3,200. She wants to buy 3 shares.

**Her thought process:**
"Should I use Market Order or Limit Order?"
The stock is moving up fast. She doesn't want to miss it.
She places a **Market Order** for 3 shares.

**9:30:02 AM:** Order executed at ₹3,205.
She paid ₹15 more than expected because the price moved while her order was processing. This is called **slippage**.

**Her colleague Arjun** waited. He placed a **Limit Order** at ₹3,180.
At 2:15 PM, the price dipped to ₹3,180. His order executed.
He saved ₹75 (₹25/share × 3 shares).

**Lesson:**
Market Orders are fast but can cost more.
Limit Orders save money but might not execute if the price never reaches your level.
''',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Search → Choose Order Type → Set Quantity → Confirm',
            'Market Order = Speed; Limit Order = Better Price',
            'Delivery is for holding; Intraday is for same-day trading',
            'Trading costs are very low (~0.1-0.2% per trade)',
            'Shares settle in T+1 (next business day)',
          ],
        },
      ],
    };
  }

  // Lesson 3: The Indian Trading Day
  static Map<String, dynamic> getTradingDayContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Timing Is Everything',
          'emoji': '⏰',
          'content':
              'The Indian stock market doesn\'t trade 24/7. It has specific hours, sessions, and even a "pre-open" auction. Knowing when to trade can save you from unnecessary volatility.',
        },
        {
          'type': 'concept',
          'title': 'Market Sessions',
          'emoji': '🕐',
          'content': '''
**Pre-Open Session: 9:00 AM - 9:15 AM**
• Orders are collected but NOT executed yet.
• NSE calculates an "equilibrium price" at 9:15 AM.
• This prevents wild opening prices.

**Normal Trading: 9:15 AM - 3:30 PM**
• Main session. All buying and selling happens here.
• Most volatile: **First 30 minutes** (9:15-9:45 AM).
• Most stable: **11:00 AM - 2:00 PM** (lunch lull).

**Closing Session: 3:30 PM - 3:40 PM**
• Last 10 minutes for closing price calculation.
• Only limit orders at the closing price are allowed.

**After-Hours: 3:40 PM - 4:00 PM**
• AMO (After Market Orders) can be placed.
• These execute at the next day's opening price.
''',
          'keyPoints': [
            'Pre-open = 9:00-9:15 (price discovery)',
            'Normal trading = 9:15-3:30 (main session)',
            'First 30 minutes are the most volatile',
            'AMO lets you place orders after hours for next day',
          ],
        },
        {
          'type': 'story',
          'title': 'Why 9:15 AM is Chaos',
          'emoji': '🌪️',
          'content': '''
**Monday, 9:14 AM.**
Over the weekend, global markets crashed. US markets fell 3%.
Oil prices spiked. China reported bad data.

**9:15 AM — Indian market opens.**
Nifty gaps down 2% instantly.

**What happens next:**
• Panic sellers dump stocks at any price → Prices crash further.
• Smart buyers see cheap prices → They start buying.
• Algo trading bots fire millions of orders in milliseconds.
• In 15 minutes, Nifty swings 300 points up, then 200 points down.

**By 10:00 AM:** The chaos settles. Volatility drops.
**By 11:00 AM:** The market finds its real direction for the day.

**Lesson for beginners:**
Avoid trading in the first 15-30 minutes unless you know what you're doing. That window is dominated by algorithms and emotional traders. Wait for the dust to settle.
''',
        },
        {
          'type': 'quiz',
          'title': 'Session Check',
          'question':
              'It\'s 10:00 PM on Sunday. You want to buy a stock when the market opens Monday. What should you do?',
          'options': [
            'Wait until 9:15 AM Monday and place a market order',
            'Place an AMO (After Market Order) now — it will execute Monday',
            'You can\'t do anything until Tuesday',
            'Call your broker to place the order',
          ],
          'correctIndex': 1,
          'explanation':
              'AMO (After Market Orders) can be placed anytime outside market hours. Your order will be queued and sent to the exchange at the next trading session\'s opening. It\'s a very convenient feature!',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Indian markets trade 9:15 AM - 3:30 PM (Mon-Fri)',
            'Pre-open session (9:00-9:15) sets the opening price',
            'First 30 minutes are the most volatile — beginners should avoid',
            'AMO lets you place orders outside market hours',
            'Markets are closed on weekends and exchange holidays',
          ],
        },
      ],
    };
  }

  // Lesson 4: Practice - Execute a Trade
  static Map<String, dynamic> getPracticeTradeContent() {
    return {
      'slides': [
        {
          'type': 'intro',
          'title': 'Let\'s Practice!',
          'emoji': '🎮',
          'content':
              'Theory is great, but let\'s test your skills with real scenarios. You\'ll make trading decisions and see the consequences. No real money at risk — just your brain cells!',
        },
        {
          'type': 'scenario',
          'title': 'Scenario 1: The Order Type',
          'situation':
              'TCS is trading at ₹3,800. You believe it\'s a good long-term buy but want to get a slightly better price. The stock has been volatile today, swinging between ₹3,750 and ₹3,850. What order do you place?',
          'choices': [
            {
              'text': 'Market Order at ₹3,800',
              'isCorrect': false,
              'feedback':
                  '⚡ This works but you might pay ₹3,830+ due to slippage. Since you want a better price and the stock is volatile, a Limit Order is smarter here.',
            },
            {
              'text': 'Limit Order at ₹3,760',
              'isCorrect': true,
              'feedback':
                  '✅ Excellent! Setting a limit at ₹3,760 means you only buy when the price dips. With today\'s volatility (low of ₹3,750), there\'s a good chance it fills. You save ₹40/share!',
            },
            {
              'text': 'Intraday Order to flip for quick profit',
              'isCorrect': false,
              'feedback':
                  '❌ You said "long-term buy" — so Intraday makes no sense. You\'d have to sell before 3:30 PM. Use Delivery (CNC) for long-term holding.',
            },
          ],
        },
        {
          'type': 'scenario',
          'title': 'Scenario 2: The Delivery Choice',
          'situation':
              'You bought 20 shares of HDFC Bank at ₹1,600 as a long-term investment. Two hours later, the stock jumps to ₹1,640 (+2.5%). A friend says "Book profits now!" What do you do?',
          'choices': [
            {
              'text': 'Sell now — ₹800 profit is ₹800 profit!',
              'isCorrect': false,
              'feedback':
                  '❌ If you bought for long-term, why sell for 2.5%? HDFC Bank has given 15-20% annual returns historically. Selling for ₹800 means you miss potential ₹6,400+ gains over a year.',
            },
            {
              'text':
                  'Hold — you bought for the long term, not for a 2-hour flip',
              'isCorrect': true,
              'feedback':
                  '✅ Discipline! You had a plan (long-term). Stick to it. Short-term noise shouldn\'t change a long-term strategy. This is what separates investors from gamblers.',
            },
          ],
        },
        {
          'type': 'scenario',
          'title': 'Scenario 3: The Timing',
          'situation':
              'It\'s 9:16 AM Monday. Markets just opened. Nifty gapped down 1.5% due to global weakness. Your watchlist stock Infosys opened 3% lower at ₹1,450 (was ₹1,500 Friday). You think it\'s a good buy.',
          'choices': [
            {
              'text': 'Buy immediately at ₹1,450 — it\'s a bargain!',
              'isCorrect': false,
              'feedback':
                  '⚡ Risky! In the first 15 minutes, prices are extremely volatile. Infosys might drop to ₹1,420 or bounce to ₹1,480. Wait for the market to stabilize.',
            },
            {
              'text': 'Wait until 10:00-10:30 AM for prices to stabilize',
              'isCorrect': true,
              'feedback':
                  '✅ Patient and smart! Opening volatility usually settles by 10 AM. You can then place a Limit Order at a fair price with much less slippage risk.',
            },
            {
              'text': 'Place an aggressive Limit Order at ₹1,420',
              'isCorrect': true,
              'feedback':
                  '✅ Also clever! If the panic continues, you might get filled at an even better price. If not, your money stays safe. Low-risk approach.',
            },
          ],
        },
        {
          'type': 'quiz',
          'title': 'Final Trade Quiz',
          'question':
              'You place a Limit Order to buy 10 shares of TCS at ₹3,700. The current price is ₹3,800 and it keeps going up all day. What happens?',
          'options': [
            'Your order buys at ₹3,800 automatically',
            'Your order is cancelled at 3:30 PM',
            'Your order stays pending — it only executes if TCS drops to ₹3,700',
            'The broker calls you to modify the order',
          ],
          'correctIndex': 2,
          'explanation':
              'A Limit Order ONLY executes at your price or better. Since TCS never reached ₹3,700, your order stays pending all day. At market close, it\'s cancelled (unless you set it as GTT — Good Till Triggered).',
        },
        {
          'type': 'summary',
          'title': 'Lesson Recap',
          'keyPoints': [
            'Use Limit Orders when you want a specific price',
            'Match your order type (Delivery/Intraday) to your goal',
            'Avoid trading in the first 15-30 minutes of market open',
            'Stick to your plan — don\'t sell long-term buys for small gains',
            'Unfilled Limit Orders expire at the end of the trading day',
          ],
        },
      ],
    };
  }
}
