import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onAction,
    this.trailing,
  });

  final String title;

  final String? subtitle;

  final String? actionText;

  final VoidCallback? onAction;

  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.h6.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              ?trailing,
              if (trailing == null && actionText != null)
                GestureDetector(
                  onTap: onAction,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xxs,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          actionText!,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.primaryPurple,
                            fontWeight: AppTypography.medium,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 18,
                          color: AppColors.primaryPurple,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),

          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.xxxs),
            Text(
              subtitle!,
              style: AppTypography.bodyXS.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
