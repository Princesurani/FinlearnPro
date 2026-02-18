import 'package:finnn/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black87),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Mark all read')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader('Today'),
          const SizedBox(height: 10),
          _NotificationItem(
            title: 'Market Alert: BTC Drop',
            description:
                'Bitcoin has dropped below \$29,000 key support level. Heavy volume detected.',
            time: '2 min ago',
            icon: Icons.trending_down,
            iconColor: AppColors.error,
            isUnread: true,
          ),
          const SizedBox(height: 12),
          _NotificationItem(
            title: 'Streak Saver Used',
            description:
                'You missed yesterday\'s challenge but your streak was saved!',
            time: '2h ago',
            icon: Icons.shield_outlined,
            iconColor: AppColors.sunsetOrange,
            isUnread: true,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Yesterday'),
          const SizedBox(height: 10),
          _NotificationItem(
            title: 'New Badge Earned',
            description:
                'Congratulations! You\'ve earned the "Chart Master" badge for 7 correct predictions.',
            time: '1d ago',
            icon: Icons.emoji_events_outlined,
            iconColor: AppColors.primaryPurple,
            isUnread: false,
          ),
          const SizedBox(height: 12),
          _NotificationItem(
            title: 'Alex Morgan posted',
            description:
                'Check out the latest analysis on AAPL earnings report provided by Alex.',
            time: '1d ago',
            icon: Icons.person_outline,
            iconColor: AppColors.electricBlue,
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.textSecondary,
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color iconColor;
  final bool isUnread;

  const _NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? AppColors.white : const Color(0xFFF8F9FE),
        borderRadius: BorderRadius.circular(16),
        border: isUnread
            ? Border.all(color: AppColors.electricBlue.withValues(alpha: 0.1))
            : null,
        boxShadow: [
          if (isUnread)
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isUnread
                            ? FontWeight.bold
                            : FontWeight.w600,
                        color: AppColors.black87,
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
