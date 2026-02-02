import 'package:flutter/material.dart';
import '../features/auth/presentation/widgets/home_top_bar.dart';
import '../features/gamification/presentation/widgets/progress_tracker_section.dart';
import '../features/learning/presentation/widgets/recommended_section.dart';
import '../features/market/presentation/widgets/market_indices_section.dart';
import '../features/social/presentation/widgets/community_insights_section.dart';
import '../shared/navigation/floating_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // Soft light background
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).padding.top + 20,
              20,
              100, // Bottom padding for floating nav
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
          // Floating Bottom Navigation Bar
          const Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: FloatingBottomNavBar(),
          ),
        ],
      ),
    );
  }
}
