import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/navigation/top_navigation_shell.dart';
import '../../bloc/social_bloc.dart';
import '../../data/repositories/social_repository.dart';
import 'tabs/leaderboard_tab.dart';
import 'tabs/feed_tab.dart';
import 'tabs/friends_tab.dart';
import 'tabs/profile_tab.dart';

class SocialProfileScreen extends StatelessWidget {
  const SocialProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';

    return BlocProvider(
      create: (context) => SocialBloc(repository: SocialRepository())
        ..add(LoadProfile(uid))
        ..add(LoadLeaderboard())
        ..add(LoadFeed(uid)),
      child: const _SocialProfileView(),
    );
  }
}

class _SocialProfileView extends StatefulWidget {
  const _SocialProfileView();

  @override
  State<_SocialProfileView> createState() => _SocialProfileViewState();
}

class _SocialProfileViewState extends State<_SocialProfileView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabLabels = ['Profile', 'Leaderboard', 'Feed', 'Friends'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLabels.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top + 12),
          Padding(
            padding: AppSpacing.screenPaddingH,
            child: _buildTopBar(),
          ),
          const SizedBox(height: 16),
          _buildTabPills(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ProfileTab(),
                LeaderboardTab(),
                FeedTab(),
                FriendsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return TopNavigationShell(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Your journey,',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 1),
          const Text(
            'Profile & Social',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabPills() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingHorizontal,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.white.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: false, // Fill available width
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTypography.label.copyWith(
          fontWeight: AppTypography.semiBold,
          fontSize: 13,
        ),
        unselectedLabelStyle: AppTypography.label.copyWith(
          fontWeight: AppTypography.medium,
          fontSize: 13,
        ),
        dividerColor: AppColors.transparent,
        overlayColor: WidgetStateProperty.all(AppColors.transparent),
        splashFactory: NoSplash.splashFactory,
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 4,
        ), // Add spacing between tabs
        tabs: _tabLabels.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          return Tab(
            child: AnimatedBuilder(
              animation: _tabController,
              builder: (context, child) {
                final isSelected = _tabController.index == index;
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.transparent
                        : Colors.transparent,
                    border: isSelected
                        ? null
                        : Border.all(
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.5,
                            ),
                            width: 1.5,
                          ),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
