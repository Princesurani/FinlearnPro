import 'package:flutter/material.dart';

import '../../../../core/domain/instrument.dart';
import '../../../../core/domain/market_data.dart';
import '../../../../core/domain/market_regime.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../../bloc/market_bloc.dart';
import '../widgets/instrument_grid_2x2.dart';
import '../widgets/products_tools_row.dart';
import '../widgets/section_header.dart';
import '../widgets/sector_trending_card.dart';

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
  List<Instrument>? _cachedStocksInNews;

  void _ensureCache() {
    if (!identical(_lastSnaps, _snaps)) {
      _lastSnaps = _snaps;
      _cachedTopByVolume = null;
      _cachedStocksInNews = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _ensureCache();

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
