import 'package:flutter/material.dart';
import '../../../../core/domain/instrument.dart';
import '../../../../core/domain/market_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/market_formatters.dart';
import '../../bloc/market_bloc.dart';

class StockDetailScreen extends StatelessWidget {
  const StockDetailScreen({
    super.key,
    required this.instrument,
    required this.snapshot,
    this.bloc,
  });

  final Instrument instrument;
  final MarketSnapshot? snapshot;
  final MarketBloc? bloc;

  @override
  Widget build(BuildContext context) {
    final effectiveBloc = bloc ?? MarketBloc();
    final formatter = MarketFormatterFactory.forMarket(instrument.market);
    final price = snapshot?.price ?? 0;
    final change = snapshot?.change ?? 0;
    final changePercent = snapshot?.changePercent ?? 0;
    final isUp = change >= 0;
    final color = isUp ? AppColors.profitGreen : AppColors.lossRed;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundPrimary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, size: 24),
            color: AppColors.textPrimary,
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            StreamBuilder<MarketState>(
              stream: effectiveBloc.stream,
              initialData: effectiveBloc.state,
              builder: (context, snapshot) {
                final state = snapshot.data!;
                final isInWatchlist = state.isInWatchlist(instrument.symbol);
                return IconButton(
                  icon: Icon(
                    isInWatchlist
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: isInWatchlist
                        ? AppColors.primaryPurple
                        : AppColors.textPrimary,
                  ),
                  onPressed: () {
                    if (isInWatchlist) {
                      effectiveBloc.add(RemoveFromWatchlist(instrument.symbol));
                    } else {
                      effectiveBloc.add(AddToWatchlist(instrument.symbol));
                    }
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isInWatchlist
                              ? '${instrument.symbol} removed from watchlist'
                              : '${instrument.symbol} added to watchlist',
                        ),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {},
              color: AppColors.textPrimary,
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Symbol & Name Header
                            Row(
                              children: [
                                Hero(
                                  tag: 'box_${instrument.symbol}',
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: _getSectorColor(
                                        instrument.sector,
                                      ).withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      instrument.symbol.substring(0, 1),
                                      style: TextStyle(
                                        color: _getSectorColor(
                                          instrument.sector,
                                        ),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Hero(
                                      tag: 'symbol_${instrument.symbol}',
                                      child: Material(
                                        color: AppColors.transparent,
                                        child: Text(
                                          '${instrument.symbol} • ${instrument.market.name.toUpperCase()}',
                                          style: AppTypography.labelSmall
                                              .copyWith(
                                                color: AppColors.textTertiary,
                                                fontSize: 10,
                                              ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      instrument.name,
                                      style: AppTypography.bodySmall.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.lg),

                            // Price Header
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  formatter.formatPrice(price),
                                  style: AppTypography.h2.copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Text(
                                  '${change >= 0 ? '+' : ''}${change.abs().toStringAsFixed(2)} (${changePercent.abs().toStringAsFixed(2)}%)',
                                  style: AppTypography.body.copyWith(
                                    color: color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '1D',
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xl),
                          ],
                        ),
                      ),
                    ),

                    // Chart Section (BoxAdapter)
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
                            decoration: BoxDecoration(
                              // No border in reference, purely graph
                            ),
                            child: Stack(
                              children: [
                                // Placeholder for Graph
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.show_chart_rounded,
                                        size: 48,
                                        color: AppColors.textTertiary
                                            .withValues(alpha: 0.3),
                                      ),
                                      const SizedBox(height: AppSpacing.sm),
                                      Text(
                                        'Interactive Chart',
                                        style: AppTypography.labelSmall
                                            .copyWith(
                                              color: AppColors.textTertiary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                // In a real app, this would be the graph
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          // Timeframe Selector
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
                            child: _TimeframeSelector(),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                        ],
                      ),
                    ),

                    // TabBar (Current Page)
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          isScrollable: true,
                          labelColor: AppColors.textPrimary,
                          unselectedLabelColor: AppColors.textSecondary,
                          labelStyle: AppTypography.label.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelStyle: AppTypography.label,
                          indicatorColor: AppColors.primaryPurple,
                          indicatorWeight: 3,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: const [
                            Tab(text: 'Overview'),
                            Tab(text: 'Technicals'),
                            Tab(text: 'F&O'),
                            Tab(text: 'News'),
                            Tab(text: 'Events'),
                          ],
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    _OverviewTab(snapshot: snapshot, formatter: formatter),
                    const _PlaceholderTab(title: 'Technicals'),
                    const _PlaceholderTab(title: 'F&O'),
                    const _PlaceholderTab(title: 'News'),
                    const _PlaceholderTab(title: 'Events'),
                  ],
                ),
              ),
            ),
            // Sticky Bottom Action Bar
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMD,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          size: 20,
                        ),
                        color: AppColors.textPrimary,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lossRed,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMD,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'SELL',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.profitGreen,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMD,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'BUY',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSectorColor(Sector sector) {
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
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.snapshot, required this.formatter});

  final MarketSnapshot? snapshot;
  final MarketFormatter formatter;

  @override
  Widget build(BuildContext context) {
    final high52 = snapshot?.fiftyTwoWeekHigh ?? 0;
    final low52 = snapshot?.fiftyTwoWeekLow ?? 0;
    final price = snapshot?.price ?? 0;
    final prevClose = snapshot?.previousClose ?? 0;
    final open = snapshot?.open ?? 0;
    final volume = snapshot?.volume ?? 0;
    final marketCap = snapshot?.marketCap ?? 0;

    // Mock Fundamentals
    final mktCapStr = formatter.formatLargeNumber(marketCap);
    final pe = (20 + (price % 50)).toStringAsFixed(2); // Random mock
    final pb = (1.2 + (price % 5)).toStringAsFixed(2);
    final roe = (12.5 + (price % 10)).toStringAsFixed(2);
    final divYield = (0.5 + (price % 2)).toStringAsFixed(2);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Performance Header
          Row(
            children: [
              Text('Performance', style: AppTypography.h5),
              const SizedBox(width: 8),
              Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: AppColors.textTertiary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Today's Low/High
          if (snapshot != null)
            _RangeSlider(
              label: "Today's",
              low: snapshot!.low,
              high: snapshot!.high,
              current: price,
              showCurrent: true,
            ),

          const SizedBox(height: AppSpacing.xl),

          // 52 Week Low/High
          if (snapshot != null)
            _RangeSlider(
              label: "52 Week",
              low: low52,
              high: high52,
              current: price,
              showCurrent: true,
            ),

          const SizedBox(height: AppSpacing.xl * 1.5),

          // Stats Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3.5, // Wide rows
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.sm,
            children: [
              _StatItem(label: 'Open', value: formatter.formatPrice(open)),
              _StatItem(
                label: 'Prev. Close',
                value: formatter.formatPrice(prevClose),
              ),
              _StatItem(
                label: 'Volume',
                value: formatter.formatLargeNumber(volume),
              ),
              _StatItem(
                label: 'Value',
                value: formatter.formatLargeNumber(volume * price),
              ),
              _StatItem(
                label: 'Upper Circuit',
                value: formatter.formatPrice(prevClose * 1.1),
              ), // Mock
              _StatItem(
                label: 'Lower Circuit',
                value: formatter.formatPrice(prevClose * 0.9),
              ), // Mock
            ],
          ),

          const SizedBox(height: AppSpacing.xl * 2),

          // Fundamentals Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Fundamentals', style: AppTypography.h5),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                ],
              ),
              Icon(
                Icons.keyboard_arrow_up_rounded,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Fundamentals Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3.5,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.sm,
            children: [
              _StatItem(label: 'Mkt Cap', value: '₹$mktCapStr'),
              _StatItem(label: 'ROE', value: '$roe%'),
              _StatItem(label: 'P/E Ratio(TTM)', value: pe),
              _StatItem(label: 'EPS(TTM)', value: '12.45'), // Mock
              _StatItem(label: 'P/B Ratio', value: pb),
              _StatItem(label: 'Div Yield', value: '$divYield%'),
              _StatItem(label: 'Industry P/E', value: '25.60'), // Mock
              _StatItem(label: 'Book Value', value: '212.08'), // Mock
              _StatItem(label: 'Debt to Equity', value: '0.08'), // Mock
              _StatItem(label: 'Face Value', value: '10'), // Mock
            ],
          ),

          const SizedBox(height: 100), // Space for bottom bar
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textTertiary,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _RangeSlider extends StatelessWidget {
  const _RangeSlider({
    required this.label,
    required this.low,
    required this.high,
    required this.current,
    this.showCurrent = false,
  });

  final String label;
  final double low;
  final double high;
  final double current;
  final bool showCurrent;

  @override
  Widget build(BuildContext context) {
    final range = high - low;
    final position = range == 0 ? 0.5 : (current - low) / range;
    final clampedPos = position.clamp(0.0, 1.0);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$label Low',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            Text(
              '$label High',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              low.toStringAsFixed(2),
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              high.toStringAsFixed(2),
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.textPrimary, // Simple black bar
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  if (showCurrent)
                    Positioned(
                      left: (width * clampedPos) - 6,
                      top: -4,
                      child: Container(
                        width: 0,
                        height: 0,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.textPrimary,
                              width: 6,
                            ), // Triangle up
                            left: BorderSide(
                              color: AppColors.transparent,
                              width: 6,
                            ),
                            right: BorderSide(
                              color: AppColors.transparent,
                              width: 6,
                            ),
                          ),
                        ),
                      ),
                      // Triangle or Arrow logic: "Today's High/Low" usually has triangle strictly at current price.
                      // The reference image has triangle pointing UP from below the line.
                      // My previous implementation had a circle. Reference has a triangle.
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final String title;
  const _PlaceholderTab({required this.title});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('$title Coming Soon', style: AppTypography.body));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.backgroundPrimary, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _TimeframeSelector extends StatefulWidget {
  const _TimeframeSelector();

  @override
  State<_TimeframeSelector> createState() => _TimeframeSelectorState();
}

class _TimeframeSelectorState extends State<_TimeframeSelector> {
  int _selectedIndex = 0;
  final _timeframes = ['1D', '1W', '1M', '1Y', '5Y', 'ALL'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _timeframes.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.textPrimary.withValues(alpha: 0.05)
                    : AppColors.transparent,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                // Reference style: Pills with light grey bg when selected? Or just text?
                // Image 1 shows dark pills.
                // I'll stick to my style but refine colors.
              ),
              child: Text(
                _timeframes[index],
                style: AppTypography.labelSmall.copyWith(
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
