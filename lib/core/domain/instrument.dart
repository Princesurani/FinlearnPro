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

  factory Instrument.fromJson(Map<String, dynamic> json) {
    return Instrument(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      type: InstrumentType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => InstrumentType.stock,
      ),
      sector: Sector.values.firstWhere(
        (e) => e.name == json['sector'],
        orElse: () => Sector.unknown,
      ),
      market: MarketRegime.values.firstWhere(
        (e) => e.name == json['market'],
        orElse: () => MarketRegime.usa,
      ),
      basePrice: (json['basePrice'] as num).toDouble(),
      volatility: (json['volatility'] as num).toDouble(),
      description: json['description'] as String,
      logoUrl: json['logoUrl'] as String?,
      exchange: json['exchange'] as String?,
      isin: json['isin'] as String?,
    );
  }

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
