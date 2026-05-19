import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';

class AdvancedSandbox extends StatefulWidget {
  const AdvancedSandbox({super.key});

  @override
  State<AdvancedSandbox> createState() => _AdvancedSandboxState();
}

class _AdvancedSandboxState extends State<AdvancedSandbox> {
  int _leverage = 1;
  double _marketMove = 0.0; // -5.0 to 5.0 %

  @override
  Widget build(BuildContext context) {
    final balance = 1000.0;
    final positionSize = balance * _leverage;
    final profitLoss = positionSize * (_marketMove / 100);
    final newBalance = balance + profitLoss;
    
    final isLiquidated = newBalance <= 0;
    
    final color = isLiquidated ? AppColors.lossRed : (profitLoss >= 0 ? AppColors.profitGreen : AppColors.warning);

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
            'Leverage Demonstrator',
            style: AppTypography.h5.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            'Initial Capital: \$1,000',
            style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isLiquidated ? AppColors.lossRed.withValues(alpha: 0.1) : AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                if (isLiquidated) ...[
                  const Icon(Icons.warning_rounded, color: AppColors.lossRed, size: 32),
                  const SizedBox(height: 8),
                  Text('LIQUIDATED', style: AppTypography.h4.copyWith(color: AppColors.lossRed)),
                  Text('Your losses exceeded your capital.', style: AppTypography.labelSmall.copyWith(color: AppColors.lossRed)),
                ] else ...[
                  Text('Current Balance', style: AppTypography.label.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  Text('\$${newBalance.toStringAsFixed(2)}', style: AppTypography.h3.copyWith(color: profitLoss >= 0 ? AppColors.profitGreen : AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: profitLoss >= 0 ? AppColors.profitGreen.withValues(alpha: 0.1) : AppColors.lossRed.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${profitLoss >= 0 ? '+' : ''}\$${profitLoss.toStringAsFixed(2)}',
                      style: AppTypography.label.copyWith(
                        color: profitLoss >= 0 ? AppColors.profitGreen : AppColors.lossRed,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Leverage:', style: AppTypography.label.copyWith(color: AppColors.textSecondary)),
              Row(
                children: [1, 5, 10, 50].map((lev) {
                  final isSelected = _leverage == lev;
                  return GestureDetector(
                    onTap: () => setState(() => _leverage = lev),
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${lev}x',
                        style: AppTypography.label.copyWith(
                          color: isSelected ? AppColors.white : AppColors.textPrimary,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Market Move', style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary)),
                  Text('${_marketMove >= 0 ? '+' : ''}${_marketMove.toStringAsFixed(1)}%', style: AppTypography.label.copyWith(color: AppColors.textPrimary)),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 4,
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.surfaceVariant,
                  thumbColor: AppColors.primary,
                  overlayColor: AppColors.primary.withValues(alpha: 0.1),
                ),
                child: Slider(
                  value: _marketMove,
                  min: -5.0,
                  max: 5.0,
                  onChanged: (v) => setState(() => _marketMove = v),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('-5%', style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary)),
                  Text('+5%', style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
