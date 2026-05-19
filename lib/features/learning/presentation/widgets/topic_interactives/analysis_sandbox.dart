import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';

class AnalysisSandbox extends StatefulWidget {
  const AnalysisSandbox({super.key});

  @override
  State<AnalysisSandbox> createState() => _AnalysisSandboxState();
}

class _AnalysisSandboxState extends State<AnalysisSandbox> {
  double _open = 150.0;
  double _close = 180.0;
  double _high = 200.0;
  double _low = 130.0;

  @override
  Widget build(BuildContext context) {
    // Ensure logical candle rules
    if (_open > _high) _high = _open;
    if (_close > _high) _high = _close;
    if (_open < _low) _low = _open;
    if (_close < _low) _low = _close;

    final isBullish = _close >= _open;
    final color = isBullish ? AppColors.profitGreen : AppColors.lossRed;
    
    // Total scale 100 to 250
    const minVal = 100.0;
    const maxVal = 250.0;
    const range = maxVal - minVal;

    // Map prices to UI height (300 total)
    const uiHeight = 200.0;
    
    double getUiY(double price) {
      return uiHeight - ((price - minVal) / range) * uiHeight;
    }

    final topWickY = getUiY(_high);
    final bottomWickY = getUiY(_low);
    final bodyTopY = getUiY(isBullish ? _close : _open);
    final bodyBottomY = getUiY(isBullish ? _open : _close);
    final bodyHeight = (bodyBottomY - bodyTopY).abs().clamp(2.0, uiHeight);

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
            'Candlestick Anatomy',
            style: AppTypography.h5.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            isBullish ? 'Bullish (Closing higher than Opening)' : 'Bearish (Closing lower than Opening)',
            style: AppTypography.bodySmall.copyWith(color: color),
          ),
          const SizedBox(height: 24),
          
          Row(
            children: [
              // Visualization
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: uiHeight,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Grid lines
                      for (int i=0; i<5; i++)
                        Positioned(
                          top: (uiHeight/4) * i,
                          left: 0, right: 0,
                          child: Container(height: 1, color: AppColors.border),
                        ),
                        
                      // Top Wick
                      Positioned(
                        top: topWickY,
                        bottom: uiHeight - bodyTopY,
                        child: Container(width: 4, color: color),
                      ),
                      
                      // Bottom Wick
                      Positioned(
                        top: bodyBottomY,
                        bottom: uiHeight - bottomWickY,
                        child: Container(width: 4, color: color),
                      ),
                      
                      // Body
                      Positioned(
                        top: bodyTopY,
                        height: bodyHeight,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: 40,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // Controls
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _buildSlider('High', _high, (v) => setState(() => _high = v), color),
                    _buildSlider(isBullish ? 'Close' : 'Open', isBullish ? _close : _open, (v) => setState((){
                      if (isBullish) {
                        _close = v;
                      } else {
                        _open = v;
                      }
                    }), color),
                    _buildSlider(isBullish ? 'Open' : 'Close', isBullish ? _open : _close, (v) => setState((){
                      if (isBullish) {
                        _open = v;
                      } else {
                        _close = v;
                      }
                    }), color),
                    _buildSlider('Low', _low, (v) => setState(() => _low = v), color),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, ValueChanged<double> onChanged, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary)),
            Text('\$${value.toInt()}', style: AppTypography.label.copyWith(color: AppColors.textPrimary)),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 2,
            activeTrackColor: color,
            inactiveTrackColor: AppColors.surfaceVariant,
            thumbColor: color,
            overlayColor: color.withValues(alpha: 0.1),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
          ),
          child: Slider(
            value: value,
            min: 100,
            max: 250,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
