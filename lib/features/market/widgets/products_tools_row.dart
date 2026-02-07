
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class ProductsToolsRow extends StatelessWidget {
  const ProductsToolsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _products.map((p) => _buildIcon(context, p)).toList(),
    );
  }

  Widget _buildIcon(BuildContext context, _ProductDef product) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.label} coming soon'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: product.color.withAlpha(25),
                shape: BoxShape.circle,
                border: Border.all(
                  color: product.color.withAlpha(50),
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
  _ProductDef('MTF', Icons.trending_up_rounded, AppColors.primaryPurple),
  _ProductDef('Stock SIP', Icons.repeat_rounded, AppColors.oceanTeal),
  _ProductDef('ETF', Icons.auto_graph_rounded, AppColors.electricBlue),
  _ProductDef('IPO', Icons.rocket_launch_rounded, AppColors.sunsetOrange),
  _ProductDef('Bonds', Icons.account_balance_rounded, AppColors.emerald),
];

class _ProductDef {
  const _ProductDef(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}
