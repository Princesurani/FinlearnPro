
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_animations.dart';

class DrawerFooter extends StatelessWidget {
  const DrawerFooter({super.key});

  // Mock: In production, this comes from user state
  static const bool _isPremiumUser = true;
  static const String _appVersion = '1.0.0';
  static const String _buildNumber = '42';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.06),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Upgrade banner for free users
          if (!_isPremiumUser) ...[
            _UpgradeBanner(),
            const SizedBox(height: 8),
          ],

          // Version and legal links
          _buildVersionSection(),

          const SizedBox(height: 6),

          // Social links
          _buildSocialLinks(context),
        ],
      ),
    );
  }

  Widget _buildVersionSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'v$_appVersion',
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white30,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        _buildDot(),
        _FooterLink(
          label: 'Privacy',
          onTap: () {},
        ),
        _buildDot(),
        _FooterLink(
          label: 'Terms',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 3,
        height: 3,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          icon: Icons.language_rounded,
          onTap: () => _showToast(context, 'Opening website...'),
        ),
        const SizedBox(width: 16),
        _SocialButton(
          icon: Icons.alternate_email_rounded,
          onTap: () => _showToast(context, 'Opening Twitter/X...'),
        ),
        const SizedBox(width: 16),
        _SocialButton(
          icon: Icons.play_circle_outline_rounded,
          onTap: () => _showToast(context, 'Opening YouTube...'),
        ),
        const SizedBox(width: 16),
        _SocialButton(
          icon: Icons.discord,
          onTap: () => _showToast(context, 'Opening Discord...'),
        ),
      ],
    );
  }

  void _showToast(BuildContext context, String message) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1A1A2E),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class _UpgradeBanner extends StatefulWidget {
  @override
  State<_UpgradeBanner> createState() => _UpgradeBannerState();
}

class _UpgradeBannerState extends State<_UpgradeBanner> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        HapticFeedback.mediumImpact();
        // Navigate to upgrade screen
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: AppAnimations.fastDuration,
        curve: AppAnimations.defaultCurve,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.goldenYellow.withOpacity(_isPressed ? 0.25 : 0.15),
              AppColors.sunsetOrange.withOpacity(_isPressed ? 0.20 : 0.10),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.goldenYellow.withOpacity(_isPressed ? 0.4 : 0.25),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Crown icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.goldenYellow, AppColors.sunsetOrange],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.goldenYellow.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.workspace_premium_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            // Text content
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upgrade to Pro',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Unlock AI advisor & more',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white60,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Arrow
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: AppColors.goldenYellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink({
    required this.label,
    required this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        HapticFeedback.selectionClick();
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedDefaultTextStyle(
        duration: AppAnimations.fastDuration,
        style: TextStyle(
          fontSize: 10,
          color: _isPressed 
              ? Colors.white70
              : Colors.white38,
          fontWeight: FontWeight.w500,
        ),
        child: Text(
          widget.label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: AppAnimations.fastDuration,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _isPressed 
              ? Colors.white.withOpacity(0.12)
              : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          widget.icon,
          size: 18,
          color: Colors.white.withOpacity(_isPressed ? 0.8 : 0.5),
        ),
      ),
    );
  }
}
