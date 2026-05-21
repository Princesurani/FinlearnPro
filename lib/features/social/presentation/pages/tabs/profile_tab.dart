import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../bloc/social_bloc.dart';
import '../../../data/models/user_profile.dart';
import '../../../../portfolio/presentation/pages/trading_journal_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _animController.forward(),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        if (state.status == SocialStatus.loading && state.myProfile == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final profile = state.myProfile;
        if (profile == null) {
          return Center(
            child: Text(
              'Unable to load profile',
              style: AppTypography.bodySmall,
            ),
          );
        }

        return CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(child: const SizedBox(height: 24)),

            // Avatar + Name + Bio
            SliverToBoxAdapter(
              child: _buildAnimated(
                index: 0,
                child: Column(
                  children: [
                    // Avatar with gradient ring
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        gradient: AppColors.auroraGradient,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: AppColors.backgroundPrimary,
                        backgroundImage: profile.avatarUrl != null
                            ? NetworkImage(profile.avatarUrl!)
                            : null,
                        child: profile.avatarUrl == null
                            ? const Icon(
                                Icons.person_rounded,
                                size: 44,
                                color: AppColors.primary,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(profile.displayName, style: AppTypography.h4),
                    if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        profile.bio!,
                        style: AppTypography.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Level + XP Progress Card
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.screenPaddingH,
                child: _buildAnimated(
                  index: 1,
                  child: _buildLevelCard(profile),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Streak Card
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.screenPaddingH,
                child: _buildAnimated(
                  index: 2,
                  child: _buildStreakCard(profile),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Stats Grid
            SliverPadding(
              padding: AppSpacing.screenPaddingH,
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.6,
                children: [
                  _buildAnimated(
                    index: 3,
                    child: _StatCard(
                      title: 'Total Trades',
                      value: profile.totalTrades.toString(),
                      icon: Icons.compare_arrows_rounded,
                      color: AppColors.electricBlue,
                    ),
                  ),
                  _buildAnimated(
                    index: 4,
                    child: _StatCard(
                      title: 'Win Rate',
                      value: '${(profile.winRate * 100).toStringAsFixed(1)}%',
                      icon: Icons.trending_up_rounded,
                      color: AppColors.profitGreen,
                    ),
                  ),
                  _buildAnimated(
                    index: 5,
                    child: _StatCard(
                      title: 'Courses Done',
                      value: profile.totalCoursesCompleted.toString(),
                      icon: Icons.menu_book_rounded,
                      color: AppColors.indigo,
                    ),
                  ),
                  _buildAnimated(
                    index: 6,
                    child: _StatCard(
                      title: 'Challenges',
                      value: profile.totalChallengesCompleted.toString(),
                      icon: Icons.military_tech_rounded,
                      color: AppColors.goldenYellow,
                    ),
                  ),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Trading Journal Access
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.screenPaddingH,
                child: _buildAnimated(
                  index: 7,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TradingJournalScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.white.withValues(alpha: 0.05)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.menu_book_rounded, color: AppColors.primary),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Trading Journal', style: AppTypography.h5.copyWith(color: AppColors.textPrimary)),
                                const SizedBox(height: 2),
                                Text('Review your trades and psychology', style: AppTypography.bodySmall),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        );
      },
    );
  }

  Widget _buildLevelCard(UserProfile profile) {
    final xpForNextLevel = (profile.level * profile.level) * 100;
    final progress = xpForNextLevel > 0
        ? (profile.totalXp / xpForNextLevel).clamp(0.0, 1.0)
        : 0.0;

    return GestureDetector(
      onTap: () => HapticFeedback.lightImpact(),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.cardPaddingCompact),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: AppSpacing.borderRadiusLG,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: AppSpacing.borderRadiusSM,
                  ),
                  child: const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Level ${profile.level}',
                        style: AppTypography.h5.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        '${profile.totalXp} / $xpForNextLevel XP',
                        style: AppTypography.bodyXS.copyWith(
                          color: AppColors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: AppSpacing.borderRadiusFull,
                  ),
                  child: Text(
                    '${profile.weeklyXp} this week',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.white,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // XP Progress Bar
            ClipRRect(
              borderRadius: AppSpacing.borderRadiusFull,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: value,
                    minHeight: 8,
                    backgroundColor: AppColors.white.withValues(alpha: 0.15),
                    valueColor: const AlwaysStoppedAnimation(Colors.amber),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCard(UserProfile profile) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPaddingCompact),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLG,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.sunsetOrange.withValues(alpha: 0.1),
              borderRadius: AppSpacing.borderRadiusMD,
            ),
            child: const Icon(
              Icons.local_fire_department_rounded,
              color: AppColors.sunsetOrange,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Streak',
                  style: AppTypography.labelSmall.copyWith(letterSpacing: 0),
                ),
                const SizedBox(height: 2),
                Text(
                  '${profile.currentStreak} day${profile.currentStreak != 1 ? "s" : ""}',
                  style: AppTypography.h5,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Best',
                style: AppTypography.labelSmall.copyWith(letterSpacing: 0),
              ),
              const SizedBox(height: 2),
              Text(
                '${profile.longestStreak} days',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.profitGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimated({required int index, required Widget child}) {
    final begin = (index * 0.08).clamp(0.0, 0.7);
    final end = (begin + 0.3).clamp(0.0, 1.0);
    final interval = Interval(begin, end, curve: Curves.easeOutCubic);

    final fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _animController, curve: interval));
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: interval));

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: slide, child: child),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLG,
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: AppSpacing.borderRadiusSM,
            ),
            child: Icon(icon, color: color, size: 15),
          ),
          const SizedBox(height: 6),
          Text(value, style: AppTypography.h5),
          Text(
            title,
            style: AppTypography.labelSmall.copyWith(letterSpacing: 0),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
