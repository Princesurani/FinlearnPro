import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../bloc/social_bloc.dart';
import '../../../data/models/leaderboard_entry.dart';

class LeagueTab extends StatelessWidget {
  const LeagueTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        final uid = FirebaseAuth.instance.currentUser?.uid ?? '';

        if (state.isFeedLoading && state.feed.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }

        final feed = state.feed;
        final leaderboard = state.leaderboard;

        return RefreshIndicator(
          onRefresh: () async {
            if (uid.isNotEmpty) {
              context.read<SocialBloc>().add(LoadFeed(uid));
              context.read<SocialBloc>().add(LoadLeaderboard());
              await Future.delayed(const Duration(milliseconds: 500));
            }
          },
          color: AppColors.primary,
          child: CustomScrollView(
            key: const PageStorageKey<String>('league_scroll'),
            slivers: [
              // Personal Standing Premium Header Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPaddingHorizontal,
                    12,
                    AppSpacing.screenPaddingHorizontal,
                    16,
                  ),
                  child: _buildPersonalRankCard(state, uid),
                ),
              ),

              // Top Traders Podium Carousel Teaser
              if (leaderboard.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenPaddingHorizontal,
                      4,
                      AppSpacing.screenPaddingHorizontal,
                      16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Global Top Traders', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () => _showAllRankings(context, leaderboard),
                              child: Text(
                                'View All Ranks',
                                style: AppTypography.bodyXS.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildPodiumWidget(context, leaderboard),
                      ],
                    ),
                  ),
                ),

              // Recent Activity Section Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPaddingHorizontal,
                    8,
                    AppSpacing.screenPaddingHorizontal,
                    12,
                  ),
                  child: Text(
                    'Recent Activity',
                    style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              if (feed.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.electricBlue.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.feed_outlined, size: 48, color: AppColors.electricBlue),
                        ),
                        const SizedBox(height: 20),
                        Text('No trades shared yet', style: AppTypography.h5),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Follow traders to see their activity, or share your own trades from the Markets tab!',
                            textAlign: TextAlign.center,
                            style: AppTypography.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPaddingHorizontal,
                    0,
                    AppSpacing.screenPaddingHorizontal,
                    100,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final post = feed[index];
                        final isBuy = post.side.toLowerCase() == 'buy';
                        final sideColor = isBuy ? AppColors.profitGreen : AppColors.lossRed;

                        return Container(
                          key: ValueKey('post_${post.id}'),
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(AppSpacing.cardPaddingCompact),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: AppSpacing.borderRadiusLG,
                            border: Border.all(color: AppColors.cardBorder, width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Author Row
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                                    child: Text(
                                      post.authorName[0].toUpperCase(),
                                      style: AppTypography.labelSmall.copyWith(
                                        color: AppColors.primary,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(post.authorName, style: AppTypography.bodyMedium.copyWith(fontSize: 14)),
                                        Text('Level ${post.authorLevel}', style: AppTypography.bodyXS),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    _formatTimeAgo(post.createdAt),
                                    style: AppTypography.bodyXS,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),

                              // Caption
                              if (post.caption != null && post.caption!.isNotEmpty) ...[
                                Text(post.caption!, style: AppTypography.bodySmall.copyWith(color: AppColors.textPrimary)),
                                const SizedBox(height: 12),
                              ],

                              // Trade Card
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundTertiary,
                                  borderRadius: AppSpacing.borderRadiusMD,
                                  border: Border.all(color: sideColor.withValues(alpha: 0.2)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: sideColor.withValues(alpha: 0.12),
                                        borderRadius: AppSpacing.borderRadiusXS,
                                      ),
                                      child: Text(
                                        post.side.toUpperCase(),
                                        style: AppTypography.labelSmall.copyWith(
                                          color: sideColor,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        '${post.quantity} ${post.symbol}',
                                        style: AppTypography.bodyMedium.copyWith(fontSize: 14),
                                      ),
                                    ),
                                    Text(
                                      '@ ₹${post.price.toStringAsFixed(2)}',
                                      style: AppTypography.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Like button
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<SocialBloc>().add(LikePost(uid, post.id, post.isLikedByMe));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          post.isLikedByMe ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                          color: post.isLikedByMe ? AppColors.coralPink : AppColors.textTertiary,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          post.likesCount.toString(),
                                          style: AppTypography.bodySmall.copyWith(
                                            color: post.isLikedByMe ? AppColors.coralPink : AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: feed.length,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // ─── Modal Sheet for Full Rankings ─────────────────────────────────────────

  void _showAllRankings(BuildContext context, List<LeaderboardEntry> leaderboard) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: AppColors.backgroundPrimary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Bottom sheet handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textTertiary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Global Rankings', style: AppTypography.h4),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: leaderboard.isEmpty
                    ? Center(
                        child: Text(
                          'No rankings yet',
                          style: AppTypography.bodySmall,
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                        itemCount: leaderboard.length,
                        itemBuilder: (context, index) {
                          final entry = leaderboard[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: AppSpacing.borderRadiusLG,
                              border: Border.all(color: AppColors.cardBorder, width: 1),
                            ),
                            child: Row(
                              children: [
                                // Rank badge
                                SizedBox(
                                  width: 36,
                                  child: Text(
                                    '#${entry.rank}',
                                    style: AppTypography.h5.copyWith(
                                      color: AppColors.textTertiary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Avatar
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                                  child: Text(
                                    entry.username[0].toUpperCase(),
                                    style: AppTypography.labelLarge.copyWith(color: AppColors.primary),
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
          ),
        );
      },
    );
  }

  // ─── Shared Premium Widgets ────────────────────────────────────────────────

  Widget _buildPodiumWidget(BuildContext context, List<LeaderboardEntry> leaderboard) {
    final count = leaderboard.length;
    final entry1 = count > 0 ? leaderboard[0] : null;
    final entry2 = count > 1 ? leaderboard[1] : null;
    final entry3 = count > 2 ? leaderboard[2] : null;

    final medalColors = [
      AppColors.goldenYellow,
      const Color(0xFFC0C0C0), // Silver
      const Color(0xFFCD7F32), // Bronze
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // 2nd Place
        Expanded(
          child: entry2 != null
              ? _buildPodiumCard(context, entry2, 2, medalColors[1])
              : const SizedBox(height: 120),
        ),
        const SizedBox(width: 8),
        // 1st Place
        Expanded(
          child: entry1 != null
              ? _buildPodiumCard(context, entry1, 1, medalColors[0])
              : const SizedBox(height: 140),
        ),
        const SizedBox(width: 8),
        // 3rd Place
        Expanded(
          child: entry3 != null
              ? _buildPodiumCard(context, entry3, 3, medalColors[2])
              : const SizedBox(height: 110),
        ),
      ],
    );
  }

  Widget _buildPodiumCard(BuildContext context, LeaderboardEntry entry, int rank, Color medalColor) {
    final isTop = rank == 1;
    final height = isTop ? 146.0 : 124.0;

    return Container(
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            medalColor.withValues(alpha: 0.1),
            AppColors.cardBackground,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: AppSpacing.borderRadiusLG,
        border: Border.all(
          color: medalColor.withValues(alpha: 0.5),
          width: isTop ? 2.0 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: medalColor.withValues(alpha: 0.08),
            blurRadius: isTop ? 10 : 4,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isTop ? Icons.workspace_premium_rounded : Icons.emoji_events_rounded,
                color: medalColor,
                size: isTop ? 20 : 16,
              ),
              const SizedBox(width: 2),
              Text(
                '#$rank',
                style: AppTypography.labelSmall.copyWith(
                  color: medalColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          CircleAvatar(
            radius: isTop ? 22 : 18,
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            child: Text(
              entry.username.isNotEmpty ? entry.username[0].toUpperCase() : 'T',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
                fontSize: isTop ? 16 : 14,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            entry.username,
            style: AppTypography.bodyXS.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${entry.totalXp} XP',
            style: AppTypography.bodyXS.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalRankCard(SocialState state, String uid) {
    LeaderboardEntry? myEntry;
    try {
      myEntry = state.leaderboard.firstWhere((e) => e.firebaseUid == uid);
    } catch (_) {}

    final name = state.myProfile?.username ?? 'Trader';
    final level = state.myProfile?.level ?? 1;
    final streak = state.myProfile?.currentStreak ?? 0;
    final totalXp = state.myProfile?.totalXp ?? 0;

    final hasRank = myEntry != null;
    final rankText = hasRank ? '#${myEntry.rank}' : 'Unranked';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.isDark
            ? const LinearGradient(
                colors: [Color(0xFF1E2130), Color(0xFF13151E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : AppColors.primaryGradient,
        borderRadius: AppSpacing.borderRadiusLG,
        border: AppColors.isDark
            ? Border.all(color: AppColors.cardBorder, width: 1.5)
            : null,
        boxShadow: AppColors.isDark
            ? null
            : [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'YOUR STANDING',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              if (streak > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.local_fire_department_rounded, color: AppColors.goldenYellow, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '$streak Days',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.white.withValues(alpha: 0.2),
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : 'T',
                  style: AppTypography.h4.copyWith(color: AppColors.white),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTypography.h5.copyWith(color: AppColors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Level $level • $totalXp XP',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.8)),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    rankText,
                    style: AppTypography.h3.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Global Rank',
                    style: AppTypography.bodyXS.copyWith(
                      color: AppColors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: AppColors.white.withValues(alpha: 0.15), height: 1),
          const SizedBox(height: 10),
          Text(
            hasRank
                ? 'Great job! Climb higher by finishing daily challenges and trading.'
                : 'Complete courses, daily challenges or share trades to enter the rankings!',
            style: AppTypography.bodyXS.copyWith(
              color: AppColors.white.withValues(alpha: 0.85),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildStatBadge(IconData icon, String text, Color color) {
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

  String _formatTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
