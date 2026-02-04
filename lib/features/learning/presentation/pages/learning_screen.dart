import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_animations.dart';
import '../../../../shared/widgets/aurora_background.dart';
import '../../data/learning_models.dart';
import '../../data/learning_mock_data.dart';
import 'widgets/learning_header.dart';
import 'widgets/learning_search_bar.dart';
import 'widgets/category_pills.dart';
import 'widgets/continue_learning_section.dart';
import 'widgets/featured_courses_section.dart';
import 'widgets/learning_paths_section.dart';
import 'widgets/daily_tip_card.dart';
import 'widgets/learning_stats_card.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen>
    with TickerProviderStateMixin {

  String? _selectedCategoryId;

  String _searchQuery = '';

  // ignore: unused_field
  bool _isSearchActive = false;

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
    HapticFeedback.selectionClick();
    setState(() {
      _selectedCategoryId = categoryId;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _onSearchFocusChanged(bool isFocused) {
    setState(() {
      _isSearchActive = isFocused;
    });
  }

  void _onCourseTap(Course course) {
    HapticFeedback.lightImpact();
  }

  void _onSeeAllCourses() {
    HapticFeedback.lightImpact();
  }

  void _onLearningPathTap(LearningPath path) {
    HapticFeedback.lightImpact();
  }

  List<Course> get _filteredCourses {
    var courses = LearningMockData.featuredCourses;

    if (_selectedCategoryId != null) {
      courses = courses
          .where((c) => c.categoryId == _selectedCategoryId)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      courses = courses.where((c) {
        return c.title.toLowerCase().contains(query) ||
            c.subtitle.toLowerCase().contains(query) ||
            c.tags.any((tag) => tag.toLowerCase().contains(query));
      }).toList();
    }

    return courses;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        body: Stack(
          children: [
            // PERFORMANCE FIX: Disabled animation - was causing constant repaints
            // Aurora background is beautiful but too expensive for scrolling screens
            const Positioned.fill(
              child: AuroraBackground(
                intensity: 0.2,
                enableAnimation: false, // CRITICAL: Disable for performance
              ),
            ),

            _buildMainContent(),

          ],
        ),
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
          child: SizedBox(height: MediaQuery.of(context).padding.top + 16),
        ),

        SliverToBoxAdapter(
          child: _buildAnimatedSection(
            index: 0,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: LearningHeader(),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        SliverToBoxAdapter(
          child: _buildAnimatedSection(
            index: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LearningSearchBar(
                onChanged: _onSearchChanged,
                onFocusChanged: _onSearchFocusChanged,
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        SliverToBoxAdapter(
          child: _buildAnimatedSection(
            index: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LearningStatsCard(
                progress: LearningMockData.currentUserProgress,
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 28)),

        SliverToBoxAdapter(
          child: _buildAnimatedSection(
            index: 3,
            child: CategoryPills(
              categories: LearningMockData.categories,
              selectedId: _selectedCategoryId,
              onSelected: _onCategorySelected,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 28)),

        if (LearningMockData.continueLearning.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildAnimatedSection(
              index: 4,
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
            index: 5,
            child: FeaturedCoursesSection(
              courses: _filteredCourses,
              onCourseTap: _onCourseTap,
              onViewAllTap: _onSeeAllCourses,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),

        SliverToBoxAdapter(
          child: _buildAnimatedSection(
            index: 6,
            child: LearningPathsSection(
              paths: LearningMockData.learningPaths,
              onPathTap: _onLearningPathTap,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),

        SliverToBoxAdapter(
          child: _buildAnimatedSection(
            index: 7,
            child: DailyTipCard(
              tip: LearningMockData.dailyTips.first['tip'] ?? '',
              category: LearningMockData.dailyTips.first['category'] ?? 'Investing',
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }

  Widget _buildAnimatedSection({
    required int index,
    required Widget child,
  }) {
    final interval = AppAnimations.staggeredInterval(index, 8);

    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _staggerController, curve: interval),
    );

    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _staggerController, curve: interval));

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: child,
      ),
    );
  }
}
