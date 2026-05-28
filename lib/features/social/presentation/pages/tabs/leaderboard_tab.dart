import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../bloc/social_bloc.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        if (state.isLeaderboardLoading && state.leaderboard.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }

        final leaderboard = state.leaderboard;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: AppSpacing.screenPaddingH,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.goldenYellow.withValues(alpha: 0.15),
                      borderRadius: AppSpacing.borderRadiusLG,
                    ),
                    child: const Icon(Icons.leaderboard_rounded, color: AppColors.goldenYellow),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Global Leaderboard', style: AppTypography.h4),
                      Text('Ranked by all-time XP', style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
                          const Color(0xFFCD7F32), // Bronze
                        ];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isTop3 ? null : AppColors.surface,
                            gradient: isTop3
                                ? LinearGradient(
                                    colors: [
                                      medalColors[index].withValues(alpha: 0.12),
                                      AppColors.surface,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            borderRadius: AppSpacing.borderRadiusLG,
                            border: Border.all(
                              color: isTop3
                                  ? medalColors[index].withValues(alpha: 0.5)
                                  : AppColors.border,
                              width: isTop3 ? 1.5 : 1,
                            ),
                            boxShadow: isTop3
                                ? [
                                    BoxShadow(
                                      color: medalColors[index].withValues(alpha: 0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    )
                                  ]
                                : null,
                          ),
                          child: Row(
                            children: [
                              // Rank badge
                              SizedBox(
                                width: 36,
                                child: isTop3
                                    ? Icon(Icons.workspace_premium_rounded, size: 32, color: medalColors[index])
                                    : Text(
                                        '#${entry.rank}',
                                        style: AppTypography.h5.copyWith(
                                          color: AppColors.textTertiary,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                              ),
                              const SizedBox(width: 16),
                              // Avatar
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: isTop3 ? AppColors.primaryGradient : null,
                                ),
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: isTop3 
                                      ? AppColors.backgroundPrimary 
                                      : AppColors.primary.withValues(alpha: 0.12),
                                  child: Text(
                                    entry.username[0].toUpperCase(),
                                    style: AppTypography.labelLarge.copyWith(color: AppColors.primary),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Name & Stats
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            entry.username,
                                            style: AppTypography.labelLarge,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withValues(alpha: 0.1),
                                            borderRadius: AppSpacing.borderRadiusFull,
                                          ),
                                          child: Text(
                                            'Lvl ${entry.level}',
                                            style: AppTypography.labelSmall.copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // Stats Row
                                    Wrap(
                                      spacing: 12,
                                      runSpacing: 6,
                                      children: [
                                        _buildStatBadge(Icons.auto_awesome_rounded, '${entry.totalXp} XP', AppColors.primary),
                                        _buildStatBadge(Icons.swap_horiz_rounded, '${entry.totalTrades}', AppColors.textSecondary),
                                        _buildStatBadge(Icons.trending_up_rounded, '${(entry.winRate * 100).toStringAsFixed(0)}%', AppColors.profitGreen),
                                        if (entry.currentStreak > 0)
                                          _buildStatBadge(Icons.local_fire_department_rounded, '${entry.currentStreak}', AppColors.electricBlue),
                                      ],
                                    ),
                                  ],
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

  Widget _buildStatBadge(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
