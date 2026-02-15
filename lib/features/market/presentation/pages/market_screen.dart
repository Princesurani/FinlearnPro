import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../bloc/market_bloc.dart';
import '../../widgets/market_selector.dart';
import '../../widgets/index_ticker.dart';
import 'explore_tab.dart';
import 'holdings_tab.dart';
import 'orders_tab.dart';
import 'watchlist_tab.dart';
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

  static const _tabLabels = ['Explore', 'Holdings', 'Orders', 'Watchlist'];

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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Market insights,',
                style: TextStyle(
                  fontSize: 11, // Further reduced for mobile fit
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 1),
              const Text(
                'Global Markets',
                style: TextStyle(
                  fontSize: 16, // Further reduced for mobile fit
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          actions: [
            MarketSelector(
              activeMarket: state.activeMarket,
              onMarketChanged: (m) => _bloc.add(SwitchMarket(m)),
            ),
            const SizedBox(width: 12),
            TopBarButton(icon: Icons.search_rounded, onTap: () {}),
          ],
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
          bloc: _bloc,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPaddingHorizontal,
          ),
        );
      },
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
                        ? Colors
                              .transparent // Selected uses indicator
                        : Colors
                              .transparent, // Unselected: no background, just border
                    border: isSelected
                        ? null
                        : Border.all(
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.5,
                            ), // Darker, more visible
                            width: 1.5, // Thicker border
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

  Widget _buildContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _ExploreStreamWrapper(bloc: _bloc),
        _HoldingsStreamWrapper(
          bloc: _bloc,
          onExplore: () => _tabController.animateTo(0),
        ),
        _OrdersStreamWrapper(
          bloc: _bloc,
          onExplore: () => _tabController.animateTo(0),
        ),
        _WatchlistStreamWrapper(
          bloc: _bloc,
          onExplore: () => _tabController.animateTo(0),
        ),
      ],
    );
  }
}

class _HoldingsStreamWrapper extends StatelessWidget {
  const _HoldingsStreamWrapper({required this.bloc, required this.onExplore});
  final MarketBloc bloc;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MarketState>(
      stream: bloc.stream,
      initialData: bloc.state,
      builder: (_, snap) {
        return HoldingsTab(state: snap.data!, onExplore: onExplore);
      },
    );
  }
}

class _OrdersStreamWrapper extends StatelessWidget {
  const _OrdersStreamWrapper({required this.bloc, required this.onExplore});
  final MarketBloc bloc;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MarketState>(
      stream: bloc.stream,
      initialData: bloc.state,
      builder: (_, snap) {
        return OrdersTab(state: snap.data!, onExplore: onExplore);
      },
    );
  }
}

class _WatchlistStreamWrapper extends StatelessWidget {
  const _WatchlistStreamWrapper({required this.bloc, required this.onExplore});
  final MarketBloc bloc;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MarketState>(
      stream: bloc.stream,
      initialData: bloc.state,
      builder: (_, snap) {
        final state = snap.data!;
        // Assuming WatchlistTab handles its own loading/error if needed,
        // or we can reuse error/loading logic here.
        // Since Watchlist is just a filter on existing data, it should be fast.
        // But if market data is loading, watchlist items might be missing snapshots.

        return WatchlistTab(state: state, onExplore: onExplore);
      },
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
