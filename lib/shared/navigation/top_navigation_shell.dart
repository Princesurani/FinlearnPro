import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../features/auth/presentation/pages/settings_screen.dart';

class TopNavigationShell extends StatelessWidget {
  final Widget title;
  final List<Widget> actions;
  final bool showMenu;
  final bool showSettings;

  const TopNavigationShell({
    super.key,
    required this.title,
    this.actions = const [],
    this.showMenu = true,
    this.showSettings = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          // Leading Menu Button
          if (showMenu) ...[
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Candle 1 (Lower)
                    SizedBox(
                      width: 7,
                      height: 16,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Wick (High/Low)
                          Container(
                            width: 2,
                            height: 16,
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          // Body (Open/Close)
                          Positioned(
                            bottom: 3,
                            child: Container(
                              width: 7,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.white.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 2),
                    // Candle 2 (Higher/Uptrend)
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      width: 7,
                      height: 22,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Wick (High/Low)
                          Container(
                            width: 2,
                            height: 22,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          // Body (Open/Close)
                          Positioned(
                            bottom: 6,
                            child: Container(
                              width: 7,
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
          ],

          // Title / Content Area
          Expanded(child: title),

          // Actions + Settings
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...actions,
              if (showSettings) ...[
                const SizedBox(width: AppSpacing.sm),
                TopBarButton(
                  icon: Icons.tune_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
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
            color: AppColors.white.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(12), // Slightly smaller radius
            border: Border.all(color: AppColors.white.withValues(alpha: 0.4), width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.03),
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
                      border: Border.all(color: AppColors.white, width: 1.5),
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
