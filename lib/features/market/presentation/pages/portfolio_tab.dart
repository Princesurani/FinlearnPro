import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/domain/market_data.dart';
import '../../bloc/market_bloc.dart';
import 'stock_detail_screen.dart';
import '../widgets/ai_review_sheet.dart';

class PortfolioTab extends StatelessWidget {
  const PortfolioTab({
    super.key,
    required this.onExplore,
    required this.state,
    required this.bloc,
  });

  final VoidCallback onExplore;
  final MarketState state;
  final MarketBloc bloc;

  @override
  Widget build(BuildContext context) {
    // Filter positions to only those in the currently active market
    final positions = state.portfolioPositions.values.where((pos) {
      return state.instruments.any((i) => i.symbol == pos.symbol);
    }).toList();

    if (positions.isEmpty) {
      return _buildEmptyState(context);
    }

    // Compute portfolio totals using live prices where available
    double totalCurrentValue = 0;
    double totalInvested = 0;

    for (final pos in positions) {
      final livePrice = state.snapshots[pos.symbol]?.price ?? pos.averageCost;
      totalCurrentValue += livePrice * pos.quantity;
      totalInvested += pos.averageCost * pos.quantity;
    }

    final totalPnl = totalCurrentValue - totalInvested;
    final totalPnlPercent = totalInvested == 0
        ? 0.0
        : (totalPnl / totalInvested) * 100;

    return RefreshIndicator(
      onRefresh: () async {
        bloc.add(RefreshMarketData());
        bloc.add(LoadPortfolio());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      color: AppColors.primary,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 120), // Padding for floating navbar
        children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: _buildSummaryCard(
            totalCurrentValue,
            totalInvested,
            totalPnl,
            totalPnlPercent,
            positions.length,
            context,
          ),
        ),
        _SectorAllocationChart(positions: positions, state: state),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.sort_rounded,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Sort',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.code_rounded,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Current (Invested)',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPaddingHorizontal,
          ),
          itemCount: positions.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            return _buildHoldingItem(context, positions[index]);
          },
        ),
      ],
    ),
    );
  }

  Widget _buildSummaryCard(
    double currentValue,
    double invested,
    double pnl,
    double pnlPercent,
    int count,
    BuildContext context,
  ) {
    final isProfit = pnl >= 0;
    final pnlColor = isProfit ? AppColors.profitGreen : AppColors.lossRed;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLG,
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PORTFOLIO ($count)',
                style: AppTypography.labelSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: AppColors.textSecondary,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.visibility_outlined,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.analytics_outlined,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.more_vert_rounded,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Text(
                '${state.activeMarket.currencySymbol}${currentValue.toStringAsFixed(2)}',
                style: AppTypography.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.md),
          _buildSummaryRow(
            'Total returns',
            '${isProfit ? '+' : ''}${state.activeMarket.currencySymbol}${pnl.toStringAsFixed(2)}',
            '(${pnlPercent.toStringAsFixed(2)}%)',
            pnlColor,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSummaryRow(
            'Invested',
            '${state.activeMarket.currencySymbol}${invested.toStringAsFixed(2)}',
            '',
            AppColors.textPrimary,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSummaryRow(
            'Available Balance',
            '${state.activeMarket.currencySymbol}${state.portfolioBalance.toStringAsFixed(2)}',
            '',
            AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.lg),
          InkWell(
            onTap: () => AiReviewSheet.show(context),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    AppColors.primary.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.auto_awesome, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Portfolio Review',
                          style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        ),
                        Text(
                          'Get deep insights & risk analysis',
                          style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value,
    String suffix,
    Color valueColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: AppTypography.bodySmall.copyWith(
                color: valueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (suffix.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                suffix,
                style: AppTypography.bodySmall.copyWith(color: valueColor),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildHoldingItem(BuildContext context, PortfolioPosition pos) {
    final liveSnap = state.snapshots[pos.symbol];
    final livePrice = liveSnap?.price ?? pos.averageCost;
    final currentValue = livePrice * pos.quantity;
    final investedValue = pos.averageCost * pos.quantity;
    final pnl = currentValue - investedValue;
    final pnlPercent = investedValue == 0 ? 0.0 : (pnl / investedValue) * 100;
    final isProfit = pnl >= 0;

    final instrument = state.tradableInstruments
        .where((i) => i.symbol == pos.symbol)
        .firstOrNull;

    Widget content = Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMD,
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Hero(
                tag: 'box_${pos.symbol}',
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      pos.symbol[0],
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'symbol_${pos.symbol}',
                    child: Material(
                      color: AppColors.transparent,
                      child: Text(
                        pos.symbol,
                        style: AppTypography.body.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Qty: ${pos.quantity} · Avg ${state.activeMarket.currencySymbol}${pos.averageCost.toStringAsFixed(2)}',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${state.activeMarket.currencySymbol}${currentValue.toStringAsFixed(2)}',
                style: AppTypography.body.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'LTP',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${state.activeMarket.currencySymbol}${livePrice.toStringAsFixed(2)}',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '${isProfit ? '+' : ''}${state.activeMarket.currencySymbol}${pnl.toStringAsFixed(2)} (${pnlPercent.toStringAsFixed(2)}%)',
                style: AppTypography.labelSmall.copyWith(
                  color: isProfit ? AppColors.profitGreen : AppColors.lossRed,
                  fontWeight: AppTypography.semiBold,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (instrument != null) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => StockDetailScreen(
                instrument: instrument,
                snapshot: liveSnap,
                bloc: bloc,
              ),
            ),
          );
        },
        child: content,
      );
    }
    return content;
  }

  Widget _buildEmptyState(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        bloc.add(RefreshMarketData());
        bloc.add(LoadPortfolio());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      color: AppColors.primary,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(AppSpacing.xl),
          alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.pie_chart_outline_rounded,
                size: 48,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No holdings yet',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Buy your first stock to start building your portfolio.',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Wallet: ${state.activeMarket.currencySymbol}${state.portfolioBalance > 0 ? state.portfolioBalance.toStringAsFixed(2) : "Loading..."}',
              style: AppTypography.body.copyWith(
                color: AppColors.profitGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton(
              onPressed: onExplore,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryButton,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.md,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                elevation: 0,
              ),
              child: const Text('Start Investing'),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    ),
    );
  }
}

class _SectorAllocationChart extends StatefulWidget {
  final List<PortfolioPosition> positions;
  final MarketState state;

  const _SectorAllocationChart({
    required this.positions,
    required this.state,
  });

  @override
  State<_SectorAllocationChart> createState() => _SectorAllocationChartState();
}

class _SectorAllocationChartState extends State<_SectorAllocationChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final sectorInvested = <String, double>{};
    double totalInvested = 0;

    for (final pos in widget.positions) {
      final instrument = widget.state.tradableInstruments
          .where((i) => i.symbol == pos.symbol)
          .firstOrNull;
      
      // Provide a clean sector name
      String sector = instrument?.sector.name ?? 'Unknown';
      // Format camelCase to Title Case if needed (e.g., financialServices -> Financial Services)
      if (sector.contains(RegExp(r'[A-Z]'))) {
        sector = sector.replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(1)}').trim();
        sector = sector[0].toUpperCase() + sector.substring(1);
      } else {
        sector = sector[0].toUpperCase() + sector.substring(1);
      }

      final invested = pos.averageCost * pos.quantity;
      sectorInvested[sector] = (sectorInvested[sector] ?? 0) + invested;
      totalInvested += invested;
    }

    if (totalInvested == 0) return const SizedBox.shrink();

    final colors = [
      AppColors.electricBlue,
      AppColors.lavender,
      AppColors.oceanTeal,
      AppColors.mintGreen,
      AppColors.goldenYellow,
      AppColors.rose,
      AppColors.indigo,
    ];

    final entries = sectorInvested.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)); // Sort largest first

    final sections = <PieChartSectionData>[];
    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 14.0 : 10.0;
      final radius = isTouched ? 45.0 : 35.0;
      final percentage = (entry.value / totalInvested) * 100;

      sections.add(
        PieChartSectionData(
          color: colors[i % colors.length],
          value: entry.value,
          title: '${percentage.toStringAsFixed(0)}%',
          radius: radius,
          titleStyle: AppTypography.labelSmall.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLG,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sector Allocation (Invested)',
            style: AppTypography.labelSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 140,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex =
                                pieTouchResponse.touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      centerSpaceRadius: 25,
                      sections: sections,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: entries.asMap().entries.map((e) {
                      final idx = e.key;
                      final name = e.value.key;
                      final val = e.value.value;
                      final pct = (val / totalInvested) * 100;
                      final isTouched = idx == touchedIndex;
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            Container(
                              width: isTouched ? 10 : 8,
                              height: isTouched ? 10 : 8,
                              decoration: BoxDecoration(
                                color: colors[idx % colors.length],
                                shape: BoxShape.circle,
                                border: isTouched ? Border.all(color: AppColors.white, width: 1) : null,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                name,
                                style: AppTypography.labelSmall.copyWith(
                                  fontSize: isTouched ? 11 : 10,
                                  color: isTouched ? AppColors.textPrimary : AppColors.textSecondary,
                                  fontWeight: isTouched ? FontWeight.bold : FontWeight.normal,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${pct.toStringAsFixed(1)}%',
                              style: AppTypography.labelSmall.copyWith(
                                fontSize: isTouched ? 11 : 10,
                                color: isTouched ? AppColors.textPrimary : AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

