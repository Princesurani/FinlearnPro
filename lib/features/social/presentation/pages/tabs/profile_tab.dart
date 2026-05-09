import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../bloc/social_bloc.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        if (state.status == SocialStatus.loading && state.myProfile == null) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple));
        }
        
        final profile = state.myProfile;
        if (profile == null) {
          return const Center(child: Text('Failed to load profile', style: TextStyle(color: AppColors.white)));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primaryPurple.withValues(alpha: 0.2),
                backgroundImage: profile.avatarUrl != null ? NetworkImage(profile.avatarUrl!) : null,
                child: profile.avatarUrl == null
                    ? const Icon(Icons.person, size: 50, color: AppColors.primaryPurple)
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                profile.displayName,
                style: const TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (profile.bio != null) ...[
                const SizedBox(height: 8),
                Text(
                  profile.bio!,
                  style: TextStyle(color: AppColors.white.withValues(alpha: 0.7), fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 24),
              
              // Level Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'Level ${profile.level}',
                      style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${profile.totalXp} XP',
                      style: TextStyle(color: AppColors.white.withValues(alpha: 0.9), fontSize: 14),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Stats Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _StatCard(title: 'Trades', value: profile.totalTrades.toString(), icon: Icons.compare_arrows),
                  _StatCard(title: 'Win Rate', value: '${(profile.winRate * 100).toStringAsFixed(1)}%', icon: Icons.trending_up),
                  _StatCard(title: 'Courses', value: profile.totalCoursesCompleted.toString(), icon: Icons.menu_book),
                  _StatCard(title: 'Challenges', value: profile.totalChallengesCompleted.toString(), icon: Icons.military_tech),
                ],
              ),
              const SizedBox(height: 100), // padding for bottom nav
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryPurple, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(color: AppColors.white.withValues(alpha: 0.5), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
