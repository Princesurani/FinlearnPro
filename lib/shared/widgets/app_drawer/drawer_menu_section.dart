
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_animations.dart';

class DrawerMenuSection extends StatefulWidget {
  final VoidCallback? onItemTap;

  const DrawerMenuSection({
    super.key,
    this.onItemTap,
  });

  @override
  State<DrawerMenuSection> createState() => _DrawerMenuSectionState();
}

class _DrawerMenuSectionState extends State<DrawerMenuSection>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  // Menu structure with all features
  final List<_MenuGroup> _menuGroups = [
    _MenuGroup(
      title: 'Trading & Portfolio',
      icon: Icons.candlestick_chart_rounded,
      iconColor: AppColors.profitGreen,
      items: [
        _MenuItem(
          icon: Icons.pie_chart_rounded,
          label: 'My Portfolio',
          description: 'Holdings & performance',
          color: AppColors.primaryPurple,
          route: '/portfolio',
        ),
        _MenuItem(
          icon: Icons.show_chart_rounded,
          label: 'Trading Simulator',
          description: 'Practice with \$100K',
          color: AppColors.oceanTeal,
          route: '/trading-simulator',
          badge: _MenuBadge.hot,
        ),
        _MenuItem(
          icon: Icons.receipt_long_rounded,
          label: 'Order History',
          description: 'View all transactions',
          color: AppColors.electricBlue,
          route: '/order-history',
        ),
        _MenuItem(
          icon: Icons.bookmark_rounded,
          label: 'Watchlist',
          description: 'Tracked securities',
          color: AppColors.goldenYellow,
          route: '/watchlist',
        ),
      ],
    ),
    _MenuGroup(
      title: 'Learn & Grow',
      icon: Icons.school_rounded,
      iconColor: AppColors.electricBlue,
      items: [
        _MenuItem(
          icon: Icons.psychology_rounded,
          label: 'AI Financial Advisor',
          description: 'Get personalized insights',
          color: AppColors.lavender,
          route: '/ai-advisor',
          badge: _MenuBadge.newFeature,
        ),
        _MenuItem(
          icon: Icons.route_rounded,
          label: 'Learning Paths',
          description: 'Structured curriculum',
          color: AppColors.coralPink,
          route: '/learning-paths',
        ),
        _MenuItem(
          icon: Icons.local_fire_department_rounded,
          label: 'Daily Challenges',
          description: 'Earn XP & rewards',
          color: AppColors.sunsetOrange,
          route: '/daily-challenges',
        ),
        _MenuItem(
          icon: Icons.workspace_premium_rounded,
          label: 'Certificates',
          description: 'Your achievements',
          color: AppColors.emerald,
          route: '/certificates',
        ),
      ],
    ),
    _MenuGroup(
      title: 'Community',
      icon: Icons.people_rounded,
      iconColor: AppColors.coralPink,
      items: [
        _MenuItem(
          icon: Icons.emoji_events_rounded,
          label: 'Achievements',
          description: '15 of 50 unlocked',
          color: AppColors.goldenYellow,
          route: '/achievements',
        ),
        _MenuItem(
          icon: Icons.leaderboard_rounded,
          label: 'Leaderboards',
          description: 'Compete globally',
          color: AppColors.rose,
          route: '/leaderboards',
          badge: _MenuBadge.hot,
        ),
        _MenuItem(
          icon: Icons.forum_rounded,
          label: 'Discussion Forums',
          description: 'Connect with traders',
          color: AppColors.cyan,
          route: '/forums',
          badge: _MenuBadge.beta,
        ),
      ],
    ),
    _MenuGroup(
      title: 'Account',
      icon: Icons.settings_rounded,
      iconColor: AppColors.textTertiary,
      items: [
        _MenuItem(
          icon: Icons.tune_rounded,
          label: 'Settings',
          description: 'App preferences',
          color: AppColors.textSecondary,
          route: '/settings',
        ),
        _MenuItem(
          icon: Icons.help_outline_rounded,
          label: 'Help & Support',
          description: 'FAQs & contact us',
          color: AppColors.info,
          route: '/help',
        ),
        _MenuItem(
          icon: Icons.info_outline_rounded,
          label: 'About FinLearn',
          description: 'Version 1.0.0',
          color: AppColors.textTertiary,
          route: '/about',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int groupIndex = 0; groupIndex < _menuGroups.length; groupIndex++) ...[
          if (groupIndex > 0) const SizedBox(height: 16),
          _buildMenuGroup(_menuGroups[groupIndex], groupIndex),
        ],
      ],
    );
  }

  Widget _buildMenuGroup(_MenuGroup group, int groupIndex) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final delay = groupIndex * 0.15;
        final interval = Interval(
          delay.clamp(0.0, 0.7),
          (delay + 0.3).clamp(0.0, 1.0),
          curve: Curves.easeOut,
        );

        final progress = interval.transform(_controller.value);

        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(0, 15 * (1 - progress)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Group header
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 10),
            child: Row(
              children: [
                Icon(
                  group.icon,
                  size: 14,
                  color: group.iconColor,
                ),
                const SizedBox(width: 6),
                Text(
                  group.title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white38,
                    letterSpacing: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Menu items
          Container(
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.06),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < group.items.length; i++) ...[
                  _DrawerMenuItem(
                    item: group.items[i],
                    onTap: () => _handleItemTap(group.items[i]),
                    isFirst: i == 0,
                    isLast: i == group.items.length - 1,
                  ),
                  if (i < group.items.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 48,
                      endIndent: 12,
                      color: AppColors.white.withValues(alpha: 0.05),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleItemTap(_MenuItem item) {
    HapticFeedback.lightImpact();

    // Close drawer first, then navigate
    widget.onItemTap?.call();

    // Small delay to let drawer close animation start
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        // In production: Navigator.pushNamed(context, item.route);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Navigating to ${item.label}...'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color(0xFF1A1A2E),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    });
  }
}

class _DrawerMenuItem extends StatefulWidget {
  final _MenuItem item;
  final VoidCallback onTap;
  final bool isFirst;
  final bool isLast;

  const _DrawerMenuItem({
    required this.item,
    required this.onTap,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  State<_DrawerMenuItem> createState() => _DrawerMenuItemState();
}

class _DrawerMenuItemState extends State<_DrawerMenuItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: AppAnimations.fastDuration,
        curve: AppAnimations.defaultCurve,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: _isPressed 
              ? item.color.withValues(alpha: 0.1)
              : AppColors.transparent,
          borderRadius: BorderRadius.vertical(
            top: widget.isFirst ? const Radius.circular(14) : Radius.zero,
            bottom: widget.isLast ? const Radius.circular(14) : Radius.zero,
          ),
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                item.icon,
                size: 18,
                color: item.color,
              ),
            ),

            const SizedBox(width: 12),

            // Labels
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          item.label,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (item.badge != null) ...[
                        const SizedBox(width: 6),
                        _BadgeWidget(badge: item.badge!),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.white.withValues(alpha: 0.45),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: AppColors.white.withValues(alpha: 0.25),
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeWidget extends StatelessWidget {
  final _MenuBadge badge;

  const _BadgeWidget({required this.badge});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String text;

    switch (badge) {
      case _MenuBadge.newFeature:
        bgColor = AppColors.primaryPurple;
        textColor = AppColors.white;
        text = 'NEW';
      case _MenuBadge.beta:
        bgColor = AppColors.electricBlue.withValues(alpha: 0.2);
        textColor = AppColors.electricBlue;
        text = 'BETA';
      case _MenuBadge.hot:
        bgColor = AppColors.sunsetOrange.withValues(alpha: 0.2);
        textColor = AppColors.sunsetOrange;
        text = 'HOT';
      case _MenuBadge.pro:
        bgColor = AppColors.goldenYellow;
        textColor = AppColors.black87;
        text = 'PRO';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: textColor,
          letterSpacing: 0.5,
        ),
        maxLines: 1,
        overflow: TextOverflow.clip,
      ),
    );
  }
}

class _MenuGroup {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<_MenuItem> items;

  const _MenuGroup({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.items,
  });
}

class _MenuItem {
  final IconData icon;
  final String label;
  final String description;
  final Color color;
  final String route;
  final _MenuBadge? badge;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.description,
    required this.color,
    required this.route,
    this.badge,
  });
}

enum _MenuBadge {
  newFeature,
  beta,
  hot,
  pro,
}
