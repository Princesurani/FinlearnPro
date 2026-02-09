import 'package:flutter/material.dart';
import '../../../../shared/navigation/top_navigation_shell.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/gamification/presentation/widgets/streak_badge.dart';
import '../../../notifications/presentation/pages/notifications_screen.dart';
import '../../data/auth_service.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;
    final displayName = user?.displayName ?? 'User';
    // Extract first name only
    final firstName = displayName.split(' ').first;

    return TopNavigationShell(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Welcome back,',
            style: TextStyle(
              fontSize: 11, // Standardized across all pages
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            firstName, // Use first name only
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
        TopBarButton(
          icon: Icons.notifications_none_rounded,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
              ),
            );
          },
          hasBadge: true,
        ),
      ],
    );
  }
}
