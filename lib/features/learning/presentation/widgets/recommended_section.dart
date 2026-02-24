import 'package:finnn/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../data/learning_mock_data.dart';
import '../pages/course_details_screen.dart';
import '../../bloc/learning_bloc_provider.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommended Courses',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E2C),
                letterSpacing: -0.5,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('View All')),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 260,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            children: LearningMockData.allCourses.take(5).map((course) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
                    if (context
                            .dependOnInheritedWidgetOfExactType<
                              LearningBlocProvider
                            >() ==
                        null) {
                      return;
                    }
                    final bloc = LearningBlocProvider.of(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LearningBlocProvider(
                          bloc: bloc,
                          child: CourseDetailsScreen(course: course),
                        ),
                      ),
                    );
                  },
                  child: RecommendedCard(
                    title: course.title,
                    subtitle: course.subtitle,
                    icon: course
                        .difficulty
                        .icon, // Using difficulty icon as placeholder, ideally category icon
                    color: course.accentColor ?? AppColors.electricBlue,
                    duration: course.formattedDuration,
                    chapterCount: course.totalLessons,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class RecommendedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String duration;
  final int chapterCount;

  const RecommendedCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.duration,
    required this.chapterCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E1E2C).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E2C),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildBadge(Icons.schedule_rounded, duration),
              const Spacer(),
              _buildBadge(Icons.article_rounded, '$chapterCount Ch'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textTertiary),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
