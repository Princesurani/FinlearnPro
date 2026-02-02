class MarketInstrument {
  final String symbol;
  final String name;
  final String price;
  final double changePercentage;
  final double changeValue;
  final bool isPositive;
  final List<double> chartData; // Mock data points for graph
  final Map<String, String> stats; // Open, High, Low, etc.
  final String about;

  const MarketInstrument({
    required this.symbol,
    required this.name,
    required this.price,
    required this.changePercentage,
    required this.changeValue,
    required this.isPositive,
    required this.chartData,
    required this.stats,
    required this.about,
  });
}

class MarketData {
  static const List<MarketInstrument> indices = [
    MarketInstrument(
      symbol: 'NIFTY 50',
      name: 'Nifty 50 Index',
      price: '19,425.35',
      changePercentage: 0.45,
      changeValue: 87.40,
      isPositive: true,
      chartData: [
        19350,
        19380,
        19360,
        19400,
        19410,
        19425,
        19420,
        19440,
        19425,
      ],
      stats: {
        'Open': '19,350.50',
        'High': '19,450.00',
        'Low': '19,320.10',
        'Prev. Close': '19,338.95',
        'Volume': '452.1M',
        '52W High': '19,991.85',
        '52W Low': '16,828.35',
      },
      about:
          'The NIFTY 50 graph is a well-diversified 50 stock index accounting for 13 sectors of the economy. It is used for a variety of purposes such as benchmarking fund portfolios, index based derivatives and index funds.',
    ),
    MarketInstrument(
      symbol: 'SENSEX',
      name: 'BSE SENSEX',
      price: '65,344.12',
      changePercentage: -0.12,
      changeValue: -78.45,
      isPositive: false,
      chartData: [65450, 65400, 65380, 65350, 65320, 65344, 65360, 65340],
      stats: {
        'Open': '65,420.00',
        'High': '65,480.00',
        'Low': '65,300.00',
        'Prev. Close': '65,422.57',
        'Volume': '12.5M',
        '52W High': '67,619.17',
        '52W Low': '56,147.23',
      },
      about:
          'The S&P BSE SENSEX (S&P Bombay Stock Exchange Sensitive Index), is a free-float market-weighted stock market index of 30 well-established and financially sound companies listed on the Bombay Stock Exchange.',
    ),
    MarketInstrument(
      symbol: 'BANKNIFTY',
      name: 'Nifty Bank',
      price: '44,213.90',
      changePercentage: 1.20,
      changeValue: 524.30,
      isPositive: true,
      chartData: [43700, 43800, 43950, 44000, 44100, 44213, 44250, 44213],
      stats: {
        'Open': '43,800.00',
        'High': '44,300.00',
        'Low': '43,750.00',
        'Prev. Close': '43,689.60',
        'Volume': '235.4M',
        '52W High': '46,369.50',
        '52W Low': '37,386.55',
      },
      about:
          'NIFTY Bank Index comprises of the most liquid and large capitalised Indian Banking stocks. It provides investors and market intermediaries a benchmark that captures the capital market performance of the Indian banking sector.',
    ),
    MarketInstrument(
      symbol: 'BTC/USD',
      name: 'Bitcoin',
      price: '29,450.00',
      changePercentage: -1.50,
      changeValue: -450.00,
      isPositive: false,
      chartData: [29900, 29800, 29600, 29500, 29400, 29450, 29300, 29450],
      stats: {
        'Open': '29,900.00',
        'High': '30,050.00',
        'Low': '29,200.00',
        'Prev. Close': '29,900.00',
        'Volume': '18.2B',
        '52W High': '31,800.00',
        '52W Low': '15,500.00',
      },
      about:
          'Bitcoin is a decentralized digital currency, without a central bank or single administrator, that can be sent from user to user on the peer-to-peer bitcoin network without the need for intermediaries.',
    ),
    MarketInstrument(
      symbol: 'GOLD',
      name: 'Gold (10g)',
      price: '59,250.00',
      changePercentage: 0.85,
      changeValue: 500.00,
      isPositive: true,
      chartData: [58750, 58800, 58900, 59000, 59100, 59250, 59200, 59250],
      stats: {
        'Open': '58,750.00',
        'High': '59,300.00',
        'Low': '58,700.00',
        'Prev. Close': '58,750.00',
        'Volume': 'N/A',
        '52W High': '61,845.00',
        '52W Low': '49,200.00',
      },
      about:
          'Gold is a precious metal that has been used for coinage, jewelry, and other arts throughout recorded history. In the past, a gold standard was often implemented as a monetary policy.',
    ),
  ];
}
