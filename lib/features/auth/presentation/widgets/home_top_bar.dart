import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../shared/widgets/app_drawer/app_drawer.dart';
import '../../../../features/gamification/presentation/widgets/streak_badge.dart';
import '../../../notifications/presentation/pages/notifications_screen.dart';
import '../../data/auth_service.dart';
import '../pages/profile_screen.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;
    final displayName = user?.displayName ?? 'User';
    final initials = displayName.isNotEmpty
        ? displayName[0].toUpperCase()
        : 'U';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side: Menu button + Welcome text
        Expanded(
          child: Row(
            children: [
              // Menu button to open drawer
              _MenuButton(onTap: () => AppDrawer.show(context)),
              const SizedBox(width: 14),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back,',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8), // Minimal spacing between left and right
        Row(
          children: [
            const StreakBadge(),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsScreen(),
                  ),
                );
              },
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  color: Colors.grey[700],
                ),
              ),
            ),
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
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6B4EF5), Color(0xFF8F7AFE)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B4EF5).withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MenuButton extends StatefulWidget {
  final VoidCallback onTap;

  const _MenuButton({required this.onTap});

  @override
  State<_MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<_MenuButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        HapticFeedback.mediumImpact();
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: _isPressed
              ? const Color(0xFF6B4EF5).withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isPressed
                ? const Color(0xFF6B4EF5).withValues(alpha: 0.3)
                : Colors.grey.withValues(alpha: 0.15),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isPressed ? 0.08 : 0.05),
              blurRadius: _isPressed ? 15 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuLine(22, _isPressed),
              const SizedBox(height: 5),
              _buildMenuLine(16, _isPressed),
              const SizedBox(height: 5),
              _buildMenuLine(22, _isPressed),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuLine(double width, bool isPressed) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: width,
      height: 2.5,
      decoration: BoxDecoration(
        color: isPressed ? const Color(0xFF6B4EF5) : const Color(0xFF1E1E2C),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
