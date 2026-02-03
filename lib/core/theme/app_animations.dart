import 'package:flutter/material.dart';

abstract final class AppAnimations {
  static const Duration microDuration = Duration(milliseconds: 100);

  static const Duration fastDuration = Duration(milliseconds: 200);

  static const Duration mediumDuration = Duration(milliseconds: 300);

  static const Duration slowDuration = Duration(milliseconds: 400);

  static const Duration emphasisDuration = Duration(milliseconds: 500);

  static const Duration pageTransitionDuration = Duration(milliseconds: 350);

  static const Duration staggerDelay = Duration(milliseconds: 50);

  static const Duration longDuration = Duration(milliseconds: 800);

  static const Duration extraLongDuration = Duration(milliseconds: 1500);

  static const Duration auroraCycleDuration = Duration(milliseconds: 4000);

  static const Duration infiniteLoopDuration = Duration(milliseconds: 8000);

  static const Curve defaultCurve = Curves.easeOutCubic;

  static const Curve entranceCurve = Curves.easeOutQuart;

  static const Curve exitCurve = Curves.easeInCubic;

  static const Curve emphasisCurve = Curves.elasticOut;

  static const Curve overshootCurve = Curves.easeOutBack;

  static const Curve smoothCurve = Curves.easeInOutSine;

  static const Curve decelerateCurve = Curves.decelerate;

  static const Curve accelerateCurve = Curves.easeIn;

  static const Curve springCurve = Curves.elasticOut;

  static const Curve bounceCurve = Curves.bounceOut;

  static const Curve sharpCurve = Curves.easeOutExpo;

  static const Curve breatheCurve = Curves.easeInOutSine;

  static const double pressedScale = 0.96;

  static const double hoverScale = 1.02;

  static const double emphasisScale = 1.05;

  static const double entryScale = 0.8;

  static const double subtleScale = 0.98;

  static const Offset slideFromBottom = Offset(0.0, 0.3);

  static const Offset slideFromTop = Offset(0.0, -0.3);

  static const Offset slideFromLeft = Offset(-0.3, 0.0);

  static const Offset slideFromRight = Offset(0.3, 0.0);

  static const Offset subtleSlide = Offset(0.0, 0.1);

  static Duration staggeredDelay(int index, [Duration? baseDelay]) {
    final base = baseDelay ?? Duration.zero;
    return base + Duration(milliseconds: 50 * index);
  }

  static Interval staggeredInterval(
    int index,
    int totalItems, {
    double overlapFactor = 0.4,
  }) {
    final double itemDuration = 1.0 / totalItems;
    final double adjustedDuration = itemDuration * (1 + overlapFactor);
    final double start = (index * itemDuration * (1 - overlapFactor))
        .clamp(0.0, 1.0 - adjustedDuration);
    final double end = (start + adjustedDuration).clamp(0.0, 1.0);
    return Interval(start, end, curve: entranceCurve);
  }

  static String courseHeroTag(String courseId) => 'course_hero_$courseId';

  static String categoryHeroTag(String categoryId) =>
      'category_hero_$categoryId';

  static String lessonHeroTag(String lessonId) => 'lesson_hero_$lessonId';

  static Animation<double> buildFadeAnimation(
    AnimationController controller, {
    double begin = 0.0,
    double end = 1.0,
    Curve curve = entranceCurve,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  static Animation<Offset> buildSlideAnimation(
    AnimationController controller, {
    Offset begin = slideFromBottom,
    Offset end = Offset.zero,
    Curve curve = entranceCurve,
  }) {
    return Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  static Animation<double> buildScaleAnimation(
    AnimationController controller, {
    double begin = entryScale,
    double end = 1.0,
    Curve curve = overshootCurve,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }
}

extension AnimationControllerExtensions on AnimationController {
  Future<void> playForward({Duration? delay}) async {
    if (delay != null) {
      await Future.delayed(delay);
    }
    forward();
  }

  Future<void> playReverse({Duration? delay}) async {
    if (delay != null) {
      await Future.delayed(delay);
    }
    reverse();
  }

  void resetAndPlay() {
    reset();
    forward();
  }
}

class StaggeredAnimation extends StatelessWidget {
  final int index;
  final int totalItems;
  final AnimationController controller;
  final Widget child;
  final double overlapFactor;

  const StaggeredAnimation({
    super.key,
    required this.index,
    required this.totalItems,
    required this.controller,
    required this.child,
    this.overlapFactor = 0.4,
  });

  @override
  Widget build(BuildContext context) {
    final interval = AppAnimations.staggeredInterval(
      index,
      totalItems,
      overlapFactor: overlapFactor,
    );

    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: interval),
    );

    final slideAnimation = Tween<Offset>(
      begin: AppAnimations.slideFromBottom,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: interval));

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: child,
      ),
    );
  }
}

class PulsingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;

  const PulsingWidget({
    super.key,
    required this.child,
    this.duration = AppAnimations.extraLongDuration,
    this.minScale = 0.95,
    this.maxScale = 1.05,
  });

  @override
  State<PulsingWidget> createState() => _PulsingWidgetState();
}

class _PulsingWidgetState extends State<PulsingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scaleAnimation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}
