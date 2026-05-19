import 'package:flutter/material.dart';
import '../../../../../core/domain/instrument.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

class TechnicalsTab extends StatelessWidget {
  final Instrument instrument;

  const TechnicalsTab({super.key, required this.instrument});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryGauge(),
          const SizedBox(height: AppSpacing.xl),
          _buildMovingAverages(),
          const SizedBox(height: AppSpacing.xl),
          _buildOscillators(),
          const SizedBox(height: AppSpacing.xl),
          _buildSupportResistance(),
          const SizedBox(height: 100), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildSummaryGauge() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Summary', style: AppTypography.h5),
              const Icon(Icons.show_chart_rounded, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          // Mock Gauge
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 120,
                width: 240,
                child: CustomPaint(
                  painter: _GaugePainter(),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'STRONG BUY',
                    style: AppTypography.h4.copyWith(
                      color: AppColors.profitGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Based on 15 Indicators',
                    style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIndicatorStat('Bullish', '12', AppColors.profitGreen),
              _buildIndicatorStat('Neutral', '2', AppColors.textSecondary),
              _buildIndicatorStat('Bearish', '1', AppColors.lossRed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.h3.copyWith(color: color, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildMovingAverages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Moving Averages', style: AppTypography.h5),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              _buildTableRow('Period', 'SMA', 'EMA', isHeader: true),
              _buildTableRow('5 Day', '142.50', '143.10'),
              _buildTableRow('10 Day', '140.20', '141.80'),
              _buildTableRow('20 Day', '138.90', '139.50'),
              _buildTableRow('50 Day', '135.00', '136.20'),
              _buildTableRow('100 Day', '130.40', '131.80'),
              _buildTableRow('200 Day', '125.60', '127.10', isLast: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOscillators() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Oscillators', style: AppTypography.h5),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              _buildTableRow('Name', 'Value', 'Action', isHeader: true),
              _buildTableRow('RSI (14)', '68.4', 'BUY', actionColor: AppColors.profitGreen),
              _buildTableRow('MACD (12, 26)', '1.45', 'BUY', actionColor: AppColors.profitGreen),
              _buildTableRow('Stochastic (14)', '82.1', 'SELL', actionColor: AppColors.lossRed),
              _buildTableRow('CCI (14)', '120.5', 'BUY', actionColor: AppColors.profitGreen, isLast: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupportResistance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pivot Points (Classic)', style: AppTypography.h5),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              _buildTableRow('Level', 'Value', '', isHeader: true),
              _buildTableRow('Resistance 3', '152.80', ''),
              _buildTableRow('Resistance 2', '149.50', ''),
              _buildTableRow('Resistance 1', '146.20', ''),
              _buildTableRow('Pivot Point', '142.10', ''),
              _buildTableRow('Support 1', '138.80', ''),
              _buildTableRow('Support 2', '134.70', ''),
              _buildTableRow('Support 3', '131.40', '', isLast: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableRow(String col1, String col2, String col3, {bool isHeader = false, bool isLast = false, Color? actionColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: isLast ? null : const Border(bottom: BorderSide(color: AppColors.border)),
        color: isHeader ? AppColors.backgroundPrimary.withOpacity(0.5) : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              col1,
              style: isHeader 
                  ? AppTypography.labelSmall.copyWith(color: AppColors.textTertiary)
                  : AppTypography.bodySmall,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              col2,
              style: isHeader 
                  ? AppTypography.labelSmall.copyWith(color: AppColors.textTertiary)
                  : AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              col3,
              style: isHeader 
                  ? AppTypography.labelSmall.copyWith(color: AppColors.textTertiary)
                  : AppTypography.bodySmall.copyWith(
                      color: actionColor ?? AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    // Draw background track (semi-circle)
    paint.color = AppColors.border;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159, // Start angle (pi)
      3.14159, // Sweep angle (pi)
      false,
      paint,
    );

    // Draw active track (STRONG BUY is around 80%)
    paint.color = AppColors.profitGreen;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159, 
      3.14159 * 0.8, // 80% of the way
      false,
      paint,
    );

    // Draw Needle
    final needlePaint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.fill;
      
    // Angle for 80% is pi + (pi * 0.8)
    final angle = 3.14159 + (3.14159 * 0.8);
    final needleLength = radius - 8;
    
    final needleEnd = Offset(
      center.dx + needleLength * 1.0 * (angle == 0 ? 1 : angle == 3.14159 ? -1 : angle > 3.14159 && angle < 6.28 ? -0.8 : 0.8), // Simplistic math for mock
      center.dy - needleLength * 0.6,
    );

    // Simplistic needle drawing just to look like a gauge
    canvas.drawLine(
      center, 
      Offset(center.dx + 60, center.dy - 80), // Fixed angle for "Strong Buy" mock
      Paint()..color = AppColors.textPrimary..strokeWidth = 4..strokeCap = StrokeCap.round
    );
    
    // Center dot
    canvas.drawCircle(center, 8, needlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
