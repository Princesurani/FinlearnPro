import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_animations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
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
    with SingleTickerProviderStateMixin {
  late final PageController _pageCtrl;
  late final AnimationController _floatCtrl;
  double _currentPage = 0;

  static const _pages = <_PageData>[
    _PageData(
      headline: 'Learn from\nthe Markets',
      body:
          'Expert-crafted courses on stocks, crypto, forex '
          'and real-world investing — no jargon, no fluff.',
      accentColor: AppColors.primaryPurple,
      illustrationType: _IllustType.chart,
    ),
    _PageData(
      headline: 'Practice\nRisk-Free',
      body:
          'Trade with \$100K virtual cash across 4 global markets '
          'powered by our deterministic simulation engine.',
      accentColor: AppColors.oceanTeal,
      illustrationType: _IllustType.wallet,
    ),
    _PageData(
      headline: 'Track Your\nProgress',
      body:
          'XP, streaks, achievements and portfolio analytics — '
          'every lesson and trade builds your financial mastery.',
      accentColor: AppColors.cyan,
      illustrationType: _IllustType.analytics,
    ),
    _PageData(
      headline: 'Compete &\nGrow',
      body:
          'Leaderboards, daily challenges, and a community of '
          'learners pushing each other forward.',
      accentColor: AppColors.warning,
      illustrationType: _IllustType.trophy,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController()
      ..addListener(() {
        setState(() => _currentPage = _pageCtrl.page ?? 0);
      });
    _floatCtrl = AnimationController(
      vsync: this,
      duration: AppAnimations.auroraCycleDuration,
    )..repeat();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    _floatCtrl.dispose();
    super.dispose();
  }

  bool get _isLastPage => _currentPage >= _pages.length - 1 - 0.3;
  int get _activePage => _currentPage.round();

  void _onNext() {
    if (_activePage < _pages.length - 1) {
      _pageCtrl.nextPage(
        duration: AppAnimations.mediumDuration,
        curve: AppAnimations.defaultCurve,
      );
    } else {
      HapticFeedback.mediumImpact();
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final safePad = MediaQuery.of(context).padding;
    final bottomPad = safePad.bottom + AppSpacing.lg;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      body: Stack(
        children: [
          _AnimatedGradient(page: _currentPage, pages: _pages),
          PageView.builder(
            controller: _pageCtrl,
            itemCount: _pages.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => _PageContent(
              data: _pages[index],
              floatAnimation: _floatCtrl,
              parallaxOffset: _currentPage - index,
            ),
          ),
          if (widget.showSkipButton && !_isLastPage)
            Positioned(
              top: safePad.top + AppSpacing.sm,
              right: AppSpacing.md,
              child: TextButton(
                onPressed: widget.onComplete,
                child: Text(
                  'Skip',
                  style: AppTypography.label.copyWith(color: Colors.white38),
                ),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomPad,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PageIndicators(
                  count: _pages.length,
                  currentPage: _currentPage,
                ),
                const SizedBox(height: AppSpacing.xl),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  child: AnimatedSwitcher(
                    duration: AppAnimations.fastDuration,
                    child: _isLastPage
                        ? PrimaryButton(
                            key: const ValueKey('start'),
                            text: 'Get Started',
                            onPressed: _onNext,
                          )
                        : OutlineButton(
                            key: const ValueKey('next'),
                            text: 'Next',
                            onPressed: _onNext,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedGradient extends StatelessWidget {
  const _AnimatedGradient({required this.page, required this.pages});
  final double page;
  final List<_PageData> pages;

  @override
  Widget build(BuildContext context) {
    final i = page.floor().clamp(0, pages.length - 2);
    final t = page - i;
    final a = pages[i].accentColor;
    final b = pages[(i + 1).clamp(0, pages.length - 1)].accentColor;
    final color = Color.lerp(a, b, t) ?? a;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.0, -0.5),
          radius: 1.6,
          colors: [color.withValues(alpha: 0.18), const Color(0xFF0A0A1A)],
        ),
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({
    required this.data,
    required this.floatAnimation,
    required this.parallaxOffset,
  });

  final _PageData data;
  final Animation<double> floatAnimation;
  final double parallaxOffset;

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final safePad = MediaQuery.of(context).padding;
    final illustOffset = parallaxOffset * 60;
    final textOffset = parallaxOffset * 30;

    return Padding(
      padding: EdgeInsets.only(top: safePad.top + AppSpacing.xxl),
      child: Column(
        children: [
          SizedBox(
            height: screenH * 0.42,
            child: Transform.translate(
              offset: Offset(illustOffset, 0),
              child: _AnimatedBuilder(
                animation: floatAnimation,
                builder: (context, _) {
                  final floatY =
                      math.sin(floatAnimation.value * 2 * math.pi) * 6;
                  return Transform.translate(
                    offset: Offset(0, floatY),
                    child: _Illustration(
                      type: data.illustrationType,
                      accent: data.accentColor,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.xl),
          Transform.translate(
            offset: Offset(textOffset, 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                children: [
                  Text(
                    data.headline,
                    textAlign: TextAlign.center,
                    style: AppTypography.display2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    data.body,
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyLarge.copyWith(
                      color: Colors.white54,
                      height: 1.5,
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

class _Illustration extends StatelessWidget {
  const _Illustration({required this.type, required this.accent});
  final _IllustType type;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: switch (type) {
          _IllustType.chart => _ChartIllustrationPainter(accent: accent),
          _IllustType.wallet => _WalletIllustrationPainter(accent: accent),
          _IllustType.analytics => _AnalyticsIllustrationPainter(
            accent: accent,
          ),
          _IllustType.trophy => _TrophyIllustrationPainter(accent: accent),
        },
        size: const Size(280, 280),
      ),
    );
  }
}

class _ChartIllustrationPainter extends CustomPainter {
  _ChartIllustrationPainter({required this.accent});
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawCircle(
      Offset(cx, cy),
      size.width * 0.42,
      Paint()..color = accent.withValues(alpha: 0.08),
    );
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 0.5;
    for (var i = 0; i < 5; i++) {
      final y = cy - size.height * 0.28 + i * size.height * 0.14;
      canvas.drawLine(
        Offset(cx - size.width * 0.32, y),
        Offset(cx + size.width * 0.32, y),
        gridPaint,
      );
    }
    const bars = [
      (0.55, 0.22, true),
      (0.42, 0.26, false),
      (0.48, 0.18, true),
      (0.35, 0.30, true),
      (0.28, 0.20, true),
      (0.22, 0.28, false),
      (0.18, 0.32, true),
    ];
    final barW = size.width * 0.05;
    final startX =
        cx - (bars.length * barW + (bars.length - 1) * barW * 0.8) / 2;

    for (var i = 0; i < bars.length; i++) {
      final (topFrac, heightFrac, isBull) = bars[i];
      final x = startX + i * barW * 1.8 + barW / 2;
      final top = cy - size.height * 0.28 + size.height * topFrac;
      final h = size.height * heightFrac;
      canvas.drawLine(
        Offset(x, top - h * 0.15),
        Offset(x, top + h + h * 0.15),
        Paint()
          ..color = (isBull ? AppColors.success : AppColors.error).withValues(
            alpha: 0.5,
          )
          ..strokeWidth = 1.2,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x - barW / 2, top, barW, h),
          const Radius.circular(2),
        ),
        Paint()
          ..color = isBull ? AppColors.success : AppColors.error
          ..style = PaintingStyle.fill,
      );
    }
    final trendPath = Path();
    for (var i = 0; i < bars.length; i++) {
      final (topFrac, heightFrac, _) = bars[i];
      final x = startX + i * barW * 1.8 + barW / 2;
      final y =
          cy -
          size.height * 0.28 +
          size.height * topFrac +
          size.height * heightFrac * 0.5;
      if (i == 0) {
        trendPath.moveTo(x, y);
      } else {
        trendPath.lineTo(x, y);
      }
    }
    canvas.drawPath(
      trendPath,
      Paint()
        ..color = accent.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _WalletIllustrationPainter extends CustomPainter {
  _WalletIllustrationPainter({required this.accent});
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawCircle(
      Offset(cx, cy),
      size.width * 0.42,
      Paint()..color = accent.withValues(alpha: 0.08),
    );
    final walletRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, cy),
        width: size.width * 0.52,
        height: size.height * 0.36,
      ),
      const Radius.circular(12),
    );
    canvas.drawRRect(
      walletRect,
      Paint()..color = accent.withValues(alpha: 0.25),
    );
    canvas.drawRRect(
      walletRect,
      Paint()
        ..color = accent.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(cx + size.width * 0.22, cy),
          width: size.width * 0.1,
          height: size.height * 0.12,
        ),
        const Radius.circular(4),
      ),
      Paint()..color = accent.withValues(alpha: 0.6),
    );
    final coinPositions = [
      Offset(cx - 40, cy - 50),
      Offset(cx + 30, cy - 65),
      Offset(cx + 55, cy - 35),
    ];
    for (var i = 0; i < coinPositions.length; i++) {
      final r = 14.0 - i * 2;
      canvas.drawCircle(
        coinPositions[i],
        r + 3,
        Paint()..color = Colors.white.withValues(alpha: 0.05),
      );
      canvas.drawCircle(
        coinPositions[i],
        r,
        Paint()..color = accent.withValues(alpha: 0.5 + i * 0.15),
      );
      final tp = TextPainter(
        text: TextSpan(
          text: '\$',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: r,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, coinPositions[i] - Offset(tp.width / 2, tp.height / 2));
      tp.dispose();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AnalyticsIllustrationPainter extends CustomPainter {
  _AnalyticsIllustrationPainter({required this.accent});
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    canvas.drawCircle(
      Offset(cx, cy),
      size.width * 0.42,
      Paint()..color = accent.withValues(alpha: 0.08),
    );
    final barHeights = [0.75, 0.55, 0.90, 0.45, 0.65];
    final barH = size.height * 0.05;
    final maxW = size.width * 0.5;
    final startY = cy - barHeights.length * barH * 1.5 / 2;

    for (var i = 0; i < barHeights.length; i++) {
      final y = startY + i * barH * 1.8;
      final w = maxW * barHeights[i];
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(cx - maxW / 2, y, w, barH),
          Radius.circular(barH / 2),
        ),
        Paint()..color = accent.withValues(alpha: 0.2 + i * 0.12),
      );
    }
    final donutCenter = Offset(cx + size.width * 0.18, cy - size.height * 0.15);
    const donutR = 28.0;
    final segments = [0.35, 0.25, 0.25, 0.15];
    var startAngle = -math.pi / 2;
    final segColors = [
      accent,
      AppColors.success,
      AppColors.warning,
      Colors.white24,
    ];

    for (var i = 0; i < segments.length; i++) {
      final sweep = segments[i] * 2 * math.pi;
      canvas.drawArc(
        Rect.fromCircle(center: donutCenter, radius: donutR),
        startAngle,
        sweep - 0.04,
        false,
        Paint()
          ..color = segColors[i]
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round,
      );
      startAngle += sweep;
    }
    final tp = TextPainter(
      text: TextSpan(
        text: '87%',
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.7),
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontFamily: 'JetBrains Mono',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, donutCenter - Offset(tp.width / 2, tp.height / 2));
    tp.dispose();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrophyIllustrationPainter extends CustomPainter {
  _TrophyIllustrationPainter({required this.accent});
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    canvas.drawCircle(
      Offset(cx, cy),
      size.width * 0.42,
      Paint()..color = accent.withValues(alpha: 0.08),
    );
    final cupPath = Path()
      ..moveTo(cx - 28, cy - 30)
      ..lineTo(cx - 32, cy + 5)
      ..quadraticBezierTo(cx, cy + 22, cx + 32, cy + 5)
      ..lineTo(cx + 28, cy - 30)
      ..close();

    canvas.drawPath(cupPath, Paint()..color = accent.withValues(alpha: 0.4));
    canvas.drawPath(
      cupPath,
      Paint()
        ..color = accent.withValues(alpha: 0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    for (final dx in [-28.0, 28.0]) {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(cx + dx, cy - 10),
          width: 20,
          height: 28,
        ),
        dx < 0 ? math.pi / 2 : -math.pi / 2,
        math.pi,
        false,
        Paint()
          ..color = accent.withValues(alpha: 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy + 25), width: 30, height: 6),
        const Radius.circular(3),
      ),
      Paint()..color = accent.withValues(alpha: 0.6),
    );
    _drawStar(canvas, Offset(cx, cy - 12), 12, accent);
    final sparkles = [
      Offset(cx - 48, cy - 40),
      Offset(cx + 50, cy - 45),
      Offset(cx + 40, cy + 30),
      Offset(cx - 45, cy + 25),
    ];
    for (final p in sparkles) {
      canvas.drawCircle(
        p,
        2.5,
        Paint()..color = accent.withValues(alpha: 0.35),
      );
    }
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Color color) {
    final path = Path();
    for (var i = 0; i < 5; i++) {
      final angle = -math.pi / 2 + i * 4 * math.pi / 5;
      final p =
          center + Offset(math.cos(angle) * radius, math.sin(angle) * radius);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color.withValues(alpha: 0.8));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PageIndicators extends StatelessWidget {
  const _PageIndicators({required this.count, required this.currentPage});
  final int count;
  final double currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final distance = (currentPage - i).abs().clamp(0.0, 1.0);
        final width = ui.lerpDouble(28, 8, distance)!;
        final opacity = ui.lerpDouble(1.0, 0.3, distance)!;

        return AnimatedContainer(
          duration: AppAnimations.fastDuration,
          curve: AppAnimations.defaultCurve,
          width: width,
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: AppSpacing.borderRadiusFull,
            color: Colors.white.withValues(alpha: opacity),
          ),
        );
      }),
    );
  }
}

enum _IllustType { chart, wallet, analytics, trophy }

class _PageData {
  const _PageData({
    required this.headline,
    required this.body,
    required this.accentColor,
    required this.illustrationType,
  });
  final String headline;
  final String body;
  final Color accentColor;
  final _IllustType illustrationType;
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
