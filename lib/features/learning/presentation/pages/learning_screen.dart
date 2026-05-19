import 'package:finnn/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_animations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/learning_models.dart';
import '../../data/learning_mock_data.dart';
import '../widgets/learning_header.dart';

import '../widgets/category_pills.dart';
import '../widgets/continue_learning_section.dart';

import '../widgets/learning_paths_section.dart';

import 'topic_detail_screen.dart';
import '../widgets/all_courses_section.dart';
import 'course_details_screen.dart';
import '../../bloc/learning_bloc_provider.dart';
import '../../bloc/learning_bloc.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;

  late AnimationController _entranceController;

  late AnimationController _staggerController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _entranceController = AnimationController(
      vsync: this,
      duration: AppAnimations.slowDuration,
    );

    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _entranceController.forward();
      _staggerController.forward();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _entranceController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  void _onCategorySelected(String? categoryId) {
    HapticFeedback.lightImpact();
    if (categoryId == null) return;

    final category = LearningMockData.categories.firstWhere(
      (c) => c.id == categoryId,
      orElse: () => LearningMockData.categories.first,
    );

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TopicDetailScreen(category: category)),
    );
  }

  void _onCourseTap(Course course) {
    HapticFeedback.lightImpact();
    final bloc = LearningBlocProvider.of(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LearningBlocProvider(
          bloc: bloc,
          child: CourseDetailsScreen(course: course),
        ),
      ),
    );
  }

  void _onLearningPathTap(LearningPath path) {
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppColors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: _buildMainContent(),
      ),
    );
  }

  Widget _buildMainContent() {
    final bloc = LearningBlocProvider.of(context);
    
    return StreamBuilder<LearningState>(
      stream: bloc.stream,
      initialData: bloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state == null) return const SizedBox.shrink();
        
        // Calculate real continue learning courses
        final continueLearningCourses = <Map<String, dynamic>>[];
        final progresses = state.userProgress.courseProgress.values
            .where((p) => p.status == ProgressStatus.inProgress)
            .toList();
            
        for (final p in progresses) {
          final course = LearningMockData.allCourses.firstWhere(
            (c) => c.id == p.courseId,
            orElse: () => LearningMockData.allCourses.first, // fallback
          );
          
          if (course.id != p.courseId) continue;
          
          double progressValue = 0;
          if (p.totalLessons > 0) {
            progressValue = p.completedLessons / p.totalLessons;
          }
          
          // Find next lesson title
          String nextLessonTitle = 'Next Lesson';
          for (final chapter in course.modules) {
            bool found = false;
            for (final lesson in chapter.lessons) {
              if (!p.completedLessonIds.contains(lesson.id)) {
                nextLessonTitle = lesson.title;
                found = true;
                break;
              }
            }
            if (found) break;
          }
          
          continueLearningCourses.add({
            'course': course,
            'progress': progressValue,
            'nextLesson': nextLessonTitle,
            'minutesLeft': (p.totalLessons - p.completedLessons) * 10, // 10 mins per lesson
          });
        }

        return CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.top + 12),
            ),
    
            SliverToBoxAdapter(
              child: _buildAnimatedSection(
                index: 0,
                child: const Padding(
                  padding: AppSpacing.screenPaddingH,
                  child: LearningHeader(),
                ),
              ),
            ),
    
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
    
            if (continueLearningCourses.isNotEmpty)
              SliverToBoxAdapter(
                child: _buildAnimatedSection(
                  index: 1,
                  child: ContinueLearningSection(
                    courses: continueLearningCourses,
                    onCourseTap: _onCourseTap,
                  ),
                ),
              ),
    
            if (continueLearningCourses.isNotEmpty)
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
    
            SliverToBoxAdapter(
              child: _buildAnimatedSection(
                index: continueLearningCourses.isNotEmpty ? 2 : 1,
                child: CategoryPills(
                  categories: LearningMockData.categories,
                  selectedId: null,
                  onSelected: _onCategorySelected,
                ),
              ),
            ),
    
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
    
            SliverToBoxAdapter(
              child: _buildAnimatedSection(
                index: continueLearningCourses.isNotEmpty ? 3 : 2,
                child: AllCoursesSection(
                  courses: LearningMockData.allCourses,
                  onCourseTap: _onCourseTap,
                ),
              ),
            ),
    
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
    
            SliverToBoxAdapter(
              child: _buildAnimatedSection(
                index: continueLearningCourses.isNotEmpty ? 4 : 3,
                child: LearningPathsSection(
                  paths: LearningMockData.learningPaths,
                  onPathTap: _onLearningPathTap,
                ),
              ),
            ),
    
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        );
      }
    );
  }

  Widget _buildAnimatedSection({required int index, required Widget child}) {
    final interval = AppAnimations.staggeredInterval(index, 8);

    final fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _staggerController, curve: interval));

    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _staggerController, curve: interval));

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(position: slideAnimation, child: child),
    );
  }
}
