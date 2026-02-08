import 'package:flutter/material.dart';

import '../../../core/domain/instrument.dart';
import '../../../core/domain/market_data.dart';
import '../../../core/domain/market_regime.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/market_formatters.dart';

class IndexTicker extends StatelessWidget {
  const IndexTicker({
    super.key,
    required this.market,
    required this.snapshots,
    required this.indices,
  });

  final MarketRegime market;

  final Map<String, MarketSnapshot> snapshots;

  final List<Instrument> indices;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.borderLight, width: 1),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPaddingHorizontal,
        ),
        itemCount: indices.length + 1,
        separatorBuilder: (_, _) => Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: VerticalDivider(
            width: 1,
            thickness: 1,
            color: AppColors.border.withAlpha(80),
          ),
        ),
        itemBuilder: (context, i) {
          if (i == indices.length) return _buildAllIndicesLink();
          return _buildIndexChip(indices[i]);
        },
      ),
    );
  }

  Widget _buildIndexChip(Instrument index) {
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
    final changeColor = isUp ? AppColors.profitGreen : AppColors.lossRed;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            index.name,
            style: AppTypography.overline.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 0,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 1),

          Text(
            _formatIndexValue(snap.price),
            style: AppTypography.number.copyWith(
              fontSize: 15,
              fontWeight: AppTypography.semiBold,
              color: AppColors.textPrimary,
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isUp
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                size: 16,
                color: changeColor,
              ),
              Text(
                '${isUp ? '+' : ''}${_formatIndexValue(snap.change)} '
                '(${snap.changePercent.abs().toStringAsFixed(2)}%)',
                style: AppTypography.numberSmall.copyWith(
                  color: changeColor,
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAllIndicesLink() {
    return GestureDetector(
      onTap: () {}, // TODO: all the nevigation of All Indices screen will go here.
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'All Indices',
                style: AppTypography.label.copyWith(
                  color: AppColors.primaryPurple,
                  fontWeight: AppTypography.medium,
                ),
              ),
              const SizedBox(width: 2),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12,
                color: AppColors.primaryPurple,
              ),
            ],
          ),
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
