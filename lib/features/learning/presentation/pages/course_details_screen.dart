import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/learning_models.dart';
import 'lesson_screen.dart';
import '../../bloc/learning_bloc.dart';
import '../../bloc/learning_bloc_provider.dart';

class CourseDetailsScreen extends StatefulWidget {
  final Course course;

  const CourseDetailsScreen({super.key, required this.course});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      if (_scrollController.offset > 200 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 200 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _startCourse() {
    if (widget.course.modules.isEmpty ||
        widget.course.modules.first.lessons.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course content is not available yet.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final bloc = LearningBlocProvider.of(context);
    final courseProgress =
        bloc.state.userProgress.courseProgress[widget.course.id];
    final completedLessonIds = courseProgress?.completedLessonIds ?? [];

    Lesson? targetLesson;
    int targetGlobalIndex = 0;

    int globalIndex = 0;
    for (final module in widget.course.modules) {
      for (final lesson in module.lessons) {
        if (targetLesson == null && !completedLessonIds.contains(lesson.id)) {
          targetLesson = lesson;
          targetGlobalIndex = globalIndex;
        }
        globalIndex++;
      }
    }

    if (targetLesson == null) {
      targetLesson = widget.course.modules.first.lessons.first;
      targetGlobalIndex = 0;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LearningBlocProvider(
          bloc: bloc,
          child: LessonScreen(
            lesson: targetLesson!,
            course: widget.course,
            lessonIndex: targetGlobalIndex,
            totalLessons: widget.course.totalLessons,
          ),
        ),
      ),
    );
  }

  void _startLesson(Lesson lesson, int globalLessonIndex) {
    final bloc = LearningBlocProvider.of(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LearningBlocProvider(
          bloc: bloc,
          child: LessonScreen(
            lesson: lesson,
            course: widget.course,
            lessonIndex: globalLessonIndex,
            totalLessons: widget.course.totalLessons,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Stack(
        children: [
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                _buildSliverAppBar(),
                SliverPersistentHeader(
                  delegate: _StickyTabBarDelegate(
                    tabBar: TabBar(
                      controller: _tabController,
                      labelColor: AppColors.primaryPurple,
                      unselectedLabelColor: AppColors.textSecondary,
                      indicatorColor: AppColors.primaryPurple,
                      indicatorWeight: 3,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      tabs: const [
                        Tab(text: 'Overview'),
                        Tab(text: 'Curriculum'),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [_buildOverviewTab(), _buildCurriculumTab()],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 340,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.backgroundPrimary,
      elevation: 0,
      systemOverlayStyle: _isScrolled
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _isScrolled
              ? AppColors.transparent
              : AppColors.black.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: _isScrolled ? AppColors.textPrimary : AppColors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: _isScrolled
                ? AppColors.transparent
                : AppColors.black.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.bookmark_border_rounded,
              color: _isScrolled ? AppColors.textPrimary : AppColors.white,
            ),
            onPressed: () {},
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: _isScrolled
            ? Text(
                widget.course.title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Hero Image
            Hero(
              tag: 'course_image_${widget.course.id}',
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.course.accentColor ?? AppColors.primaryPurple,
                      AppColors.darkBackground,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: widget.course.thumbnailUrl.startsWith('assets')
                    ? Image.asset(
                        widget.course.thumbnailUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(),
                      )
                    : null,
              ),
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: 0.1),
                    AppColors.black.withValues(alpha: 0.3),
                    AppColors.backgroundPrimary,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
            // Content
            Positioned(
              bottom: 60,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges
                  Row(
                    children: [
                      _buildGlassBadge(
                        widget.course.categoryId.toUpperCase(),
                        AppColors.primaryPurple,
                      ),
                      const SizedBox(width: 8),
                      _buildGlassBadge(
                        widget.course.difficulty.label,
                        widget.course.difficulty.color,
                        icon: widget.course.difficulty.icon,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.course.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white, // Changed for new gradient
                      height: 1.2,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.course.subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  // Stats Row
                  Row(
                    children: [
                      _buildStat(
                        Icons.star_rounded,
                        '${widget.course.rating}',
                        Colors.amber,
                      ),
                      const SizedBox(width: 16),
                      _buildStat(
                        Icons.people_alt_rounded,
                        widget.course.formattedEnrollment.replaceAll(
                          ' Students',
                          '',
                        ),
                        Colors.blueAccent,
                      ),
                      const SizedBox(width: 16),
                      _buildStat(
                        Icons.access_time_filled_rounded,
                        widget.course.formattedDuration,
                        Colors.greenAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassBadge(String text, Color color, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: AppColors.white),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('About this Course'),
          const SizedBox(height: 12),
          Text(
            widget.course.description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          _buildLearningOutcomes(),
          const SizedBox(height: 32),
          _buildInstructorProfile(),
        ],
      ),
    );
  }

  Widget _buildLearningOutcomes() {
    if (widget.course.learningOutcomes.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: AppColors.primaryPurple,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'What you\'ll learn',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...widget.course.learningOutcomes.map(
            (outcome) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.success,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      outcome,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorProfile() {
    // Mock instructor data since simpler models don't have it
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Instructor'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.backgroundTertiary,
                child: Icon(Icons.person, color: AppColors.primaryPurple),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FinLearn Expert Team',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Finance & Trading Professionals',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurriculumTab() {
    final bloc = LearningBlocProvider.of(context);
    return StreamBuilder<LearningState>(
      stream: bloc.stream,
      initialData: bloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state == null) return const SizedBox();
        final courseProgress =
            state.userProgress.courseProgress[widget.course.id];
        final completedLessonIds = courseProgress?.completedLessonIds ?? [];

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
          itemCount: widget.course.modules.length,
          itemBuilder: (context, index) {
            return _buildModuleCard(
              widget.course.modules[index],
              index + 1,
              completedLessonIds,
            );
          },
        );
      },
    );
  }

  Widget _buildModuleCard(
    CourseModule module,
    int index,
    List<String> completedLessonIds,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        backgroundColor: AppColors.white,
        collapsedBackgroundColor: AppColors.white,
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        title: Text(
          module.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          '${module.lessons.length} Lessons',
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        children: module.lessons.asMap().entries.map((entry) {
          final lessonIndex = entry.key;
          final lesson = entry.value;

          final globalIndex = _getGlobalLessonIndex(module, lessonIndex);
          return _buildLessonTile(
            lesson,
            globalIndex,
            entry.key == module.lessons.length - 1,
            completedLessonIds.contains(lesson.id),
          );
        }).toList(),
      ),
    );
  }

  int _getGlobalLessonIndex(
    CourseModule currentModule,
    int lessonIndexInModule,
  ) {
    int globalIndex = 0;
    for (final module in widget.course.modules) {
      if (module.id == currentModule.id) {
        return globalIndex + lessonIndexInModule;
      }
      globalIndex += module.lessons.length;
    }
    return globalIndex;
  }

  Widget _buildLessonTile(
    Lesson lesson,
    int globalIndex,
    bool isLast,
    bool isCompleted,
  ) {
    return InkWell(
      onTap: () => _startLesson(lesson, globalIndex),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
          ),
          color: AppColors.backgroundTertiary.withValues(alpha: 0.3),
        ),
        child: Row(
          children: [
            // Timeline connector style
            Column(
              children: [
                Container(width: 2, height: 10, color: AppColors.border),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryPurple,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    lesson.contentType.icon,
                    size: 12,
                    color: AppColors.primaryPurple,
                  ),
                ),
                if (!isLast)
                  Container(width: 2, height: 10, color: AppColors.border),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        lesson.formattedDuration,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              isCompleted
                  ? Icons.check_circle_rounded
                  : Icons.play_circle_fill_rounded,
              color: isCompleted ? AppColors.success : AppColors.primaryPurple,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildBottomBar() {
    final bloc = LearningBlocProvider.of(context);
    return StreamBuilder<LearningState>(
      stream: bloc.stream,
      initialData: bloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state == null) return const SizedBox();
        final courseProgress =
            state.userProgress.courseProgress[widget.course.id];
        final completedLessonIds = courseProgress?.completedLessonIds ?? [];
        final bool hasStarted = completedLessonIds.isNotEmpty;

        return Positioned(
          bottom: 30,
          left: 32,
          right: 32,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryPurple.withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _startCourse,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    hasStarted ? 'Continue Learning' : 'Start Course',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _StickyTabBarDelegate({required this.tabBar});

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.backgroundPrimary, child: tabBar);
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
