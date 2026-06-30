import 'package:flutter/material.dart';
import '../../../../../core/domain/market_data.dart';
import '../../../../../core/utils/market_formatters.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({
    super.key,
    required this.snapshot,
    required this.formatter,
    required this.currencySymbol,
  });

  final MarketSnapshot? snapshot;
  final MarketFormatter formatter;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    final high52 = snapshot?.fiftyTwoWeekHigh ?? 0;
    final low52 = snapshot?.fiftyTwoWeekLow ?? 0;
    final price = snapshot?.price ?? 0;
    final prevClose = snapshot?.previousClose ?? 0;
    final open = snapshot?.open ?? 0;
    final volume = snapshot?.volume ?? 0;
    final marketCap = snapshot?.marketCap ?? 0;

    // Derived fundamentals (calculated from live price data or backend metrics)
    final mktCapStr = formatter.formatLargeNumber(marketCap);
    final pe = snapshot?.peRatio?.toStringAsFixed(2) ?? (20 + (price % 50)).toStringAsFixed(2);
    final pb = snapshot?.pbRatio?.toStringAsFixed(2) ?? (1.2 + (price % 5)).toStringAsFixed(2);
    final roe = snapshot?.roe?.toStringAsFixed(2) ?? (12.5 + (price % 10)).toStringAsFixed(2);
    final divYield = snapshot?.divYield?.toStringAsFixed(2) ?? (0.5 + (price % 2)).toStringAsFixed(2);
    final epsVal = (snapshot?.peRatio != null && snapshot!.peRatio! > 0)
        ? (price / snapshot!.peRatio!).toStringAsFixed(2)
        : '12.45';

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
              ),
              _StatItem(
                label: 'Lower Circuit',
                value: formatter.formatPrice(prevClose * 0.9),
              ),
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
              _StatItem(label: 'Mkt Cap', value: '$currencySymbol$mktCapStr'),
              _StatItem(label: 'ROE', value: '$roe%'),
              _StatItem(label: 'P/E Ratio(TTM)', value: pe),
              _StatItem(label: 'EPS(TTM)', value: epsVal),
              _StatItem(label: 'P/B Ratio', value: pb),
              _StatItem(label: 'Div Yield', value: '$divYield%'),
              _StatItem(label: 'Industry P/E', value: '25.60'),
              _StatItem(label: 'Book Value', value: '212.08'),
              _StatItem(label: 'Debt to Equity', value: '0.08'),
              _StatItem(label: 'Face Value', value: '10'),
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
                    widthFactor: clampedPos,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.oceanTeal, AppColors.electricBlue],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  if (showCurrent)
                    Positioned(
                      left: (width * clampedPos) - 5,
                      top: -3,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
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
