import 'market_regime.dart';

enum InstrumentType {
  stock,
  marketIndex, // Renamed from 'index' to avoid conflict with enum.index
  etf,
  commodity,
  forex,
  crypto,
  bond,
}

enum Sector {
  technology,
  financialServices,
  healthcare,
  consumerCyclical,
  consumerDefensive,
  industrials,
  energy,
  utilities,
  realEstate,
  basicMaterials,
  communicationServices,
  unknown,
}

class Instrument {
  const Instrument({
    required this.symbol,
    required this.name,
    required this.type,
    required this.sector,
    required this.market,
    required this.basePrice,
    required this.volatility,
    required this.description,
    this.logoUrl,
    this.exchange,
    this.isin,
  });

  final String symbol;

  final String name;

  final InstrumentType type;

  final Sector sector;

  final MarketRegime market;

  final double basePrice;

  final double volatility;

  final String description;

  final String? logoUrl;

  final String? exchange;

  final String? isin;

  int get priceSeed => '${symbol}_${market.shortName}_v1'.hashCode;

  String get currencySymbol => market.currencySymbol;

  bool get isTradable => type != InstrumentType.marketIndex;

  @override
  String toString() => '$symbol ($name) on ${market.shortName}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Instrument &&
          runtimeType == other.runtimeType &&
          symbol == other.symbol &&
          market == other.market;

  @override
  int get hashCode => symbol.hashCode ^ market.hashCode;
}
