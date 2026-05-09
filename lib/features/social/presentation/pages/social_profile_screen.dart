import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/theme/app_colors.dart';
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

class _SocialProfileViewState extends State<_SocialProfileView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        title: const Text(
          'Profile & Social',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: AppColors.primaryPurple,
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.white.withValues(alpha: 0.5),
          dividerColor: AppColors.transparent,
          tabs: const [
            Tab(text: 'Profile'),
            Tab(text: 'Leaderboard'),
            Tab(text: 'Feed'),
            Tab(text: 'Friends'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ProfileTab(),
          LeaderboardTab(),
          FeedTab(),
          FriendsTab(),
        ],
      ),
    );
  }
}
