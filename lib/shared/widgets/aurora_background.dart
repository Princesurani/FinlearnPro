import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_animations.dart';

class AuroraBackground extends StatefulWidget {
  const AuroraBackground({
    super.key,
    this.intensity = 0.6,
    this.enableAnimation = true,
    this.customColors,
  });

  final double intensity;

  final bool enableAnimation;

  final List<Color>? customColors;

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with TickerProviderStateMixin {
  late AnimationController _primaryController;

  late AnimationController _secondaryController;

  late AnimationController _tertiaryController;

  double _primaryProgress = 0.0;

  double _secondaryProgress = 0.0;

  double _tertiaryProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _primaryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8000),
    );

    _secondaryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    );

    _tertiaryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _primaryController.addListener(_onPrimaryAnimation);
    _secondaryController.addListener(_onSecondaryAnimation);
    _tertiaryController.addListener(_onTertiaryAnimation);

    if (widget.enableAnimation) {
      _primaryController.repeat();
      _secondaryController.repeat();
      _tertiaryController.repeat();
    }
  }

  void _onPrimaryAnimation() {
    setState(() {
      _primaryProgress = _primaryController.value;
    });
  }

  void _onSecondaryAnimation() {
    setState(() {
      _secondaryProgress = _secondaryController.value;
    });
  }

  void _onTertiaryAnimation() {
    setState(() {
      _tertiaryProgress = _tertiaryController.value;
    });
  }

  @override
  void dispose() {
    _primaryController.removeListener(_onPrimaryAnimation);
    _secondaryController.removeListener(_onSecondaryAnimation);
    _tertiaryController.removeListener(_onTertiaryAnimation);
    _primaryController.dispose();
    _secondaryController.dispose();
    _tertiaryController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AuroraBackground oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.enableAnimation != oldWidget.enableAnimation) {
      if (widget.enableAnimation) {
        _primaryController.repeat();
        _secondaryController.repeat();
        _tertiaryController.repeat();
      } else {
        _primaryController.stop();
        _secondaryController.stop();
        _tertiaryController.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _AuroraPainter(
          primaryProgress: _primaryProgress,
          secondaryProgress: _secondaryProgress,
          tertiaryProgress: _tertiaryProgress,
          intensity: widget.intensity,
          customColors: widget.customColors,
        ),
        size: Size.infinite,
        isComplex: true,
        willChange: widget.enableAnimation,
      ),
    );
  }
}

class _AuroraPainter extends CustomPainter {
  _AuroraPainter({
    required this.primaryProgress,
    required this.secondaryProgress,
    required this.tertiaryProgress,
    required this.intensity,
    this.customColors,
  });

  final double primaryProgress;
  final double secondaryProgress;
  final double tertiaryProgress;
  final double intensity;
  final List<Color>? customColors;

  late final List<Color> _auroraColors = customColors ?? [
    AppColors.auroraPurple,
    AppColors.auroraBlue,
    AppColors.auroraCyan,
    AppColors.auroraPink,
    AppColors.auroraTeal,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    _drawBaseBackground(canvas, size);

    _drawAuroraLayer(
      canvas,
      size,
      progress: primaryProgress,
      colors: [
        _auroraColors[0].withOpacity(0.15 * intensity),
        _auroraColors[1].withOpacity(0.1 * intensity),
      ],
      waveAmplitude: 0.15,
      waveFrequency: 1.5,
      verticalOffset: 0.2,
      blur: 80,
    );

    _drawAuroraLayer(
      canvas,
      size,
      progress: secondaryProgress,
      colors: [
        _auroraColors[2].withOpacity(0.12 * intensity),
        _auroraColors[4].withOpacity(0.08 * intensity),
      ],
      waveAmplitude: 0.12,
      waveFrequency: 2.0,
      verticalOffset: 0.35,
      blur: 60,
    );

    _drawAuroraLayer(
      canvas,
      size,
      progress: tertiaryProgress,
      colors: [
        _auroraColors[3].withOpacity(0.1 * intensity),
        _auroraColors[0].withOpacity(0.06 * intensity),
      ],
      waveAmplitude: 0.08,
      waveFrequency: 2.5,
      verticalOffset: 0.15,
      blur: 40,
    );

    _drawNoiseOverlay(canvas, size);

    _drawVignette(canvas, size);
  }

  void _drawBaseBackground(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(0, size.height),
        [
          AppColors.backgroundPrimary,
          const Color(0xFFF1F5F9),
        ],
      );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  void _drawAuroraLayer(
    Canvas canvas,
    Size size, {
    required double progress,
    required List<Color> colors,
    required double waveAmplitude,
    required double waveFrequency,
    required double verticalOffset,
    required double blur,
  }) {
    final path = Path();
    final paint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur)
      ..style = PaintingStyle.fill;

    final animPhase = progress * 2 * math.pi;
    path.moveTo(0, size.height);

    const int segments = 100;
    for (int i = 0; i <= segments; i++) {
      final x = (i / segments) * size.width;
      final normalizedX = i / segments;

      final wave1 = math.sin(normalizedX * waveFrequency * math.pi + animPhase);
      final wave2 = math.sin(
        normalizedX * waveFrequency * 1.5 * math.pi + animPhase * 0.7,
      ) * 0.5;
      final wave3 = math.sin(
        normalizedX * waveFrequency * 2.5 * math.pi + animPhase * 1.3,
      ) * 0.25;

      final combinedWave = (wave1 + wave2 + wave3) / 1.75;
      final y = size.height * verticalOffset +
          combinedWave * size.height * waveAmplitude;

      if (i == 0) {
        path.lineTo(x, y);
      } else {
        final prevX = ((i - 1) / segments) * size.width;
        final controlX = (prevX + x) / 2;
        path.quadraticBezierTo(controlX, y, x, y);
      }
    }

    path.lineTo(size.width, size.height);
    path.close();

    paint.shader = ui.Gradient.linear(
      Offset(0, size.height * verticalOffset - size.height * waveAmplitude),
      Offset(0, size.height * verticalOffset + size.height * waveAmplitude),
      colors,
      [0.0, 1.0],
    );

    canvas.drawPath(path, paint);
  }


  void _drawNoiseOverlay(Canvas canvas, Size size) {
    final random = math.Random(42);
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.02 * intensity)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height * 0.5;
      final radius = random.nextDouble() * 2 + 1;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  void _drawVignette(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..shader = ui.Gradient.radial(
        Offset(size.width / 2, size.height * 0.3),
        size.width * 0.8,
        [
          Colors.transparent,
          Colors.white.withOpacity(0.05 * intensity),
        ],
        [0.5, 1.0],
      );

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(_AuroraPainter oldDelegate) {
    return primaryProgress != oldDelegate.primaryProgress ||
        secondaryProgress != oldDelegate.secondaryProgress ||
        tertiaryProgress != oldDelegate.tertiaryProgress ||
        intensity != oldDelegate.intensity;
  }
}

class StaticAuroraGradient extends StatelessWidget {
  const StaticAuroraGradient({
    super.key,
    this.intensity = 0.4,
  });

  final double intensity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.backgroundPrimary,
            AppColors.auroraPurple.withOpacity(0.05 * intensity),
            AppColors.auroraBlue.withOpacity(0.03 * intensity),
            AppColors.backgroundPrimary,
          ],
          stops: const [0.0, 0.3, 0.6, 1.0],
        ),
      ),
    );
  }
}

class AuroraOrb extends StatefulWidget {
  const AuroraOrb({
    super.key,
    this.size = 200,
    this.color,
    this.pulseIntensity = 0.2,
  });

  final double size;
  final Color? color;
  final double pulseIntensity;

  @override
  State<AuroraOrb> createState() => _AuroraOrbState();
}

class _AuroraOrbState extends State<AuroraOrb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0 - widget.pulseIntensity,
      end: 1.0 + widget.pulseIntensity,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: AppAnimations.breatheCurve,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.auroraPurple;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color.withOpacity(0.4),
                  color.withOpacity(0.1),
                  color.withOpacity(0.0),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: widget.size * 0.5,
                  spreadRadius: widget.size * 0.1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
