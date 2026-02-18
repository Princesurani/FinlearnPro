import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/navigation/top_navigation_shell.dart';
import '../../../../features/gamification/presentation/widgets/streak_badge.dart';

class LearningHeader extends StatelessWidget {
  const LearningHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return TopNavigationShell(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Learn more,', // Shortened from 'Keep growing,'
            style: TextStyle(
              fontSize: 11, // Standardized across all pages
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            'Learning', // Shortened from 'Learning Hub'
            style: const TextStyle(
              fontSize: 16, // Standardized across all pages
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: const [StreakBadge()],
    );
  }
}
