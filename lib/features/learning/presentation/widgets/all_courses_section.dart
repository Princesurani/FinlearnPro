import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/learning_models.dart';

class AllCoursesSection extends StatelessWidget {
  const AllCoursesSection({super.key, required this.courses, this.onCourseTap});

  final List<Course> courses;
  final Function(Course)? onCourseTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Courses',
                style: AppTypography.h4.copyWith(color: AppColors.textPrimary),
              ),
              Text(
                'See All',
                style: AppTypography.button.copyWith(
                  color: AppColors.primaryPurple,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 240,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              return _CourseCard(
                course: courses[index],
                onTap: () {
                  if (onCourseTap != null) {
                    onCourseTap!(courses[index]);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course, required this.onTap});

  final Course course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color:
                      course.accentColor?.withValues(alpha: 0.1) ??
                      course.difficulty.color.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSpacing.radiusXL),
                    topRight: Radius.circular(AppSpacing.radiusXL),
                  ),
                ),
                child: Center(
                  child: Icon(
                    course.difficulty.icon,
                    size: 40,
                    color: course.accentColor ?? course.difficulty.color,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Difficulty Tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: course.difficulty.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusSM,
                          ),
                        ),
                        child: Text(
                          course.difficulty.label.toUpperCase(),
                          style: AppTypography.labelSmall.copyWith(
                            color: course.difficulty.color,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          height: 1.2,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            course.formattedDuration,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            course.rating.toString(),
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
