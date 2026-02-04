import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_animations.dart';
import '../../../data/learning_models.dart';

class FeaturedCoursesSection extends StatefulWidget {
  const FeaturedCoursesSection({
    super.key,
    required this.courses,
    this.onCourseTap,
    this.onViewAllTap,
  });

  final List<Course> courses;

  final ValueChanged<Course>? onCourseTap;

  final VoidCallback? onViewAllTap;

  @override
  State<FeaturedCoursesSection> createState() => _FeaturedCoursesSectionState();
}

class _FeaturedCoursesSectionState extends State<FeaturedCoursesSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _headerController;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: AppAnimations.slowDuration,
    )..forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: _headerController,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-0.1, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _headerController,
                curve: AppAnimations.entranceCurve,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [AppColors.electricBlue, AppColors.primaryPurple],
                        ).createShader(bounds),
                        child: const Text(
                          'Featured Courses',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'NEW',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      widget.onViewAllTap?.call();
                    },
                    child: const Row(
                      children: [
                        Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryPurple,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12,
                          color: AppColors.primaryPurple,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              if (widget.courses.isNotEmpty)
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _FeaturedCourseCard(
                        course: widget.courses[0],
                        height: 220,
                        isLarge: true,
                        delayIndex: 0,
                        onTap: () => widget.onCourseTap?.call(widget.courses[0]),
                      ),
                    ),
                    if (widget.courses.length > 1) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: _FeaturedCourseCard(
                          course: widget.courses[1],
                          height: 220,
                          isLarge: false,
                          delayIndex: 1,
                          onTap: () => widget.onCourseTap?.call(widget.courses[1]),
                        ),
                      ),
                    ],
                  ],
                ),

              const SizedBox(height: 12),

              if (widget.courses.length > 2)
                Row(
                  children: [
                    for (int i = 2; i < math.min(5, widget.courses.length); i++) ...[
                      if (i > 2) const SizedBox(width: 12),
                      Expanded(
                        child: _FeaturedCourseCard(
                          course: widget.courses[i],
                          height: 160,
                          isLarge: false,
                          isCompact: true,
                          delayIndex: i,
                          onTap: () => widget.onCourseTap?.call(widget.courses[i]),
                        ),
                      ),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeaturedCourseCard extends StatefulWidget {
  const _FeaturedCourseCard({
    required this.course,
    required this.height,
    required this.isLarge,
    required this.delayIndex,
    this.isCompact = false,
    this.onTap,
  });

  final Course course;
  final double height;
  final bool isLarge;
  final bool isCompact;
  final int delayIndex;
  final VoidCallback? onTap;

  @override
  State<_FeaturedCourseCard> createState() => _FeaturedCourseCardState();
}

class _FeaturedCourseCardState extends State<_FeaturedCourseCard>
    with TickerProviderStateMixin {
  late AnimationController _pressController;
  late AnimationController _shimmerController;
  late AnimationController _entranceController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    _pressController = AnimationController(
      vsync: this,
      duration: AppAnimations.fastDuration,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(
      CurvedAnimation(parent: _pressController, curve: AppAnimations.defaultCurve),
    );

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(_shimmerController);

    _entranceController = AnimationController(
      vsync: this,
      duration: AppAnimations.mediumDuration,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _entranceController, curve: AppAnimations.entranceCurve),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _entranceController, curve: AppAnimations.entranceCurve),
    );

    Future.delayed(Duration(milliseconds: 80 * widget.delayIndex), () {
      if (mounted) {
        _entranceController.forward();
      }
    });
  }

  @override
  void dispose() {
    _pressController.dispose();
    _shimmerController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _pressController.forward();
    _shimmerController.forward(from: 0);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _pressController.reverse();
    HapticFeedback.lightImpact();
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _pressController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: AnimatedBuilder(
            animation: _pressController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: Container(
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: course.displayColor.withOpacity(_isPressed ? 0.35 : 0.25),
                    blurRadius: _isPressed ? 24 : 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            course.displayColor,
                            course.displayColor.withOpacity(0.7),
                            _getSecondaryColor(course.displayColor),
                          ],
                        ),
                      ),
                    ),

                    Positioned.fill(
                      child: CustomPaint(
                        painter: _PatternPainter(
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ),

                    AnimatedBuilder(
                      animation: _shimmerController,
                      builder: (context, _) {
                        return ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0),
                                Colors.white.withOpacity(0.3),
                                Colors.white.withOpacity(0),
                              ],
                              stops: [
                                _shimmerAnimation.value - 0.3,
                                _shimmerAnimation.value,
                                _shimmerAnimation.value + 0.3,
                              ].map((v) => v.clamp(0.0, 1.0)).toList(),
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.srcATop,
                          child: Container(color: Colors.white.withOpacity(0.1)),
                        );
                      },
                    ),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.5),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(widget.isCompact ? 12 : 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    course.difficulty.name.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 0.3,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              if (!widget.isCompact && course.isFree) ...[
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    'FREE',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),

                          const Spacer(),

                          Text(
                            course.title,
                            style: TextStyle(
                              fontSize: widget.isLarge
                                  ? 18
                                  : widget.isCompact
                                      ? 13
                                      : 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                            maxLines: widget.isCompact ? 2 : 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (!widget.isCompact) ...[
                            const SizedBox(height: 4),
                            Text(
                              course.subtitle,
                              style: TextStyle(
                                fontSize: widget.isLarge ? 13 : 11,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          const SizedBox(height: 8),

                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.schedule_rounded,
                                    color: Colors.white.withOpacity(0.8),
                                    size: widget.isCompact ? 10 : 12,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    '${course.estimatedHours.toStringAsFixed(0)}h',
                                    style: TextStyle(
                                      fontSize: widget.isCompact ? 9 : 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.play_lesson_rounded,
                                    color: Colors.white.withOpacity(0.8),
                                    size: widget.isCompact ? 10 : 12,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    '${course.totalLessons}',
                                    style: TextStyle(
                                      fontSize: widget.isCompact ? 9 : 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getSecondaryColor(Color primary) {
    final hsl = HSLColor.fromColor(primary);
    return hsl.withHue((hsl.hue + 30) % 360).withSaturation(0.8).toColor();
  }
}

class _PatternPainter extends CustomPainter {
  _PatternPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const spacing = 30.0;

    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
