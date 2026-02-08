import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../core/theme/app_colors.dart';
import '../../features/auth/presentation/widgets/home_top_bar.dart';
import '../../features/gamification/presentation/widgets/progress_tracker_section.dart';
import '../../features/learning/presentation/widgets/recommended_section.dart';
import '../../features/market/presentation/widgets/market_indices_section.dart';
import '../../features/market/presentation/widgets/blogs_section.dart';
import '../../features/market/presentation/pages/market_screen.dart';
import '../../features/learning/presentation/pages/learning_screen.dart';
import '../widgets/aurora_background.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  late PageController _pageController;

  final GlobalKey<CurvedNavigationBarState> _navBarKey = GlobalKey();

  static const List<_NavScreen> _screens = [
    _NavScreen(
      icon: Icons.home_rounded,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    _NavScreen(
      icon: Icons.candlestick_chart_outlined,
      activeIcon: Icons.candlestick_chart_rounded,
      label: 'Markets',
    ),
    _NavScreen(
      icon: Icons.auto_stories_outlined,
      activeIcon: Icons.auto_stories_rounded,
      label: 'Learn',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: _currentIndex,
      keepPage: true,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
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

    _navBarKey.currentState?.setPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        extendBody: true,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: const ClampingScrollPhysics(),
              children: const [
                _HomeScreenWrapper(),
                RepaintBoundary(child: MarketScreen()),
                LearningScreen(),
              ],
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: _buildGlassNavBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassNavBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: CurvedNavigationBar(
        key: _navBarKey,
        index: _currentIndex,
        height: 60,
        items: _screens.map((screen) {
          final isSelected = _screens.indexOf(screen) == _currentIndex;
          return Icon(
            isSelected ? screen.activeIcon : screen.icon,
            size: isSelected ? 28 : 24,
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.6),
          );
        }).toList(),
        color: const Color(0xFF1E1E2C),
        buttonBackgroundColor: AppColors.primaryPurple,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeOutCubic,
        animationDuration: const Duration(milliseconds: 280),
        onTap: _onNavTap,
      ),
    );
  }
}

class _HomeScreenWrapper extends StatelessWidget {
  const _HomeScreenWrapper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: Stack(
        children: [
          const Positioned.fill(child: AuroraBackground()),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).padding.top + 20,
              20,
              100,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeTopBar(),
                SizedBox(height: 30),
                ProgressTrackerSection(),
                SizedBox(height: 30),
                MarketIndicesSection(),
                SizedBox(height: 30),
                RecommendedSection(),
                SizedBox(height: 30),
                BlogsSection(),
              ],
            ),
          ),
        ],
      ),
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
