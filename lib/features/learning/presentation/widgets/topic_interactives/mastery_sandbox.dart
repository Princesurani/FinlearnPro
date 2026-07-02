import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';

class MasterySandbox extends StatefulWidget {
  const MasterySandbox({super.key});

  @override
  State<MasterySandbox> createState() => _MasterySandboxState();
}

class _MasterySandboxState extends State<MasterySandbox> {
  final List<double> _emotionalCurve = [1000.0];
  final List<double> _consistentCurve = [1000.0];
  
  void _simulateTrade() {
    HapticFeedback.lightImpact();
    
    final random = math.Random();
    
    // Consistent: high win rate (60%), small wins, small losses (R:R 1:1 for simplicity)
    final consistentWin = random.nextDouble() < 0.60;
    final lastConsistent = _consistentCurve.last;
    final consistentChange = consistentWin ? 20.0 : -20.0;
    _consistentCurve.add(math.max(0, lastConsistent + consistentChange));
    
    // Emotional: low win rate (30%), huge wins, huge losses
    final emotionalWin = random.nextDouble() < 0.30;
    final lastEmotional = _emotionalCurve.last;
    
    double emotionalChange;
    if (emotionalWin) {
      emotionalChange = 150.0 + random.nextDouble() * 100; // huge win
    } else {
      emotionalChange = -100.0 - random.nextDouble() * 150; // huge loss
    }
    _emotionalCurve.add(math.max(0, lastEmotional + emotionalChange));
    
    setState(() {});
  }
  
  void _reset() {
    setState(() {
      _emotionalCurve.clear();
      _emotionalCurve.add(1000.0);
      _consistentCurve.clear();
      _consistentCurve.add(1000.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxTrades = 50;
    
    // Auto simulate if empty
    if (_emotionalCurve.length == 1 && _consistentCurve.length == 1) {
      Future.microtask(() {
        for(int i=0; i<10; i++) {
          _simulateTrade();
        }
      });
    }

    final allValues = [..._emotionalCurve, ..._consistentCurve];
    final minVal = allValues.reduce(math.min) * 0.8;
    final maxVal = allValues.reduce(math.max) * 1.2;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.emerald.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.emerald.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Consistency Simulator',
            style: AppTypography.h5.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            'Emotional vs Consistent Trading',
            style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend('Consistent', AppColors.emerald),
              const SizedBox(width: 24),
              _buildLegend('Emotional', AppColors.lossRed),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Chart
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundPrimary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: CustomPaint(
              painter: _DualCurvePainter(
                curve1: _consistentCurve,
                color1: AppColors.emerald,
                curve2: _emotionalCurve,
                color2: AppColors.lossRed,
                min: minVal,
                max: maxVal,
                maxPoints: maxTrades,
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: _reset,
                icon: Icon(Icons.refresh_rounded, color: AppColors.textSecondary),
                label: Text('Reset', style: AppTypography.label.copyWith(color: AppColors.textSecondary)),
              ),
              ElevatedButton.icon(
                onPressed: _consistentCurve.length < maxTrades ? _simulateTrade : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Next Trade'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 3,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(label, style: AppTypography.labelSmall.copyWith(color: AppColors.textPrimary)),
      ],
    );
  }
}

class _DualCurvePainter extends CustomPainter {
  _DualCurvePainter({
    required this.curve1, required this.color1,
    required this.curve2, required this.color2,
    required this.min, required this.max,
    required this.maxPoints,
  });
  
  final List<double> curve1;
  final Color color1;
  final List<double> curve2;
  final Color color2;
  final double min;
  final double max;
  final int maxPoints;

  @override
  void paint(Canvas canvas, Size size) {
    _drawCurve(canvas, size, curve1, color1);
    _drawCurve(canvas, size, curve2, color2);
  }
  
  void _drawCurve(Canvas canvas, Size size, List<double> curve, Color color) {
    if (curve.isEmpty) return;
    
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
      
    final range = (max - min) == 0 ? 1 : (max - min);
    final widthStep = size.width / math.max(1, maxPoints - 1);
    
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
