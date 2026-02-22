import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/domain/market_data.dart';
import '../../bloc/market_bloc.dart';
import 'stock_detail_screen.dart';

class HoldingsTab extends StatelessWidget {
  const HoldingsTab({
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
    // Real data from BLoC — populated by the backend portfolio API
    final positions = state.portfolioPositions.values.toList();

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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: _buildSummaryCard(
            totalCurrentValue,
            totalInvested,
            totalPnl,
            totalPnlPercent,
            positions.length,
          ),
        ),
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
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPaddingHorizontal,
            ),
            itemCount: positions.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              return _buildHoldingItem(context, positions[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    double currentValue,
    double invested,
    double pnl,
    double pnlPercent,
    int count,
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
                'HOLDINGS ($count)',
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
                    color: AppColors.primaryPurple,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.analytics_outlined,
                    size: 20,
                    color: AppColors.primaryPurple,
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
                '₹${currentValue.toStringAsFixed(2)}',
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
            '${isProfit ? '+' : ''}₹${pnl.toStringAsFixed(2)}',
            '(${pnlPercent.toStringAsFixed(2)}%)',
            pnlColor,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSummaryRow(
            'Invested',
            '₹${invested.toStringAsFixed(2)}',
            '',
            AppColors.textPrimary,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSummaryRow(
            'Available Balance',
            '₹${state.portfolioBalance.toStringAsFixed(2)}',
            '',
            AppColors.textSecondary,
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
                    color: AppColors.primaryPurple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      pos.symbol[0],
                      style: const TextStyle(
                        color: AppColors.primaryPurple,
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
                    'Qty: ${pos.quantity} · Avg ₹${pos.averageCost.toStringAsFixed(2)}',
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
                '₹${currentValue.toStringAsFixed(2)}',
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
                    '₹${livePrice.toStringAsFixed(2)}',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '${isProfit ? '+' : ''}₹${pnl.toStringAsFixed(2)} (${pnlPercent.toStringAsFixed(2)}%)',
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
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
              'Wallet: ₹${state.portfolioBalance > 0 ? state.portfolioBalance.toStringAsFixed(2) : "Loading..."}',
              style: AppTypography.body.copyWith(
                color: AppColors.profitGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton(
              onPressed: onExplore,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
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
    );
  }
}
