import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/navigation/top_navigation_shell.dart';
import '../../../market/bloc/market_bloc.dart';
import 'tabs/portfolio_tab.dart';
import '../../bloc/social_bloc.dart';
import 'tabs/league_tab.dart';
import 'tabs/profile_tab.dart';

class SocialProfileScreen extends StatelessWidget {
  const SocialProfileScreen({super.key, required this.marketBloc});

  final MarketBloc marketBloc;

  @override
  Widget build(BuildContext context) {
    return _SocialProfileView(marketBloc: marketBloc);
  }
}

class _SocialProfileView extends StatefulWidget {
  const _SocialProfileView({required this.marketBloc});

  final MarketBloc marketBloc;

  @override
  State<_SocialProfileView> createState() => _SocialProfileViewState();
}

class _SocialProfileViewState extends State<_SocialProfileView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  static const _tabLabels = ['Profile', 'Portfolio', 'League'];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLabels.length, vsync: this);
    
    // Only load heavy social features when the user visits the social section
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      if (uid.isNotEmpty && mounted) {
        final bloc = context.read<SocialBloc>();
        if (bloc.state.leaderboard.isEmpty) bloc.add(LoadLeaderboard());
        if (bloc.state.feed.isEmpty) bloc.add(LoadFeed(uid));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
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
              children: [
                const ProfileTab(),
                StreamBuilder<MarketState>(
                  stream: widget.marketBloc.stream,
                  initialData: widget.marketBloc.state,
                  builder: (context, snapshot) => PortfolioTab(
                    state: snapshot.data ?? MarketState.initial(),
                    bloc: widget.marketBloc,
                    onExplore: () {},
                  ),
                ),
                const LeagueTab(),
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
          Text(
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
            color: AppColors.textSecondary.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: false, // Fill available width
        indicator: BoxDecoration(
          color: AppColors.primaryButton,
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
                        : AppColors.textSecondary.withValues(alpha: 0.02),
                    border: isSelected
                        ? null
                        : Border.all(
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.08,
                            ),
                            width: 1.0,
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
