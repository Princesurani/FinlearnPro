import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../features/auth/presentation/widgets/home_top_bar.dart';

import '../../features/market/bloc/market_bloc.dart';
import '../../features/market/presentation/pages/market_screen.dart';
import '../../features/learning/presentation/pages/learning_screen.dart';
import '../../features/social/presentation/pages/social_profile_screen.dart';
import '../../features/home/presentation/widgets/home_overview_card.dart';
import '../../features/home/presentation/widgets/continue_learning_card.dart';
import '../../features/home/presentation/widgets/market_news_sentiment_card.dart';
import '../../features/learning/data/learning_data.dart';
import '../../features/learning/data/learning_models.dart';
import '../../features/learning/presentation/pages/course_details_screen.dart';
import '../../features/learning/bloc/learning_bloc_provider.dart';
import '../widgets/aurora_background.dart';
import '../../features/learning/bloc/learning_bloc.dart';
import '../../features/social/bloc/social_bloc.dart';
import '../../features/social/data/repositories/social_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key, required this.firebaseUid});

  final String firebaseUid;

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  late PageController _pageController;

  static const List<_NavScreen> _screens = [
    _NavScreen(
      icon: Icons.home_rounded,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    _NavScreen(
      icon: Icons.auto_stories_outlined,
      activeIcon: Icons.auto_stories_rounded,
      label: 'Learn',
    ),
    _NavScreen(
      icon: Icons.candlestick_chart_outlined,
      activeIcon: Icons.candlestick_chart_rounded,
      label: 'Markets',
    ),
    _NavScreen(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  late MarketBloc _marketBloc;
  late LearningBloc _learningBloc;
  late SocialBloc _socialBloc;
  StreamSubscription<LearningState>? _learningSub;
  int? _lastLocalXp;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: _currentIndex,
      keepPage: true,
    );
    _marketBloc = MarketBloc(firebaseUid: widget.firebaseUid);
    _marketBloc.resume();
    _learningBloc = LearningBloc(userId: widget.firebaseUid);
    
    _socialBloc = SocialBloc(repository: SocialRepository())
      ..add(LoadProfile(widget.firebaseUid));
      
    // Listen to local XP changes and sync Social profile automatically
    _learningSub = _learningBloc.stream.listen((state) {
      final currentXp = state.userProgress.totalXp;
      if (_lastLocalXp != null && currentXp > _lastLocalXp!) {
        // Add a delay to allow the backend HTTP request to complete saving the XP 
        // before we fetch the updated profile back from Postgres.
        Future.delayed(const Duration(milliseconds: 3000), () {
          if (mounted) {
            _socialBloc.add(LoadProfile(widget.firebaseUid));
          }
        });
      }
      _lastLocalXp = currentXp;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _marketBloc.pause();
    _learningBloc.dispose();
    _socialBloc.close();
    _learningSub?.cancel();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == _currentIndex) return;

    HapticFeedback.lightImpact();

    setState(() {
      _currentIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  void _onPageChanged(int index) {
    if (index == _currentIndex) return;

    HapticFeedback.selectionClick();

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
      ),
      child: BlocProvider.value(
        value: _socialBloc,
        child: LearningBlocProvider(
          bloc: _learningBloc,
          child: Scaffold(
          backgroundColor: AppColors.backgroundPrimary,
          extendBody: true,
          body: Stack(
            children: [
              const Positioned.fill(child: AuroraBackground()),
              PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                physics: const ClampingScrollPhysics(),
                children: [
                  _HomeScreenWrapper(
                    bloc: _marketBloc,
                    onNavigateToLearn: () => _onNavTap(1),
                    onNavigateToMarket: () => _onNavTap(2),
                  ),
                  const LearningScreen(),
                  RepaintBoundary(child: MarketScreen(bloc: _marketBloc)),
                  const SocialProfileScreen(),
                ],
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 34,
                height: 64,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                            255,
                            19,
                            19,
                            28,
                          ).withValues(alpha: 0.90),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.08),
                            width: 1,
                          ),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final itemWidth =
                                constraints.maxWidth / _screens.length;

                            return Stack(
                              children: [
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOutCubic,
                                  left: itemWidth * _currentIndex,
                                  top: 4,
                                  bottom: 4,
                                  width: itemWidth,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: AppColors.primaryGradient,
                                      borderRadius: BorderRadius.circular(36),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary
                                              .withValues(alpha: 0.4),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  children: _screens.asMap().entries.map((
                                    entry,
                                  ) {
                                    final index = entry.key;
                                    final screen = entry.value;
                                    final isSelected = index == _currentIndex;

                                    return Expanded(
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () => _onNavTap(index),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: AnimatedScale(
                                            scale: isSelected ? 1.05 : 1.0,
                                            duration: const Duration(
                                              milliseconds: 200,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  isSelected
                                                      ? screen.activeIcon
                                                      : screen.icon,
                                                  size: 24,
                                                  color: isSelected
                                                      ? AppColors.white
                                                      : AppColors.white
                                                            .withValues(
                                                              alpha: 0.5,
                                                            ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  screen.label,
                                                  style: TextStyle(
                                                    color: isSelected
                                                        ? AppColors.white
                                                        : AppColors.white
                                                              .withValues(
                                                                alpha: 0.5,
                                                              ),
                                                    fontSize: 11,
                                                    fontWeight: isSelected
                                                        ? FontWeight.w600
                                                        : FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

class _HomeScreenWrapper extends StatelessWidget {
  const _HomeScreenWrapper({
    required this.bloc,
    required this.onNavigateToLearn,
    required this.onNavigateToMarket,
  });

  final MarketBloc bloc;
  final VoidCallback onNavigateToLearn;
  final VoidCallback onNavigateToMarket;

  @override
  Widget build(BuildContext context) {
    final learningBloc = LearningBlocProvider.of(context);

    return StreamBuilder<LearningState>(
      stream: learningBloc.stream,
      initialData: learningBloc.state,
      builder: (context, snapshot) {
        final learningState = snapshot.data;
        
        Course? continueCourse;

        if (learningState != null) {
          final progress = learningState.userProgress;
          
          // 1. Find Continue Learning Course
          final inProgressCourses = progress.courseProgress.values
              .where((p) => p.status == ProgressStatus.inProgress)
              .toList();
          
          if (inProgressCourses.isNotEmpty) {
            inProgressCourses.sort((a, b) => b.lastAccessedDate.compareTo(a.lastAccessedDate));
            continueCourse = LearningData.allCourses.firstWhere(
              (c) => c.id == inProgressCourses.first.courseId,
              orElse: () => LearningData.allCourses.first,
            );
          } else {
            // Find first not started course
            continueCourse = LearningData.allCourses.firstWhere(
              (c) {
                final p = progress.courseProgress[c.id];
                return p == null || p.status == ProgressStatus.notStarted;
              },
              orElse: () => LearningData.allCourses.first,
            );
            
            // Hide continue course if all courses are completed
            final allCompleted = LearningData.allCourses.every((c) {
              final p = progress.courseProgress[c.id];
              return p != null && p.status == ProgressStatus.completed;
            });
            if (allCompleted) {
              continueCourse = null;
            }
          }
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            20,
            MediaQuery.of(context).padding.top + 12,
            20,
            100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTopBar(),
              const SizedBox(height: 30),
              HomeOverviewCard(marketBloc: bloc),
              if (continueCourse != null) ...[
                const SizedBox(height: 30),
                ContinueLearningCard(
                  course: continueCourse,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => LearningBlocProvider(
                          bloc: learningBloc,
                          child: CourseDetailsScreen(
                            course: continueCourse!,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
              const SizedBox(height: 30),
              MarketNewsSentimentCard(onTradeTap: onNavigateToMarket),
            ],
          ),
        );
      },
    );
  }
}

class _NavScreen {
  const _NavScreen({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}
