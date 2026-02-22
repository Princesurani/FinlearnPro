import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/navigation/top_navigation_shell.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top + 12),
          Padding(
            padding: AppSpacing.screenPaddingH,
            child: TopNavigationShell(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Your wealth,',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    'Portfolio',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(child: _ComingSoonBody()),
        ],
      ),
    );
  }
}

class _ComingSoonBody extends StatelessWidget {
  const _ComingSoonBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.pie_chart_outline_rounded,
                size: 40,
                color: AppColors.primaryPurple,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Coming Soon',
              style: AppTypography.h2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Advanced portfolio analytics and insights\nare on their way.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryPurple.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Text(
                'Stay tuned',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
