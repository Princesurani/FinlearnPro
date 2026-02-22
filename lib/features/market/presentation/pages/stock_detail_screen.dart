import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/domain/instrument.dart';
import '../../../../core/domain/market_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/market_formatters.dart';
import '../../../../core/services/api_market_service.dart';
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
    final effectiveBloc =
        bloc ??
        MarketBloc(firebaseUid: FirebaseAuth.instance.currentUser?.uid ?? '');
    final formatter = MarketFormatterFactory.forMarket(instrument.market);

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
        body: StreamBuilder<MarketState>(
          stream: effectiveBloc.stream,
          initialData: effectiveBloc.state,
          builder: (context, stateSnapshot) {
            final state = stateSnapshot.data!;
            final currentSnapshot =
                state.snapshots[instrument.symbol] ?? snapshot;
            final price = currentSnapshot?.price ?? 0;
            final change = currentSnapshot?.change ?? 0;
            final changePercent = currentSnapshot?.changePercent ?? 0;
            final isUp = change >= 0;
            final color = isUp ? AppColors.profitGreen : AppColors.lossRed;

            return Column(
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
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Hero(
                                          tag: 'symbol_${instrument.symbol}',
                                          child: Material(
                                            color: AppColors.transparent,
                                            child: Text(
                                              '${instrument.symbol} • ${instrument.market.name.toUpperCase()}',
                                              style: AppTypography.labelSmall
                                                  .copyWith(
                                                    color:
                                                        AppColors.textTertiary,
                                                    fontSize: 10,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          instrument.name,
                                          style: AppTypography.bodySmall
                                              .copyWith(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
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
                          child: _ChartSection(
                            instrument: instrument,
                            color: color,
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
                        _OverviewTab(
                          snapshot: currentSnapshot,
                          formatter: formatter,
                        ),
                        const _PlaceholderTab(title: 'Technicals'),
                        const _PlaceholderTab(title: 'F&O'),
                        const _PlaceholderTab(title: 'News'),
                        const _PlaceholderTab(title: 'Events'),
                      ],
                    ),
                  ),
                ),
                // Sticky Bottom Action Bar
                _BottomActionButtons(
                  instrument: instrument,
                  bloc: effectiveBloc,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BottomActionButtons extends StatelessWidget {
  const _BottomActionButtons({required this.instrument, required this.bloc});

  final Instrument instrument;
  final MarketBloc bloc;

  void _showOrderBottomSheet(BuildContext context, String side) {
    int quantity = 1;
    final isBuy = side == 'buy';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                top: AppSpacing.xl,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${isBuy ? "Buy" : "Sell"} ${instrument.symbol}',
                    style: AppTypography.h3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quantity', style: AppTypography.body),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (quantity > 1) setState(() => quantity--);
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                            color: AppColors.textPrimary,
                          ),
                          Text(
                            '$quantity',
                            style: AppTypography.h3.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () => setState(() => quantity++),
                            icon: const Icon(Icons.add_circle_outline),
                            color: AppColors.textPrimary,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        bloc.add(
                          PlaceOrder(
                            symbol: instrument.symbol,
                            side: side,
                            quantity: quantity,
                          ),
                        );
                        Navigator.pop(context); // Close sheet
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '$side order placed for $quantity shares of ${instrument.symbol}!',
                            ),
                            backgroundColor: isBuy
                                ? AppColors.profitGreen
                                : AppColors.lossRed,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isBuy
                            ? AppColors.profitGreen
                            : AppColors.lossRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        isBuy ? 'CONFIRM BUY' : 'CONFIRM SELL',
                        style: AppTypography.button.copyWith(
                          color: AppColors.surface,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              ),
              child: IconButton(
                icon: const Icon(Icons.calendar_month_outlined, size: 20),
                color: AppColors.textPrimary,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showOrderBottomSheet(context, 'sell'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lossRed,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
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
                onPressed: () => _showOrderBottomSheet(context, 'buy'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.profitGreen,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
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
    );
  }
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

class _TimeframeOption {
  final String label;
  final Timeframe resolution;
  const _TimeframeOption(this.label, this.resolution);
}

class _ChartSection extends StatefulWidget {
  const _ChartSection({required this.instrument, required this.color});
  final Instrument instrument;
  final Color color;

  @override
  State<_ChartSection> createState() => _ChartSectionState();
}

class _ChartSectionState extends State<_ChartSection> {
  late _TimeframeOption _selectedOption;

  static const _options = [
    _TimeframeOption('1D', Timeframe.fiveMinute),
    _TimeframeOption('1W', Timeframe.oneHour),
    _TimeframeOption('1M', Timeframe.fourHour),
    _TimeframeOption('1Y', Timeframe.oneDay),
    _TimeframeOption('5Y', Timeframe.oneWeek),
    _TimeframeOption('ALL', Timeframe.oneMonth),
  ];

  @override
  void initState() {
    super.initState();
    _selectedOption = _options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: _InteractiveChart(
            instrument: widget.instrument,
            color: widget.color,
            timeframe: _selectedOption.resolution,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: _TimeframeSelector(
            selected: _selectedOption,
            options: _options,
            onChanged: (opt) => setState(() => _selectedOption = opt),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}

class _TimeframeSelector extends StatelessWidget {
  const _TimeframeSelector({
    required this.selected,
    required this.options,
    required this.onChanged,
  });

  final _TimeframeOption selected;
  final List<_TimeframeOption> options;
  final ValueChanged<_TimeframeOption> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final option = options[index];
          final isSelected = selected.label == option.label;
          return GestureDetector(
            onTap: () => onChanged(option),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.textPrimary.withValues(alpha: 0.05)
                    : AppColors.transparent,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Text(
                option.label,
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

class _InteractiveChart extends StatefulWidget {
  final Instrument instrument;
  final Color color;
  final Timeframe timeframe;
  const _InteractiveChart({
    required this.instrument,
    required this.color,
    required this.timeframe,
  });

  @override
  State<_InteractiveChart> createState() => _InteractiveChartState();
}

class _InteractiveChartState extends State<_InteractiveChart> {
  List<Candle>? _candles;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void didUpdateWidget(_InteractiveChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.timeframe != widget.timeframe) {
      setState(() => _isLoading = true);
      _loadHistory();
    }
  }

  Future<void> _loadHistory() async {
    try {
      final candles = await ApiMarketService().getHistory(
        widget.instrument.symbol,
        widget.timeframe,
      );
      if (mounted) {
        setState(() {
          _candles = candles;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_candles == null || _candles!.isEmpty) {
      return Center(
        child: Text(
          'No chart data available',
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      );
    }

    final minPrice = _candles!
        .map((c) => c.low)
        .reduce((a, b) => a < b ? a : b);
    final maxPrice = _candles!
        .map((c) => c.high)
        .reduce((a, b) => a > b ? a : b);

    final spots = _candles!.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.close);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minY: minPrice * 0.999,
        maxY: maxPrice * 1.001,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: widget.color,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: widget.color.withValues(alpha: 0.1),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          getTouchedSpotIndicator: (barData, spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: widget.color,
                  strokeWidth: 1.5,
                  dashArray: [4, 4],
                ),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: widget.color,
                      strokeWidth: 2,
                      strokeColor: AppColors.backgroundPrimary,
                    );
                  },
                ),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => AppColors.surface,
            maxContentWidth: 250,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final candle = _candles![spot.spotIndex.toInt()];
                final timeStr = DateFormat(
                  "hh:mm a d MMM",
                ).format(candle.timestamp.toLocal()).toUpperCase();

                return LineTooltipItem(
                  '₹${spot.y.toStringAsFixed(2)}',
                  AppTypography.labelSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: ' | ',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    TextSpan(
                      text: timeStr,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
