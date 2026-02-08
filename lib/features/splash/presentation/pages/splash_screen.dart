import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

typedef SplashCompleteCallback = void Function();

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.onComplete,
    this.minimumDuration = const Duration(milliseconds: 4200),
  });

  final SplashCompleteCallback onComplete;

  final Duration minimumDuration;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _master;

  static const _actII = Interval(0.08, 0.40, curve: Curves.easeInOut);
  static const _actIIILine = Interval(0.35, 0.62, curve: Curves.easeInOutCubic);
  static const _actIVLogo = Interval(0.58, 0.72, curve: Curves.easeOutBack);
  static const _actIVText = Interval(0.66, 0.78, curve: Curves.easeOutCubic);
  static const _actIVPro = Interval(0.72, 0.82, curve: Curves.elasticOut);
  static const _actIVTagline = Interval(0.78, 0.88, curve: Curves.easeOut);
  static const _actIVPulse = Interval(0.82, 0.95, curve: Curves.easeOut);
  static const _exit = Interval(0.92, 1.00, curve: Curves.easeInCubic);

  late final List<_DataColumn> _dataColumns;

  late final DateTime _mountedAt;

  @override
  void initState() {
    super.initState();
    _mountedAt = DateTime.now();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _generateDataColumns();

    _master = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..addStatusListener(_onMasterStatus);

    _master.forward();
  }

  void _generateDataColumns() {
    final rng = math.Random(42);
    const symbols = [
      'AAPL',
      'TSLA',
      'GOOG',
      'MSFT',
      'AMZN',
      'META',
      'NVDA',
      'NFLX',
      'BTC',
      'ETH',
      'SPY',
      'QQQ',
      'RELIANCE',
      'TCS',
      'INFY',
      'HDFC',
      'VOD.L',
      'BARC.L',
      'AZN.L',
      'SHEL.L',
      'JPM',
      'GS',
      'V',
      'MA',
      'DIS',
      'PYPL',
      'AMD',
      'BABA',
    ];
    _dataColumns = List.generate(28, (i) {
      final speed = 0.4 + rng.nextDouble() * 0.8;
      final offset = rng.nextDouble();
      final entries = List.generate(12 + rng.nextInt(8), (_) {
        final sym = symbols[rng.nextInt(symbols.length)];
        final price = (10 + rng.nextDouble() * 990).toStringAsFixed(2);
        final pct = ((rng.nextDouble() - 0.5) * 20).toStringAsFixed(2);
        final positive = !pct.startsWith('-');
        return _DataEntry(
          text: rng.nextBool() ? sym : '\$$price',
          subtext: '${positive ? '+' : ''}$pct%',
          isPositive: positive,
        );
      });
      return _DataColumn(
        xFraction: (i + 0.5) / 28,
        speed: speed,
        startOffset: offset,
        entries: entries,
      );
    });
  }

  void _onMasterStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;

    final elapsed = DateTime.now().difference(_mountedAt);
    final remaining = widget.minimumDuration - elapsed;
    if (remaining > Duration.zero) {
      Future.delayed(remaining, _fireComplete);
    } else {
      _fireComplete();
    }
  }

  void _fireComplete() {
    if (!mounted) return;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    widget.onComplete();
  }

  @override
  void dispose() {
    _master.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050510),
      body: _AnimatedBuilder(
        animation: _master,
        builder: (context, _) {
          final t = _master.value;
          return Stack(
            fit: StackFit.expand,
            children: [
              _buildBackground(t),

              RepaintBoundary(
                child: CustomPaint(
                  painter: _DataRainPainter(
                    progress: _actII.transform(t),
                    columns: _dataColumns,
                    convergence: _actIIILine.transform(t),
                  ),
                  size: Size.infinite,
                ),
              ),

              RepaintBoundary(
                child: CustomPaint(
                  painter: _ChartLinePainter(
                    drawProgress: _actIIILine.transform(t),
                    fadeOut: _actIVLogo.transform(t),
                    accentColor: AppColors.primaryPurple,
                    glowColor: AppColors.cyan,
                  ),
                  size: Size.infinite,
                ),
              ),

              _buildIdentity(t),

              RepaintBoundary(
                child: CustomPaint(
                  painter: _RadialPulsePainter(
                    progress: _actIVPulse.transform(t),
                    color: AppColors.primaryPurple,
                  ),
                  size: Size.infinite,
                ),
              ),

              if (_exit.transform(t) > 0)
                Opacity(
                  opacity: _exit.transform(t),
                  child: const ColoredBox(
                    color: Color(0xFF050510),
                    child: SizedBox.expand(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackground(double t) {
    final auroraOpacity = (t > 0.15 && t < 0.85)
        ? math.sin((t - 0.15) / 0.70 * math.pi) * 0.12
        : 0.0;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.4,
          colors: [
            AppColors.primaryPurple.withValues(alpha: auroraOpacity),
            const Color(0xFF050510),
          ],
        ),
      ),
      child: const SizedBox.expand(),
    );
  }

  Widget _buildIdentity(double t) {
    final logoProgress = _actIVLogo.transform(t);
    final textProgress = _actIVText.transform(t);
    final proProgress = _actIVPro.transform(t);
    final tagProgress = _actIVTagline.transform(t);

    if (logoProgress == 0) return const SizedBox.shrink();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: logoProgress,
            child: Opacity(
              opacity: logoProgress.clamp(0.0, 1.0),
              child: const _BrandIcon(size: 72),
            ),
          ),

          SizedBox(height: AppSpacing.md * logoProgress),

          ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: textProgress.clamp(0.0, 1.0),
              child: Opacity(
                opacity: textProgress.clamp(0.0, 1.0),
                child: Text(
                  'FINLEARN',
                  style: AppTypography.display1.copyWith(
                    color: Colors.white,
                    letterSpacing: 6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 4),

          Transform.scale(
            scale: proProgress.clamp(0.0, 1.2),
            child: Opacity(
              opacity: proProgress.clamp(0.0, 1.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: AppSpacing.borderRadiusFull,
                ),
                child: Text(
                  'PRO',
                  style: AppTypography.labelSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: AppSpacing.lg * tagProgress),

          Opacity(
            opacity: tagProgress.clamp(0.0, 1.0),
            child: Transform.translate(
              offset: Offset(0, 8 * (1 - tagProgress)),
              child: Text(
                'Master the Markets. Zero Risk.',
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.white54,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandIcon extends StatelessWidget {
  const _BrandIcon({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(size * 0.24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withValues(alpha: 0.4),
            blurRadius: 32,
            spreadRadius: 4,
          ),
        ],
      ),
      child: CustomPaint(painter: _CandlestickIconPainter()),
    );
  }
}

class _CandlestickIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final barW = w * 0.08;
    final gap = w * 0.12;
    final startX = (w - (4 * barW + 3 * gap)) / 2;
    final paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round;

    const bars = [
      (0.55, 0.30, true),
      (0.40, 0.60, false),
      (0.25, 0.45, true),
      (0.20, 0.68, true),
    ];

    for (var i = 0; i < bars.length; i++) {
      final (top, height, isBull) = bars[i];
      final x = startX + i * (barW + gap) + barW / 2;
      final y1 = h * top;
      final y2 = h * (top + height);

      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = Colors.white70;
      canvas.drawLine(
        Offset(x, y1 - h * 0.06),
        Offset(x, y2 + h * 0.06),
        paint,
      );

      paint
        ..style = isBull ? PaintingStyle.fill : PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = Colors.white;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x - barW / 2, y1, barW, y2 - y1),
          const Radius.circular(2),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DataRainPainter extends CustomPainter {
  _DataRainPainter({
    required this.progress,
    required this.columns,
    required this.convergence,
  });

  final double progress;
  final List<_DataColumn> columns;
  final double convergence;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final fadeIn = (progress * 4).clamp(0.0, 1.0);
    final fadeOut = progress > 0.8 ? ((progress - 0.8) / 0.2) : 0.0;
    final opacity = (fadeIn - fadeOut).clamp(0.0, 1.0);
    if (opacity <= 0) return;

    for (final col in columns) {
      final baseX = col.xFraction * size.width;
      final cx = size.width / 2;
      final x = ui.lerpDouble(baseX, cx, convergence * 0.6)!;

      final scrollOffset =
          (progress * col.speed + col.startOffset) * size.height * 3;

      for (var i = 0; i < col.entries.length; i++) {
        final entry = col.entries[i];
        final y = (i * 48.0 - scrollOffset) % (col.entries.length * 48.0);
        if (y < -30 || y > size.height + 30) continue;

        final distFromCenter = (x - cx).abs() / (size.width / 2);
        final alpha = opacity * (0.15 + 0.25 * (1 - distFromCenter));

        final tp = TextPainter(
          text: TextSpan(
            text: entry.text,
            style: TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 11,
              color: (entry.isPositive ? AppColors.success : AppColors.error)
                  .withValues(alpha: alpha),
              fontWeight: FontWeight.w500,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        tp.paint(canvas, Offset(x - tp.width / 2, y));
        tp.dispose();
      }
    }
  }

  @override
  bool shouldRepaint(_DataRainPainter old) =>
      old.progress != progress || old.convergence != convergence;
}

class _ChartLinePainter extends CustomPainter {
  _ChartLinePainter({
    required this.drawProgress,
    required this.fadeOut,
    required this.accentColor,
    required this.glowColor,
  });

  final double drawProgress;
  final double fadeOut;
  final Color accentColor;
  final Color glowColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (drawProgress <= 0) return;

    final opacity = (1.0 - fadeOut).clamp(0.0, 1.0);
    if (opacity <= 0) return;

    final path = Path();
    const segments = 60;
    final rng = math.Random(7);

    for (var i = 0; i <= segments; i++) {
      final t = i / segments;
      final x = t * size.width;
      final trend = size.height * 0.7 - t * size.height * 0.4;
      final noise = (rng.nextDouble() - 0.5) * size.height * 0.08;
      final y = trend + noise;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevX = (i - 1) / segments * size.width;
        final cpX = (prevX + x) / 2;
        path.quadraticBezierTo(cpX, y + noise * 0.3, x, y);
      }
    }

    final metrics = path.computeMetrics().first;
    final visibleLength = metrics.length * drawProgress;
    final visible = metrics.extractPath(0, visibleLength);

    canvas.drawPath(
      visible,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..color = glowColor.withValues(alpha: 0.15 * opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );

    canvas.drawPath(
      visible,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..color = accentColor.withValues(alpha: 0.8 * opacity),
    );

    if (drawProgress > 0.01 && drawProgress < 0.99) {
      final tangent = metrics.getTangentForOffset(visibleLength);
      if (tangent != null) {
        canvas.drawCircle(
          tangent.position,
          5,
          Paint()..color = Colors.white.withValues(alpha: opacity),
        );
        canvas.drawCircle(
          tangent.position,
          12,
          Paint()
            ..color = glowColor.withValues(alpha: 0.25 * opacity)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_ChartLinePainter old) =>
      old.drawProgress != drawProgress || old.fadeOut != fadeOut;
}

class _RadialPulsePainter extends CustomPainter {
  _RadialPulsePainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || progress >= 1) return;

    final center = size.center(Offset.zero);
    final maxR = size.longestSide * 0.8;
    final r = maxR * progress;
    final alpha = 0.18 * (1 - progress);

    canvas.drawCircle(
      center,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = color.withValues(alpha: alpha),
    );

    if (progress > 0.15) {
      final r2 = maxR * (progress - 0.15);
      canvas.drawCircle(
        center,
        r2,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = color.withValues(alpha: alpha * 0.5),
      );
    }
  }

  @override
  bool shouldRepaint(_RadialPulsePainter old) => old.progress != progress;
}

class _DataColumn {
  const _DataColumn({
    required this.xFraction,
    required this.speed,
    required this.startOffset,
    required this.entries,
  });

  final double xFraction;

  final double speed;

  final double startOffset;

  final List<_DataEntry> entries;
}

class _DataEntry {
  const _DataEntry({
    required this.text,
    required this.subtext,
    required this.isPositive,
  });
  final String text;
  final String subtext;
  final bool isPositive;
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
