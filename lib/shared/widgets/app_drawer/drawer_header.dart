import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_animations.dart';
import '../../../features/auth/data/auth_service.dart';

class AppDrawerHeader extends StatefulWidget {
  final VoidCallback onClose;

  const AppDrawerHeader({super.key, required this.onClose});

  @override
  State<AppDrawerHeader> createState() => _AppDrawerHeaderState();
}

class _AppDrawerHeaderState extends State<AppDrawerHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;

  // Initial mock data - will be updated with real user info
  _UserData _getUserData() {
    final user = AuthService().currentUser;
    final displayName = user?.displayName ?? 'User';
    final initials = displayName.isNotEmpty
        ? displayName[0].toUpperCase()
        : 'U';

    return _UserData(
      name: displayName,
      email: user?.email ?? 'user@example.com',
      avatarInitials: initials,
      level: 12,
      currentXp: 12450,
      xpToNextLevel: 15000,
      subscriptionTier: SubscriptionTier.pro,
      streakDays: 7,
      joinDate: '2025-06-15',
    );
  }

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: AppAnimations.slowDuration,
    );

    // Stagger the entrance slightly for polish
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _entranceController.forward();
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = _getUserData();

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 16, 16),
      decoration: BoxDecoration(
        // Subtle gradient overlay for the header
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white.withOpacity(0.05), Colors.transparent],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row with close button
          _buildTopRow(),

          const SizedBox(height: 16),

          // Profile section
          _buildProfileSection(userData),

          const SizedBox(height: 12),

          // XP Progress Bar
          _buildXpProgress(userData),
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // App branding
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'F',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'FinLearn',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
            const SizedBox(width: 4),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.goldenYellow, AppColors.sunsetOrange],
              ).createShader(bounds),
              child: const Text(
                'Pro',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),

        // Close button
        _CloseButton(onPressed: widget.onClose),
      ],
    );
  }

  Widget _buildProfileSection(_UserData userData) {
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) {
        final slideValue =
            Tween<Offset>(begin: const Offset(-0.1, 0), end: Offset.zero)
                .animate(
                  CurvedAnimation(
                    parent: _entranceController,
                    curve: AppAnimations.entranceCurve,
                  ),
                )
                .value;

        final fadeValue = Tween<double>(begin: 0, end: 1)
            .animate(
              CurvedAnimation(
                parent: _entranceController,
                curve: const Interval(0, 0.7, curve: Curves.easeOut),
              ),
            )
            .value;

        return Transform.translate(
          offset: Offset(slideValue.dx * 30, 0),
          child: Opacity(opacity: fadeValue, child: child),
        );
      },
      child: Row(
        children: [
          // Avatar with level badge
          _ProfileAvatar(
            initials: userData.avatarInitials,
            level: userData.level,
            tier: userData.subscriptionTier,
          ),

          const SizedBox(width: 14),

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        userData.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _SubscriptionBadge(tier: userData.subscriptionTier),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  userData.email,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Quick stats row
                Row(
                  children: [
                    _QuickStatChip(
                      icon: Icons.local_fire_department_rounded,
                      value: '${userData.streakDays}',
                      label: 'day streak',
                      color: AppColors.sunsetOrange,
                    ),
                    const SizedBox(width: 12),
                    _QuickStatChip(
                      icon: Icons.bolt_rounded,
                      value: _formatXp(userData.currentXp),
                      label: 'XP',
                      color: AppColors.goldenYellow,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXpProgress(_UserData userData) {
    final progress = userData.currentXp / userData.xpToNextLevel;
    final xpRemaining = userData.xpToNextLevel - userData.currentXp;

    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) {
        final animatedProgress = Tween<double>(begin: 0, end: progress)
            .animate(
              CurvedAnimation(
                parent: _entranceController,
                curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
              ),
            )
            .value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Level Progress',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_formatXp(xpRemaining.toInt())} XP left',
                  style: const TextStyle(fontSize: 10, color: Colors.white54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Stack(
                children: [
                  // Animated progress fill
                  FractionallySizedBox(
                    widthFactor: animatedProgress,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryPurple,
                            AppColors.electricBlue,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryPurple.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatXp(int xp) {
    if (xp >= 1000) {
      return '${(xp / 1000).toStringAsFixed(1)}k';
    }
    return xp.toString();
  }
}

class _ProfileAvatar extends StatelessWidget {
  final String initials;
  final int level;
  final SubscriptionTier tier;

  const _ProfileAvatar({
    required this.initials,
    required this.level,
    required this.tier,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = tier == SubscriptionTier.pro
        ? AppColors.goldenYellow
        : AppColors.primaryPurple;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Avatar container
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryPurple, AppColors.primaryPurpleDark],
            ),
            border: Border.all(color: borderColor.withOpacity(0.6), width: 2),
            boxShadow: [
              BoxShadow(
                color: borderColor.withOpacity(0.3),
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              initials,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        ),

        // Level badge
        Positioned(
          right: -4,
          bottom: -4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A1A2E), Color(0xFF2D2D44)],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.goldenYellow.withOpacity(0.5),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_rounded,
                  size: 10,
                  color: AppColors.goldenYellow,
                ),
                const SizedBox(width: 2),
                Text(
                  '$level',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CloseButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _CloseButton({required this.onPressed});

  @override
  State<_CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<_CloseButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        HapticFeedback.lightImpact();
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: AppAnimations.fastDuration,
        curve: AppAnimations.defaultCurve,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _isPressed
              ? Colors.white.withOpacity(0.15)
              : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(_isPressed ? 0.2 : 0.1),
            width: 1,
          ),
        ),
        child: Icon(
          Icons.close_rounded,
          color: Colors.white.withOpacity(0.8),
          size: 20,
        ),
      ),
    );
  }
}

class _SubscriptionBadge extends StatelessWidget {
  final SubscriptionTier tier;

  const _SubscriptionBadge({required this.tier});

  @override
  Widget build(BuildContext context) {
    if (tier == SubscriptionTier.free) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        gradient: tier == SubscriptionTier.pro
            ? const LinearGradient(
                colors: [AppColors.goldenYellow, AppColors.sunsetOrange],
              )
            : AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color:
                (tier == SubscriptionTier.pro
                        ? AppColors.goldenYellow
                        : AppColors.primaryPurple)
                    .withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        tier == SubscriptionTier.pro ? 'PRO' : 'PREMIUM',
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
        maxLines: 1,
        overflow: TextOverflow.clip,
      ),
    );
  }
}

class _QuickStatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _QuickStatChip({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: 3),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white54),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _UserData {
  final String name;
  final String email;
  final String avatarInitials;
  final int level;
  final int currentXp;
  final int xpToNextLevel;
  final SubscriptionTier subscriptionTier;
  final int streakDays;
  final String joinDate;

  const _UserData({
    required this.name,
    required this.email,
    required this.avatarInitials,
    required this.level,
    required this.currentXp,
    required this.xpToNextLevel,
    required this.subscriptionTier,
    required this.streakDays,
    required this.joinDate,
  });
}

enum SubscriptionTier { free, premium, pro }
