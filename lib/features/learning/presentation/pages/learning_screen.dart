import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_animations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/learning_models.dart';
import '../../data/learning_mock_data.dart';
import 'widgets/learning_header.dart';

import 'widgets/category_pills.dart';
import 'widgets/continue_learning_section.dart';

import 'widgets/learning_paths_section.dart';
import 'widgets/daily_tip_card.dart';
import 'topic_detail_screen.dart';
import 'widgets/all_courses_section.dart';

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
  }

  void _onLearningPathTap(LearningPath path) {
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _buildMainContent(),
      ),
    );
  }

  Widget _buildMainContent() {
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

        SliverToBoxAdapter(
          child: _buildAnimatedSection(
            index: 1,
            child: AllCoursesSection(
              courses: LearningMockData.allCourses,
              onCourseTap: _onCourseTap,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 28)),

        SliverToBoxAdapter(
          child: _buildAnimatedSection(
            index: 2,
            child: CategoryPills(
              categories: LearningMockData.categories,
              selectedId: null,
              onSelected: _onCategorySelected,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 28)),

        if (LearningMockData.continueLearning.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildAnimatedSection(
              index: 3,
              child: ContinueLearningSection(
                courses: LearningMockData.continueLearning,
                onCourseTap: _onCourseTap,
              ),
            ),
          ),

        if (LearningMockData.continueLearning.isNotEmpty)
          const SliverToBoxAdapter(child: SizedBox(height: 32)),

        SliverToBoxAdapter(
          child: _buildAnimatedSection(
            index: 3,
            child: LearningPathsSection(
              paths: LearningMockData.learningPaths,
              onPathTap: _onLearningPathTap,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),

        SliverToBoxAdapter(
          child: _buildAnimatedSection(
            index: 4,
            child: DailyTipCard(
              tip: LearningMockData.dailyTips.first['tip'] ?? '',
              category:
                  LearningMockData.dailyTips.first['category'] ?? 'Investing',
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
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
