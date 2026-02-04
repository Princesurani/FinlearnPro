
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_animations.dart';
import '../../../../shared/widgets/gradient_button.dart';
import '../../../../shared/widgets/glass_container.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({
    super.key,
    required this.courseId,
    this.course,
  });

  final String courseId;
  final CourseData? course;

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _heroController;
  late AnimationController _contentController;
  late AnimationController _fabController;

  late Animation<double> _heroParallax;
  late Animation<double> _heroOverlay;
  late Animation<double> _contentSlide;
  late Animation<double> _fabScale;

  double _scrollOffset = 0;
  bool _isEnrolled = false;
  bool _showStickyHeader = false;
  Set<int> _expandedModules = {0}; // First module expanded by default

  // Mock data - in production, this would come from API
  late CourseData _course;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _initializeAnimations();
    _startEntranceAnimations();
  }

  void _initializeData() {
    _course = widget.course ?? CourseData.mock();
  }

  void _initializeAnimations() {
    _scrollController = ScrollController()
      ..addListener(_onScroll);

    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _heroParallax = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _heroController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _heroOverlay = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _heroController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _contentSlide = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: Curves.easeOutCubic,
      ),
    );

    _fabScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _fabController,
        curve: Curves.elasticOut,
      ),
    );
  }

  void _startEntranceAnimations() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _heroController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _contentController.forward();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      _fabController.forward();
    });
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
      _showStickyHeader = _scrollOffset > 300;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _heroController.dispose();
    _contentController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Stack(
        children: [
          // Main scrollable content
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Hero section
              _buildHeroSection(),

              // Course content
              SliverToBoxAdapter(
                child: AnimatedBuilder(
                  animation: _contentController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _contentController.value,
                      child: Transform.translate(
                        offset: Offset(0, _contentSlide.value),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCourseHeader(),
                      _buildStatsRow(),
                      _buildLearningOutcomes(),
                      _buildCurriculum(),
                      _buildInstructorSection(),
                      _buildReviewsSection(),
                      _buildRelatedCourses(),
                      // Bottom padding for FAB
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sticky header
          _buildStickyHeader(),

          // Floating enrollment button
          _buildEnrollmentFAB(),

          // Back button
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    const heroHeight = 400.0;
    final parallaxOffset = _scrollOffset * 0.5;

    return SliverAppBar(
      expandedHeight: heroHeight,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      pinned: false,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: AnimatedBuilder(
          animation: _heroController,
          builder: (context, child) {
            return Stack(
              fit: StackFit.expand,
              children: [
                // Course thumbnail with parallax
                Transform.translate(
                  offset: Offset(0, parallaxOffset),
                  child: Opacity(
                    opacity: _heroParallax.value,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: _course.gradientColors,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Decorative pattern
                          CustomPaint(
                            painter: _HeroPatternPainter(
                              progress: _heroController.value,
                              color: Colors.white.withAlpha(25),
                            ),
                            size: Size.infinite,
                          ),
                          // Course icon
                          Center(
                            child: Icon(
                              _course.icon,
                              size: 120,
                              color: Colors.white.withAlpha(77),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Gradient overlay
                Opacity(
                  opacity: _heroOverlay.value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(77),
                          AppColors.backgroundPrimary,
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),

                // Level badge
                Positioned(
                  top: MediaQuery.of(context).padding.top + 60,
                  left: AppSpacing.lg,
                  child: Opacity(
                    opacity: _heroOverlay.value,
                    child: _buildLevelBadge(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLevelBadge() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(51),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withAlpha(77),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _course.levelIcon,
                size: 16,
                color: Colors.white,
              ),
              AppSpacing.gapXS,
              Text(
                _course.level,
                style: AppTypography.labelSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category chip
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xxs,
            ),
            decoration: BoxDecoration(
              color: _course.categoryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
            ),
            child: Text(
              _course.category,
              style: AppTypography.labelSmall.copyWith(
                color: _course.categoryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          AppSpacing.gapSM,

          // Title
          Text(
            _course.title,
            style: AppTypography.h1.copyWith(
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          AppSpacing.gapSM,

          // Subtitle
          Text(
            _course.subtitle,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          AppSpacing.gapMD,

          // Quick stats row
          Row(
            children: [
              _buildQuickStat(
                Icons.star_rounded,
                '${_course.rating}',
                '(${_course.reviewCount} reviews)',
                AppColors.warning,
              ),
              AppSpacing.gapLG,
              _buildQuickStat(
                Icons.people_outline_rounded,
                '${_course.enrolledCount}',
                'enrolled',
                AppColors.primaryPurple,
              ),
              AppSpacing.gapLG,
              _buildQuickStat(
                Icons.update_rounded,
                _course.lastUpdated,
                'updated',
                AppColors.success,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        AppSpacing.gapXXS,
        Text(
          value,
          style: AppTypography.label.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpacing.gapXXS,
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            Icons.play_circle_outline_rounded,
            '${_course.totalLessons}',
            'Lessons',
          ),
          _buildStatDivider(),
          _buildStatItem(
            Icons.schedule_rounded,
            _course.duration,
            'Total',
          ),
          _buildStatDivider(),
          _buildStatItem(
            Icons.quiz_outlined,
            '${_course.totalQuizzes}',
            'Quizzes',
          ),
          _buildStatDivider(),
          _buildStatItem(
            Icons.workspace_premium_outlined,
            'Yes',
            'Certificate',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryPurple, size: 24),
        AppSpacing.gapXXS,
        Text(
          value,
          style: AppTypography.h4.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.border,
    );
  }

  Widget _buildLearningOutcomes() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.success.withAlpha(25),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                ),
                child: Icon(
                  Icons.emoji_objects_rounded,
                  color: AppColors.success,
                  size: 20,
                ),
              ),
              AppSpacing.gapSM,
              Text(
                'What You\'ll Learn',
                style: AppTypography.h3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          AppSpacing.gapMD,
          ...List.generate(
            _course.learningOutcomes.length,
            (index) => _LearningOutcomeItem(
              outcome: _course.learningOutcomes[index],
              index: index,
              isVisible: _contentController.value > 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurriculum() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withAlpha(25),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                    ),
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: AppColors.primaryPurple,
                      size: 20,
                    ),
                  ),
                  AppSpacing.gapSM,
                  Text(
                    'Course Curriculum',
                    style: AppTypography.h3.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    if (_expandedModules.length == _course.modules.length) {
                      _expandedModules = {0};
                    } else {
                      _expandedModules = Set.from(
                        List.generate(_course.modules.length, (i) => i),
                      );
                    }
                  });
                },
                child: Text(
                  _expandedModules.length == _course.modules.length
                      ? 'Collapse All'
                      : 'Expand All',
                  style: AppTypography.label.copyWith(
                    color: AppColors.primaryPurple,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.gapSM,
          Text(
            '${_course.modules.length} modules • ${_course.totalLessons} lessons • ${_course.duration}',
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppSpacing.gapMD,
          ...List.generate(
            _course.modules.length,
            (index) => _ModuleCard(
              module: _course.modules[index],
              index: index,
              isExpanded: _expandedModules.contains(index),
              onToggle: () {
                setState(() {
                  if (_expandedModules.contains(index)) {
                    _expandedModules.remove(index);
                  } else {
                    _expandedModules.add(index);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorSection() {
    final instructor = _course.instructor;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.electricBlue.withAlpha(25),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: AppColors.electricBlue,
                  size: 20,
                ),
              ),
              AppSpacing.gapSM,
              Text(
                'Your Instructor',
                style: AppTypography.h3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          AppSpacing.gapMD,
          GlassContainer(
            padding: const EdgeInsets.all(AppSpacing.md),
            borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
            backgroundColor: AppColors.surface,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryPurple, AppColors.primaryPurpleLight],
                    ),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
                  ),
                  child: Center(
                    child: Text(
                      instructor.initials,
                      style: AppTypography.h2.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                AppSpacing.gapMD,
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            instructor.name,
                            style: AppTypography.h4.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          AppSpacing.gapXS,
                          if (instructor.isVerified)
                            Icon(
                              Icons.verified_rounded,
                              color: AppColors.primaryPurple,
                              size: 18,
                            ),
                        ],
                      ),
                      Text(
                        instructor.title,
                        style: AppTypography.body.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      AppSpacing.gapSM,
                      Row(
                        children: [
                          _buildInstructorStat(
                            Icons.star_rounded,
                            '${instructor.rating}',
                          ),
                          AppSpacing.gapMD,
                          _buildInstructorStat(
                            Icons.people_rounded,
                            '${instructor.studentCount}',
                          ),
                          AppSpacing.gapMD,
                          _buildInstructorStat(
                            Icons.play_circle_rounded,
                            '${instructor.courseCount} courses',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.gapMD,
          Text(
            instructor.bio,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorStat(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textTertiary),
        AppSpacing.gapXXS,
        Text(
          value,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withAlpha(25),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                    ),
                    child: Icon(
                      Icons.rate_review_rounded,
                      color: AppColors.warning,
                      size: 20,
                    ),
                  ),
                  AppSpacing.gapSM,
                  Text(
                    'Student Reviews',
                    style: AppTypography.h3.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all reviews
                },
                child: Text(
                  'See All',
                  style: AppTypography.label.copyWith(
                    color: AppColors.primaryPurple,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.gapMD,
          // Rating summary
          _buildRatingSummary(),
          AppSpacing.gapLG,
          // Reviews list
          ...List.generate(
            math.min(3, _course.reviews.length),
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _ReviewCard(review: _course.reviews[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSummary() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Big rating number
          Column(
            children: [
              Text(
                '${_course.rating}',
                style: AppTypography.display1.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  final filled = index < _course.rating.floor();
                  final partial = index == _course.rating.floor() &&
                      _course.rating % 1 > 0;
                  return Icon(
                    filled
                        ? Icons.star_rounded
                        : (partial
                            ? Icons.star_half_rounded
                            : Icons.star_outline_rounded),
                    color: AppColors.warning,
                    size: 16,
                  );
                }),
              ),
              AppSpacing.gapXXS,
              Text(
                '${_course.reviewCount} reviews',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          AppSpacing.gapLG,
          // Rating bars
          Expanded(
            child: Column(
              children: List.generate(5, (index) {
                final stars = 5 - index;
                final percentage = _course.ratingDistribution[stars] ?? 0;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                        child: Text(
                          '$stars',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      AppSpacing.gapXXS,
                      Icon(
                        Icons.star_rounded,
                        size: 12,
                        color: AppColors.warning,
                      ),
                      AppSpacing.gapXS,
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: percentage / 100,
                            backgroundColor: AppColors.border,
                            valueColor: AlwaysStoppedAnimation(
                              AppColors.warning,
                            ),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      AppSpacing.gapXS,
                      SizedBox(
                        width: 32,
                        child: Text(
                          '$percentage%',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedCourses() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withAlpha(25),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.primaryPurple,
                  size: 20,
                ),
              ),
              AppSpacing.gapSM,
              Text(
                'Related Courses',
                style: AppTypography.h3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          AppSpacing.gapMD,
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < 4 ? AppSpacing.md : 0,
                  ),
                  child: _RelatedCourseCard(
                    title: 'Related Course ${index + 1}',
                    category: 'Category',
                    lessons: 12 + index * 3,
                    color: [
                      AppColors.primaryPurple,
                      AppColors.electricBlue,
                      AppColors.success,
                      AppColors.warning,
                      AppColors.error,
                    ][index % 5],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyHeader() {
    return AnimatedPositioned(
      duration: AppAnimations.mediumDuration,
      curve: AppAnimations.defaultCurve,
      top: _showStickyHeader ? 0 : -100,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: AppSpacing.sm,
              left: AppSpacing.lg,
              right: AppSpacing.lg,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundPrimary.withAlpha(230),
              border: Border(
                bottom: BorderSide(color: AppColors.border),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: AppColors.textPrimary,
                ),
                AppSpacing.gapSM,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _course.title,
                        style: AppTypography.h4.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _course.category,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  text: _isEnrolled ? 'Continue' : 'Enroll Now',
                  size: GradientButtonSize.small,
                  onPressed: _handleEnrollment,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnrollmentFAB() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _fabController,
        builder: (context, child) {
          return Transform.scale(
            scale: _fabScale.value,
            alignment: Alignment.bottomCenter,
            child: child,
          );
        },
        child: Container(
          padding: EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: MediaQuery.of(context).padding.bottom + AppSpacing.md,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.backgroundPrimary.withAlpha(0),
                AppColors.backgroundPrimary,
              ],
            ),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                // Price info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_course.originalPrice != null)
                        Text(
                          '\$${_course.originalPrice}',
                          style: AppTypography.body.copyWith(
                            color: AppColors.textTertiary,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            _course.price == 0
                                ? 'Free'
                                : '\$${_course.price}',
                            style: AppTypography.h2.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (_course.originalPrice != null) ...[
                            AppSpacing.gapXS,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.xs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.success.withAlpha(25),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${((((_course.originalPrice ?? 0) - _course.price) / (_course.originalPrice ?? 1)) * 100).round()}% off',
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                // Enroll button
                _EnrollButton(
                  isEnrolled: _isEnrolled,
                  onPressed: _handleEnrollment,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + AppSpacing.sm,
      left: AppSpacing.sm,
      child: AnimatedOpacity(
        duration: AppAnimations.mediumDuration,
        opacity: _showStickyHeader ? 0 : 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(51),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_rounded),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleEnrollment() {
    HapticFeedback.mediumImpact();
    setState(() {
      _isEnrolled = !_isEnrolled;
    });
    // TODO: Implement actual enrollment logic
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SUPPORTING WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

class _LearningOutcomeItem extends StatelessWidget {
  const _LearningOutcomeItem({
    required this.outcome,
    required this.index,
    required this.isVisible,
  });

  final String outcome;
  final int index;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: isVisible ? 1 : 0),
      duration: Duration(milliseconds: 300 + (index * 100)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(20 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.success.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                color: AppColors.success,
                size: 16,
              ),
            ),
            AppSpacing.gapSM,
            Expanded(
              child: Text(
                outcome,
                style: AppTypography.body.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    required this.module,
    required this.index,
    required this.isExpanded,
    required this.onToggle,
  });

  final ModuleData module;
  final int index;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        border: Border.all(
          color: isExpanded ? AppColors.primaryPurple.withAlpha(77) : AppColors.border,
        ),
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withAlpha(25),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: AppTypography.h4.copyWith(
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.gapMD,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module.title,
                          style: AppTypography.h4.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        AppSpacing.gapXXS,
                        Text(
                          '${module.lessons.length} lessons • ${module.duration}',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: AppAnimations.mediumDuration,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Lessons list
          AnimatedCrossFade(
            duration: AppAnimations.mediumDuration,
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                Divider(color: AppColors.border, height: 1),
                ...List.generate(
                  module.lessons.length,
                  (lessonIndex) => _LessonItem(
                    lesson: module.lessons[lessonIndex],
                    index: lessonIndex,
                    isLast: lessonIndex == module.lessons.length - 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonItem extends StatelessWidget {
  const _LessonItem({
    required this.lesson,
    required this.index,
    required this.isLast,
  });

  final LessonData lesson;
  final int index;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: AppColors.border.withAlpha(128))),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: lesson.isCompleted
                  ? AppColors.success.withAlpha(25)
                  : AppColors.backgroundPrimary,
              shape: BoxShape.circle,
              border: lesson.isCompleted
                  ? null
                  : Border.all(color: AppColors.border),
            ),
            child: Center(
              child: lesson.isCompleted
                  ? Icon(
                      Icons.check_rounded,
                      color: AppColors.success,
                      size: 18,
                    )
                  : Icon(
                      _getLessonIcon(lesson.type),
                      color: AppColors.textTertiary,
                      size: 16,
                    ),
            ),
          ),
          AppSpacing.gapMD,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                AppSpacing.gapXXS,
                Row(
                  children: [
                    Icon(
                      _getLessonIcon(lesson.type),
                      size: 12,
                      color: AppColors.textTertiary,
                    ),
                    AppSpacing.gapXXS,
                    Text(
                      lesson.type,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    AppSpacing.gapSM,
                    Icon(
                      Icons.schedule_rounded,
                      size: 12,
                      color: AppColors.textTertiary,
                    ),
                    AppSpacing.gapXXS,
                    Text(
                      lesson.duration,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (lesson.isPreview)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withAlpha(25),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Preview',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getLessonIcon(String type) {
    switch (type.toLowerCase()) {
      case 'video':
        return Icons.play_circle_outline_rounded;
      case 'quiz':
        return Icons.quiz_outlined;
      case 'reading':
        return Icons.article_outlined;
      case 'interactive':
        return Icons.touch_app_outlined;
      case 'exercise':
        return Icons.fitness_center_rounded;
      default:
        return Icons.school_outlined;
    }
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final ReviewData review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    review.userInitials,
                    style: AppTypography.label.copyWith(
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              AppSpacing.gapSM,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: AppTypography.label.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < review.rating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: AppColors.warning,
                            size: 14,
                          );
                        }),
                        AppSpacing.gapXS,
                        Text(
                          review.date,
                          style: AppTypography.labelSmall.copyWith(
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
          AppSpacing.gapSM,
          Text(
            review.comment,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          if (review.isHelpful) ...[
            AppSpacing.gapSM,
            Row(
              children: [
                Icon(
                  Icons.thumb_up_rounded,
                  size: 14,
                  color: AppColors.textTertiary,
                ),
                AppSpacing.gapXXS,
                Text(
                  '${review.helpfulCount} found this helpful',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _RelatedCourseCard extends StatelessWidget {
  const _RelatedCourseCard({
    required this.title,
    required this.category,
    required this.lessons,
    required this.color,
  });

  final String title;
  final String category;
  final int lessons;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, color.withAlpha(179)],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSpacing.radiusLG - 1),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.school_rounded,
                color: Colors.white.withAlpha(179),
                size: 40,
              ),
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: AppTypography.labelSmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppSpacing.gapXXS,
                Text(
                  title,
                  style: AppTypography.label.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.gapXS,
                Text(
                  '$lessons lessons',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EnrollButton extends StatefulWidget {
  const _EnrollButton({
    required this.isEnrolled,
    required this.onPressed,
  });

  final bool isEnrolled;
  final VoidCallback onPressed;

  @override
  State<_EnrollButton> createState() => _EnrollButtonState();
}

class _EnrollButtonState extends State<_EnrollButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scale = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: AppAnimations.mediumDuration,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.isEnrolled
                  ? [AppColors.success, AppColors.successLight]
                  : [AppColors.primaryPurple, AppColors.primaryPurpleLight],
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
            boxShadow: [
              BoxShadow(
                color: (widget.isEnrolled ? AppColors.success : AppColors.primaryPurple)
                    .withAlpha(77),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.isEnrolled
                    ? Icons.play_arrow_rounded
                    : Icons.school_rounded,
                color: Colors.white,
              ),
              AppSpacing.gapSM,
              Text(
                widget.isEnrolled ? 'Continue Learning' : 'Enroll Now',
                style: AppTypography.button.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CUSTOM PAINTERS
// ═══════════════════════════════════════════════════════════════════════════

class _HeroPatternPainter extends CustomPainter {
  _HeroPatternPainter({
    required this.progress,
    required this.color,
  });

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw grid pattern
    const spacing = 40.0;
    for (var i = 0.0; i < size.width + size.height; i += spacing) {
      final lineProgress = (progress * 2 - i / (size.width + size.height))
          .clamp(0.0, 1.0);

      if (lineProgress > 0) {
        paint.color = color.withAlpha((color.alpha * lineProgress).round());

        // Diagonal lines
        canvas.drawLine(
          Offset(i, 0),
          Offset(0, i),
          paint,
        );
      }
    }

    // Draw circles
    final circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 0; i < 3; i++) {
      final radius = 50.0 + i * 30;
      final circleProgress = (progress - i * 0.2).clamp(0.0, 1.0);
      circlePaint.color = color.withAlpha((color.alpha * circleProgress * 0.5).round());
      canvas.drawCircle(
        Offset(size.width * 0.8, size.height * 0.3),
        radius * circleProgress,
        circlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HeroPatternPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DATA MODELS
// ═══════════════════════════════════════════════════════════════════════════

class CourseData {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final Color categoryColor;
  final String level;
  final IconData levelIcon;
  final IconData icon;
  final List<Color> gradientColors;
  final double rating;
  final int reviewCount;
  final Map<int, int> ratingDistribution;
  final int enrolledCount;
  final String lastUpdated;
  final int totalLessons;
  final int totalQuizzes;
  final String duration;
  final double price;
  final double? originalPrice;
  final List<String> learningOutcomes;
  final List<ModuleData> modules;
  final InstructorData instructor;
  final List<ReviewData> reviews;

  const CourseData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.categoryColor,
    required this.level,
    required this.levelIcon,
    required this.icon,
    required this.gradientColors,
    required this.rating,
    required this.reviewCount,
    required this.ratingDistribution,
    required this.enrolledCount,
    required this.lastUpdated,
    required this.totalLessons,
    required this.totalQuizzes,
    required this.duration,
    required this.price,
    this.originalPrice,
    required this.learningOutcomes,
    required this.modules,
    required this.instructor,
    required this.reviews,
  });

  factory CourseData.mock() {
    return CourseData(
      id: 'course_001',
      title: 'Stock Market Fundamentals',
      subtitle: 'Master the essentials of stock market investing. Learn how markets work, analyze stocks, and build your first portfolio with confidence.',
      category: 'Investing Basics',
      categoryColor: AppColors.primaryPurple,
      level: 'Beginner',
      levelIcon: Icons.signal_cellular_alt_1_bar_rounded,
      icon: Icons.candlestick_chart_rounded,
      gradientColors: [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      rating: 4.8,
      reviewCount: 2847,
      ratingDistribution: {5: 72, 4: 20, 3: 5, 2: 2, 1: 1},
      enrolledCount: 15420,
      lastUpdated: 'Jan 2025',
      totalLessons: 42,
      totalQuizzes: 8,
      duration: '6h 30m',
      price: 49.99,
      originalPrice: 99.99,
      learningOutcomes: [
        'Understand how stock markets operate and their role in the economy',
        'Read and analyze stock quotes, charts, and financial statements',
        'Identify different types of securities and their risk profiles',
        'Build a diversified portfolio aligned with your financial goals',
        'Apply fundamental and technical analysis techniques',
        'Manage risk and protect your investments with proven strategies',
      ],
      modules: [
        ModuleData(
          title: 'Introduction to Stock Markets',
          duration: '45 min',
          lessons: [
            LessonData(title: 'What is the Stock Market?', type: 'Video', duration: '8 min', isPreview: true, isCompleted: false),
            LessonData(title: 'History of Stock Exchanges', type: 'Reading', duration: '5 min', isPreview: false, isCompleted: false),
            LessonData(title: 'How Exchanges Work', type: 'Video', duration: '12 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Market Participants', type: 'Interactive', duration: '10 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Module 1 Quiz', type: 'Quiz', duration: '10 min', isPreview: false, isCompleted: false),
          ],
        ),
        ModuleData(
          title: 'Understanding Stock Prices',
          duration: '55 min',
          lessons: [
            LessonData(title: 'Supply and Demand Basics', type: 'Video', duration: '10 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Bid-Ask Spread Explained', type: 'Video', duration: '8 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Order Types Deep Dive', type: 'Interactive', duration: '15 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Practice: Place Different Orders', type: 'Exercise', duration: '12 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Module 2 Quiz', type: 'Quiz', duration: '10 min', isPreview: false, isCompleted: false),
          ],
        ),
        ModuleData(
          title: 'Types of Securities',
          duration: '1h 10min',
          lessons: [
            LessonData(title: 'Common vs Preferred Stock', type: 'Video', duration: '12 min', isPreview: false, isCompleted: false),
            LessonData(title: 'ETFs Explained', type: 'Video', duration: '15 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Mutual Funds Deep Dive', type: 'Reading', duration: '10 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Bonds and Fixed Income', type: 'Video', duration: '12 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Security Comparison Tool', type: 'Interactive', duration: '15 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Module 3 Quiz', type: 'Quiz', duration: '10 min', isPreview: false, isCompleted: false),
          ],
        ),
        ModuleData(
          title: 'Reading Stock Information',
          duration: '50 min',
          lessons: [
            LessonData(title: 'Understanding Stock Tickers', type: 'Video', duration: '8 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Reading Stock Quotes', type: 'Interactive', duration: '12 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Key Metrics Explained', type: 'Video', duration: '15 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Company Research Challenge', type: 'Exercise', duration: '15 min', isPreview: false, isCompleted: false),
          ],
        ),
        ModuleData(
          title: 'Building Your First Portfolio',
          duration: '1h 5min',
          lessons: [
            LessonData(title: 'Introduction to Diversification', type: 'Video', duration: '12 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Asset Allocation Strategies', type: 'Video', duration: '15 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Sector Distribution', type: 'Reading', duration: '8 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Portfolio Builder Tool', type: 'Interactive', duration: '20 min', isPreview: false, isCompleted: false),
            LessonData(title: 'Final Assessment', type: 'Quiz', duration: '15 min', isPreview: false, isCompleted: false),
          ],
        ),
      ],
      instructor: InstructorData(
        name: 'Dr. Sarah Chen',
        initials: 'SC',
        title: 'CFA, Former Goldman Sachs VP',
        bio: 'Dr. Sarah Chen is a CFA charterholder with over 15 years of experience in investment management. After spending a decade at Goldman Sachs, she transitioned to education, combining her practical expertise with a passion for teaching. Her courses have helped over 50,000 students start their investment journeys.',
        rating: 4.9,
        studentCount: 52340,
        courseCount: 8,
        isVerified: true,
      ),
      reviews: [
        ReviewData(
          userName: 'Michael T.',
          userInitials: 'MT',
          rating: 5,
          date: '2 weeks ago',
          comment: 'This course completely changed my understanding of the stock market. Sarah explains complex concepts in such an accessible way. The interactive exercises really helped solidify my learning.',
          isHelpful: true,
          helpfulCount: 127,
        ),
        ReviewData(
          userName: 'Jennifer L.',
          userInitials: 'JL',
          rating: 5,
          date: '1 month ago',
          comment: 'Perfect for beginners! I had zero knowledge about investing before this course. Now I feel confident enough to start building my portfolio. Highly recommend!',
          isHelpful: true,
          helpfulCount: 89,
        ),
        ReviewData(
          userName: 'David K.',
          userInitials: 'DK',
          rating: 4,
          date: '1 month ago',
          comment: 'Great content and well-structured lessons. Would have loved more advanced topics, but it\'s perfect for its target audience. The portfolio builder tool is fantastic!',
          isHelpful: false,
          helpfulCount: 45,
        ),
      ],
    );
  }
}

class ModuleData {
  final String title;
  final String duration;
  final List<LessonData> lessons;

  const ModuleData({
    required this.title,
    required this.duration,
    required this.lessons,
  });
}

class LessonData {
  final String title;
  final String type;
  final String duration;
  final bool isPreview;
  final bool isCompleted;

  const LessonData({
    required this.title,
    required this.type,
    required this.duration,
    required this.isPreview,
    required this.isCompleted,
  });
}

class InstructorData {
  final String name;
  final String initials;
  final String title;
  final String bio;
  final double rating;
  final int studentCount;
  final int courseCount;
  final bool isVerified;

  const InstructorData({
    required this.name,
    required this.initials,
    required this.title,
    required this.bio,
    required this.rating,
    required this.studentCount,
    required this.courseCount,
    required this.isVerified,
  });
}

class ReviewData {
  final String userName;
  final String userInitials;
  final int rating;
  final String date;
  final String comment;
  final bool isHelpful;
  final int helpfulCount;

  const ReviewData({
    required this.userName,
    required this.userInitials,
    required this.rating,
    required this.date,
    required this.comment,
    required this.isHelpful,
    required this.helpfulCount,
  });
}
