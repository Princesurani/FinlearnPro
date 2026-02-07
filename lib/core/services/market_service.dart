import 'dart:math' as math;

import '../domain/instrument.dart';
import '../domain/market_data.dart';

class MarketService {
  MarketService({int? globalSeed})
      : _globalSeed = globalSeed ?? DateTime.now().millisecondsSinceEpoch;

  final int _globalSeed;


  List<Candle> generateCandles(
    Instrument instrument,
    Timeframe timeframe, {
    required int count,
    DateTime? endTime,
  }) {
    final end = endTime ?? DateTime.now();
    final candles = <Candle>[];

    final prng = _Xoshiro256StarStar(
      seed: _globalSeed ^ instrument.priceSeed ^ timeframe.hashCode,
    );

    final drift = _getDrift(instrument);
    var volatility = instrument.volatility;

    var price = instrument.basePrice;

    var previousReturn = 0.0;

    final dt = timeframe.duration.inSeconds / (365.25 * 24 * 3600);

    for (var i = 0; i < count; i++) {
      final timestamp = end.subtract(timeframe.duration * (count - 1 - i));

      volatility = _updateVolatility(
        baseVol: instrument.volatility,
        previousReturn: previousReturn,
        previousVol: volatility,
      );

      final candle = _generateCandle(
        timestamp: timestamp,
        openPrice: price,
        drift: drift,
        volatility: volatility,
        dt: dt,
        prng: prng,
        instrument: instrument,
        timeframe: timeframe,
      );

      candles.add(candle);

      price = candle.close;
      previousReturn = (candle.close - candle.open) / candle.open;
    }

    return candles;
  }

  MarketSnapshot getCurrentSnapshot(Instrument instrument) {
    final recentCandles = generateCandles(
      instrument,
      Timeframe.oneMinute,
      count: 2 * 24 * 60, // 2 days
    );

    final lastCandle = recentCandles.last;
    final previousClose = recentCandles[recentCandles.length - 2].close;

    final yearCandles = generateCandles(
      instrument,
      Timeframe.oneDay,
      count: 365,
      endTime: lastCandle.timestamp,
    );
    
    final high52w = yearCandles.map((c) => c.high).reduce(math.max);
    final low52w = yearCandles.map((c) => c.low).reduce(math.min);

    final marketCap = instrument.type == InstrumentType.stock
        ? lastCandle.close * _estimateSharesOutstanding(instrument)
        : null;

    final monthCandles = yearCandles.sublist(yearCandles.length - 30);
    final avgVolume = monthCandles
            .map((c) => c.volume)
            .reduce((a, b) => a + b) /
        monthCandles.length;

    return MarketSnapshot(
      symbol: instrument.symbol,
      name: instrument.name,
      price: lastCandle.close,
      open: lastCandle.open,
      high: lastCandle.high,
      low: lastCandle.low,
      previousClose: previousClose,
      change: lastCandle.close - previousClose,
      changePercent: ((lastCandle.close - previousClose) / previousClose) * 100,
      volume: lastCandle.volume,
      timestamp: lastCandle.timestamp,
      fiftyTwoWeekHigh: high52w,
      fiftyTwoWeekLow: low52w,
      marketCap: marketCap,
      avgVolume: avgVolume,
    );
  }

  PriceTick getCurrentTick(Instrument instrument) {
    final snapshot = getCurrentSnapshot(instrument);
    
    final spreadBps = instrument.volatility * 20; // Higher vol = wider spread
    final spread = snapshot.price * (spreadBps / 10000);

    return PriceTick(
      symbol: instrument.symbol,
      timestamp: snapshot.timestamp,
      price: snapshot.price,
      bid: snapshot.price - spread / 2,
      ask: snapshot.price + spread / 2,
      volume: snapshot.volume,
      change: snapshot.change,
      changePercent: snapshot.changePercent,
    );
  }

  PriceTick getQuickTick(Instrument instrument, MarketSnapshot existing) {
    final timeBucket = DateTime.now().millisecondsSinceEpoch ~/ 3000;
    final prng = _Xoshiro256StarStar(
      seed: _globalSeed ^ instrument.priceSeed ^ timeBucket,
    );

    final z = _boxMuller(prng);
    final tickMove = instrument.volatility * 0.005 * z;
    final newPrice = existing.price * (1 + tickMove);

    final spreadBps = instrument.volatility * 20;
    final spread = newPrice * (spreadBps / 10000);

    final volumeAdd =
        _getBaseVolume(instrument) * 0.0005 * (0.5 + prng.nextDouble());

    return PriceTick(
      symbol: instrument.symbol,
      timestamp: DateTime.now(),
      price: newPrice,
      bid: newPrice - spread / 2,
      ask: newPrice + spread / 2,
      volume: existing.volume + volumeAdd,
      change: newPrice - existing.previousClose,
      changePercent:
          ((newPrice - existing.previousClose) / existing.previousClose) * 100,
    );
  }


  Candle _generateCandle({
    required DateTime timestamp,
    required double openPrice,
    required double drift,
    required double volatility,
    required double dt,
    required _Xoshiro256StarStar prng,
    required Instrument instrument,
    required Timeframe timeframe,
  }) {
    final tickCount = _getTickCount(timeframe);

    var price = openPrice;
    var high = openPrice;
    var low = openPrice;

    for (var t = 0; t < tickCount; t++) {
      final z = _boxMuller(prng);
      final driftTerm = (drift - volatility * volatility / 2) * dt;
      final diffusionTerm = volatility * math.sqrt(dt) * z;

      final jumpTerm = _mertonJump(prng, instrument);

      price *= math.exp(driftTerm + diffusionTerm + jumpTerm);

      if (price > high) high = price;
      if (price < low) low = price;
    }

    final close = price;
    final volume = _generateVolume(
      instrument: instrument,
      timeframe: timeframe,
      timestamp: timestamp,
      prng: prng,
    );

    return Candle(
      timestamp: timestamp,
      open: openPrice,
      high: high,
      low: low,
      close: close,
      volume: volume,
    );
  }

  double _updateVolatility({
    required double baseVol,
    required double previousReturn,
    required double previousVol,
  }) {
    const omega = 0.0001; // Long-term variance baseline
    const alpha = 0.1; // Sensitivity to recent shocks
    const beta = 0.85; // Persistence of old volatility

    final newVariance = omega +
        alpha * previousReturn * previousReturn +
        beta * previousVol * previousVol;

    final newVol = math.sqrt(newVariance);
    return newVol.clamp(baseVol * 0.5, baseVol * 2.0);
  }

  double _mertonJump(_Xoshiro256StarStar prng, Instrument instrument) {
    const jumpProbability = 0.01; // 1% chance per tick
    const jumpMeanSize = 0.0; // Symmetric jumps
    final jumpStdDev = instrument.volatility * 0.5;

    if (prng.nextDouble() < jumpProbability) {
      final jumpZ = _boxMuller(prng);
      return jumpMeanSize + jumpStdDev * jumpZ;
    }

    return 0.0;
  }

  double _generateVolume({
    required Instrument instrument,
    required Timeframe timeframe,
    required DateTime timestamp,
    required _Xoshiro256StarStar prng,
  }) {
    final baseVolume = _getBaseVolume(instrument);

    final timeframeMultiplier = timeframe.duration.inSeconds /
        (24 * 3600); // Fraction of a day

    final intradayMultiplier = _getIntradayMultiplier(timestamp);

    final randomMultiplier = 0.7 + prng.nextDouble() * 0.6;

    return baseVolume *
        timeframeMultiplier *
        intradayMultiplier *
        randomMultiplier;
  }


  double _getDrift(Instrument instrument) {
    switch (instrument.type) {
      case InstrumentType.stock:
        return 0.10; // 10% annual growth
      case InstrumentType.marketIndex:
        return 0.08; // 8% market return
      case InstrumentType.etf:
        return 0.09;
      case InstrumentType.crypto:
        return 0.20; // 20% (but much higher vol)
      case InstrumentType.commodity:
        return 0.05;
      case InstrumentType.forex:
        return 0.0; // Zero-sum
      case InstrumentType.bond:
        return 0.03;
    }
  }

  int _getTickCount(Timeframe timeframe) {
    switch (timeframe) {
      case Timeframe.tick:
        return 1;
      case Timeframe.oneMinute:
        return 10;
      case Timeframe.fiveMinute:
        return 20;
      case Timeframe.fifteenMinute:
        return 30;
      case Timeframe.oneHour:
        return 60;
      case Timeframe.fourHour:
        return 100;
      case Timeframe.oneDay:
        return 200;
      case Timeframe.oneWeek:
        return 500;
      case Timeframe.oneMonth:
        return 1000;
    }
  }

  double _getBaseVolume(Instrument instrument) {
    final basePrice = instrument.basePrice;

    switch (instrument.type) {
      case InstrumentType.stock:
        if (basePrice > 1000) return 500000; // High-price (e.g., MARUTI)
        if (basePrice > 100) return 2000000; // Mid-price
        return 5000000; // Low-price (higher share count)
      
      case InstrumentType.marketIndex:
        return 0; // Indices don't have volume
      
      case InstrumentType.etf:
        return 1000000; // ETFs have moderate volume
      
      case InstrumentType.crypto:
        if (basePrice > 10000) return 50000; // BTC
        if (basePrice > 1000) return 500000; // ETH
        if (basePrice > 100) return 2000000; // Mid-caps
        return 50000000; // Altcoins (high count, low value)
      
      default:
        return 1000000;
    }
  }

  double _getIntradayMultiplier(DateTime timestamp) {
    final hour = timestamp.hour;
    
    if (hour >= 9 && hour < 10) return 1.5; // Opening rush
    if (hour >= 10 && hour < 12) return 1.0; // Morning
    if (hour >= 12 && hour < 14) return 0.7; // Lunch lull
    if (hour >= 14 && hour < 15) return 1.1; // Afternoon
    if (hour >= 15 && hour < 16) return 1.6; // Closing rush
    
    return 0.5; // Off-hours (pre/post market)
  }

  double _estimateSharesOutstanding(Instrument instrument) {
    final basePrice = instrument.basePrice;
    
    if (basePrice > 1000) return 100000000; // 100M shares
    if (basePrice > 100) return 500000000; // 500M shares
    return 2000000000; // 2B shares (low-price stocks)
  }


  double _boxMuller(_Xoshiro256StarStar prng) {
    final u1 = prng.nextDouble();
    final u2 = prng.nextDouble();
    return math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2);
  }
}


class _Xoshiro256StarStar {
  _Xoshiro256StarStar({required int seed}) {
    var state = seed;
    for (var i = 0; i < 4; i++) {
      state += 0x9e3779b97f4a7c15;
      var z = state;
      z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9;
      z = (z ^ (z >> 27)) * 0x94d049bb133111eb;
      z = z ^ (z >> 31);
      _state[i] = z;
    }
  }

  final _state = List<int>.filled(4, 0);

  int next() {
    final result = _rotl(_state[1] * 5, 7) * 9;
    final t = _state[1] << 17;

    _state[2] ^= _state[0];
    _state[3] ^= _state[1];
    _state[1] ^= _state[2];
    _state[0] ^= _state[3];

    _state[2] ^= t;
    _state[3] = _rotl(_state[3], 45);

    return result;
  }

  double nextDouble() {
    return (next() >>> 11) / (1 << 53);
  }

  int _rotl(int x, int k) {
    return (x << k) | (x >> (64 - k));
  }
}
