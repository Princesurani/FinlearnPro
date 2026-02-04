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

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late AnimationController _formAnimationController;
  late AnimationController _shakeController;
  late AnimationController _successController;

  final _formKey = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _isLoading = false;
  bool _acceptTerms = false;
  String? _errorMessage;
  bool _showSuccess = false;
  double _passwordStrength = 0.0;

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
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController()
      ..addListener(_updatePasswordStrength);
    _confirmPasswordController = TextEditingController();

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

  void _updatePasswordStrength() {
    final password = _passwordController.text;
    double strength = 0.0;

    if (password.length >= 8) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.25;

    setState(() => _passwordStrength = strength);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _formAnimationController.dispose();
    _shakeController.dispose();
    _successController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    // Clear previous error
    setState(() => _errorMessage = null);

    // Check terms acceptance
    if (!_acceptTerms) {
      HapticFeedback.heavyImpact();
      setState(() {
        _errorMessage = 'Please accept the Terms of Service and Privacy Policy';
      });
      _triggerShake();
      return;
    }

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
    await Future.delayed(const Duration(milliseconds: 1500));

    // For now, always succeed (until DB integration)
    HapticFeedback.mediumImpact();
    setState(() {
      _isLoading = false;
      _showSuccess = true;
    });

    _successController.forward();

    // Navigate after success animation
    await Future.delayed(const Duration(milliseconds: 800));
    widget.onSignUpSuccess();
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
          AppSpacing.gapSM,

          // Back Button
          _buildBackButton(),

          AppSpacing.gapLG,

          // Header
          _buildHeader(),

          AppSpacing.gapXL,

          // Sign Up Form
          _buildSignUpForm(),

          AppSpacing.gapLG,

          // Sign In Link
          _buildSignInLink(),

          AppSpacing.gapXL,
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
          'Create Account',
          style: AppTypography.display3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        AppSpacing.gapSM,
        Text(
          'Start your journey to financial mastery',
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: GlassCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Full Name Field
            NameTextField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              label: 'Full Name',
              hint: 'Enter your full name',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _emailFocusNode.requestFocus(),
            ),

            AppSpacing.gapLG,

            // Email Field
            EmailTextField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              label: 'Email Address',
              hint: 'Enter your email',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _passwordFocusNode.requestFocus(),
            ),

            AppSpacing.gapLG,

            // Password Field with Strength Indicator
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PasswordTextField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  label: 'Password',
                  hint: 'Create a strong password',
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                AppSpacing.gapSM,
                _buildPasswordStrengthIndicator(),
              ],
            ),

            AppSpacing.gapLG,

            // Confirm Password Field
            PasswordTextField(
              controller: _confirmPasswordController,
              focusNode: _confirmPasswordFocusNode,
              label: 'Confirm Password',
              hint: 'Re-enter your password',
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleSignUp(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),

            AppSpacing.gapLG,

            // Terms Checkbox
            _buildTermsCheckbox(),

            // Error Message
            if (_errorMessage != null) ...[
              AppSpacing.gapMD,
              _buildErrorMessage(),
            ],

            AppSpacing.gapLG,

            // Sign Up Button
            PrimaryButton(
              onPressed: _handleSignUp,
              text: 'Create Account',
              isLoading: _isLoading,
              size: GradientButtonSize.large,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    final Color strengthColor;
    final String strengthText;

    if (_passwordStrength <= 0.25) {
      strengthColor = AppColors.error;
      strengthText = 'Weak';
    } else if (_passwordStrength <= 0.5) {
      strengthColor = AppColors.warning;
      strengthText = 'Fair';
    } else if (_passwordStrength <= 0.75) {
      strengthColor = AppColors.info;
      strengthText = 'Good';
    } else {
      strengthColor = AppColors.success;
      strengthText = 'Strong';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Strength Bar
        Row(
          children: List.generate(4, (index) {
            final isActive = (_passwordStrength * 4) > index;
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 4,
                margin: EdgeInsets.only(right: index < 3 ? 4 : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: isActive
                      ? strengthColor
                      : AppColors.border,
                ),
              ),
            );
          }),
        ),

        AppSpacing.gapXS,

        // Strength Text
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _passwordController.text.isNotEmpty
              ? Row(
                  children: [
                    Icon(
                      _passwordStrength >= 1.0
                          ? Icons.check_circle_outline_rounded
                          : Icons.info_outline_rounded,
                      size: 14,
                      color: strengthColor,
                    ),
                    AppSpacing.gapXXS,
                    Text(
                      'Password strength: $strengthText',
                      style: AppTypography.bodyXS.copyWith(
                        color: strengthColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _acceptTerms = !_acceptTerms);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: _acceptTerms
                  ? AppColors.primaryPurple
                  : Colors.transparent,
              border: Border.all(
                color: _acceptTerms
                    ? AppColors.primaryPurple
                    : AppColors.border,
                width: 2,
              ),
            ),
            child: _acceptTerms
                ? const Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  )
                : null,
          ),
          AppSpacing.gapSM,
          Expanded(
            child: Text.rich(
              TextSpan(
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                children: [
                  const TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.w600,
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

  Widget _buildSignInLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          TextButton(
            onPressed: widget.onNavigateToSignIn,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Sign In',
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
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
                AppSpacing.gapLG,
                Opacity(
                  opacity: _successController.value,
                  child: Text(
                    'Account Created!',
                    style: AppTypography.h3.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
