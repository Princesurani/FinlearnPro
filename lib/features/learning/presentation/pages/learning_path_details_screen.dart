import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/learning_models.dart';
import '../../data/learning_data.dart';
import '../../bloc/learning_bloc_provider.dart';
import '../../bloc/learning_bloc.dart';
import 'course_details_screen.dart';

class LearningPathDetailsScreen extends StatelessWidget {
  const LearningPathDetailsScreen({super.key, required this.path});

  final LearningPath path;

  @override
  Widget build(BuildContext context) {
    // Map course IDs to actual Course objects
    final coursesInPath = path.courseIds.map((id) {
      return LearningData.allCourses.firstWhere(
        (c) => c.id == id,
        orElse: () => LearningData.allCourses.first, // fallback
      );
    }).where((c) => path.courseIds.contains(c.id)).toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        body: StreamBuilder<LearningState>(
          stream: LearningBlocProvider.of(context).stream,
          initialData: LearningBlocProvider.of(context).state,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state == null) return const SizedBox.shrink();

            // Calculate progress
            int completedCourses = 0;
            for (final courseId in path.courseIds) {
              final prog = state.userProgress.courseProgress[courseId];
              if (prog != null && prog.status == ProgressStatus.completed) {
                completedCourses++;
              }
            }
            final double progressFraction = path.courseIds.isEmpty
                ? 0
                : completedCourses / path.courseIds.length;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildSliverAppBar(context, progressFraction, completedCourses),
                SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final course = coursesInPath[index];
                        final courseProg = state.userProgress.courseProgress[course.id];
                        final isCompleted = courseProg?.status == ProgressStatus.completed;
                        final isLocked = index > 0 && 
                            state.userProgress.courseProgress[coursesInPath[index-1].id]?.status != ProgressStatus.completed;

                        return _buildCourseNode(
                          context: context,
                          course: course,
                          index: index,
                          isLast: index == coursesInPath.length - 1,
                          isCompleted: isCompleted,
                          isLocked: isLocked,
                        );
                      },
                      childCount: coursesInPath.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, double progressFraction, int completedCount) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: path.displayColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                path.displayColor.withValues(alpha: 0.8),
                path.displayColor,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${path.estimatedWeeks} WEEKS',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    path.title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    path.description,
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.9),
                      fontSize: 15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 24),
                  // Progress Bar
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progressFraction,
                            backgroundColor: AppColors.white.withValues(alpha: 0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.white),
                            minHeight: 8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '$completedCount / ${path.courseIds.length}',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCourseNode({
    required BuildContext context,
    required Course course,
    required int index,
    required bool isLast,
    required bool isCompleted,
    required bool isLocked,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? path.displayColor
                        : (isLocked ? AppColors.surface : AppColors.white),
                    border: Border.all(
                      color: isLocked ? AppColors.borderLight : path.displayColor,
                      width: 2,
                    ),
                    boxShadow: !isLocked && !isCompleted
                        ? [
                            BoxShadow(
                              color: path.displayColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                            )
                          ]
                        : null,
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check_rounded, color: AppColors.white, size: 18)
                        : (isLocked
                            ? const Icon(Icons.lock_outline_rounded, color: AppColors.textTertiary, size: 16)
                            : Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: path.displayColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isCompleted ? path.displayColor : AppColors.borderLight,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Course Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: GestureDetector(
                onTap: isLocked
                    ? null
                    : () {
                        HapticFeedback.lightImpact();
                        final bloc = LearningBlocProvider.of(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LearningBlocProvider(
                              bloc: bloc,
                              child: CourseDetailsScreen(course: course),
                            ),
                          ),
                        );
                      },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isLocked ? AppColors.borderLight : path.displayColor.withValues(alpha: 0.2),
                    ),
                    boxShadow: isLocked
                        ? null
                        : [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(course.difficulty.icon,
                              color: isLocked ? AppColors.textTertiary : course.difficulty.color, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            course.difficulty.label.toUpperCase(),
                            style: TextStyle(
                              color: isLocked ? AppColors.textTertiary : course.difficulty.color,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            course.formattedDuration,
                            style: const TextStyle(
                              color: AppColors.textTertiary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        course.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isLocked ? AppColors.textSecondary : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textTertiary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
