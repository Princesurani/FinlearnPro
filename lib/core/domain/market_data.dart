class Candle {
  const Candle({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory Candle.fromJson(Map<String, dynamic> json) {
    return Candle(
      timestamp: DateTime.parse(json['timestamp'] as String),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
    );
  }

  final DateTime timestamp;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  double get change => close - open;

  double get changePercent => (change / open) * 100;

  bool get isBullish => close > open;

  bool get isBearish => close < open;

  double get trueRange => high - low;

  double get bodySize => (close - open).abs();

  double get upperWick => isBullish ? (high - close) : (high - open);

  double get lowerWick => isBullish ? (open - low) : (close - low);

  bool get isDoji => bodySize / open < 0.001;

  @override
  String toString() =>
      'Candle($timestamp O:$open H:$high L:$low C:$close V:$volume)';
}

enum Timeframe {
  tick('Tick', Duration.zero),
  oneMinute('1m', Duration(minutes: 1)),
  fiveMinute('5m', Duration(minutes: 5)),
  fifteenMinute('15m', Duration(minutes: 15)),
  oneHour('1h', Duration(hours: 1)),
  fourHour('4h', Duration(hours: 4)),
  oneDay('1D', Duration(days: 1)),
  oneWeek('1W', Duration(days: 7)),
  oneMonth('1M', Duration(days: 30));

  const Timeframe(this.label, this.duration);

  final String label;
  final Duration duration;

  int get minutes => duration.inMinutes;
}

class PriceTick {
  const PriceTick({
    required this.symbol,
    required this.timestamp,
    required this.price,
    required this.bid,
    required this.ask,
    required this.volume,
    required this.change,
    required this.changePercent,
  });

  factory PriceTick.fromJson(Map<String, dynamic> json) {
    return PriceTick(
      symbol: json['symbol'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      price: (json['price'] as num).toDouble(),
      bid: (json['bid'] as num).toDouble(),
      ask: (json['ask'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
    );
  }

  final String symbol;
  final DateTime timestamp;
  final double price; // Last traded price
  final double bid; // Best bid (buyer willing to pay)
  final double ask; // Best ask (seller offering)
  final double volume; // Cumulative volume today
  final double change; // Change from yesterday's close
  final double changePercent; // Percentage change

  double get spread => ask - bid;

  double get spreadPercent => (spread / midPrice) * 100;

  double get midPrice => (bid + ask) / 2;

  bool get isPositive => change >= 0;

  @override
  String toString() =>
      'Tick($symbol $price ${isPositive ? '+' : ''}$changePercent%)';
}

class MarketSnapshot {
  const MarketSnapshot({
    required this.symbol,
    required this.name,
    required this.price,
    required this.open,
    required this.high,
    required this.low,
    required this.previousClose,
    required this.change,
    required this.changePercent,
    required this.volume,
    required this.timestamp,
    this.fiftyTwoWeekHigh,
    this.fiftyTwoWeekLow,
    this.marketCap,
    this.avgVolume,
  });

  factory MarketSnapshot.fromJson(Map<String, dynamic> json) {
    return MarketSnapshot(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      previousClose: (json['previousClose'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      fiftyTwoWeekHigh: json['fiftyTwoWeekHigh'] != null
          ? (json['fiftyTwoWeekHigh'] as num).toDouble()
          : null,
      fiftyTwoWeekLow: json['fiftyTwoWeekLow'] != null
          ? (json['fiftyTwoWeekLow'] as num).toDouble()
          : null,
      marketCap: json['marketCap'] != null
          ? (json['marketCap'] as num).toDouble()
          : null,
      avgVolume: json['avgVolume'] != null
          ? (json['avgVolume'] as num).toDouble()
          : null,
    );
  }

  final String symbol;
  final String name;
  final double price;
  final double open;
  final double high;
  final double low;
  final double previousClose;
  final double change;
  final double changePercent;
  final double volume;
  final DateTime timestamp;
  final double? fiftyTwoWeekHigh;
  final double? fiftyTwoWeekLow;
  final double? marketCap;
  final double? avgVolume;

  bool get isPositive => change >= 0;

  MarketSnapshot copyWithPrice({
    required double price,
    required double high,
    required double low,
    required double volume,
    DateTime? timestamp,
  }) {
    final newChange = price - previousClose;
    final newChangePercent = (newChange / previousClose) * 100;
    return MarketSnapshot(
      symbol: symbol,
      name: name,
      price: price,
      open: open,
      high: high,
      low: low,
      previousClose: previousClose,
      change: newChange,
      changePercent: newChangePercent,
      volume: volume,
      timestamp: timestamp ?? this.timestamp,
      fiftyTwoWeekHigh: fiftyTwoWeekHigh,
      fiftyTwoWeekLow: fiftyTwoWeekLow,
      marketCap: marketCap,
      avgVolume: avgVolume,
    );
  }
}
