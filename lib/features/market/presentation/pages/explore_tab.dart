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
  const ExploreTab({super.key, required this.state, required this.bloc});
  final MarketState state;
  final MarketBloc bloc;

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab>
    with AutomaticKeepAliveClientMixin {
  String _moverFilter = 'gainers';
  String _capFilter = 'all';
  bool _showAllMovers = false;

  @override
  bool get wantKeepAlive => true;

  MarketState get _s => widget.state;
  List<Instrument> get _tradable => _s.tradableInstruments;
  Map<String, MarketSnapshot> get _snaps => _s.snapshots;
  MarketRegime get _market => _s.activeMarket;

  Map<String, MarketSnapshot>? _lastSnaps;
  List<Instrument>? _cachedStocksInNews;

  void _ensureCache() {
    if (!identical(_lastSnaps, _snaps)) {
      _lastSnaps = _snaps;
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
              SectionHeader(
                title: 'Top Movers Today',
                actionText: _showAllMovers ? 'Show Less' : 'See All',
                onAction: () {
                  setState(() {
                    _showAllMovers = !_showAllMovers;
                  });
                },
              ),
              _buildMoverFilters(),
              const SizedBox(height: AppSpacing.sm),
              InstrumentGrid2x2(
                instruments: _topMovers(),
                market: _market,
                snapshots: _snaps,
                bloc: widget.bloc,
                showSeeMore: !_showAllMovers,
                onSeeMore: () {
                  setState(() {
                    _showAllMovers = true;
                  });
                },
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
                bloc: widget.bloc,
                showSeeMore: false,
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

        Theme(
          data: Theme.of(context).copyWith(
            splashColor: AppColors.primary.withValues(alpha: 0.1),
            highlightColor: AppColors.primary.withValues(alpha: 0.05),
          ),
          child: PopupMenuButton<String>(
            initialValue: _capFilter,
            onSelected: (v) => setState(() => _capFilter = v),
            color: AppColors.surfaceLayer1,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: AppColors.borderHint.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            position: PopupMenuPosition.under,
            offset: const Offset(0, 8),
            itemBuilder: (context) => [
              _buildPopupItem('all', 'All Market Caps'),
              const PopupMenuDivider(height: 1),
              _buildPopupItem('large', 'Large Cap'),
              _buildPopupItem('mid', 'Mid Cap'),
              _buildPopupItem('small', 'Small Cap'),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: _capFilter == 'all' 
                    ? AppColors.textSecondary.withValues(alpha: 0.02)
                    : AppColors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                border: Border.all(
                  color: _capFilter == 'all'
                      ? AppColors.textSecondary.withValues(alpha: 0.08)
                      : AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.filter_list_rounded,
                    size: 14,
                    color: _capFilter == 'all' ? AppColors.textSecondary : AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _capFilter == 'all'
                        ? 'Filter'
                        : _capFilter == 'large'
                            ? 'Large Cap'
                            : _capFilter == 'mid'
                                ? 'Mid Cap'
                                : 'Small Cap',
                    style: AppTypography.label.copyWith(
                      color: _capFilter == 'all' ? AppColors.textPrimary : AppColors.primary,
                      fontWeight: _capFilter == 'all' ? AppTypography.medium : AppTypography.semiBold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 16,
                    color: _capFilter == 'all' ? AppColors.textSecondary : AppColors.primary,
                  ),
                ],
              ),
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
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withAlpha(20) : AppColors.textSecondary.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: Border.all(
            color: isActive ? activeColor.withValues(alpha: 0.15) : AppColors.textSecondary.withValues(alpha: 0.08),
            width: 1.0,
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

  List<Instrument> _topMovers() {
    var stocks = _tradable.where((i) => i.type == InstrumentType.stock);

    if (_capFilter != 'all') {
      stocks = stocks.where((i) {
        double cap = _snaps[i.symbol]?.marketCap ?? 0;
        
        // If market cap is not provided by the API, distribute deterministically for the UI
        if (cap == 0) {
          final hash = i.symbol.hashCode.abs();
          final category = hash % 3; // 0 = Large, 1 = Mid, 2 = Small
          if (category == 0) {
            cap = 50e9; // Large Cap
          } else if (category == 1) {
            cap = 5e9; // Mid Cap
          } else {
            cap = 1e9; // Small Cap
          }
        }
        
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

    return _showAllMovers ? list : list.take(4).toList();
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

  PopupMenuItem<String> _buildPopupItem(String value, String label) {
    final isSelected = _capFilter == value;
    return PopupMenuItem<String>(
      value: value,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.label.copyWith(
              color: isSelected ? AppColors.primary : AppColors.textPrimary,
              fontWeight: isSelected ? AppTypography.semiBold : AppTypography.medium,
            ),
          ),
          if (isSelected)
            const Icon(Icons.check_rounded, size: 16, color: AppColors.primary),
        ],
      ),
    );
  }
}
