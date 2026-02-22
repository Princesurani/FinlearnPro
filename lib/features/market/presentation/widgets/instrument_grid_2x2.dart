import 'package:flutter/material.dart';

import '../../../../core/domain/instrument.dart';
import '../../../../core/domain/market_data.dart';
import '../../../../core/domain/market_regime.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/market_formatters.dart';

import '../pages/stock_detail_screen.dart';
import '../../bloc/market_bloc.dart';

class InstrumentGrid2x2 extends StatelessWidget {
  const InstrumentGrid2x2({
    super.key,
    required this.instruments,
    required this.market,
    required this.snapshots,
    this.onSeeMore,
    this.showSeeMore = true,
    this.bloc,
  });

  final List<Instrument> instruments;
  final MarketRegime market;
  final Map<String, MarketSnapshot> snapshots;
  final VoidCallback? onSeeMore;
  final bool showSeeMore;
  final MarketBloc? bloc;

  @override
  Widget build(BuildContext context) {
    final maxVisible = showSeeMore && instruments.length > 3 ? 3 : 4;
    final visible = instruments.take(maxVisible).toList();
    final hasMore = showSeeMore && instruments.length > 3;
    final cellCount = hasMore ? 4 : visible.length;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 1.25,
      ),
      itemCount: cellCount,
      itemBuilder: (context, index) {
        if (hasMore && index == 3) {
          return _SeeMoreCell(onTap: onSeeMore);
        }
        if (index >= visible.length) return const SizedBox.shrink();

        final instrument = visible[index];
        final snapshot = snapshots[instrument.symbol];
        return _StockCell(
          instrument: instrument,
          snapshot: snapshot,
          market: market,
          bloc: bloc,
        );
      },
    );
  }
}

class _StockCell extends StatelessWidget {
  const _StockCell({
    required this.instrument,
    required this.snapshot,
    required this.market,
    this.bloc,
  });

  final Instrument instrument;
  final MarketSnapshot? snapshot;
  final MarketRegime market;
  final MarketBloc? bloc;

  @override
  Widget build(BuildContext context) {
    final formatter = MarketFormatterFactory.forMarket(market);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => StockDetailScreen(
              instrument: instrument,
              snapshot: snapshot,
              bloc: bloc,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMD,
          border: Border.all(color: AppColors.border, width: 0.5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _StockLogo(
                  symbol: instrument.symbol,
                  sector: instrument.sector,
                ),
                AppSpacing.gapHXS,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displaySymbol(instrument.symbol),
                        style: AppTypography.label.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: AppTypography.semiBold,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        instrument.exchange ?? instrument.name,
                        style: AppTypography.bodyXS.copyWith(
                          color: AppColors.textTertiary,
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),

            if (snapshot != null) ...[
              Text(
                formatter.formatPrice(snapshot!.price),
                style: AppTypography.number.copyWith(
                  fontWeight: AppTypography.semiBold,
                ),
              ),
              const SizedBox(height: 2),
              _ChangeRow(
                change: snapshot!.change,
                changePercent: snapshot!.changePercent,
              ),
            ] else
              const _LoadingIndicator(),
          ],
        ),
      ),
    );
  }

  String _displaySymbol(String symbol) {
    final slash = symbol.indexOf('/');
    return slash > 0 ? symbol.substring(0, slash) : symbol;
  }
}

class _StockLogo extends StatelessWidget {
  const _StockLogo({required this.symbol, required this.sector});

  final String symbol;
  final Sector sector;

  @override
  Widget build(BuildContext context) {
    final color = _sectorColor(sector);
    final initials = _getInitials(symbol);

    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppSpacing.borderRadiusSM,
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  String _getInitials(String sym) {
    final clean = sym.replaceAll('/', '').replaceAll('.', '');
    return clean.substring(0, clean.length >= 2 ? 2 : 1).toUpperCase();
  }

  static Color _sectorColor(Sector sector) {
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

class _ChangeRow extends StatelessWidget {
  const _ChangeRow({required this.change, required this.changePercent});

  final double change;
  final double changePercent;

  @override
  Widget build(BuildContext context) {
    final isUp = change >= 0;
    final color = isUp ? AppColors.profitGreen : AppColors.lossRed;
    final sign = isUp ? '+' : '';
    final arrow = isUp
        ? Icons.arrow_drop_up_rounded
        : Icons.arrow_drop_down_rounded;

    return Row(
      children: [
        Icon(arrow, size: 18, color: color),
        Flexible(
          child: Text(
            '$sign${change.toStringAsFixed(2)} '
            '(${changePercent.abs().toStringAsFixed(2)}%)',
            style: AppTypography.numberSmall.copyWith(
              color: color,
              fontSize: 11,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _SeeMoreCell extends StatelessWidget {
  const _SeeMoreCell({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: AppSpacing.borderRadiusMD,
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.grid_view_rounded,
                  size: 22,
                  color: AppColors.primaryPurple,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'See more',
                style: AppTypography.label.copyWith(
                  color: AppColors.primaryPurple,
                  fontWeight: AppTypography.medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16,
      width: 16,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        color: AppColors.textTertiary,
      ),
    );
  }
}
