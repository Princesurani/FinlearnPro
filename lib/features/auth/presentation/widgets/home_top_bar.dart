import 'package:flutter/material.dart';
import '../../../../shared/navigation/top_navigation_shell.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/gamification/presentation/widgets/streak_badge.dart';
import '../../../notifications/presentation/pages/notifications_screen.dart';
import '../../data/auth_service.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 6) {
      // Late night / pre-market
      return 'Pre-market grind,';
    } else if (hour < 9) {
      // Early morning before market opens
      return 'Markets open soon,';
    } else if (hour < 12) {
      // Morning session
      final greetings = [
        'Chart the course,',
        'Opening bell,',
        'Position ready,',
      ];
      return greetings[DateTime.now().day % greetings.length];
    } else if (hour < 15) {
      // Midday
      final greetings = [
        'Mid-session,',
        'Stay disciplined,',
        'Watch the charts,',
      ];
      return greetings[DateTime.now().day % greetings.length];
    } else if (hour < 18) {
      // Afternoon / closing bell
      return 'Closing bell,';
    } else {
      // Evening / after-hours
      final greetings = [
        'After-hours review,',
        'Analyse & grow,',
        'Plan tomorrow\'s trades,',
      ];
      return greetings[DateTime.now().day % greetings.length];
    }
  }


  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;
    final username = user?.displayName ?? 'User';
    // Extract first name only
    final firstName = username.split(' ').first;

    return TopNavigationShell(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _getGreeting(),
            style: TextStyle(
              fontSize: 11, // Standardized across all pages
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            firstName.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: 0.8,
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
