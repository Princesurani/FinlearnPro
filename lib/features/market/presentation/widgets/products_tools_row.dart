import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ProductsToolsRow extends StatelessWidget {
  const ProductsToolsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _products.map((p) => _buildIcon(context, p)).toList(),
    );
  }

  void _showProductDetails(BuildContext context, _ProductDef product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Use transparent to allow custom decoration
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: product.color.withValues(alpha: 0.15),
                blurRadius: 40,
                spreadRadius: 0,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          padding: EdgeInsets.only(
            top: 12, // For the drag handle
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            bottom: MediaQuery.of(context).padding.bottom + AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              
              // Glowing Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: product.color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: product.color.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: product.color.withValues(alpha: 0.2),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(product.icon, color: product.color, size: 28),
              ),
              const SizedBox(height: AppSpacing.md),
              
              Text(
                product.label,
                style: AppTypography.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              
              Text(
                product.description,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),

              // Benefits Card
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLayer1,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.borderHint.withValues(alpha: 0.5),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Why use ${product.label}?',
                      style: AppTypography.labelLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ...product.benefits.map((benefit) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                color: product.color,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  benefit,
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.textSecondary,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: product.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    shadowColor: product.color.withValues(alpha: 0.4),
                  ),
                  child: const Text(
                    'Got it',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIcon(BuildContext context, _ProductDef product) {
    return GestureDetector(
      onTap: () => _showProductDetails(context, product),
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: product.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: product.color.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              child: Icon(product.icon, color: product.color, size: 24),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              product.label,
              style: AppTypography.overline.copyWith(
                color: AppColors.textSecondary,
                fontSize: 10.5,
                fontWeight: AppTypography.medium,
                letterSpacing: 0,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

const List<_ProductDef> _products = [
  _ProductDef(
    'MTF',
    Icons.trending_up_rounded,
    AppColors.primary,
    'Margin Trading Facility (MTF) allows you to buy stocks by paying only a fraction of the total value. The broker funds the rest, amplifying your purchasing power.',
    [
      'Up to 4x buying power',
      'Pay later in flexible installments',
      'Ideal for short-term opportunities',
    ],
  ),
  _ProductDef(
    'Stock SIP',
    Icons.repeat_rounded,
    AppColors.oceanTeal,
    'Systematic Investment Plan (SIP) in stocks lets you invest a fixed amount regularly in specific stocks, helping you build wealth through the power of compounding.',
    [
      'Rupee cost averaging',
      'Automated disciplined investing',
      'Start with small amounts',
    ],
  ),
  _ProductDef(
    'ETF',
    Icons.auto_graph_rounded,
    AppColors.electricBlue,
    'Exchange Traded Funds (ETFs) are baskets of securities that track an underlying index. They are traded on the exchange like regular stocks, offering easy diversification.',
    [
      'Instant portfolio diversification',
      'Lower expense ratios than mutual funds',
      'Real-time market trading',
    ],
  ),
  _ProductDef(
    'IPO',
    Icons.rocket_launch_rounded,
    AppColors.sunsetOrange,
    'Initial Public Offering (IPO) is the process by which a private company offers its shares to the public for the first time, allowing you to invest early in a company\'s growth.',
    [
      'Get in on the ground floor',
      'Potential for listing day gains',
      'Invest in high-growth startups',
    ],
  ),
  _ProductDef(
    'Bonds',
    Icons.account_balance_rounded,
    AppColors.emerald,
    'Bonds are fixed-income instruments representing a loan made by an investor to a borrower. They offer regular interest payments and return the principal at maturity.',
    [
      'Fixed, predictable returns',
      'Lower risk compared to equities',
      'Excellent for capital preservation',
    ],
  ),
];

class _ProductDef {
  const _ProductDef(this.label, this.icon, this.color, this.description, this.benefits);
  final String label;
  final IconData icon;
  final Color color;
  final String description;
  final List<String> benefits;
}
