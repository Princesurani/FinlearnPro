import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../bloc/social_bloc.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        if (state.status == SocialStatus.loading && state.leaderboard.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple));
        }

        final leaderboard = state.leaderboard;

        return Column(
          children: [
            const SizedBox(height: 16),
            // Metrics Toggle (All Time XP only for now, per user request)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'All-Time Top Traders (XP)',
                style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: leaderboard.isEmpty
                  ? Center(child: Text('No entries yet.', style: TextStyle(color: AppColors.white.withValues(alpha: 0.5))))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                      itemCount: leaderboard.length,
                      itemBuilder: (context, index) {
                        final entry = leaderboard[index];
                        final isTop3 = index < 3;
                        
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isTop3 ? AppColors.primaryPurple.withValues(alpha: 0.1) : AppColors.surface.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isTop3 ? Colors.amber.withValues(alpha: 0.5) : AppColors.white.withValues(alpha: 0.05),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Rank
                              SizedBox(
                                width: 30,
                                child: Text(
                                  '#${entry.rank}',
                                  style: TextStyle(
                                    color: isTop3 ? Colors.amber : AppColors.white.withValues(alpha: 0.5),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Avatar
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primaryPurple.withValues(alpha: 0.2),
                                child: Text(
                                  entry.displayName[0].toUpperCase(),
                                  style: const TextStyle(color: AppColors.white),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Name & Level
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.displayName,
                                      style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w600, fontSize: 16),
                                    ),
                                    Text(
                                      'Level ${entry.level}',
                                      style: TextStyle(color: AppColors.white.withValues(alpha: 0.5), fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              // XP
                              Text(
                                '${entry.totalXp} XP',
                                style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
