import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_animations.dart';

enum GradientButtonSize { small, medium, large }

enum GradientButtonVariant { primary, secondary, success, danger, outline, ghost }

class GradientButton extends StatefulWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    this.child,
    this.text,
    this.gradient,
    this.color,
    this.textColor,
    this.leadingIcon,
    this.trailingIcon,
    this.iconSize,
    this.size = GradientButtonSize.large,
    this.variant = GradientButtonVariant.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.isExpanded = true,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.enableHaptics = true,
    this.loadingText,
  });

  final VoidCallback? onPressed;

  final Widget? child;

  final String? text;

  final Gradient? gradient;

  final Color? color;

  final Color? textColor;

  final IconData? leadingIcon;

  final IconData? trailingIcon;

  final double? iconSize;

  final GradientButtonSize size;

  final GradientButtonVariant variant;

  final bool isLoading;

  final bool isDisabled;

  final bool isExpanded;

  final double? width;

  final double? height;

  final EdgeInsetsGeometry? padding;

  final BorderRadius? borderRadius;

  final double? elevation;

  final bool enableHaptics;

  final String? loadingText;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  bool _isPressed = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: AppAnimations.pressedScale,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool get _isActive => !widget.isDisabled && !widget.isLoading;

  double get _buttonHeight {
    if (widget.height != null) return widget.height!;
    return switch (widget.size) {
      GradientButtonSize.small => AppSpacing.buttonHeightSmall,
      GradientButtonSize.medium => AppSpacing.buttonHeightCompact,
      GradientButtonSize.large => AppSpacing.buttonHeight,
    };
  }

  double get _fontSize {
    return switch (widget.size) {
      GradientButtonSize.small => 14.0,
      GradientButtonSize.medium => 15.0,
      GradientButtonSize.large => 17.0,
    };
  }

  double get _iconSize {
    if (widget.iconSize != null) return widget.iconSize!;
    return switch (widget.size) {
      GradientButtonSize.small => 18.0,
      GradientButtonSize.medium => 20.0,
      GradientButtonSize.large => 22.0,
    };
  }

  EdgeInsetsGeometry get _padding {
    if (widget.padding != null) return widget.padding!;
    return switch (widget.size) {
      GradientButtonSize.small => const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      GradientButtonSize.medium => const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      GradientButtonSize.large => const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
    };
  }

  BorderRadius get _borderRadius {
    if (widget.borderRadius != null) return widget.borderRadius!;
    return switch (widget.size) {
      GradientButtonSize.small => AppSpacing.borderRadiusSM,
      GradientButtonSize.medium => AppSpacing.borderRadiusMD,
      GradientButtonSize.large => AppSpacing.borderRadiusLG,
    };
  }

  Gradient get _gradient {
    if (widget.gradient != null) return widget.gradient!;
    if (widget.color != null) {
      return LinearGradient(
        colors: [widget.color!, widget.color!],
      );
    }
    return switch (widget.variant) {
      GradientButtonVariant.primary => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7C5CFF),
            Color(0xFF6B4EF5),
            Color(0xFF5038D4),
          ],
        ),
      GradientButtonVariant.secondary => const LinearGradient(
          colors: [Color(0xFF64748B), Color(0xFF475569)],
        ),
      GradientButtonVariant.success => const LinearGradient(
          colors: [Color(0xFF00D4AA), Color(0xFF00BFA5)],
        ),
      GradientButtonVariant.danger => const LinearGradient(
          colors: [Color(0xFFFF6B6B), Color(0xFFFF5252)],
        ),
      GradientButtonVariant.outline => const LinearGradient(
          colors: [Colors.transparent, Colors.transparent],
        ),
      GradientButtonVariant.ghost => const LinearGradient(
          colors: [Colors.transparent, Colors.transparent],
        ),
    };
  }

  Color get _contentColor {
    if (widget.textColor != null) return widget.textColor!;
    if (widget.variant == GradientButtonVariant.outline) {
      return AppColors.primaryPurple;
    }
    if (widget.variant == GradientButtonVariant.ghost) {
      return AppColors.textPrimary;
    }
    return Colors.white;
  }

  List<BoxShadow> get _shadows {
    if (!_isActive) return [];
    if (widget.variant == GradientButtonVariant.outline ||
        widget.variant == GradientButtonVariant.ghost) {
      return [];
    }

    final baseShadow = switch (widget.variant) {
      GradientButtonVariant.primary => AppShadows.primaryGlow,
      GradientButtonVariant.success => AppShadows.successGlow,
      GradientButtonVariant.danger => AppShadows.errorGlow,
      _ => AppShadows.md,
    };

    if (_isPressed || _isHovered) {
      return baseShadow.scale(1.3);
    }
    return baseShadow;
  }

  void _handleTapDown(TapDownDetails details) {
    if (!_isActive) return;
    setState(() => _isPressed = true);
    _animationController.forward();
    if (widget.enableHaptics) {
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!_isActive) return;
    setState(() => _isPressed = false);
    _animationController.reverse();
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    if (!_isActive) return;
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: _isActive ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          behavior: HitTestBehavior.opaque,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: widget.isDisabled ? 0.5 : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: widget.isExpanded ? double.infinity : widget.width,
              height: _buttonHeight,
              decoration: BoxDecoration(
                gradient: widget.variant == GradientButtonVariant.outline ||
                        widget.variant == GradientButtonVariant.ghost
                    ? null
                    : _gradient,
                borderRadius: _borderRadius,
                border: widget.variant == GradientButtonVariant.outline
                    ? Border.all(
                        color: AppColors.primaryPurple,
                        width: 2,
                      )
                    : null,
                boxShadow: _shadows,
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: _padding,
                  child: _buildContent(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (widget.isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: _iconSize,
            height: _iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(_contentColor),
            ),
          ),
          if (widget.loadingText != null) ...[
            const SizedBox(width: 12),
            Text(
              widget.loadingText!,
              style: TextStyle(
                color: _contentColor,
                fontSize: _fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      );
    }

    if (widget.child != null) {
      return Center(child: widget.child);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.leadingIcon != null) ...[
          Icon(
            widget.leadingIcon,
            color: _contentColor,
            size: _iconSize,
          ),
          const SizedBox(width: 10),
        ],
        if (widget.text != null)
          Flexible(
            child: Text(
              widget.text!,
              style: TextStyle(
                color: _contentColor,
                fontSize: _fontSize,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (widget.trailingIcon != null) ...[
          const SizedBox(width: 10),
          Icon(
            widget.trailingIcon,
            color: _contentColor,
            size: _iconSize,
          ),
        ],
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.size = GradientButtonSize.large,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final GradientButtonSize size;

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      size: size,
      variant: GradientButtonVariant.primary,
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.size = GradientButtonSize.medium,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final GradientButtonSize size;

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      size: size,
      variant: GradientButtonVariant.secondary,
    );
  }
}

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.size = GradientButtonSize.medium,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final GradientButtonSize size;

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      size: size,
      variant: GradientButtonVariant.outline,
    );
  }
}

class GhostButton extends StatelessWidget {
  const GhostButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.size = GradientButtonSize.medium,
    this.textColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final GradientButtonSize size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      size: size,
      variant: GradientButtonVariant.ghost,
      textColor: textColor,
      isExpanded: false,
    );
  }
}

class IconActionButton extends StatefulWidget {
  const IconActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 48.0,
    this.iconSize = 24.0,
    this.color,
    this.backgroundColor,
    this.isLoading = false,
    this.isDisabled = false,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final Color? color;
  final Color? backgroundColor;
  final bool isLoading;
  final bool isDisabled;
  final String? tooltip;

  @override
  State<IconActionButton> createState() => _IconActionButtonState();
}

class _IconActionButtonState extends State<IconActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = !widget.isDisabled && !widget.isLoading;

    Widget button = GestureDetector(
      onTapDown: isActive ? (_) => _controller.forward() : null,
      onTapUp: isActive
          ? (_) {
              _controller.reverse();
              HapticFeedback.lightImpact();
              widget.onPressed?.call();
            }
          : null,
      onTapCancel: isActive ? () => _controller.reverse() : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: widget.isDisabled ? 0.5 : 1.0,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.backgroundColor ??
                  AppColors.primaryPurple.withAlpha((0.1 * 255).round()),
              borderRadius: BorderRadius.circular(widget.size / 2),
            ),
            child: Center(
              child: widget.isLoading
                  ? SizedBox(
                      width: widget.iconSize,
                      height: widget.iconSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.color ?? AppColors.primaryPurple,
                        ),
                      ),
                    )
                  : Icon(
                      widget.icon,
                      size: widget.iconSize,
                      color: widget.color ?? AppColors.primaryPurple,
                    ),
            ),
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      button = Tooltip(
        message: widget.tooltip!,
        child: button,
      );
    }

    return button;
  }
}
