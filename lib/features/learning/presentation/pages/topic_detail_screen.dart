import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

import '../../data/learning_models.dart';
import '../../data/learning_mock_data.dart';
import 'course_details_screen.dart';
import '../../bloc/learning_bloc_provider.dart';

import '../widgets/topic_interactives/foundations_sandbox.dart';
import '../widgets/topic_interactives/analysis_sandbox.dart';
import '../widgets/topic_interactives/risk_sandbox.dart';
import '../widgets/topic_interactives/advanced_sandbox.dart';
import '../widgets/topic_interactives/mastery_sandbox.dart';

class TopicDetailScreen extends StatelessWidget {
  const TopicDetailScreen({super.key, required this.category});

  final LearningCategory category;

  List<Course> _getCoursesForCategory(String categoryId) {
    final all = LearningMockData.allCourses;
    switch (categoryId) {
      case 'foundations':
        return all.where((c) => ['trading', 'stocks', 'crypto', 'forex', 'commodities'].contains(c.categoryId)).toList();
      case 'analysis':
        return all.where((c) => c.categoryId == 'analysis').toList();
      case 'risk-psychology':
        return all.where((c) => ['risk', 'practice'].contains(c.categoryId)).toList();
      case 'advanced':
        return all.where((c) => ['derivatives', 'strategies', 'setup'].contains(c.categoryId)).toList();
      case 'mastery':
        return all.where((c) => c.categoryId == 'mindset').toList();
      default:
        return [];
    }
  }

  Widget _buildInteractiveWidget() {
    switch (category.id) {
      case 'foundations':
        return const FoundationsSandbox();
      case 'analysis':
        return const AnalysisSandbox();
      case 'risk-psychology':
        return const RiskSandbox();
      case 'advanced':
        return const AdvancedSandbox();
      case 'mastery':
        return const MasterySandbox();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final courses = _getCoursesForCategory(category.id);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.surface,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.backgroundPrimary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.textPrimary,
                  size: 18,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [category.color.withValues(alpha: 0.1), AppColors.surface],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: category.color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(category.icon, color: category.color, size: 32),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.name,
                                    style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${courses.length} Courses • ${category.estimatedHours}h Total',
                                    style: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary, fontWeight: AppTypography.semiBold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          category.description,
                          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Row(
                children: [
                  const Icon(Icons.extension_rounded, size: 20, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Interactive Sandbox',
                    style: AppTypography.h6.copyWith(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: _buildInteractiveWidget(),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
              child: Text(
                'Courses in this Category',
                style: AppTypography.h6.copyWith(color: AppColors.textPrimary),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final course = courses[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        final bloc = LearningBlocProvider.of(context);
                        Navigator.of(context).push(
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
                          border: Border.all(color: AppColors.border, width: 0.5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: course.displayColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(course.difficulty.icon, color: course.displayColor, size: 32),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.title,
                                    style: AppTypography.label.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: AppTypography.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time_rounded, size: 14, color: AppColors.textTertiary),
                                      const SizedBox(width: 4),
                                      Text(
                                        course.formattedDuration,
                                        style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary),
                                      ),
                                      const SizedBox(width: 12),
                                      Icon(Icons.layers_outlined, size: 14, color: AppColors.textTertiary),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${course.totalLessons} lessons',
                                        style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: courses.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
