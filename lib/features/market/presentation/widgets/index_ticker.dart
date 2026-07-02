import 'package:flutter/material.dart';

import '../../../../core/domain/instrument.dart';
import '../../../../core/domain/market_data.dart';
import '../../../../core/domain/market_regime.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../bloc/market_bloc.dart';
import '../pages/index_detail_screen.dart';

class IndexTicker extends StatefulWidget {
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
  State<IndexTicker> createState() => _IndexTickerState();
}

class _IndexTickerState extends State<IndexTicker> {
  bool _showPercentage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: SizedBox(
        height: 70,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: widget.padding,
          itemCount: widget.indices.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, i) => _buildIndexCard(context, widget.indices[i]),
        ),
      ),
    );
  }

  Widget _buildIndexCard(BuildContext context, Instrument index) {
    final snap = widget.snapshots[index.symbol];

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
            SizedBox(
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
            builder: (_) => IndexDetailScreen(
              instrument: index,
              snapshot: snap,
              bloc: widget.bloc,
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: AppSpacing.borderRadiusMD,
          border: Border.all(
            color: AppColors.cardBorder,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              index.name,
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _formatIndexValue(snap.price),
                      style: AppTypography.number.copyWith(
                        fontWeight: AppTypography.semiBold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPercentage = !_showPercentage;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        size: 16,
                        color: changeColor,
                      ),
                      Flexible(
                        child: Text(
                          _showPercentage
                              ? '${isUp ? '+' : '-'}${snap.changePercent.abs().toStringAsFixed(2)}%'
                              : '${isUp ? '+' : ''}${_formatIndexValue(snap.change)}',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: changeColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
