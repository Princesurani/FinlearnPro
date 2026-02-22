import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../bloc/market_bloc.dart';
import 'stock_detail_screen.dart';

class HoldingsTab extends StatelessWidget {
  const HoldingsTab({super.key, required this.onExplore, required this.state});

  final VoidCallback onExplore;
  final MarketState state;

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final initialHoldings = [
      _Holding(
        symbol: 'RELIANCE',
        name: 'Reliance Industries',
        qty: 10,
        avgPrice: 2100.0,
        ltp: 2100.0,
      ),
      _Holding(
        symbol: 'TCS',
        name: 'Tata Consultancy Services',
        qty: 5,
        avgPrice: 3200.0,
        ltp: 3200.0,
      ),
      _Holding(
        symbol: 'HDFCBANK',
        name: 'HDFC Bank',
        qty: 20,
        avgPrice: 1600.0,
        ltp: 1600.0,
      ),
      _Holding(
        symbol: 'INFY',
        name: 'Infosys',
        qty: 15,
        avgPrice: 1400.0,
        ltp: 1400.0,
      ),
    ];

    final holdings = initialHoldings.map((h) {
      final snap = state.snapshots[h.symbol];
      if (snap != null) {
        return h.copyWith(ltp: snap.price);
      }
      return h;
    }).toList();

    if (holdings.isEmpty) {
      return _buildEmptyState(context);
    }

    final totalCurrentValue = holdings.fold<double>(
      0,
      (sum, h) => sum + h.currentValue,
    );
    final totalInvested = holdings.fold<double>(
      0,
      (sum, h) => sum + h.investedValue,
    );
    final totalPnl = totalCurrentValue - totalInvested;
    final totalPnlPercent = (totalPnl / totalInvested) * 100;

    // Mock 1D Change (since we don't have prev close in holdings)
    final totalOneDayChange = totalCurrentValue * 0.0123;
    final totalOneDayChangePercent = 1.23;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: _buildSummaryCard(
            totalCurrentValue,
            totalOneDayChange,
            totalOneDayChangePercent,
            totalInvested,
            totalPnl,
            totalPnlPercent,
            holdings.length,
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
            itemCount: holdings.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              return _buildHoldingItem(context, holdings[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    double currentValue,
    double oneDayChange,
    double oneDayChangePercent,
    double invested,
    double pnl,
    double pnlPercent,
    int count,
  ) {
    final isProfit = pnl >= 0;
    final pnlColor = isProfit ? AppColors.profitGreen : AppColors.lossRed;

    final isDayProfit = oneDayChange >= 0;
    final dayColor = isDayProfit ? AppColors.profitGreen : AppColors.lossRed;

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
            '1D returns',
            '${isDayProfit ? '+' : ''}₹${oneDayChange.toStringAsFixed(2)}',
            '(${oneDayChangePercent.toStringAsFixed(2)}%)',
            dayColor,
          ),
          const SizedBox(height: AppSpacing.sm),
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

  Widget _buildHoldingItem(BuildContext context, _Holding h) {
    // Attempt to find real instrument and snapshot
    // Since mock data use symbols like 'RELIANCE', we need to match broadly or hope for exact match if real data exists.
    // In a real app, mock data wouldn't be here.
    // I'll try to find instrument.
    final instrument = state.tradableInstruments
        .where((i) => i.symbol.contains(h.symbol))
        .firstOrNull;
    final snapshot = instrument != null
        ? state.snapshots[instrument.symbol]
        : null;

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
                tag: 'box_${h.symbol}',
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      h.symbol[0],
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
                    tag: 'symbol_${h.symbol}',
                    child: Material(
                      color: AppColors.transparent,
                      child: Text(
                        h.symbol,
                        style: AppTypography.body.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    h.name,
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
                '₹${h.currentValue.toStringAsFixed(2)}',
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
                    '₹${h.ltp.toStringAsFixed(2)}',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '${h.pnl >= 0 ? '+' : ''}₹${h.pnl.toStringAsFixed(2)} (${h.pnlPercent.toStringAsFixed(2)}%)',
                style: AppTypography.labelSmall.copyWith(
                  color: h.pnl >= 0 ? AppColors.profitGreen : AppColors.lossRed,
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
              builder: (_) =>
                  StockDetailScreen(instrument: instrument, snapshot: snapshot),
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
              'No holdings found',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'You can start building your portfolio by exploring stocks.',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
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

class _Holding {
  _Holding({
    required this.symbol,
    required this.name,
    required this.qty,
    required this.avgPrice,
    required this.ltp,
  });

  final String symbol;
  final String name;
  final int qty;
  final double avgPrice;
  final double ltp;

  double get investedValue => qty * avgPrice;
  double get currentValue => qty * ltp;
  double get pnl => currentValue - investedValue;
  double get pnlPercent => (pnl / investedValue) * 100;

  _Holding copyWith({double? ltp}) {
    return _Holding(
      symbol: symbol,
      name: name,
      qty: qty,
      avgPrice: avgPrice,
      ltp: ltp ?? this.ltp,
    );
  }
}
