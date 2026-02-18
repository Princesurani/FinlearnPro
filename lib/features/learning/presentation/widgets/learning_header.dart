import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/navigation/top_navigation_shell.dart';
import '../../../../features/gamification/presentation/widgets/streak_badge.dart';
import '../../data/learning_mock_data.dart';
import 'tip_dialog.dart';

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
      actions: [
        const StreakBadge(),
        const SizedBox(width: 12),
        // Daily Tip Button
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderLight, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              final dailyTip = LearningMockData.dailyTips.first;
              showDialog(
                context: context,
                builder: (context) => TipDialog(
                  tip: dailyTip['tip'] ?? 'Keep learning!',
                  category: dailyTip['category'] ?? 'General',
                ),
              );
            },
            icon: const Text('💡', style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }
}
