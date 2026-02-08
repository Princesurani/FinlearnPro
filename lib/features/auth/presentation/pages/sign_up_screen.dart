import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_animations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/gradient_button.dart';
import '../../data/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.onSignUpSuccess,
    required this.onNavigateToSignIn,
  });

  final VoidCallback onSignUpSuccess;
  final VoidCallback onNavigateToSignIn;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  final _authService = AuthService();

  late final AnimationController _entranceCtrl;
  late final AnimationController _shakeCtrl;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _formFade;
  late final Animation<Offset> _formSlide;
  late final Animation<double> _footerFade;

  bool _isLoading = false;
  bool _agreedToTerms = false;
  String? _errorMessage;
  double _passwordStrength = 0;

  @override
  void initState() {
    super.initState();

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: AppAnimations.longDuration,
    );

    _shakeCtrl = AnimationController(
      vsync: this,
      duration: AppAnimations.fastDuration,
    );

    _headerFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
    );
    _headerSlide =
        Tween<Offset>(begin: const Offset(0, -0.12), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceCtrl,
            curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
          ),
        );

    _formFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.15, 0.6, curve: Curves.easeOut),
    );
    _formSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entranceCtrl,
            curve: const Interval(0.15, 0.6, curve: Curves.easeOutCubic),
          ),
        );

    _footerFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.45, 1.0, curve: Curves.easeOut),
    );

    _passwordCtrl.addListener(_evaluatePasswordStrength);
    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _shakeCtrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  void _evaluatePasswordStrength() {
    final pw = _passwordCtrl.text;
    if (pw.isEmpty) {
      setState(() => _passwordStrength = 0);
      return;
    }

    var score = 0.0;
    if (pw.length >= 6) score += 0.2;
    if (pw.length >= 10) score += 0.15;
    if (RegExp(r'[A-Z]').hasMatch(pw)) score += 0.2;
    if (RegExp(r'[0-9]').hasMatch(pw)) score += 0.2;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pw)) score += 0.25;

    setState(() => _passwordStrength = score.clamp(0.0, 1.0));
  }

  String _strengthLabel() {
    if (_passwordStrength < 0.3) return 'Weak';
    if (_passwordStrength < 0.6) return 'Fair';
    if (_passwordStrength < 0.85) return 'Good';
    return 'Strong';
  }

  Color _strengthColor() {
    if (_passwordStrength < 0.3) return AppColors.error;
    if (_passwordStrength < 0.6) return AppColors.warning;
    if (_passwordStrength < 0.85) return AppColors.cyan;
    return AppColors.success;
  }

  Future<void> _handleSignUp() async {
    setState(() => _errorMessage = null);

    if (!_agreedToTerms) {
      setState(
        () => _errorMessage = 'Please agree to the Terms & Privacy Policy',
      );
      _triggerShake();
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) {
      _triggerShake();
      return;
    }

    setState(() => _isLoading = true);
    HapticFeedback.lightImpact();

    try {
      await _authService.signUpWithEmailAndPassword(
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );
      if (!mounted) return;
      HapticFeedback.mediumImpact();
      widget.onSignUpSuccess();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
      _triggerShake();
    }
  }

  void _triggerShake() {
    HapticFeedback.heavyImpact();
    _shakeCtrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final safePad = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      body: Stack(
        children: [
          const Positioned.fill(child: _GridBackground()),

          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              safePad.top + AppSpacing.xl,
              AppSpacing.lg,
              safePad.bottom + AppSpacing.xl,
            ),
            physics: const BouncingScrollPhysics(),
            child: _AnimatedBuilder(
              animation: _entranceCtrl,
              builder: (context, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FadeTransition(
                    opacity: _headerFade,
                    child: SlideTransition(
                      position: _headerSlide,
                      child: _buildHeader(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _ErrorBanner(message: _errorMessage),
                  _ShakeWrapper(
                    animation: _shakeCtrl,
                    child: FadeTransition(
                      opacity: _formFade,
                      child: SlideTransition(
                        position: _formSlide,
                        child: _buildFormCard(),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  FadeTransition(opacity: _footerFade, child: _buildFooter()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: AppColors.primaryGradient,
          ),
          child: const Icon(
            Icons.candlestick_chart_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Create your\naccount',
          style: AppTypography.display2.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Start your financial mastery journey today',
          style: AppTypography.bodyLarge.copyWith(color: Colors.white38),
        ),
      ],
    );
  }

  Widget _buildFormCard() {
    return GlassContainer(
      padding: const EdgeInsets.all(AppSpacing.lg),
      borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NameTextField(
              controller: _nameCtrl,
              focusNode: _nameFocus,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _emailFocus.requestFocus(),
            ),
            const SizedBox(height: AppSpacing.md),

            EmailTextField(
              controller: _emailCtrl,
              focusNode: _emailFocus,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _passwordFocus.requestFocus(),
            ),
            const SizedBox(height: AppSpacing.md),

            PasswordTextField(
              controller: _passwordCtrl,
              focusNode: _passwordFocus,
              label: 'Password',
              hint: 'Create a strong password',
              textInputAction: TextInputAction.next,
              showStrengthIndicator: true,
              onSubmitted: (_) => _confirmFocus.requestFocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 6) return 'Must be at least 6 characters';
                return null;
              },
            ),
            if (_passwordCtrl.text.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              _PasswordStrengthMeter(
                strength: _passwordStrength,
                label: _strengthLabel(),
                color: _strengthColor(),
              ),
            ],
            const SizedBox(height: AppSpacing.md),

            PasswordTextField(
              controller: _confirmCtrl,
              focusNode: _confirmFocus,
              label: 'Confirm Password',
              hint: 'Re-enter your password',
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleSignUp(),
              validator: (value) {
                if (value == null || value.isEmpty)
                {
                  return 'Please confirm your password';
                }
                if (value != _passwordCtrl.text)
                {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.md),
            _TermsCheckbox(
              value: _agreedToTerms,
              onChanged: (v) => setState(() => _agreedToTerms = v ?? false),
            ),
            const SizedBox(height: AppSpacing.lg),

            PrimaryButton(
              text: 'Create Account',
              onPressed: _isLoading ? null : _handleSignUp,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: AppTypography.bodyMedium.copyWith(color: Colors.white38),
        ),
        GestureDetector(
          onTap: widget.onNavigateToSignIn,
          child: Text(
            'Sign In',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.cyan,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordStrengthMeter extends StatelessWidget {
  const _PasswordStrengthMeter({
    required this.strength,
    required this.label,
    required this.color,
  });

  final double strength;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (i) {
            final segmentThreshold = (i + 1) * 0.25;
            final active = strength >= segmentThreshold - 0.12;
            return Expanded(
              child: AnimatedContainer(
                duration: AppAnimations.fastDuration,
                curve: AppAnimations.defaultCurve,
                height: 3,
                margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: active
                      ? color.withValues(alpha: 0.8)
                      : Colors.white.withValues(alpha: 0.08),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: color.withValues(alpha: 0.8),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _TermsCheckbox extends StatelessWidget {
  const _TermsCheckbox({required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: AppAnimations.microDuration,
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: value
                    ? AppColors.cyan
                    : Colors.white.withValues(alpha: 0.25),
                width: 1.5,
              ),
              color: value
                  ? AppColors.cyan.withValues(alpha: 0.15)
                  : Colors.transparent,
            ),
            child: value
                ? const Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: AppColors.cyan,
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: AppTypography.labelSmall.copyWith(
                  color: Colors.white38,
                  height: 1.4,
                ),
                children: const [
                  TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: AppColors.cyan,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AppColors.cyan,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridBackground extends StatelessWidget {
  const _GridBackground();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(painter: _GridPainter(), size: Size.infinite),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.025)
      ..strokeWidth = 0.5;

    const spacing = 32.0;
    for (var x = 0.0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final dotPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;
    for (var x = 0.0; x < size.width; x += spacing) {
      for (var y = 0.0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.0, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: AppAnimations.fastDuration,
      curve: AppAnimations.defaultCurve,
      alignment: Alignment.topCenter,
      child: message != null
          ? Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: AppColors.error,
                      size: 18,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        message!,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _ShakeWrapper extends StatelessWidget {
  const _ShakeWrapper({required this.animation, required this.child});
  final AnimationController animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final t = animation.value;
        final dx = math.sin(t * math.pi * 6) * 8 * (1 - t);
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
    );
  }
}

class _AnimatedBuilder extends StatelessWidget {
  const _AnimatedBuilder({required this.animation, required this.builder});

  final Animation<double> animation;
  final Widget Function(BuildContext context, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: animation,
      builder: (ctx, child) => builder(ctx, child),
    );
  }
}
