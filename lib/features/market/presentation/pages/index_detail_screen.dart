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
import '../widgets/stock_detail_tabs/overview_tab.dart';
import '../widgets/stock_detail_tabs/technicals_tab.dart';
import '../widgets/stock_detail_tabs/fno_tab.dart';
import '../widgets/stock_detail_tabs/news_tab.dart';

class IndexDetailScreen extends StatelessWidget {
  const IndexDetailScreen({
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
      length: 4,
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
          actions: [const SizedBox(width: AppSpacing.sm)],
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
                                      formatter
                                          .formatPrice(price)
                                          .replaceAll(RegExp(r'[\$₹£]'), ''),
                                      style: AppTypography.h3.copyWith(
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
                              tabAlignment: TabAlignment.start,
                              padding: EdgeInsets.zero,
                              labelColor: AppColors.textPrimary,
                              unselectedLabelColor: AppColors.textSecondary,
                              labelStyle: AppTypography.label.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              unselectedLabelStyle: AppTypography.label,
                              indicatorColor: AppColors.primary,
                              indicatorWeight: 3,
                              indicatorSize: TabBarIndicatorSize.label,
                              tabs: const [
                                Tab(text: 'Overview'),
                                Tab(text: 'Technicals'),
                                Tab(text: 'F&O'),
                                Tab(text: 'News'),
                              ],
                            ),
                          ),
                          pinned: true,
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        OverviewTab(
                          snapshot: currentSnapshot,
                          formatter: formatter,
                          currencySymbol: instrument.currencySymbol,
                        ),
                        TechnicalsTab(instrument: instrument),
                        FnoTab(instrument: instrument),
                        NewsTab(instrument: instrument),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
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
      return AppColors.primary;
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
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            maxContentWidth: 250,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final candle = _candles![spot.spotIndex.toInt()];
                final timeStr = DateFormat(
                  "hh:mm a d MMM",
                ).format(candle.timestamp.toLocal()).toUpperCase();

                return LineTooltipItem(
                  spot.y.toStringAsFixed(2),
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
