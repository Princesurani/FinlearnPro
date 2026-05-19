import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';


class FoundationsSandbox extends StatefulWidget {
  const FoundationsSandbox({super.key});

  @override
  State<FoundationsSandbox> createState() => _FoundationsSandboxState();
}

class _FoundationsSandboxState extends State<FoundationsSandbox> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _markets = [
    {
      'name': 'Stocks',
      'icon': Icons.business_rounded,
      'color': AppColors.electricBlue,
      'volatility': 0.4,
      'leverage': 0.2,
      'hours': '9:30 AM - 4:00 PM',
      'desc': 'Partial ownership of companies. Moderate risk, highly regulated.',
    },
    {
      'name': 'Crypto',
      'icon': Icons.currency_bitcoin_rounded,
      'color': AppColors.amber,
      'volatility': 0.9,
      'leverage': 0.8,
      'hours': '24 / 7 / 365',
      'desc': 'Digital assets. Extremely high volatility, always open.',
    },
    {
      'name': 'Forex',
      'icon': Icons.currency_exchange_rounded,
      'color': AppColors.emerald,
      'volatility': 0.2,
      'leverage': 1.0,
      'hours': '24/5 (Mon-Fri)',
      'desc': 'Global currencies. Low volatility but very high leverage available.',
    },
    {
      'name': 'Commodities',
      'icon': Icons.oil_barrel_rounded,
      'color': AppColors.sunsetOrange,
      'volatility': 0.6,
      'leverage': 0.5,
      'hours': 'Varies by Asset',
      'desc': 'Physical goods like gold, oil, wheat. Driven by supply and demand.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final market = _markets[_selectedIndex];
    final color = market['color'] as Color;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_markets.length, (index) {
              final m = _markets[index];
              final isSelected = _selectedIndex == index;
              final mColor = m['color'] as Color;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() => _selectedIndex = index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? mColor.withValues(alpha: 0.15) : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? mColor : AppColors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    m['icon'] as IconData,
                    color: isSelected ? mColor : AppColors.textTertiary,
                    size: 24,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          Text(
            market['name'],
            style: AppTypography.h4.copyWith(color: color),
          ),
          const SizedBox(height: 8),
          Text(
            market['desc'],
            style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary, height: 1.4),
          ),
          const SizedBox(height: 24),
          _buildStatBar('Volatility', market['volatility'] as double, color),
          const SizedBox(height: 16),
          _buildStatBar('Typical Leverage', market['leverage'] as double, color),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.access_time_rounded, color: AppColors.textTertiary, size: 18),
              const SizedBox(width: 8),
              Text(
                'Trading Hours: ${market['hours']}',
                style: AppTypography.label.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTypography.label.copyWith(color: AppColors.textPrimary)),
            Text('${(value * 100).toInt()}%', style: AppTypography.labelSmall.copyWith(color: color, fontWeight: AppTypography.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              widthFactor: value,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.5),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
