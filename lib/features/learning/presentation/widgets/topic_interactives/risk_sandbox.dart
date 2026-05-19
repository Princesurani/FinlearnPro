import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';

class RiskSandbox extends StatefulWidget {
  const RiskSandbox({super.key});

  @override
  State<RiskSandbox> createState() => _RiskSandboxState();
}

class _RiskSandboxState extends State<RiskSandbox> {
  double _winRate = 0.40; // 40% win rate
  double _riskReward = 2.0; // 1:2 R:R

  @override
  Widget build(BuildContext context) {
    // Calculate expected value
    final risk = 100.0; // Assume $100 risk per trade
    final reward = risk * _riskReward;
    final expectedValue = (reward * _winRate) - (risk * (1 - _winRate));
    
    final isProfitable = expectedValue > 0;
    final color = isProfitable ? AppColors.emerald : AppColors.lossRed;

    // Generate simulated curve
    final random = math.Random(42); // deterministic seed for smooth updates
    List<double> curve = [10000.0];
    double current = 10000.0;
    
    for (int i=0; i<50; i++) {
      final isWin = random.nextDouble() < _winRate;
      if (isWin) {
        current += reward;
      } else {
        current -= risk;
      }
      curve.add(current);
    }
    
    final minVal = curve.reduce(math.min);
    final maxVal = curve.reduce(math.max);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Risk/Reward Simulator',
            style: AppTypography.h5.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            'Simulating 50 trades with \$100 risk per trade',
            style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          
          // Chart
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: CustomPaint(
              painter: _CurvePainter(curve: curve, min: minVal, max: maxVal, color: color),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Expected Value', style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary)),
                  Text('${expectedValue >= 0 ? '+' : ''}\$${expectedValue.toStringAsFixed(1)}/trade', 
                    style: AppTypography.h6.copyWith(color: color),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isProfitable ? 'PROFITABLE' : 'LOSING',
                  style: AppTypography.label.copyWith(color: color, fontWeight: AppTypography.bold),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          _buildSlider(
            'Win Rate', 
            '${(_winRate * 100).toInt()}%', 
            _winRate, 0.1, 0.9, 
            (v) => setState(() => _winRate = v), 
            AppColors.primary
          ),
          
          const SizedBox(height: 12),
          
          _buildSlider(
            'Risk:Reward Ratio', 
            '1 : ${_riskReward.toStringAsFixed(1)}', 
            _riskReward, 0.5, 5.0, 
            (v) => setState(() => _riskReward = v), 
            AppColors.primary
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, String display, double value, double min, double max, ValueChanged<double> onChanged, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary)),
            Text(display, style: AppTypography.label.copyWith(color: AppColors.textPrimary)),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            activeTrackColor: color,
            inactiveTrackColor: AppColors.surfaceVariant,
            thumbColor: color,
            overlayColor: color.withValues(alpha: 0.1),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _CurvePainter extends CustomPainter {
  _CurvePainter({required this.curve, required this.min, required this.max, required this.color});
  
  final List<double> curve;
  final double min;
  final double max;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (curve.isEmpty) return;
    
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
      
    final range = (max - min) == 0 ? 1 : (max - min);
    final widthStep = size.width / (curve.length - 1);
    
    final path = Path();
    
    for (int i=0; i<curve.length; i++) {
      final x = i * widthStep;
      final y = size.height - ((curve[i] - min) / range) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
