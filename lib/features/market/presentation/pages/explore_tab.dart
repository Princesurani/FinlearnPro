import 'package:flutter/material.dart';

import '../../../../core/domain/instrument.dart';
import '../../../../core/domain/market_data.dart';
import '../../../../core/domain/market_regime.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/market_formatters.dart';
import '../../bloc/market_bloc.dart';
import '../../widgets/instrument_grid_2x2.dart';
import '../../widgets/products_tools_row.dart';
import '../../widgets/section_header.dart';
import '../../widgets/sector_trending_card.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key, required this.state});
  final MarketState state;

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab>
    with AutomaticKeepAliveClientMixin {
  String _moverFilter = 'gainers';
  String _capFilter = 'all';

  @override
  bool get wantKeepAlive => true;

  MarketState get _s => widget.state;
  List<Instrument> get _tradable => _s.tradableInstruments;
  Map<String, MarketSnapshot> get _snaps => _s.snapshots;
  MarketRegime get _market => _s.activeMarket;

  Map<String, MarketSnapshot>? _lastSnaps;
  List<Instrument>? _cachedTopByVolume;
  List<Instrument>? _cachedMtfStocks;
  List<Instrument>? _cachedTopIntraday;
  List<_VolumeShockerData>? _cachedVolumeShockers;
  List<Instrument>? _cachedStocksInNews;

  void _ensureCache() {
    if (!identical(_lastSnaps, _snaps)) {
      _lastSnaps = _snaps;
      _cachedTopByVolume = null;
      _cachedMtfStocks = null;
      _cachedTopIntraday = null;
      _cachedVolumeShockers = null;
      _cachedStocksInNews = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _ensureCache();
    final formatter = MarketFormatterFactory.forMarket(_market);

    return ListView(
      padding: const EdgeInsets.only(top: AppSpacing.xl, bottom: 100),
      children: [
        _section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Most Bought',
                subtitle: 'Popular among investors on FinLearn',
                actionText: 'See more',
              ),
              InstrumentGrid2x2(
                instruments: _topByVolume(4),
                market: _market,
                snapshots: _snaps,
              ),
            ],
          ),
        ),

        _sectionGap(),

        _section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Products & Tools',
                actionText: 'See more',
              ),
              const ProductsToolsRow(),
            ],
          ),
        ),

        _sectionGap(),

        _section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(title: 'Top Movers Today'),
              _buildMoverFilters(),
              const SizedBox(height: AppSpacing.sm),
              InstrumentGrid2x2(
                instruments: _topMovers(),
                market: _market,
                snapshots: _snaps,
              ),
            ],
          ),
        ),

        _sectionGap(),

        _section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Most Traded in MTF',
                subtitle: 'Margin Trading Facility',
                actionText: 'See more',
              ),
              InstrumentGrid2x2(
                instruments: _mtfStocks(),
                market: _market,
                snapshots: _snaps,
              ),
            ],
          ),
        ),

        _sectionGap(),

        _section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Top Intraday',
                subtitle: 'Highest intraday price movement',
                actionText: 'Intraday screener',
              ),
              InstrumentGrid2x2(
                instruments: _topIntraday(),
                market: _market,
                snapshots: _snaps,
              ),
            ],
          ),
        ),

        _sectionGap(),

        _section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Volume Shockers',
                subtitle: 'Stocks trading above their weekly avg volume',
                actionText: 'See more',
              ),
              _buildVolumeShockersList(formatter),
            ],
          ),
        ),

        _sectionGap(),

        _section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Trading Screens',
                actionText: 'Intraday screener',
              ),
              _buildTradingSignals(),
            ],
          ),
        ),

        _sectionGap(),

        _section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Sectors Trending Today',
                subtitle: 'Sectors with the highest price change',
              ),
              SectorTrendingCard(
                market: _market,
                snapshots: _snaps,
                instruments: _tradable,
              ),
            ],
          ),
        ),

        _sectionGap(),

        _section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'Popular ETFs for ${_market.systematicInvestmentTerm}',
                actionText: 'See more',
              ),
              _buildETFRow(formatter),
            ],
          ),
        ),

        _sectionGap(),

        _section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Stocks in News',
                actionText: 'Market news',
              ),
              InstrumentGrid2x2(
                instruments: _stocksInNews(),
                market: _market,
                snapshots: _snaps,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _section({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingHorizontal,
      ),
      child: child,
    );
  }

  Widget _sectionGap() => const SizedBox(height: 40);

  Widget _buildMoverFilters() {
    return Row(
      children: [
        _chipButton(
          label: 'Gainers',
          isActive: _moverFilter == 'gainers',
          activeColor: AppColors.profitGreen,
          onTap: () => setState(() => _moverFilter = 'gainers'),
        ),
        const SizedBox(width: AppSpacing.xs),
        _chipButton(
          label: 'Losers',
          isActive: _moverFilter == 'losers',
          activeColor: AppColors.lossRed,
          onTap: () => setState(() => _moverFilter = 'losers'),
        ),

        const Spacer(),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xxs,
          ),
          decoration: BoxDecoration(
            borderRadius: AppSpacing.borderRadiusSM,
            border: Border.all(color: AppColors.border, width: 0.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _capFilter,
              isDense: true,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textPrimary,
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: AppColors.textSecondary,
              ),
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All')),
                DropdownMenuItem(value: 'large', child: Text('Large Cap')),
                DropdownMenuItem(value: 'mid', child: Text('Mid Cap')),
                DropdownMenuItem(value: 'small', child: Text('Small Cap')),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _capFilter = v);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _chipButton({
    required String label,
    required bool isActive,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: Border.all(
            color: isActive ? activeColor : AppColors.border,
            width: isActive ? 1.5 : 0.5,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.label.copyWith(
            color: isActive ? activeColor : AppColors.textSecondary,
            fontWeight: isActive
                ? AppTypography.semiBold
                : AppTypography.medium,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildVolumeShockersList(MarketFormatter formatter) {
    final shockers = _volumeShockers();

    return Column(
      children: [
        for (var i = 0; i < shockers.length; i++) ...[
          _buildShockerRow(shockers[i], formatter),
          if (i < shockers.length - 1)
            const Divider(height: 1, color: AppColors.borderLight),
        ],
      ],
    );
  }

  Widget _buildShockerRow(_VolumeShockerData data, MarketFormatter formatter) {
    final snap = _snaps[data.instrument.symbol];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          _buildMiniLogo(data.instrument),
          AppSpacing.gapHSM,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.instrument.name,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: AppTypography.medium,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  data.instrument.symbol,
                  style: AppTypography.bodyXS.copyWith(
                    color: AppColors.textTertiary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.xxxs,
            ),
            decoration: BoxDecoration(
              color: AppColors.profitGreen.withAlpha(20),
              borderRadius: AppSpacing.borderRadiusXS,
            ),
            child: Text(
              '+${data.volumeSpike.toStringAsFixed(0)}%',
              style: AppTypography.numberSmall.copyWith(
                color: AppColors.profitGreen,
                fontWeight: AppTypography.semiBold,
                fontSize: 12,
              ),
            ),
          ),
          AppSpacing.gapHSM,

          Text(
            snap != null ? formatter.formatVolume(snap.volume) : '—',
            style: AppTypography.numberSmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTradingSignals() {
    const signals = [
      _SignalDef(
        title: 'Bullish Resistance\nBreakouts',
        count: 12,
        icon: Icons.trending_up_rounded,
        color: AppColors.profitGreen,
      ),
      _SignalDef(
        title: 'Bearish\nRSI Overbought',
        count: 8,
        icon: Icons.trending_down_rounded,
        color: AppColors.lossRed,
      ),
      _SignalDef(
        title: 'Bullish MACD\nAbove Signal',
        count: 15,
        icon: Icons.show_chart_rounded,
        color: AppColors.electricBlue,
      ),
      _SignalDef(
        title: 'Bullish\nRSI Oversold',
        count: 6,
        icon: Icons.ssid_chart_rounded,
        color: AppColors.oceanTeal,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 1.4,
      ),
      itemCount: signals.length,
      itemBuilder: (_, i) => _buildSignalCard(signals[i]),
    );
  }

  Widget _buildSignalCard(_SignalDef signal) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMD,
        border: Border.all(color: AppColors.border, width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: signal.color.withAlpha(20),
              borderRadius: AppSpacing.borderRadiusSM,
            ),
            child: Icon(signal.icon, size: 18, color: signal.color),
          ),
          const Spacer(),

          Text(
            signal.title,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: AppTypography.medium,
              height: 1.3,
              letterSpacing: 0,
              fontSize: 11,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),

          Text(
            '${signal.count} stocks',
            style: AppTypography.bodyXS.copyWith(
              color: signal.color,
              fontWeight: AppTypography.semiBold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildETFRow(MarketFormatter formatter) {
    final etfs = _tradable
        .where((i) => i.type == InstrumentType.etf)
        .take(2)
        .toList();

    if (etfs.isEmpty) {
      return Text(
        'No ETFs available for this market',
        style: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary),
      );
    }

    return Row(
      children: [
        for (var i = 0; i < etfs.length; i++) ...[
          Expanded(child: _buildETFCard(etfs[i], formatter)),
          if (i < etfs.length - 1) const SizedBox(width: AppSpacing.sm),
        ],
      ],
    );
  }

  Widget _buildETFCard(Instrument etf, MarketFormatter formatter) {
    final snap = _snaps[etf.symbol];
    final isUp = (snap?.change ?? 0) >= 0;
    final changeColor = isUp ? AppColors.profitGreen : AppColors.lossRed;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMD,
        border: Border.all(color: AppColors.border, width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            etf.name,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: AppTypography.medium,
              letterSpacing: 0,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),

          if (snap != null) ...[
            Text(
              formatter.formatPrice(snap.price),
              style: AppTypography.number.copyWith(
                fontWeight: AppTypography.semiBold,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(
                  isUp
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                  size: 16,
                  color: changeColor,
                ),
                Flexible(
                  child: Text(
                    '${isUp ? '+' : ''}${snap.change.toStringAsFixed(2)} '
                    '${snap.changePercent.abs().toStringAsFixed(2)}%',
                    style: AppTypography.numberSmall.copyWith(
                      color: changeColor,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMiniLogo(Instrument inst) {
    final color = _sectorColor(inst.sector);
    final initials = inst.symbol
        .replaceAll('/', '')
        .replaceAll('.', '')
        .substring(0, inst.symbol.length >= 2 ? 2 : 1)
        .toUpperCase();

    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppSpacing.borderRadiusSM,
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  static Color _sectorColor(Sector sector) {
    switch (sector) {
      case Sector.technology:
        return AppColors.electricBlue;
      case Sector.financialServices:
        return AppColors.emerald;
      case Sector.healthcare:
        return AppColors.oceanTeal;
      case Sector.consumerCyclical:
        return AppColors.primaryPurple;
      case Sector.consumerDefensive:
        return AppColors.lavender;
      case Sector.industrials:
        return AppColors.indigo;
      case Sector.energy:
        return AppColors.sunsetOrange;
      case Sector.utilities:
        return AppColors.amber;
      case Sector.realEstate:
        return AppColors.coralPink;
      case Sector.basicMaterials:
        return AppColors.goldenYellow;
      case Sector.communicationServices:
        return AppColors.cyan;
      case Sector.unknown:
        return AppColors.neutralGray;
    }
  }

  List<Instrument> _topByVolume(int n) {
    if (_cachedTopByVolume != null) return _cachedTopByVolume!;
    final sorted =
        List<Instrument>.from(
          _tradable.where((i) => i.type == InstrumentType.stock),
        )..sort((a, b) {
          final va = _snaps[a.symbol]?.volume ?? 0;
          final vb = _snaps[b.symbol]?.volume ?? 0;
          return vb.compareTo(va);
        });
    _cachedTopByVolume = sorted.take(n).toList();
    return _cachedTopByVolume!;
  }

  List<Instrument> _topMovers() {
    var stocks = _tradable.where((i) => i.type == InstrumentType.stock);

    if (_capFilter != 'all') {
      stocks = stocks.where((i) {
        final cap = _snaps[i.symbol]?.marketCap ?? 0;
        switch (_capFilter) {
          case 'large':
            return cap > 10e9;
          case 'mid':
            return cap >= 2e9 && cap <= 10e9;
          case 'small':
            return cap < 2e9;
          default:
            return true;
        }
      });
    }

    final list = stocks.toList()
      ..sort((a, b) {
        final ca = _snaps[a.symbol]?.changePercent ?? 0;
        final cb = _snaps[b.symbol]?.changePercent ?? 0;
        return _moverFilter == 'gainers' ? cb.compareTo(ca) : ca.compareTo(cb);
      });

    return list.take(4).toList();
  }

  List<Instrument> _mtfStocks() {
    if (_cachedMtfStocks != null) return _cachedMtfStocks!;
    final stocks =
        _tradable.where((i) => i.type == InstrumentType.stock).toList()
          ..sort((a, b) {
            final va = _snaps[a.symbol]?.volume ?? 0;
            final vb = _snaps[b.symbol]?.volume ?? 0;
            return vb.compareTo(va);
          });
    _cachedMtfStocks = stocks.take(4).toList();
    return _cachedMtfStocks!;
  }

  List<Instrument> _topIntraday() {
    if (_cachedTopIntraday != null) return _cachedTopIntraday!;
    final stocks =
        _tradable.where((i) => i.type == InstrumentType.stock).toList()
          ..sort((a, b) {
            final sa = _snaps[a.symbol];
            final sb = _snaps[b.symbol];
            final ra = sa != null && sa.open > 0
                ? (sa.high - sa.low) / sa.open
                : 0.0;
            final rb = sb != null && sb.open > 0
                ? (sb.high - sb.low) / sb.open
                : 0.0;
            return rb.compareTo(ra);
          });
    _cachedTopIntraday = stocks.take(4).toList();
    return _cachedTopIntraday!;
  }

  List<_VolumeShockerData> _volumeShockers() {
    if (_cachedVolumeShockers != null) return _cachedVolumeShockers!;
    final stocks = _tradable
        .where((i) => i.type == InstrumentType.stock)
        .toList();

    final shockers = stocks.map((inst) {
      final snap = _snaps[inst.symbol];
      final spike = (inst.volatility * 10000 + (inst.priceSeed % 5000))
          .clamp(500, 9999)
          .toDouble();
      return _VolumeShockerData(
        instrument: inst,
        volumeSpike: spike,
        volume: snap?.volume ?? 0,
      );
    }).toList()..sort((a, b) => b.volumeSpike.compareTo(a.volumeSpike));

    _cachedVolumeShockers = shockers.take(5).toList();
    return _cachedVolumeShockers!;
  }

  List<Instrument> _stocksInNews() {
    if (_cachedStocksInNews != null) return _cachedStocksInNews!;
    final stocks =
        _tradable.where((i) => i.type == InstrumentType.stock).toList()
          ..sort((a, b) {
            final ca = (_snaps[a.symbol]?.changePercent ?? 0).abs();
            final cb = (_snaps[b.symbol]?.changePercent ?? 0).abs();
            return cb.compareTo(ca);
          });
    _cachedStocksInNews = stocks.take(4).toList();
    return _cachedStocksInNews!;
  }
}

class _VolumeShockerData {
  const _VolumeShockerData({
    required this.instrument,
    required this.volumeSpike,
    required this.volume,
  });
  final Instrument instrument;
  final double volumeSpike;
  final double volume;
}

class _SignalDef {
  const _SignalDef({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });
  final String title;
  final int count;
  final IconData icon;
  final Color color;
}
