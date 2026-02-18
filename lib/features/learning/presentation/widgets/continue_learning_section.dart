import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_animations.dart';
import '../../data/learning_models.dart';

class ContinueLearningSection extends StatelessWidget {
  const ContinueLearningSection({
    super.key,
    required this.courses,
    this.onCourseTap,
  });

  final List<Map<String, dynamic>> courses;

  final ValueChanged<Course>? onCourseTap;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text(
                    'Continue Learning',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.play_circle_fill_rounded,
                    color: AppColors.primaryPurple,
                    size: 20,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  HapticFeedback.selectionClick();
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final courseData = courses[index];
              final course = courseData['course'] as Course;
              final progress = courseData['progress'] as double;
              final nextLesson = courseData['nextLesson'] as String;
              final minutesLeft = courseData['minutesLeft'] as int;

              return Padding(
                padding: EdgeInsets.only(
                  right: index < courses.length - 1 ? 16 : 0,
                ),
                child: _ContinueLearningCard(
                  course: course,
                  progress: progress,
                  nextLesson: nextLesson,
                  minutesLeft: minutesLeft,
                  onTap: () => onCourseTap?.call(course),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ContinueLearningCard extends StatefulWidget {
  const _ContinueLearningCard({
    required this.course,
    required this.progress,
    required this.nextLesson,
    required this.minutesLeft,
    this.onTap,
  });

  final Course course;
  final double progress;
  final String nextLesson;
  final int minutesLeft;
  final VoidCallback? onTap;

  @override
  State<_ContinueLearningCard> createState() => _ContinueLearningCardState();
}

class _ContinueLearningCardState extends State<_ContinueLearningCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.fastDuration,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.defaultCurve),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    HapticFeedback.lightImpact();
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: 300,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: course.displayColor.withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: course.displayColor.withValues(alpha: _isPressed ? 0.2 : 0.1),
                blurRadius: _isPressed ? 20 : 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: course.displayColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getCourseIcon(course.categoryId),
                      color: course.displayColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${widget.minutesLeft}m left',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: course.displayColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${(widget.progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: course.displayColor,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Text(
                'Up Next',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textTertiary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.nextLesson,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              Stack(
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: course.displayColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: widget.progress,
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            course.displayColor,
                            course.displayColor.withValues(alpha: 0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: course.displayColor.withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      course.displayColor,
                      course.displayColor.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: course.displayColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Resume',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCourseIcon(String categoryId) {
    switch (categoryId) {
      case 'stock-basics':
        return Icons.candlestick_chart_outlined;
      case 'technical-analysis':
        return Icons.show_chart_rounded;
      case 'options-trading':
        return Icons.call_split_rounded;
      case 'crypto':
        return Icons.currency_bitcoin;
      case 'psychology':
        return Icons.psychology_outlined;
      default:
        return Icons.book_outlined;
    }
  }
}
