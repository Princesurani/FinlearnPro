import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/aurora_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.onComplete,
    this.minimumDuration = const Duration(milliseconds: 3500),
  });

  final VoidCallback onComplete;

  final Duration minimumDuration;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _backgroundController;
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _taglineController;
  late AnimationController _progressController;
  late AnimationController _exitController;
  late AnimationController _particleController;
  late AnimationController _pulseController;

  late Animation<double> _backgroundOpacity;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _taglineOpacity;
  late Animation<double> _progressOpacity;
  late Animation<double> _progressValue;
  late Animation<double> _exitScale;
  late Animation<double> _exitOpacity;

  bool _isExiting = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeAnimations();
    _startAnimationSequence();

    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  void _initializeControllers() {
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  void _initializeAnimations() {
    // Background fade-in
    _backgroundOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _backgroundController,
        curve: Curves.easeOut,
      ),
    );

    // Logo scale with spring
    _logoScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.elasticOut,
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    // Text slide and fade
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeOut,
      ),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Tagline fade
    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _taglineController,
        curve: Curves.easeOut,
      ),
    );

    // Progress indicator
    _progressOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
      ),
    );

    _progressValue = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: const Interval(0.1, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Exit transition
    _exitScale = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _exitController,
        curve: Curves.easeInCubic,
      ),
    );

    _exitOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _exitController,
        curve: Curves.easeIn,
      ),
    );
  }

  Future<void> _startAnimationSequence() async {
    // Phase A: Background (0-800ms)
    await Future.delayed(const Duration(milliseconds: 100));
    _backgroundController.forward();
    _particleController.forward();

    // Phase B: Logo (300-1300ms)
    await Future.delayed(const Duration(milliseconds: 200));
    _logoController.forward();

    // Phase C: Brand Text (800-1600ms)
    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();

    // Phase D: Tagline (1200-1800ms)
    await Future.delayed(const Duration(milliseconds: 400));
    _taglineController.forward();

    // Phase E: Progress (1400-2900ms)
    await Future.delayed(const Duration(milliseconds: 200));
    _progressController.forward();

    // Wait for minimum duration
    await Future.delayed(const Duration(milliseconds: 1000));

    // Phase F: Exit transition
    _startExitTransition();
  }

  void _startExitTransition() {
    if (_isExiting) return;
    setState(() => _isExiting = true);

    HapticFeedback.mediumImpact();

    _exitController.forward().then((_) {
      widget.onComplete();
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _logoController.dispose();
    _textController.dispose();
    _taglineController.dispose();
    _progressController.dispose();
    _exitController.dispose();
    _particleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: AnimatedBuilder(
        animation: Listenable.merge([_exitController]),
        builder: (context, child) {
          return Opacity(
            opacity: _exitOpacity.value,
            child: Transform.scale(
              scale: _exitScale.value,
              child: child,
            ),
          );
        },
        child: Stack(
          children: [
            // Aurora Background
            AnimatedBuilder(
              animation: _backgroundOpacity,
              builder: (context, child) {
                return Opacity(
                  opacity: _backgroundOpacity.value,
                  child: const AuroraBackground(
                    intensity: 0.4,
                    enableAnimation: true,
                  ),
                );
              },
            ),

            // Particle Effect Layer
            AnimatedBuilder(
              animation: _particleController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _ParticlePainter(
                    progress: _particleController.value,
                    logoProgress: _logoController.value,
                  ),
                  size: Size.infinite,
                );
              },
            ),

            // Main Content
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),

                    // Logo Container with Glow
                    _buildAnimatedLogo(),

                    AppSpacing.gapXL,

                    // Brand Name
                    _buildBrandText(),

                    AppSpacing.gapMD,

                    // Tagline
                    _buildTagline(),

                    const Spacer(flex: 2),

                    // Progress Indicator
                    _buildProgressIndicator(),

                    AppSpacing.gapXXL,

                    // Version & Credits
                    _buildVersionInfo(),

                    AppSpacing.gapXL,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: Listenable.merge([_logoController, _pulseController]),
      builder: (context, child) {
        final pulseValue = 1.0 + (_pulseController.value * 0.02);
        return Transform.scale(
          scale: _logoScale.value * pulseValue,
          child: Opacity(
            opacity: _logoOpacity.value,
            child: child,
          ),
        );
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF7C5CFF),
              Color(0xFF6B4EF5),
              Color(0xFF5038D4),
            ],
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPurple.withAlpha((0.4 * 255).round()),
              blurRadius: 40,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: AppColors.primaryPurple.withAlpha((0.2 * 255).round()),
              blurRadius: 80,
              spreadRadius: 0,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Inner glow
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withAlpha((0.2 * 255).round()),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Logo Icon
            const _AnimatedLogoIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandText() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return SlideTransition(
          position: _textSlide,
          child: Opacity(
            opacity: _textOpacity.value,
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color(0xFF1E293B),
                Color(0xFF334155),
              ],
            ).createShader(bounds),
            child: Text(
              'FINLEARN',
              style: AppTypography.display2.copyWith(
                letterSpacing: 8,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'PRO',
                style: AppTypography.h4.copyWith(
                  color: Colors.white,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagline() {
    return AnimatedBuilder(
      animation: _taglineController,
      builder: (context, child) {
        return Opacity(
          opacity: _taglineOpacity.value,
          child: child,
        );
      },
      child: Text(
        'Master the Markets',
        style: AppTypography.bodyLarge.copyWith(
          color: AppColors.textSecondary,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        return Opacity(
          opacity: _progressOpacity.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              children: [
                // Progress Bar
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Stack(
                    children: [
                      // Progress Fill
                      FractionallySizedBox(
                        widthFactor: _progressValue.value,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      // Shimmer Overlay
                      if (_progressValue.value > 0 && _progressValue.value < 1)
                        Positioned.fill(
                          child: _ShimmerOverlay(
                            progress: _progressValue.value,
                          ),
                        ),
                    ],
                  ),
                ),
                AppSpacing.gapSM,
                // Loading Text
                Text(
                  _getLoadingText(),
                  style: AppTypography.bodyXS.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getLoadingText() {
    final progress = _progressValue.value;
    if (progress < 0.3) return 'Initializing...';
    if (progress < 0.6) return 'Loading resources...';
    if (progress < 0.9) return 'Almost ready...';
    return 'Welcome!';
  }

  Widget _buildVersionInfo() {
    return AnimatedBuilder(
      animation: _taglineController,
      builder: (context, child) {
        return Opacity(
          opacity: _taglineOpacity.value * 0.7,
          child: child,
        );
      },
      child: Column(
        children: [
          Text(
            'v1.0.0',
            style: AppTypography.bodyXS.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          AppSpacing.gapXXS,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Made with ',
                style: AppTypography.bodyXS.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              const Icon(
                Icons.favorite,
                size: 12,
                color: AppColors.coralPink,
              ),
              Text(
                ' for learners',
                style: AppTypography.bodyXS.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedLogoIcon extends StatelessWidget {
  const _AnimatedLogoIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(60, 60),
      painter: _LogoIconPainter(),
    );
  }
}

class _LogoIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Draw ascending chart line
    final path = Path();
    path.moveTo(size.width * 0.15, size.height * 0.75);
    path.lineTo(size.width * 0.35, size.height * 0.55);
    path.lineTo(size.width * 0.5, size.height * 0.65);
    path.lineTo(size.width * 0.85, size.height * 0.25);

    canvas.drawPath(path, strokePaint);

    // Draw arrow head
    final arrowPath = Path();
    arrowPath.moveTo(size.width * 0.85, size.height * 0.25);
    arrowPath.lineTo(size.width * 0.7, size.height * 0.28);
    arrowPath.moveTo(size.width * 0.85, size.height * 0.25);
    arrowPath.lineTo(size.width * 0.82, size.height * 0.4);

    canvas.drawPath(arrowPath, strokePaint);

    // Draw dots at data points
    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.55),
      4,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.65),
      4,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({
    required this.progress,
    required this.logoProgress,
  });

  final double progress;
  final double logoProgress;

  final int particleCount = 30;

  @override
  void paint(Canvas canvas, Size size) {
    if (logoProgress < 0.1) return;

    final random = math.Random(42);
    final center = Offset(size.width / 2, size.height * 0.35);

    for (int i = 0; i < particleCount; i++) {
      final angle = (i / particleCount) * 2 * math.pi;
      final baseRadius = 80.0 + random.nextDouble() * 60;

      // Particles converge toward center as logo appears
      final radius = baseRadius * (1 - logoProgress * 0.8);

      final x = center.dx + math.cos(angle + progress * 2) * radius;
      final y = center.dy + math.sin(angle + progress * 2) * radius;

      final opacity = (1 - logoProgress) * 0.6;
      final particleSize = 2.0 + random.nextDouble() * 3;

      final paint = Paint()
        ..color = AppColors.primaryPurple.withAlpha((opacity * 255).round())
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), particleSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) =>
      progress != oldDelegate.progress ||
      logoProgress != oldDelegate.logoProgress;
}

class _ShimmerOverlay extends StatefulWidget {
  const _ShimmerOverlay({required this.progress});

  final double progress;

  @override
  State<_ShimmerOverlay> createState() => _ShimmerOverlayState();
}

class _ShimmerOverlayState extends State<_ShimmerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.transparent,
                Colors.white.withAlpha((0.3 * 255).round()),
                Colors.transparent,
              ],
              stops: [
                (_shimmerController.value - 0.3).clamp(0.0, 1.0),
                _shimmerController.value,
                (_shimmerController.value + 0.3).clamp(0.0, 1.0),
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      },
    );
  }
}
