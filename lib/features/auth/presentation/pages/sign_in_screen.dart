import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/aurora_background.dart';
import '../../../../shared/widgets/gradient_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/glass_container.dart';

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

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late AnimationController _formAnimationController;
  late AnimationController _shakeController;
  late AnimationController _successController;

  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isLoading = false;
  bool _rememberMe = false;
  String? _errorMessage;
  bool _showSuccess = false;

  late Animation<double> _formSlide;
  late Animation<double> _formOpacity;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _initAnimations();
    _startEntryAnimation();
  }

  void _initControllers() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _formAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  void _initAnimations() {
    _formSlide = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _formAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _formOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _formAnimationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _shakeAnimation = Tween<double>(begin: 0.0, end: 24.0).animate(
      CurvedAnimation(
        parent: _shakeController,
        curve: Curves.elasticIn,
      ),
    );
  }

  void _startEntryAnimation() {
    _formAnimationController.forward();
  }

  void _triggerShake() {
    _shakeController.forward(from: 0).then((_) {
      _shakeController.reverse();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formAnimationController.dispose();
    _shakeController.dispose();
    _successController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    // Clear previous error
    setState(() => _errorMessage = null);

    // Validate form
    if (!_formKey.currentState!.validate()) {
      HapticFeedback.heavyImpact();
      _triggerShake();
      return;
    }

    // Start loading
    setState(() => _isLoading = true);
    HapticFeedback.lightImpact();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1200));

    // Temporary authentication - admin/admin
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email == 'admin' && password == 'admin') {
      // Success
      HapticFeedback.mediumImpact();
      setState(() {
        _isLoading = false;
        _showSuccess = true;
      });

      _successController.forward();

      // Navigate after success animation
      await Future.delayed(const Duration(milliseconds: 800));
      widget.onSignInSuccess();
    } else {
      // Failure
      HapticFeedback.heavyImpact();
      _triggerShake();
      setState(() {
        _isLoading = false;
        _errorMessage = 'Invalid credentials. Use admin/admin for now.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Stack(
        children: [
          // Background
          const AuroraBackground(
            intensity: 0.2,
            enableAnimation: true,
          ),

          // Main Content
          SafeArea(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _formAnimationController,
                _shakeController,
              ]),
              builder: (context, child) {
                final shakeOffset = _shakeAnimation.value *
                    ((_shakeController.value * 4).floor().isEven ? 1 : -1) *
                    (1 - _shakeController.value);

                return Transform.translate(
                  offset: Offset(shakeOffset, _formSlide.value),
                  child: Opacity(
                    opacity: _formOpacity.value,
                    child: child,
                  ),
                );
              },
              child: _buildContent(),
            ),
          ),

          // Success Overlay
          if (_showSuccess) _buildSuccessOverlay(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.gapXL,

          // Back Button (if needed)
          _buildBackButton(),

          AppSpacing.gapXXL,

          // Header
          _buildHeader(),

          AppSpacing.gapXXL,

          // Sign In Form
          _buildSignInForm(),

          AppSpacing.gapXL,

          // Social Sign-In Options
          _buildSocialSignIn(),

          AppSpacing.gapXXL,

          // Sign Up Link
          _buildSignUpLink(),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back_rounded),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        padding: const EdgeInsets.all(AppSpacing.sm),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back',
          style: AppTypography.display3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        AppSpacing.gapSM,
        Text(
          'Sign in to continue your learning journey',
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSignInForm() {
    return Form(
      key: _formKey,
      child: GlassCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email Field
            AppTextField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              label: 'Username or Email',
              hint: 'Enter your username',
              prefixIcon: Icons.person_outline_rounded,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _passwordFocusNode.requestFocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),

            AppSpacing.gapLG,

            // Password Field
            PasswordTextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              label: 'Password',
              hint: 'Enter your password',
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleSignIn(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),

            AppSpacing.gapMD,

            // Remember Me & Forgot Password Row
            _buildOptionsRow(),

            // Error Message
            if (_errorMessage != null) ...[
              AppSpacing.gapMD,
              _buildErrorMessage(),
            ],

            AppSpacing.gapLG,

            // Sign In Button
            PrimaryButton(
              onPressed: _handleSignIn,
              text: 'Sign In',
              isLoading: _isLoading,
              size: GradientButtonSize.large,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsRow() {
    return Row(
      children: [
        // Remember Me Checkbox
        GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _rememberMe = !_rememberMe);
          },
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: _rememberMe
                      ? AppColors.primaryPurple
                      : Colors.transparent,
                  border: Border.all(
                    color: _rememberMe
                        ? AppColors.primaryPurple
                        : AppColors.border,
                    width: 2,
                  ),
                ),
                child: _rememberMe
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
              AppSpacing.gapSM,
              Text(
                'Remember me',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        const Spacer(),

        // Forgot Password
        TextButton(
          onPressed: widget.onForgotPassword,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Forgot Password?',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primaryPurple,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.error.withAlpha((0.1 * 255).round()),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        border: Border.all(
          color: AppColors.error.withAlpha((0.3 * 255).round()),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: AppColors.error,
            size: 20,
          ),
          AppSpacing.gapSM,
          Expanded(
            child: Text(
              _errorMessage!,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialSignIn() {
    return Column(
      children: [
        // Divider with "OR"
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.border)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(
                'OR',
                style: AppTypography.label.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            const Expanded(child: Divider(color: AppColors.border)),
          ],
        ),

        AppSpacing.gapLG,

        // Social Buttons
        Row(
          children: [
            Expanded(
              child: _SocialButton(
                icon: _GoogleIcon(),
                label: 'Google',
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // TODO: Implement Google Sign-In
                },
              ),
            ),
            AppSpacing.gapMD,
            Expanded(
              child: _SocialButton(
                icon: const Icon(Icons.apple, size: 24),
                label: 'Apple',
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // TODO: Implement Apple Sign-In
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSignUpLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          TextButton(
            onPressed: widget.onNavigateToSignUp,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Sign Up',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primaryPurple,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessOverlay() {
    return AnimatedBuilder(
      animation: _successController,
      builder: (context, child) {
        return Container(
          color: Colors.white.withAlpha((_successController.value * 0.9 * 255).round()),
          child: Center(
            child: Transform.scale(
              scale: _successController.value,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.successGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.success.withAlpha((0.3 * 255).round()),
                      blurRadius: 24,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Widget icon;
  final String label;
  final VoidCallback onPressed;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(_) {
    _controller.forward();
    setState(() => _isPressed = true);
  }

  void _handleTapUp(_) {
    _controller.reverse();
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    _controller.reverse();
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: _isPressed
                ? AppColors.backgroundTertiary
                : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
            border: Border.all(
              color: _isPressed ? AppColors.primaryPurple : AppColors.border,
            ),
            boxShadow: _isPressed
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.04 * 255).round()),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon,
              AppSpacing.gapSM,
              Text(
                widget.label,
                style: AppTypography.button.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _GoogleIconPainter(),
      ),
    );
  }
}

class _GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width / 24;

    // Blue
    final bluePaint = Paint()..color = const Color(0xFF4285F4);
    canvas.drawPath(
      Path()
        ..moveTo(23.7 * s, 12.3 * s)
        ..cubicTo(23.7 * s, 11.5 * s, 23.6 * s, 10.7 * s, 23.5 * s, 10 * s)
        ..lineTo(12 * s, 10 * s)
        ..lineTo(12 * s, 14.5 * s)
        ..lineTo(18.5 * s, 14.5 * s)
        ..cubicTo(18.2 * s, 16.1 * s, 17.3 * s, 17.4 * s, 15.9 * s, 18.3 * s)
        ..lineTo(15.9 * s, 21.2 * s)
        ..lineTo(19.7 * s, 21.2 * s)
        ..cubicTo(22.2 * s, 18.9 * s, 23.7 * s, 15.8 * s, 23.7 * s, 12.3 * s)
        ..close(),
      bluePaint,
    );

    // Green
    final greenPaint = Paint()..color = const Color(0xFF34A853);
    canvas.drawPath(
      Path()
        ..moveTo(12 * s, 24 * s)
        ..cubicTo(15.2 * s, 24 * s, 17.8 * s, 23 * s, 19.7 * s, 21.2 * s)
        ..lineTo(15.9 * s, 18.3 * s)
        ..cubicTo(14.8 * s, 19.1 * s, 13.5 * s, 19.5 * s, 12 * s, 19.5 * s)
        ..cubicTo(8.9 * s, 19.5 * s, 6.3 * s, 17.2 * s, 5.4 * s, 14.2 * s)
        ..lineTo(1.5 * s, 14.2 * s)
        ..lineTo(1.5 * s, 17.2 * s)
        ..cubicTo(3.4 * s, 21 * s, 7.4 * s, 24 * s, 12 * s, 24 * s)
        ..close(),
      greenPaint,
    );

    // Yellow
    final yellowPaint = Paint()..color = const Color(0xFFFBBC05);
    canvas.drawPath(
      Path()
        ..moveTo(5.4 * s, 14.2 * s)
        ..cubicTo(5.1 * s, 13.4 * s, 5 * s, 12.7 * s, 5 * s, 12 * s)
        ..cubicTo(5 * s, 11.3 * s, 5.1 * s, 10.6 * s, 5.4 * s, 9.8 * s)
        ..lineTo(5.4 * s, 6.8 * s)
        ..lineTo(1.5 * s, 6.8 * s)
        ..cubicTo(0.5 * s, 8.7 * s, 0 * s, 10.3 * s, 0 * s, 12 * s)
        ..cubicTo(0 * s, 13.7 * s, 0.5 * s, 15.3 * s, 1.5 * s, 17.2 * s)
        ..lineTo(5.4 * s, 14.2 * s)
        ..close(),
      yellowPaint,
    );

    // Red
    final redPaint = Paint()..color = const Color(0xFFEA4335);
    canvas.drawPath(
      Path()
        ..moveTo(12 * s, 4.8 * s)
        ..cubicTo(13.7 * s, 4.8 * s, 15.2 * s, 5.4 * s, 16.4 * s, 6.5 * s)
        ..lineTo(19.8 * s, 3.1 * s)
        ..cubicTo(17.8 * s, 1.2 * s, 15.2 * s, 0 * s, 12 * s, 0 * s)
        ..cubicTo(7.4 * s, 0 * s, 3.4 * s, 3 * s, 1.5 * s, 6.8 * s)
        ..lineTo(5.4 * s, 9.8 * s)
        ..cubicTo(6.3 * s, 6.8 * s, 8.9 * s, 4.8 * s, 12 * s, 4.8 * s)
        ..close(),
      redPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
