import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../bloc/social_bloc.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key});

  static const _filters = [
    {'label': 'XP', 'type': 'xp'},
    {'label': 'Trades', 'type': 'trades'},
    {'label': 'Streaks', 'type': 'streak'},
    {'label': 'Win Rate', 'type': 'win_rate'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        if (state.status == SocialStatus.loading && state.leaderboard.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple));
        }

        final leaderboard = state.leaderboard;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Filter chips
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: AppSpacing.screenPaddingH,
                itemCount: _filters.length,
                  separatorBuilder: (context, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    final isSelected = state.leaderboardType == filter['type'];
                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        context.read<SocialBloc>().add(LoadLeaderboard(
                          type: filter['type']!,
                          period: state.leaderboardPeriod,
                        ));
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryPurple : AppColors.surface,
                          borderRadius: AppSpacing.borderRadiusFull,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryPurple
                                : AppColors.textSecondary.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Text(
                          filter['label']!,
                          style: AppTypography.labelSmall.copyWith(
                            color: isSelected ? AppColors.white : AppColors.textSecondary,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: AppSpacing.screenPaddingH,
                child: Row(
                  children: [
                    Text('Top Traders', style: AppTypography.h5),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: leaderboard.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.goldenYellow.withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.emoji_events_outlined, size: 48, color: AppColors.goldenYellow),
                            ),
                            const SizedBox(height: 16),
                            Text('No leaderboard data yet', style: AppTypography.bodySmall),
                            const SizedBox(height: 4),
                            Text('Start trading to earn XP!', style: AppTypography.bodyXS),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.screenPaddingHorizontal, 0,
                          AppSpacing.screenPaddingHorizontal, 100,
                        ),
                        itemCount: leaderboard.length,
                        itemBuilder: (context, index) {
                          final entry = leaderboard[index];
                          final isTop3 = index < 3;
                          final medalColors = [
                            AppColors.goldenYellow,
                            AppColors.textDisabled,
                            const Color(0xFFCD7F32),
                          ];
  
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isTop3
                                  ? AppColors.primaryPurple.withValues(alpha: 0.06)
                                  : AppColors.surface,
                              borderRadius: AppSpacing.borderRadiusLG,
                              border: Border.all(
                                color: isTop3
                                    ? AppColors.primaryPurple.withValues(alpha: 0.2)
                                    : AppColors.border,
                              ),
                            ),
                            child: Row(
                              children: [
                                // Rank badge
                                SizedBox(
                                  width: 32,
                                  child: isTop3
                                      ? Icon(Icons.emoji_events_rounded, size: 22, color: medalColors[index])
                                      : Text(
                                          '#${entry.rank}',
                                          style: AppTypography.labelMedium.copyWith(
                                            color: AppColors.textTertiary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 10),
                                // Avatar
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppColors.primaryPurple.withValues(alpha: 0.12),
                                  child: Text(
                                    entry.displayName[0].toUpperCase(),
                                    style: AppTypography.labelMedium.copyWith(color: AppColors.primaryPurple),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                // Name + Level
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(entry.displayName, style: AppTypography.bodyMedium),
                                      Text('Level ${entry.level}', style: AppTypography.bodyXS),
                                    ],
                                  ),
                                ),
                                // Stat value
                                Text(
                                  _getStatValue(entry, state.leaderboardType),
                                  style: AppTypography.labelMedium.copyWith(
                                    color: AppColors.primaryPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
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
  
    String _getStatValue(dynamic entry, String type) {
      switch (type) {
        case 'trades':
          return '${entry.totalTrades} trades';
        case 'streak':
          return '${entry.currentStreak}🔥';
        case 'win_rate':
          return '${(entry.winRate * 100).toStringAsFixed(1)}%';
        default:
          return '${entry.totalXp} XP';
      }
    }
  }
