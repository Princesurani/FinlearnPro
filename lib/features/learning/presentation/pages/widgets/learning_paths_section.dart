import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_animations.dart';
import '../../../data/learning_models.dart';

class LearningPathsSection extends StatefulWidget {
  const LearningPathsSection({super.key, required this.paths, this.onPathTap});

  final List<LearningPath> paths;

  final ValueChanged<LearningPath>? onPathTap;

  @override
  State<LearningPathsSection> createState() => _LearningPathsSectionState();
}

class _LearningPathsSectionState extends State<LearningPathsSection> {
  // PERFORMANCE FIX: Removed _pulseController.repeat() - was causing constant rebuilds

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Learning Paths',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // PERFORMANCE FIX: Static badge instead of animated
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.oceanTeal, AppColors.electricBlue],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '🎯 ROADMAPS',
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
                },
                child: const Text(
                  'Explore All',
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
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: widget.paths.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < widget.paths.length - 1 ? 16 : 0,
                ),
                child: _LearningPathCard(
                  path: widget.paths[index],
                  onTap: () => widget.onPathTap?.call(widget.paths[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LearningPathCard extends StatefulWidget {
  const _LearningPathCard({required this.path, this.onTap});

  final LearningPath path;
  final VoidCallback? onTap;

  @override
  State<_LearningPathCard> createState() => _LearningPathCardState();
}

class _LearningPathCardState extends State<_LearningPathCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: AppAnimations.fastDuration,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: AppAnimations.defaultCurve,
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _scaleController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _scaleController.reverse();
    HapticFeedback.lightImpact();
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final path = widget.path;
    final totalCourses = path.courseIds.length;
    final completedCourses = (totalCourses * 0.3).floor();

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleController,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: path.displayColor.withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: path.displayColor.withValues(alpha: _isPressed ? 0.2 : 0.1),
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
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          path.displayColor,
                          path.displayColor.withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: path.displayColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      _getPathIcon(path.id),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          path.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 12,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${path.estimatedWeeks} weeks',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textTertiary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.textTertiary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$totalCourses courses',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Roadmap Progress (static version - animation removed for performance)
              SizedBox(
                height: 60,
                child: CustomPaint(
                  painter: _RoadmapPainter(
                    totalNodes: totalCourses,
                    completedNodes: completedCourses,
                    color: path.displayColor,
                    pulseValue: 0.5, // Static value
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(totalCourses, (index) {
                      final isCompleted = index < completedCourses;
                      final isCurrent = index == completedCourses;

                      return Container(
                        width: isCurrent ? 36 : 28,
                        height: isCurrent ? 36 : 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted
                              ? path.displayColor
                              : isCurrent
                              ? AppColors.surface
                              : AppColors.surface.withValues(alpha: 0.8),
                          border: Border.all(
                            color: isCompleted
                                ? path.displayColor
                                : isCurrent
                                ? path.displayColor
                                : AppColors.borderLight,
                            width: isCurrent ? 3 : 2,
                          ),
                          boxShadow: isCurrent
                              ? [
                                  BoxShadow(
                                    color: path.displayColor.withValues(alpha: 0.4),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: isCompleted
                              ? const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: isCurrent ? 14 : 12,
                                    fontWeight: FontWeight.bold,
                                    color: isCurrent
                                        ? path.displayColor
                                        : AppColors.textTertiary,
                                  ),
                                ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$completedCourses of $totalCourses completed',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Stack(
                          children: [
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: path.displayColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: completedCourses / totalCourses,
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      path.displayColor,
                                      path.displayColor.withValues(alpha: 0.7),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: path.displayColor.withValues(alpha: 0.4),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          path.displayColor,
                          path.displayColor.withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: path.displayColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          completedCourses > 0
                              ? Icons.play_arrow_rounded
                              : Icons.rocket_launch_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          completedCourses > 0 ? 'Continue' : 'Start',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getPathIcon(String pathId) {
    switch (pathId) {
      case 'path-beginner':
        return Icons.school_outlined;
      case 'path-technical':
        return Icons.analytics_outlined;
      case 'path-options':
        return Icons.call_split_rounded;
      case 'path-crypto':
        return Icons.currency_bitcoin;
      default:
        return Icons.route_outlined;
    }
  }
}

class _RoadmapPainter extends CustomPainter {
  _RoadmapPainter({
    required this.totalNodes,
    required this.completedNodes,
    required this.color,
    required this.pulseValue,
  });

  final int totalNodes;
  final int completedNodes;
  final Color color;
  final double pulseValue;

  @override
  void paint(Canvas canvas, Size size) {
    final nodeSpacing = size.width / (totalNodes + 1);
    final yCenter = size.height / 2;

    for (int i = 0; i < totalNodes - 1; i++) {
      final startX = nodeSpacing * (i + 1) + 14;
      final endX = nodeSpacing * (i + 2) - 14;

      final paint = Paint()
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;

      if (i < completedNodes) {
        paint.color = color;
      } else if (i == completedNodes) {
        paint.color = color.withValues(alpha: 0.4);
      } else {
        paint.color = color.withValues(alpha: 0.15);
      }

      canvas.drawLine(Offset(startX, yCenter), Offset(endX, yCenter), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RoadmapPainter oldDelegate) {
    return oldDelegate.pulseValue != pulseValue;
  }
}
