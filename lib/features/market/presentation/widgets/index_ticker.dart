import 'package:flutter/material.dart';

import '../../../../core/domain/instrument.dart';
import '../../../../core/domain/market_data.dart';
import '../../../../core/domain/market_regime.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/market_formatters.dart';
import '../../bloc/market_bloc.dart';
import '../pages/stock_detail_screen.dart';

class IndexTicker extends StatelessWidget {
  const IndexTicker({
    super.key,
    required this.market,
    required this.snapshots,
    required this.indices,
    required this.bloc,
    this.padding = EdgeInsets.zero,
  });

  final MarketRegime market;

  final Map<String, MarketSnapshot> snapshots;

  final List<Instrument> indices;
  final MarketBloc bloc;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: padding,
          itemCount: indices.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, i) => _buildIndexCard(context, indices[i]),
        ),
      ),
    );
  }

  Widget _buildIndexCard(BuildContext context, Instrument index) {
    final snap = snapshots[index.symbol];

    if (snap == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              index.name,
              style: AppTypography.overline.copyWith(
                color: AppColors.textTertiary,
                letterSpacing: 0,
              ),
            ),
            AppSpacing.gapXXS,
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      );
    }

    final isUp = snap.change >= 0;
    final changeColor = isUp ? AppColors.success : AppColors.error;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => StockDetailScreen(
              instrument: index,
              snapshot: snap,
              bloc: bloc,
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderLight, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              index.name,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              _formatIndexValue(snap.price),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  size: 18,
                  color: changeColor,
                ),
                Flexible(
                  child: Text(
                    '${isUp ? '+' : ''}${_formatIndexValue(snap.change)} (${snap.changePercent.abs().toStringAsFixed(2)}%)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: changeColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatIndexValue(double value) {
    final isNeg = value < 0;
    final abs = value.abs();
    final fixed = abs.toStringAsFixed(2);
    final parts = fixed.split('.');
    final intPart = parts[0];
    final decPart = parts[1];

    if (market == MarketRegime.crypto && abs >= 1e9) {
      final formatter = MarketFormatterFactory.forMarket(market);
      return '${isNeg ? '-' : ''}${formatter.formatLargeNumber(abs)}';
    }

    final buffer = StringBuffer();
    for (var i = 0; i < intPart.length; i++) {
      if (i > 0 && (intPart.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(intPart[i]);
    }

    return '${isNeg ? '-' : ''}$buffer.$decPart';
  }
}
