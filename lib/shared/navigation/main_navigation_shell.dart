import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../core/theme/app_colors.dart';
import '../../features/auth/presentation/widgets/home_top_bar.dart';
import '../../features/gamification/presentation/widgets/progress_tracker_section.dart';
import '../../features/learning/presentation/widgets/recommended_section.dart';
import '../../features/market/presentation/widgets/market_indices_section.dart';
import '../../features/social/presentation/widgets/community_insights_section.dart';
import '../../features/learning/presentation/pages/learning_screen.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  late PageController _pageController;

  final GlobalKey<CurvedNavigationBarState> _navBarKey = GlobalKey();

  late AnimationController _shimmerController;

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

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _shimmerController.dispose();
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
      duration: const Duration(milliseconds: 400),
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
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: const BouncingScrollPhysics(),
          children: const [
            _HomeScreenWrapper(),
            _MarketsScreenWrapper(),
            LearningScreen(),
          ],
        ),
        bottomNavigationBar: _buildGlassNavBar(),
      ),
    );
  }

  Widget _buildGlassNavBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, -10),
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: AnimatedBuilder(
            animation: _shimmerController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.05),
                      Colors.white.withOpacity(0.1),
                    ],
                    stops: [
                      0,
                      0.5 + 0.3 * _shimmerController.value,
                      1,
                    ],
                  ),
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withOpacity(0.2),
                      width: 0.5,
                    ),
                  ),
                ),
                child: child,
              );
            },
            child: CurvedNavigationBar(
              key: _navBarKey,
              index: _currentIndex,
              height: 65,
              items: _screens.map((screen) {
                final isSelected = _screens.indexOf(screen) == _currentIndex;
                return _buildNavIcon(screen, isSelected);
              }).toList(),
              color: const Color(0xFF1A1A2E).withOpacity(0.85),
              buttonBackgroundColor: AppColors.primaryPurple,
              backgroundColor: Colors.transparent,
              animationCurve: Curves.easeOutCubic,
              animationDuration: const Duration(milliseconds: 400),
              onTap: _onNavTap,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(_NavScreen screen, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.all(isSelected ? 12 : 10),
      child: Icon(
        isSelected ? screen.activeIcon : screen.icon,
        size: isSelected ? 28 : 24,
        color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
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
      body: SingleChildScrollView(
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
            CommunityInsightsSection(),
          ],
        ),
      ),
    );
  }
}

class _MarketsScreenWrapper extends StatelessWidget {
  const _MarketsScreenWrapper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          20,
          MediaQuery.of(context).padding.top + 20,
          20,
          100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Markets',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E2C),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track live market data',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            const MarketIndicesSection(),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Coming Soon',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E2C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Advanced charting, watchlists, and real-time alerts',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
