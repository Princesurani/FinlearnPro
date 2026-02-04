import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_shadows.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.blurIntensity = 24.0,
    this.opacity = 0.08,
    this.borderOpacity = 0.15,
    this.gradientOpacity = 0.05,
    this.backgroundColor,
    this.borderColor,
    this.enableBorder = true,
    this.enableGradient = true,
    this.enableShadow = true,
    this.shadowColor,
    this.constraints,
    this.clipBehavior = Clip.antiAlias,
    this.onTap,
    this.enableScaleAnimation = false,
  });

  final Widget child;

  final double? width;

  final double? height;

  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  final BorderRadiusGeometry? borderRadius;

  final double blurIntensity;

  final double opacity;

  final double borderOpacity;

  final double gradientOpacity;

  final Color? backgroundColor;

  final Color? borderColor;

  final bool enableBorder;

  final bool enableGradient;

  final bool enableShadow;

  final Color? shadowColor;

  final BoxConstraints? constraints;

  final Clip clipBehavior;

  final VoidCallback? onTap;

  final bool enableScaleAnimation;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? AppSpacing.borderRadiusXL;
    final effectiveBackgroundColor = backgroundColor ?? Colors.white;
    final effectiveBorderColor = borderColor ?? Colors.white;

    Widget content = ClipRRect(
      borderRadius: effectiveBorderRadius as BorderRadius,
      clipBehavior: clipBehavior,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurIntensity,
          sigmaY: blurIntensity,
        ),
        child: Container(
          width: width,
          height: height,
          constraints: constraints,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor.withAlpha((opacity * 255).round()),
            borderRadius: effectiveBorderRadius,
            border: enableBorder
                ? Border.all(
                    color: effectiveBorderColor.withAlpha((borderOpacity * 255).round()),
                    width: 1.0,
                  )
                : null,
            gradient: enableGradient
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withAlpha((gradientOpacity * 2 * 255).round()),
                      Colors.white.withAlpha((gradientOpacity * 0.5 * 255).round()),
                    ],
                  )
                : null,
            boxShadow: enableShadow
                ? [
                    BoxShadow(
                      color: (shadowColor ?? AppColors.darkBackground)
                          .withAlpha((0.08 * 255).round()),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                      spreadRadius: -4,
                    ),
                  ]
                : null,
          ),
          padding: padding,
          margin: margin,
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      if (enableScaleAnimation) {
        content = _TappableGlass(
          onTap: onTap!,
          borderRadius: effectiveBorderRadius,
          child: content,
        );
      } else {
        content = GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: content,
        );
      }
    }

    return content;
  }
}

class _TappableGlass extends StatefulWidget {
  const _TappableGlass({
    required this.onTap,
    required this.child,
    required this.borderRadius,
  });

  final VoidCallback onTap;
  final Widget child;
  final BorderRadiusGeometry borderRadius;

  @override
  State<_TappableGlass> createState() => _TappableGlassState();
}

class _TappableGlassState extends State<_TappableGlass>
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
      end: 0.97,
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

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.onTap,
    this.enableScaleAnimation = true,
  });

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onTap;
  final bool enableScaleAnimation;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: width,
      height: height,
      padding: padding ?? AppSpacing.cardInsets,
      margin: margin,
      borderRadius: borderRadius ?? AppSpacing.borderRadiusXL,
      blurIntensity: 20.0,
      opacity: 0.1,
      borderOpacity: 0.2,
      onTap: onTap,
      enableScaleAnimation: enableScaleAnimation,
      child: child,
    );
  }
}

class GlassPanel extends StatelessWidget {
  const GlassPanel({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: padding ?? AppSpacing.paddingLG,
      margin: margin,
      borderRadius: borderRadius ?? AppSpacing.borderRadiusLG,
      blurIntensity: 16.0,
      opacity: 0.06,
      borderOpacity: 0.12,
      enableShadow: false,
      child: child,
    );
  }
}

class GlassNavBar extends StatelessWidget {
  const GlassNavBar({
    super.key,
    required this.child,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: height ?? AppSpacing.bottomNavHeight,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
      margin: margin ?? const EdgeInsets.fromLTRB(16, 0, 16, 12),
      borderRadius: borderRadius ?? AppSpacing.borderRadiusFull,
      blurIntensity: 30.0,
      opacity: 0.12,
      borderOpacity: 0.25,
      gradientOpacity: 0.08,
      enableShadow: true,
      child: child,
    );
  }
}

class GlassOverlay extends StatelessWidget {
  const GlassOverlay({
    super.key,
    required this.child,
    this.onTapOutside,
  });

  final Widget child;
  final VoidCallback? onTapOutside;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapOutside,
      behavior: HitTestBehavior.opaque,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          color: Colors.black.withAlpha((0.3 * 255).round()),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {}, // Prevent tap propagation
            child: child,
          ),
        ),
      ),
    );
  }
}

class GlassBottomSheet extends StatelessWidget {
  const GlassBottomSheet({
    super.key,
    required this.child,
    this.padding,
    this.maxHeight,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? MediaQuery.sizeOf(context).height * 0.85,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.95 * 255).round()),
        borderRadius: AppSpacing.borderRadiusTopXXL,
        boxShadow: AppShadows.xxl,
      ),
      child: ClipRRect(
        borderRadius: AppSpacing.borderRadiusTopXXL,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle indicator
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Content
              Flexible(
                child: Padding(
                  padding: padding ?? AppSpacing.modalInsets,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
