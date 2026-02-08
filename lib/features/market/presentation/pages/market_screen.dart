import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../bloc/market_bloc.dart';
import '../../widgets/country_selector.dart';
import '../../widgets/index_ticker.dart';
import 'explore_tab.dart';
import '../../../../shared/navigation/top_navigation_shell.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen>
    with SingleTickerProviderStateMixin {
  late final MarketBloc _bloc;
  late final TabController _tabController;

  static const _tabLabels = [
    'Explore',
    'Holdings',
    'Positions',
    'Orders',
    'My Watchlist',
    'All Watchlist',
  ];

  @override
  void initState() {
    super.initState();
    _bloc = MarketBloc();
    _bloc.resume();
    _tabController = TabController(length: _tabLabels.length, vsync: this);
  }

  @override
  void dispose() {
    _bloc.pause();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top + 12),
          Padding(padding: AppSpacing.screenPaddingH, child: _buildTopBar()),
          const SizedBox(height: 16),
          _buildIndexStrip(),
          _buildTabPills(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return StreamBuilder<MarketState>(
      stream: _bloc.stream,
      initialData: _bloc.state,
      builder: (_, snap) {
        final state = snap.data!;

        return TopNavigationShell(
          title: Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Market insights,',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Markets',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              CountrySelector(
                activeMarket: state.activeMarket,
                onMarketChanged: (m) => _bloc.add(SwitchMarket(m)),
              ),
            ],
          ),
          actions: [TopBarButton(icon: Icons.search_rounded, onTap: () {})],
        );
      },
    );
  }

  Widget _buildIndexStrip() {
    return StreamBuilder<MarketState>(
      stream: _bloc.stream,
      initialData: _bloc.state,
      builder: (_, snap) {
        final state = snap.data!;
        return IndexTicker(
          market: state.activeMarket,
          snapshots: state.snapshots,
          indices: state.indices,
        );
      },
    );
  }

  Widget _buildTabPills() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.borderLight, width: 1),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPaddingHorizontal - 4,
          vertical: AppSpacing.xs,
        ),
        indicator: BoxDecoration(
          color: AppColors.primaryPurple,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTypography.label.copyWith(
          fontWeight: AppTypography.semiBold,
          fontSize: 13,
        ),
        unselectedLabelStyle: AppTypography.label.copyWith(
          fontWeight: AppTypography.medium,
          fontSize: 13,
        ),
        dividerColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        tabs: _tabLabels.map((label) {
          return Tab(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xxs,
              ),
              child: Text(label),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _ExploreStreamWrapper(bloc: _bloc),
        _buildComingSoonTab('Holdings', Icons.pie_chart_outline_rounded),
        _buildComingSoonTab('Positions', Icons.swap_vert_rounded),
        _buildComingSoonTab('Orders', Icons.list_alt_rounded),
        _buildComingSoonTab('My Watchlist', Icons.bookmark_border_rounded),
        _buildComingSoonTab('All Watchlist', Icons.visibility_outlined),
      ],
    );
  }

  Widget _buildComingSoonTab(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withAlpha(15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: AppColors.primaryPurple),
          ),
          AppSpacing.gapLG,
          Text(
            title,
            style: AppTypography.h5.copyWith(color: AppColors.textPrimary),
          ),
          AppSpacing.gapXS,
          Text(
            'Coming soon',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreStreamWrapper extends StatelessWidget {
  const _ExploreStreamWrapper({required this.bloc});
  final MarketBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MarketState>(
      stream: bloc.stream,
      initialData: bloc.state,
      builder: (_, snap) {
        final state = snap.data!;

        if (state.status == MarketStatus.loading) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.primaryPurple,
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                Text('Loading market data...', style: AppTypography.bodySmall),
              ],
            ),
          );
        }

        if (state.status == MarketStatus.error) {
          return Center(
            child: Padding(
              padding: AppSpacing.screenPaddingH,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cloud_off_rounded,
                    size: 56,
                    color: AppColors.textTertiary,
                  ),
                  AppSpacing.gapLG,
                  Text(
                    'Something went wrong',
                    style: AppTypography.h5.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  AppSpacing.gapSM,
                  Text(
                    state.errorMessage ??
                        'Failed to load market data. Please try again.',
                    style: AppTypography.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  AppSpacing.gapXL,
                  FilledButton.icon(
                    onPressed: () => bloc.add(RefreshMarketData()),
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('Retry'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ExploreTab(state: state);
      },
    );
  }
}
