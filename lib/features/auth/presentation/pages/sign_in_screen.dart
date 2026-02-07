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
class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
    required this.onSignInSuccess,
    required this.onNavigateToSignUp,
    this.onForgotPassword,
  });

  final VoidCallback onSignInSuccess;
  final VoidCallback onNavigateToSignUp;
  final VoidCallback? onForgotPassword;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _authService = AuthService();

  late final AnimationController _entranceCtrl;
  late final AnimationController _shakeCtrl;

  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _formFade;
  late final Animation<Offset> _formSlide;
  late final Animation<double> _footerFade;

  bool _isLoading = false;
  String? _errorMessage;

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
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
    ));

    _formFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.2, 0.65, curve: Curves.easeOut),
    );
    _formSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.2, 0.65, curve: Curves.easeOutCubic),
    ));

    _footerFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _shakeCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    setState(() => _errorMessage = null);

    if (!(_formKey.currentState?.validate() ?? false)) {
      _triggerShake();
      return;
    }

    setState(() => _isLoading = true);
    HapticFeedback.lightImpact();

    try {
      await _authService.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );
      if (!mounted) return;
      HapticFeedback.mediumImpact();
      widget.onSignInSuccess();
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
              safePad.top + AppSpacing.xxl,
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

                  const SizedBox(height: AppSpacing.xxl),
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
                  FadeTransition(
                    opacity: _footerFade,
                    child: _buildFooter(),
                  ),
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
          child: const Icon(Icons.candlestick_chart_rounded,
              color: Colors.white, size: 24),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Welcome\nback',
          style: AppTypography.display2.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Sign in to continue your learning journey',
          style: AppTypography.bodyLarge.copyWith(
            color: Colors.white38,
          ),
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
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => _handleSignIn(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            if (widget.onForgotPassword != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: widget.onForgotPassword,
                  child: Text(
                    'Forgot password?',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.cyan,
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: AppSpacing.lg),

            PrimaryButton(
              text: 'Sign In',
              onPressed: _isLoading ? null : _handleSignIn,
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
          "Don't have an account? ",
          style: AppTypography.bodyMedium.copyWith(color: Colors.white38),
        ),
        GestureDetector(
          onTap: widget.onNavigateToSignUp,
          child: Text(
            'Sign Up',
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
                    Icon(Icons.error_outline_rounded,
                        color: AppColors.error, size: 18),
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
  const _AnimatedBuilder({
    super.key,
    required this.animation,
    required this.builder,
  });

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
