import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_animations.dart';

class DrawerQuickActions extends StatefulWidget {
  const DrawerQuickActions({super.key});

  @override
  State<DrawerQuickActions> createState() => _DrawerQuickActionsState();
}

class _DrawerQuickActionsState extends State<DrawerQuickActions>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Mock data for badges
  final List<_QuickAction> _actions = const [
    _QuickAction(
      icon: Icons.bookmark_rounded,
      label: 'Watchlist',
      badgeCount: 12,
      color: AppColors.electricBlue,
      route: '/watchlist',
    ),
    _QuickAction(
      icon: Icons.history_rounded,
      label: 'Trades',
      badgeCount: 0,
      color: AppColors.oceanTeal,
      route: '/trade-history',
    ),
    _QuickAction(
      icon: Icons.collections_bookmark_rounded,
      label: 'Saved',
      badgeCount: 5,
      color: AppColors.coralPink,
      route: '/saved-lessons',
    ),
    _QuickAction(
      icon: Icons.notifications_rounded,
      label: 'Alerts',
      badgeCount: 3,
      color: AppColors.sunsetOrange,
      route: '/notifications',
    ),
    _QuickAction(
      icon: Icons.trending_up_rounded,
      label: 'Analysis',
      badgeCount: 0,
      color: AppColors.lavender,
      route: '/analysis',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
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
        // Section header
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Row(
            children: [
              Icon(
                Icons.flash_on_rounded,
                size: 16,
                color: AppColors.goldenYellow,
              ),
              const SizedBox(width: 6),
              const Text(
                'Quick Access',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                  letterSpacing: -0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),

        // Horizontal scroll of actions
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _actions.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  // Staggered entrance animation
                  final delay = index * 0.1;
                  final startInterval = delay.clamp(0.0, 0.6);
                  final endInterval = (delay + 0.4).clamp(0.0, 1.0);

                  final interval = Interval(
                    startInterval,
                    endInterval,
                    curve: Curves.easeOut,
                  );

                  final progress = interval.transform(_controller.value);
                  // Clamp opacity to valid range (0.0 to 1.0)
                  final opacity = progress.clamp(0.0, 1.0);

                  return Transform.translate(
                    offset: Offset(0, 20 * (1 - progress)),
                    child: Opacity(opacity: opacity, child: child),
                  );
                },
                child: _QuickActionChip(action: _actions[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _QuickActionChip extends StatefulWidget {
  final _QuickAction action;

  const _QuickActionChip({required this.action});

  @override
  State<_QuickActionChip> createState() => _QuickActionChipState();
}

class _QuickActionChipState extends State<_QuickActionChip> {
  bool _isPressed = false;

  void _handleTap() {
    HapticFeedback.lightImpact();
    // Navigate to the action's route
    // In production: Navigator.pushNamed(context, widget.action.route);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${widget.action.label}...'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1A1A2E),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final action = widget.action;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _handleTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: AppAnimations.fastDuration,
        curve: AppAnimations.defaultCurve,
        width: 70,
        height: 72,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: _isPressed
              ? action.color.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isPressed
                ? action.color.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: action.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(action.icon, size: 18, color: action.color),
                ),
                const SizedBox(height: 4),
                // Label
                Text(
                  action.label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            // Badge
            if (action.badgeCount > 0)
              Positioned(
                top: -4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: action.color,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: action.color.withValues(alpha: 0.5),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    action.badgeCount > 99 ? '99+' : '${action.badgeCount}',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Quick action data model
class _QuickAction {
  final IconData icon;
  final String label;
  final int badgeCount;
  final Color color;
  final String route;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.badgeCount,
    required this.color,
    required this.route,
  });
}
