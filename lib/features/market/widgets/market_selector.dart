import 'package:flutter/material.dart';

import '../../../core/domain/market_regime.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class MarketSelector extends StatelessWidget {
  const MarketSelector({
    super.key,
    required this.activeMarket,
    required this.onMarketChanged,
  });

  final MarketRegime activeMarket;
  final ValueChanged<MarketRegime> onMarketChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMarketSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10, // Reduced from 12 (AppSpacing.sm)
          vertical: 6, // Reduced from 8 (AppSpacing.xs)
        ),
        decoration: BoxDecoration(
          color: Colors.white, // Changed from gray for better visibility
          borderRadius: AppSpacing.borderRadiusSM,
          border: Border.all(
            color: AppColors.border.withValues(alpha: 0.8), // Darker border
            width: 1.5, // Increased from 0.5 for better visibility
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              activeMarket.flag,
              style: const TextStyle(fontSize: 16),
            ), // Reduced from 18
            const SizedBox(width: 4), // Reduced gap
            Text(
              activeMarket.shortName,
              style: AppTypography.label.copyWith(
                color: AppColors.textPrimary, // Darker for better contrast
                fontWeight: AppTypography.bold, // Bolder for visibility
                fontSize: 12, // Explicit smaller size
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18, // Reduced from 20
              color: AppColors.textPrimary, // Darker for visibility
            ),
          ],
        ),
      ),
    );
  }

  void _showMarketSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _MarketSelectorSheet(
        activeMarket: activeMarket,
        onMarketChanged: (market) {
          onMarketChanged(market);
          Navigator.pop(ctx);
        },
      ),
    );
  }
}

class _MarketSelectorSheet extends StatelessWidget {
  const _MarketSelectorSheet({
    required this.activeMarket,
    required this.onMarketChanged,
  });

  final MarketRegime activeMarket;
  final ValueChanged<MarketRegime> onMarketChanged;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusTopXL,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: AppSpacing.sm),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: AppSpacing.borderRadiusFull,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPaddingHorizontal,
              vertical: AppSpacing.lg,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.public_rounded,
                  size: 22,
                  color: AppColors.primaryPurple,
                ),
                AppSpacing.gapHSM,
                Text('Select Market', style: AppTypography.h5),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.borderLight),

          ...MarketRegime.values.map(_buildOption),

          SizedBox(height: bottomPadding + AppSpacing.md),
        ],
      ),
    );
  }

  Widget _buildOption(MarketRegime market) {
    final isActive = market == activeMarket;

    return Material(
      color: isActive
          ? AppColors.primaryPurple.withAlpha(15)
          : Colors.transparent,
      child: InkWell(
        onTap: () => onMarketChanged(market),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPaddingHorizontal,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            border: isActive
                ? const Border(
                    left: BorderSide(color: AppColors.primaryPurple, width: 3),
                  )
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.backgroundTertiary,
                  borderRadius: AppSpacing.borderRadiusMD,
                ),
                child: Center(
                  child: Text(
                    market.flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              AppSpacing.gapHMD,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      market.displayName,
                      style: AppTypography.bodyMedium.copyWith(
                        color: isActive
                            ? AppColors.primaryPurple
                            : AppColors.textPrimary,
                        fontWeight: AppTypography.semiBold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      market.primaryIndex,
                      style: AppTypography.bodyXS.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),

              if (isActive)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primaryPurple,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
