import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/app_drawer/app_drawer.dart';
import '../../features/auth/data/auth_service.dart';
import '../../features/auth/presentation/pages/profile_screen.dart';

class TopNavigationShell extends StatelessWidget {
  final Widget title;
  final List<Widget> actions;
  final bool showMenu;
  final bool showProfile;

  const TopNavigationShell({
    super.key,
    required this.title,
    this.actions = const [],
    this.showMenu = true,
    this.showProfile = true,
  });

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;
    final displayName = user?.displayName ?? 'User';
    final initials = displayName.isNotEmpty
        ? displayName[0].toUpperCase()
        : 'U';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          // Leading Menu Button
          if (showMenu) ...[
            TopBarButton(
              icon: Icons.grid_view_rounded,
              onTap: () => AppDrawer.show(context),
            ),
            const SizedBox(width: 16),
          ],

          // Title / Content Area
          Expanded(child: title),

          // Actions + Profile
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...actions,
              if (showProfile) ...[
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 44, // Reduced from 48 for better mobile fit
                    width: 44, // Reduced from 48 for better mobile fit
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryPurple.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primaryPurple,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          initials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                15, // Reduced from 16 for smaller container
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class TopBarButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool hasBadge;

  const TopBarButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.hasBadge = false,
  });

  @override
  State<TopBarButton> createState() => _TopBarButtonState();
}

class _TopBarButtonState extends State<TopBarButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        HapticFeedback.lightImpact();
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: 40, // Reduced from 44 for better mobile fit
          width: 40, // Reduced from 44 for better mobile fit
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12), // Slightly smaller radius
            border: Border.all(color: AppColors.borderLight, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                widget.icon,
                color: AppColors.textPrimary,
                size: 20,
              ), // Reduced from 22
              if (widget.hasBadge)
                Positioned(
                  top: 10, // Adjusted for smaller container
                  right: 10, // Adjusted for smaller container
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
