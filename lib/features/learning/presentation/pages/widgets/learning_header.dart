import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/navigation/top_navigation_shell.dart';
import '../../../../../features/gamification/presentation/widgets/streak_badge.dart';

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
            'Keep growing,',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Learning Hub',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: const [StreakBadge()],
    );
  }
}
