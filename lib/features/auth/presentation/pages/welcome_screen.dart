import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_animations.dart';
import '../../../../shared/widgets/aurora_background.dart';
import '../../../../shared/widgets/gradient_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
    required this.onComplete,
    this.showSkipButton = true,
  });

  final VoidCallback onComplete;

  final bool showSkipButton;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _buttonAnimationController;
  late AnimationController _illustrationController;

  int _currentPage = 0;
  double _pageOffset = 0.0;

  final List<_OnboardingPageData> _pages = const [
    _OnboardingPageData(
      title: 'Master Financial\nMarkets',
      subtitle: 'Learn from expertly crafted courses covering stocks, options, crypto, and more.',
      icon: Icons.school_rounded,
      gradient: [Color(0xFF7C5CFF), Color(0xFF6B4EF5)],
      accentColor: Color(0xFF7C5CFF),
    ),
    _OnboardingPageData(
      title: 'Trade Without\nAny Risk',
      subtitle: 'Practice trading with virtual money in our realistic market simulator.',
      icon: Icons.trending_up_rounded,
      gradient: [Color(0xFF00D9B8), Color(0xFF00BFA5)],
      accentColor: Color(0xFF00D9B8),
    ),
    _OnboardingPageData(
      title: 'Track Your\nProgress',
      subtitle: 'Monitor your learning journey with detailed analytics and insights.',
      icon: Icons.insights_rounded,
      gradient: [Color(0xFF3B82F6), Color(0xFF2563EB)],
      accentColor: Color(0xFF3B82F6),
    ),
    _OnboardingPageData(
      title: 'Compete &\nClimb',
      subtitle: 'Earn XP, unlock achievements, and compete on the global leaderboard.',
      icon: Icons.emoji_events_rounded,
      gradient: [Color(0xFFFF8A50), Color(0xFFFF6B8A)],
      accentColor: Color(0xFFFF8A50),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController()
      ..addListener(_onPageScroll);

    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _illustrationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  void _onPageScroll() {
    setState(() {
      _pageOffset = _pageController.page ?? 0.0;
      _currentPage = _pageOffset.round();
    });
  }

  void _nextPage() {
    HapticFeedback.lightImpact();

    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: AppAnimations.mediumDuration,
        curve: AppAnimations.defaultCurve,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    HapticFeedback.mediumImpact();
    widget.onComplete();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _buttonAnimationController.dispose();
    _illustrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Stack(
        children: [
          // Aurora Background
          AuroraBackground(
            intensity: 0.25,
            enableAnimation: true,
          ),

          // Page Content
          SafeArea(
            child: Column(
              children: [
                // Top Bar with Skip Button
                _buildTopBar(),

                // PageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return _OnboardingPage(
                        data: _pages[index],
                        pageOffset: _pageOffset,
                        currentIndex: index,
                        illustrationProgress: _illustrationController,
                      );
                    },
                  ),
                ),

                // Bottom Section
                _buildBottomSection(isLastPage),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.showSkipButton && _currentPage < _pages.length - 1)
            AnimatedOpacity(
              opacity: _currentPage < _pages.length - 1 ? 1.0 : 0.0,
              duration: AppAnimations.fastDuration,
              child: TextButton(
                onPressed: _completeOnboarding,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                ),
                child: Text(
                  'Skip',
                  style: AppTypography.button.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(bool isLastPage) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          // Page Indicators
          _PageIndicators(
            pageCount: _pages.length,
            currentPage: _currentPage,
            pageOffset: _pageOffset,
          ),

          AppSpacing.gapXL,

          // Action Button
          AnimatedSwitcher(
            duration: AppAnimations.fastDuration,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: isLastPage
                ? PrimaryButton(
                    key: const ValueKey('getStarted'),
                    onPressed: _completeOnboarding,
                    text: 'Get Started',
                    size: GradientButtonSize.large,
                    trailingIcon: Icons.arrow_forward_rounded,
                  )
                : OutlineButton(
                    key: const ValueKey('next'),
                    onPressed: _nextPage,
                    text: 'Next',
                    size: GradientButtonSize.large,
                    trailingIcon: Icons.arrow_forward_rounded,
                  ),
          ),

          AppSpacing.gapMD,
        ],
      ),
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.accentColor,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final Color accentColor;
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.data,
    required this.pageOffset,
    required this.currentIndex,
    required this.illustrationProgress,
  });

  final _OnboardingPageData data;
  final double pageOffset;
  final int currentIndex;
  final Animation<double> illustrationProgress;

  @override
  Widget build(BuildContext context) {
    // Calculate parallax effect
    final parallax = pageOffset - currentIndex;
    final isVisible = parallax.abs() <= 1;

    if (!isVisible) {
      return const SizedBox.shrink();
    }

    // Opacity based on distance from center
    final opacity = (1 - parallax.abs()).clamp(0.0, 1.0);

    // Parallax offset for illustration
    final illustrationOffset = parallax * 50;

    // Scale for illustration
    final scale = 1 - (parallax.abs() * 0.2);

    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          children: [
            const Spacer(flex: 1),

            // Illustration Container
            Transform.translate(
              offset: Offset(illustrationOffset, 0),
              child: Transform.scale(
                scale: scale,
                child: _OnboardingIllustration(
                  data: data,
                  animationProgress: illustrationProgress,
                ),
              ),
            ),

            const Spacer(flex: 1),

            // Title
            Transform.translate(
              offset: Offset(illustrationOffset * 0.5, 0),
              child: Text(
                data.title,
                textAlign: TextAlign.center,
                style: AppTypography.h1.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
            ),

            AppSpacing.gapLG,

            // Subtitle
            Transform.translate(
              offset: Offset(illustrationOffset * 0.3, 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  data.subtitle,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

class _OnboardingIllustration extends StatelessWidget {
  const _OnboardingIllustration({
    required this.data,
    required this.animationProgress,
  });

  final _OnboardingPageData data;
  final Animation<double> animationProgress;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationProgress,
      builder: (context, child) {
        final floatOffset = math.sin(animationProgress.value * math.pi) * 8;

        return Transform.translate(
          offset: Offset(0, floatOffset),
          child: child,
        );
      },
      child: Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              data.gradient[0].withAlpha((0.15 * 255).round()),
              data.gradient[1].withAlpha((0.05 * 255).round()),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: data.accentColor.withAlpha((0.2 * 255).round()),
              blurRadius: 60,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer ring
            _AnimatedRing(
              size: 260,
              color: data.accentColor.withAlpha((0.1 * 255).round()),
              animation: animationProgress,
            ),

            // Middle ring
            _AnimatedRing(
              size: 200,
              color: data.accentColor.withAlpha((0.15 * 255).round()),
              animation: animationProgress,
              reverse: true,
            ),

            // Inner gradient circle
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: data.gradient,
                ),
                boxShadow: [
                  BoxShadow(
                    color: data.accentColor.withAlpha((0.4 * 255).round()),
                    blurRadius: 30,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                data.icon,
                size: 64,
                color: Colors.white,
              ),
            ),

            // Floating particles
            ..._buildFloatingParticles(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFloatingParticles() {
    return List.generate(6, (index) {
      final angle = (index / 6) * 2 * math.pi;
      final radius = 100.0 + (index % 2) * 20;

      return AnimatedBuilder(
        animation: animationProgress,
        builder: (context, child) {
          final progress = animationProgress.value;
          final particleAngle = angle + progress * math.pi * 0.5;

          return Positioned(
            left: 140 + math.cos(particleAngle) * radius - 4,
            top: 140 + math.sin(particleAngle) * radius - 4,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data.accentColor.withAlpha(((0.3 + (index % 3) * 0.2) * 255).round()),
              ),
            ),
          );
        },
      );
    });
  }
}

class _AnimatedRing extends StatelessWidget {
  const _AnimatedRing({
    required this.size,
    required this.color,
    required this.animation,
    this.reverse = false,
  });

  final double size;
  final Color color;
  final Animation<double> animation;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final rotation = animation.value * math.pi * 2;
        return Transform.rotate(
          angle: reverse ? -rotation : rotation,
          child: child,
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: CustomPaint(
          painter: _DashedCirclePainter(color: color),
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  _DashedCirclePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Draw small dots around the circle
    for (int i = 0; i < 12; i++) {
      final angle = (i / 12) * 2 * math.pi;
      final x = center.dx + math.cos(angle) * radius;
      final y = center.dy + math.sin(angle) * radius;
      canvas.drawCircle(Offset(x, y), 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PageIndicators extends StatelessWidget {
  const _PageIndicators({
    required this.pageCount,
    required this.currentPage,
    required this.pageOffset,
  });

  final int pageCount;
  final int currentPage;
  final double pageOffset;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        // Calculate indicator state based on continuous offset
        final distance = (pageOffset - index).abs();
        final isActive = distance < 0.5;

        // Width interpolation
        final width = isActive
            ? 32.0 - (distance * 2 * 24) // Active indicator is wider
            : 8.0;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: width.clamp(8.0, 32.0),
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive
                ? AppColors.primaryPurple
                : AppColors.border,
          ),
        );
      }),
    );
  }
}
