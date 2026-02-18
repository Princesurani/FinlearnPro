import 'package:flutter/material.dart';
import '../../../../core/domain/instrument.dart';
import '../../../../core/domain/market_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/market_formatters.dart';
import '../../bloc/market_bloc.dart';
import 'stock_detail_screen.dart';

class WatchlistTab extends StatelessWidget {
  const WatchlistTab({super.key, required this.state, required this.onExplore});

  final MarketState state;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    if (state.watchlist.isEmpty) {
      return _buildEmptyState(context);
    }

    final watchlistInstruments = state.tradableInstruments
        .where((i) => state.watchlist.contains(i.symbol))
        .toList();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingHorizontal,
        vertical: AppSpacing.lg,
      ),
      itemCount: watchlistInstruments.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final instrument = watchlistInstruments[index];
        final snapshot = state.snapshots[instrument.symbol];
        return _WatchlistTile(instrument: instrument, snapshot: snapshot);
      },
    );
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
                Icons.bookmark_border_rounded,
                size: 48,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Your watchlist is empty',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Keep track of your favorite stocks by adding them to your watchlist.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
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
              child: const Text('Explore Stocks'),
            ),
            const SizedBox(height: 100), // Bottom padding for tabs
          ],
        ),
      ),
    );
  }
}

class _WatchlistTile extends StatelessWidget {
  const _WatchlistTile({required this.instrument, required this.snapshot});

  final Instrument instrument;
  final MarketSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    final formatter = MarketFormatterFactory.forMarket(instrument.market);
    final isUp = (snapshot?.change ?? 0) >= 0;
    final changeColor = isUp ? AppColors.profitGreen : AppColors.lossRed;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                StockDetailScreen(instrument: instrument, snapshot: snapshot),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMD,
          border: Border.all(color: AppColors.border, width: 0.5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x06000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildLogo(context),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    instrument.symbol,
                    style: AppTypography.label.copyWith(
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    instrument.name,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (snapshot != null) ...[
                  Text(
                    formatter.formatPrice(snapshot!.price),
                    style: AppTypography.label.copyWith(
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: changeColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          size: 14,
                          color: changeColor,
                        ),
                        Text(
                          '${snapshot!.change.abs().toStringAsFixed(2)} (${snapshot!.changePercent.abs().toStringAsFixed(2)}%)',
                          style: AppTypography.labelSmall.copyWith(
                            color: changeColor,
                            fontWeight: AppTypography.semiBold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else
                  Text('--', style: AppTypography.label),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    // Generate a consistent color based on symbol
    final color = _getSectorColor(instrument.sector);

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          instrument.symbol.substring(0, 1),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
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
