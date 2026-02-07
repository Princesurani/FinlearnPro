
import 'package:flutter/material.dart';

import '../../../core/domain/instrument.dart';
import '../../../core/domain/market_data.dart';
import '../../../core/domain/market_regime.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class SectorTrendingCard extends StatelessWidget {
  const SectorTrendingCard({
    super.key,
    required this.market,
    required this.snapshots,
    required this.instruments,
  });

  final MarketRegime market;
  final Map<String, MarketSnapshot> snapshots;
  final List<Instrument> instruments;

  @override
  Widget build(BuildContext context) {
    final performances = _computeSectorPerformance();

    if (performances.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        ...performances.take(5).map(_buildRow),
        const SizedBox(height: AppSpacing.sm),

        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'See all sectors',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primaryPurple,
                  fontWeight: AppTypography.medium,
                ),
              ),
              const SizedBox(width: 2),
              const Icon(
                Icons.chevron_right_rounded,
                size: 16,
                color: AppColors.primaryPurple,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(_SectorPerf perf) {
    final isUp = perf.change >= 0;
    final color = isUp ? AppColors.profitGreen : AppColors.lossRed;

    final progress = (perf.change.abs() / 10.0).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  perf.name,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: AppTypography.medium,
                  ),
                ),
              ),
              Text(
                '${isUp ? '+' : ''}${perf.change.toStringAsFixed(2)}%',
                style: AppTypography.numberSmall.copyWith(
                  color: color,
                  fontWeight: AppTypography.semiBold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),

          ClipRRect(
            borderRadius: AppSpacing.borderRadiusFull,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.backgroundTertiary,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  List<_SectorPerf> _computeSectorPerformance() {
    final totals = <Sector, double>{};
    final counts = <Sector, int>{};

    for (final inst in instruments) {
      if (inst.type != InstrumentType.stock) continue;
      if (inst.sector == Sector.unknown) continue;

      final snap = snapshots[inst.symbol];
      if (snap == null) continue;

      totals[inst.sector] = (totals[inst.sector] ?? 0) + snap.changePercent;
      counts[inst.sector] = (counts[inst.sector] ?? 0) + 1;
    }

    final perfs = <_SectorPerf>[];
    for (final entry in totals.entries) {
      final avg = entry.value / (counts[entry.key] ?? 1);
      perfs.add(_SectorPerf(
        name: _sectorDisplayName(entry.key),
        change: avg,
      ));
    }

    perfs.sort((a, b) => b.change.abs().compareTo(a.change.abs()));
    return perfs;
  }

  String _sectorDisplayName(Sector s) {
    switch (s) {
      case Sector.technology:
        return 'Technology';
      case Sector.financialServices:
        return 'Financial Services';
      case Sector.healthcare:
        return 'Healthcare';
      case Sector.consumerCyclical:
        return 'Consumer Cyclical';
      case Sector.consumerDefensive:
        return 'Consumer Defensive';
      case Sector.industrials:
        return 'Industrials';
      case Sector.energy:
        return 'Energy';
      case Sector.utilities:
        return 'Utilities';
      case Sector.realEstate:
        return 'Real Estate';
      case Sector.basicMaterials:
        return 'Basic Materials';
      case Sector.communicationServices:
        return 'Communication';
      case Sector.unknown:
        return 'Other';
    }
  }
}

class _SectorPerf {
  const _SectorPerf({required this.name, required this.change});
  final String name;
  final double change;
}
