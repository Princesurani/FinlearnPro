import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../bloc/social_bloc.dart';
import '../../../data/models/user_profile.dart';
import '../../../../portfolio/presentation/pages/trading_journal_screen.dart';

// ─── Persona Config ──────────────────────────────────────────────────────────

class _Persona {
  final String id;
  final String emoji;
  final String name;
  final LinearGradient gradient;
  const _Persona({required this.id, required this.emoji, required this.name, required this.gradient});
}

const _kPersonas = [
  _Persona(id: 'bull',   emoji: '🐂', name: 'Bull',   gradient: AppColors.successGradient),
  _Persona(id: 'bear',   emoji: '🐻', name: 'Bear',   gradient: AppColors.premiumGradient),
  _Persona(id: 'whale',  emoji: '🐳', name: 'Whale',  gradient: AppColors.auroraGradient),
  _Persona(id: 'hawk',   emoji: '🦅', name: 'Hawk',   gradient: AppColors.learningGradient),
  _Persona(id: 'lion',   emoji: '🦁', name: 'Lion',   gradient: LinearGradient(colors: [AppColors.sunsetOrange, AppColors.deepOrange], begin: Alignment.topLeft, end: Alignment.bottomRight)),
  _Persona(id: 'rocket', emoji: '🚀', name: 'Rocket', gradient: AppColors.primaryGradient),
];

_Persona? _personaForUrl(String? url) {
  if (url == null || !url.startsWith('emoji:')) return null;
  final id = url.substring(6);
  try { return _kPersonas.firstWhere((p) => p.id == id); } catch (_) { return null; }
}

// ─── Profile Tab ─────────────────────────────────────────────────────────────

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  bool _timedOut = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    WidgetsBinding.instance.addPostFrameCallback((_) => _animController.forward());
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && context.read<SocialBloc>().state.myProfile == null) {
        setState(() => _timedOut = true);
      }
    });
  }

  @override
  void dispose() { _animController.dispose(); super.dispose(); }

  // ─── Root build ───────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        final profile = state.myProfile;

        if (profile == null) {
          if (_timedOut) return Center(child: Text('Unable to load profile', style: AppTypography.bodySmall));
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }

        // Pre-compute values used by multiple sections
        final currentBaseXp = (profile.level - 1) * (profile.level - 1) * 100;
        final nextLevelXp   = profile.level * profile.level * 100;
        final xpProgress    = (nextLevelXp - currentBaseXp) > 0
            ? ((profile.totalXp - currentBaseXp) / (nextLevelXp - currentBaseXp)).clamp(0.0, 1.0)
            : 0.0;
        final wins   = (profile.totalTrades * profile.winRate).round();
        final losses = profile.totalTrades - wins;

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            if (profile.firebaseUid.isNotEmpty) {
              context.read<SocialBloc>().add(LoadProfile(profile.firebaseUid));
            }
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [

              // ── 1. Hero header
              SliverToBoxAdapter(
                child: _anim(0, _buildHeader(context, profile)),
              ),

              _gap(20),

              // ── 2. Level progress card (expanded, inline)
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenPaddingH,
                  child: _anim(1, _buildLevelSection(profile, xpProgress, nextLevelXp)),
                ),
              ),

              _gap(12),

              // ── 3. Streak + 7-day calendar (inline)
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenPaddingH,
                  child: _anim(2, _buildStreakSection(profile)),
                ),
              ),

              _gap(12),

              // ── 4. Win-rate gauge + trades stats (inline)
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenPaddingH,
                  child: _anim(3, _buildPerformanceSection(profile, wins, losses)),
                ),
              ),

              _gap(12),

              // ── 5. Achievements badge grid (inline)
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenPaddingH,
                  child: _anim(4, _buildAchievementsSection(profile)),
                ),
              ),

              _gap(12),

              // ── 6. Course roadmap (inline)
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenPaddingH,
                  child: _anim(5, _buildCoursesSection(profile)),
                ),
              ),

              _gap(16),

              // ── 7. Trading Journal shortcut
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenPaddingH,
                  child: _anim(6, _buildJournalTile(context)),
                ),
              ),

              _gap(120),
            ],
          ),
        );
      },
    );
  }

  // ─── Section: Header ──────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context, UserProfile profile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        children: [
          // Tappable avatar → opens edit sheet
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _showEditProfileSheet(context, profile);
            },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                _buildAvatar(profile, radius: 52),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.backgroundPrimary, width: 2),
                  ),
                  child: const Icon(Icons.edit_rounded, color: AppColors.white, size: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(profile.username, style: AppTypography.h3.copyWith(fontWeight: FontWeight.bold)),
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              profile.bio!,
              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () { HapticFeedback.lightImpact(); _showEditProfileSheet(context, profile); },
            icon: const Icon(Icons.edit_outlined, size: 14),
            label: Text('Edit Profile', style: AppTypography.bodyXS.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section: Level ───────────────────────────────────────────────────────

  Widget _buildLevelSection(UserProfile profile, double xpProgress, int nextLevelXp) {
    final levels = [
      {'lvl': 1, 'title': 'Beginner',      'xp': '0 – 100 XP'},
      {'lvl': 2, 'title': 'Novice',         'xp': '100 – 400 XP'},
      {'lvl': 3, 'title': 'Intermediate',   'xp': '400 – 900 XP'},
      {'lvl': 4, 'title': 'Strategist',     'xp': '900 – 1,600 XP'},
      {'lvl': 5, 'title': 'Market Master',  'xp': '1,600+ XP'},
    ];

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Level ${profile.level}', style: AppTypography.h5),
                    Text('${profile.totalXp} / $nextLevelXp XP  •  ${profile.weeklyXp} XP this week',
                        style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                child: Text('${(xpProgress * 100).toInt()}%', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, letterSpacing: 0, fontWeight: FontWeight.bold)),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Animated progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: xpProgress),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutCubic,
              builder: (_, v, ss) => LinearProgressIndicator(
                value: v, minHeight: 10,
                backgroundColor: AppColors.backgroundTertiary,
                valueColor: AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ),

          const SizedBox(height: 20),
          _sectionLabel('XP Milestones'),
          const SizedBox(height: 10),

          // Level roadmap
          ...levels.map((lvl) {
            final isCurrent = profile.level == lvl['lvl'];
            final isDone    = profile.level > (lvl['lvl'] as int);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  _levelBubble(lvl['lvl'] as int, isCurrent, isDone),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lvl['title'] as String, style: AppTypography.bodySmall.copyWith(fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal, color: isCurrent ? AppColors.primary : AppColors.textPrimary)),
                        Text(lvl['xp'] as String, style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  if (isCurrent) const Icon(Icons.chevron_right_rounded, color: AppColors.primary, size: 18)
                  else if (isDone) const Icon(Icons.check_circle_rounded, color: AppColors.profitGreen, size: 18)
                  else const Icon(Icons.lock_outline_rounded, color: AppColors.textTertiary, size: 16),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _levelBubble(int lvl, bool isCurrent, bool isDone) {
    return Container(
      width: 34, height: 34,
      decoration: BoxDecoration(
        color: isCurrent ? AppColors.primary : isDone ? AppColors.profitGreen.withValues(alpha: 0.15) : AppColors.backgroundTertiary,
        shape: BoxShape.circle,
        border: isCurrent ? null : Border.all(color: isDone ? AppColors.profitGreen : AppColors.border),
      ),
      child: Center(
        child: isDone && !isCurrent
            ? const Icon(Icons.check_rounded, color: AppColors.profitGreen, size: 16)
            : Text('$lvl', style: TextStyle(color: isCurrent ? AppColors.white : AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 13)),
      ),
    );
  }

  // ─── Section: Streak ──────────────────────────────────────────────────────

  Widget _buildStreakSection(UserProfile profile) {
    final today  = DateTime.now();
    final streak = profile.currentStreak.clamp(0, 7);

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(color: AppColors.sunsetOrange.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.local_fire_department_rounded, color: AppColors.sunsetOrange, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Daily Streak', style: AppTypography.h5),
                    Text('Best: ${profile.longestStreak} days', style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
              // Big streak number
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text('${profile.currentStreak}', style: AppTypography.h3.copyWith(color: AppColors.sunsetOrange, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Text('🔥', style: const TextStyle(fontSize: 22)),
                    ],
                  ),
                  Text('days', style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),
          _sectionLabel('This week'),
          const SizedBox(height: 12),

          // 7-day calendar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final day      = today.subtract(Duration(days: 6 - i));
              final dayName  = ['M', 'T', 'W', 'T', 'F', 'S', 'S'][day.weekday % 7];
              final isToday  = i == 6;
              final isActive = i >= (7 - streak);
              return Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200 + i * 60),
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      gradient: isActive ? const LinearGradient(colors: [AppColors.sunsetOrange, AppColors.deepOrange], begin: Alignment.topLeft, end: Alignment.bottomRight) : null,
                      color: isActive ? null : AppColors.backgroundTertiary,
                      shape: BoxShape.circle,
                      border: isToday && !isActive ? Border.all(color: AppColors.sunsetOrange, width: 1.5) : null,
                      boxShadow: isActive ? [BoxShadow(color: AppColors.sunsetOrange.withValues(alpha: 0.35), blurRadius: 8)] : null,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      isActive ? Icons.local_fire_department_rounded : Icons.circle_outlined,
                      color: isActive ? AppColors.white : AppColors.textTertiary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(dayName, style: AppTypography.bodyXS.copyWith(color: isActive ? AppColors.sunsetOrange : AppColors.textTertiary, fontWeight: isToday ? FontWeight.bold : FontWeight.normal)),
                ],
              );
            }),
          ),

          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.backgroundTertiary, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const Icon(Icons.bolt_rounded, color: Colors.amber, size: 16),
                const SizedBox(width: 8),
                Expanded(child: Text('Keep your streak going — daily XP bonuses increase the longer you hold it!', style: AppTypography.bodyXS)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section: Performance (Win Rate + Trades) ─────────────────────────────

  Widget _buildPerformanceSection(UserProfile profile, int wins, int losses) {
    final winPct = profile.totalTrades > 0 ? (wins / profile.totalTrades).clamp(0.0, 1.0) : 0.0;

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('Performance'),
          const SizedBox(height: 16),

          // Win Rate gauge + summary
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _WinRateGauge(rate: profile.winRate),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StatRow(label: 'Wins',   value: '$wins',                      color: AppColors.profitGreen),
                    const SizedBox(height: 8),
                    _StatRow(label: 'Losses', value: '$losses',                    color: AppColors.lossRed),
                    const SizedBox(height: 8),
                    _StatRow(label: 'Total',  value: '${profile.totalTrades}',     color: AppColors.electricBlue),
                    const SizedBox(height: 8),
                    _StatRow(label: 'Win %',  value: '${(profile.winRate * 100).toStringAsFixed(1)}%', color: AppColors.indigo),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          _sectionLabel('Long vs Short'),
          const SizedBox(height: 10),

          // Animated balance bar
          profile.totalTrades == 0
              ? Text('No trades yet', style: AppTypography.bodyXS.copyWith(color: AppColors.textTertiary))
              : TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: winPct),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  builder: (_, v, ss) {
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Row(
                            children: [
                              Flexible(
                                flex: (v * 100).toInt().clamp(1, 99),
                                child: Container(height: 28, color: AppColors.profitGreen, alignment: Alignment.center,
                                  child: Text('${(v * 100).toInt()}% W', style: AppTypography.bodyXS.copyWith(color: AppColors.white, fontWeight: FontWeight.bold))),
                              ),
                              Flexible(
                                flex: ((1 - v) * 100).toInt().clamp(1, 99),
                                child: Container(height: 28, color: AppColors.lossRed, alignment: Alignment.center,
                                  child: Text('${((1 - v) * 100).toInt()}% L', style: AppTypography.bodyXS.copyWith(color: AppColors.white, fontWeight: FontWeight.bold))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),

          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.backgroundTertiary, borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb_outline_rounded, color: AppColors.goldenYellow, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    profile.winRate >= 0.6
                        ? 'Excellent! Keep following your strategy and managing risk.'
                        : profile.winRate >= 0.4
                            ? 'Solid. Focus on cutting losses early and letting winners run.'
                            : 'Review your entry criteria and tighten stop-losses.',
                    style: AppTypography.bodyXS,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section: Achievements ────────────────────────────────────────────────

  Widget _buildAchievementsSection(UserProfile profile) {
    final badges = [
      {'icon': Icons.rocket_launch_rounded,       'label': 'First Trade',     'desc': 'Placed your first trade',      'color': AppColors.electricBlue,  'unlocked': profile.totalTrades >= 1},
      {'icon': Icons.local_fire_department_rounded,'label': 'Streak Starter', 'desc': '3-day streak',                 'color': AppColors.sunsetOrange,  'unlocked': profile.currentStreak >= 3},
      {'icon': Icons.school_rounded,              'label': 'Scholar',          'desc': '3 or more courses done',       'color': AppColors.indigo,        'unlocked': profile.totalCoursesCompleted >= 3},
      {'icon': Icons.shield_rounded,              'label': 'Risk Manager',     'desc': 'Win rate above 50%',           'color': AppColors.profitGreen,   'unlocked': profile.winRate >= 0.5},
      {'icon': Icons.military_tech_rounded,       'label': 'Challenge Pro',   'desc': '5 challenges completed',       'color': AppColors.goldenYellow,  'unlocked': profile.totalChallengesCompleted >= 5},
      {'icon': Icons.auto_graph_rounded,          'label': 'Market Master',   'desc': 'Reached level 5',              'color': AppColors.lavender,      'unlocked': profile.level >= 5},
    ];
    final unlockedCount = badges.where((b) => b['unlocked'] == true).length;

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _sectionLabel('Achievements')),
              Text('$unlockedCount / ${badges.length} unlocked', style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 14),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.92,
            ),
            itemCount: badges.length,
            itemBuilder: (_, i) {
              final b        = badges[i];
              final unlocked = b['unlocked'] as bool;
              final color    = b['color'] as Color;
              return AnimatedOpacity(
                duration: Duration(milliseconds: 300 + i * 80),
                opacity: unlocked ? 1.0 : 0.4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: unlocked ? color.withValues(alpha: 0.08) : AppColors.backgroundTertiary,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: unlocked ? color.withValues(alpha: 0.25) : AppColors.border),
                    boxShadow: unlocked ? [BoxShadow(color: color.withValues(alpha: 0.12), blurRadius: 8, offset: const Offset(0, 3))] : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(b['icon'] as IconData, color: unlocked ? color : AppColors.textTertiary, size: 20),
                          const Spacer(),
                          if (unlocked) const Icon(Icons.verified_rounded, color: AppColors.profitGreen, size: 13),
                        ],
                      ),
                      const Spacer(),
                      Text(b['label'] as String, style: AppTypography.bodyXS.copyWith(fontWeight: FontWeight.bold, color: unlocked ? AppColors.textPrimary : AppColors.textTertiary), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(b['desc'] as String, style: AppTypography.bodyXS.copyWith(fontSize: 9, color: AppColors.textTertiary), maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─── Section: Courses ─────────────────────────────────────────────────────

  Widget _buildCoursesSection(UserProfile profile) {
    final courses = [
      'Stock Market Basics',
      'Technical Analysis 101',
      'Options & Derivatives',
      'Portfolio Risk Management',
      'Fundamental Analysis',
      'Trading Psychology',
    ];
    final completed = profile.totalCoursesCompleted.clamp(0, courses.length);

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _sectionLabel('Courses')),
              Text('$completed / ${courses.length}', style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: completed / courses.length),
              duration: const Duration(milliseconds: 900),
              builder: (_, v, ss) => LinearProgressIndicator(
                value: v, minHeight: 6,
                backgroundColor: AppColors.backgroundTertiary,
                valueColor: AlwaysStoppedAnimation(AppColors.indigo),
              ),
            ),
          ),
          const SizedBox(height: 14),
          ...List.generate(courses.length, (i) {
            final isDone   = i < completed;
            final isNext   = i == completed;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(
                      color: isDone ? AppColors.indigo : isNext ? AppColors.indigo.withValues(alpha: 0.1) : AppColors.backgroundTertiary,
                      shape: BoxShape.circle,
                      border: isNext ? Border.all(color: AppColors.indigo, width: 1.5) : null,
                    ),
                    child: Center(
                      child: isDone
                          ? const Icon(Icons.check_rounded, color: AppColors.white, size: 14)
                          : i >= completed
                              ? Icon(i == completed ? Icons.play_arrow_rounded : Icons.lock_rounded,
                                  color: isNext ? AppColors.indigo : AppColors.textTertiary, size: 14)
                              : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      courses[i],
                      style: AppTypography.bodySmall.copyWith(
                        color: isDone ? AppColors.textPrimary : isNext ? AppColors.indigo : AppColors.textTertiary,
                        fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (isDone) Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.indigo.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                    child: Text('Done', style: AppTypography.bodyXS.copyWith(color: AppColors.indigo, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─── Trading Journal tile ─────────────────────────────────────────────────

  Widget _buildJournalTile(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(context, MaterialPageRoute(builder: (_) => const TradingJournalScreen()));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
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
    );
  }

  // ─── Edit Profile Modal (only popup) ────────────────────────────────────

  void _showEditProfileSheet(BuildContext context, UserProfile profile) {
    final nameCtrl = TextEditingController(text: profile.username);
    final bioCtrl  = TextEditingController(text: profile.bio ?? '');
    String? selectedAvatarUrl = profile.avatarUrl;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            decoration: const BoxDecoration(
              color: AppColors.backgroundPrimary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40, height: 4,
                      decoration: BoxDecoration(color: AppColors.textTertiary.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Edit Profile', style: AppTypography.h4),
                      IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(ctx)),
                    ],
                  ),

                  // ── Persona picker
                  const SizedBox(height: 8),
                  Text('Choose Persona', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 90,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _kPersonas.length,
                      separatorBuilder: (_, ss) => const SizedBox(width: 12),
                      itemBuilder: (_, i) {
                        final p          = _kPersonas[i];
                        final isSelected = selectedAvatarUrl == 'emoji:${p.id}';
                        return GestureDetector(
                          onTap: () { HapticFeedback.selectionClick(); setSheetState(() => selectedAvatarUrl = 'emoji:${p.id}'); },
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 56, height: 56,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: p.gradient,
                                  border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent, width: 3),
                                  boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.35), blurRadius: 10, offset: const Offset(0, 4))] : null,
                                ),
                                alignment: Alignment.center,
                                child: Text(p.emoji, style: const TextStyle(fontSize: 24)),
                              ),
                              const SizedBox(height: 4),
                              Text(p.name, style: AppTypography.bodyXS.copyWith(color: isSelected ? AppColors.primary : AppColors.textSecondary, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text('Username', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameCtrl,
                    decoration: _inputDecoration('Enter username'),
                    style: AppTypography.bodySmall,
                  ),

                  const SizedBox(height: 16),
                  Text('Bio', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: bioCtrl,
                    maxLines: 3,
                    decoration: _inputDecoration('Tell others about your trading style...'),
                    style: AppTypography.bodySmall,
                  ),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final newName = nameCtrl.text.trim();
                        final newBio  = bioCtrl.text.trim();
                        if (newName.isNotEmpty) {
                          context.read<SocialBloc>().add(UpdateProfile(profile.firebaseUid, username: newName, bio: newBio, avatarUrl: selectedAvatarUrl));
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated!'), backgroundColor: AppColors.profitGreen));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryButton,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: Text('Save Changes', style: AppTypography.buttonSmall),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Avatar builder ───────────────────────────────────────────────────────

  Widget _buildAvatar(UserProfile profile, {double radius = 48}) {
    final persona = _personaForUrl(profile.avatarUrl);
    Widget inner;
    if (persona != null) {
      inner = Container(
        width: radius * 2, height: radius * 2,
        decoration: BoxDecoration(shape: BoxShape.circle, gradient: persona.gradient),
        alignment: Alignment.center,
        child: Text(persona.emoji, style: TextStyle(fontSize: radius * 0.75)),
      );
    } else if (profile.avatarUrl != null) {
      inner = CircleAvatar(radius: radius, backgroundColor: AppColors.backgroundPrimary, backgroundImage: NetworkImage(profile.avatarUrl!));
    } else {
      inner = CircleAvatar(radius: radius, backgroundColor: AppColors.backgroundPrimary, child: Icon(Icons.person_rounded, size: radius, color: AppColors.primary));
    }
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(gradient: AppColors.auroraGradient, shape: BoxShape.circle),
      child: inner,
    );
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  Widget _anim(int index, Widget child) {
    final begin = (index * 0.08).clamp(0.0, 0.65);
    final end   = (begin + 0.35).clamp(0.0, 1.0);
    final curve = Interval(begin, end, curve: Curves.easeOutCubic);
    final fade  = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: curve));
    final slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _animController, curve: curve));
    return FadeTransition(opacity: fade, child: SlideTransition(position: slide, child: child));
  }

  SliverToBoxAdapter _gap(double h) => SliverToBoxAdapter(child: SizedBox(height: h));

  Widget _sectionLabel(String text) => Text(text, style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.4));

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true, fillColor: AppColors.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
  );
}

// ─── Section Card ─────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: AppSpacing.borderRadiusLG,
      border: Border.all(color: AppColors.border),
    ),
    child: child,
  );
}

// ─── Win Rate Gauge ───────────────────────────────────────────────────────────

class _WinRateGauge extends StatelessWidget {
  final double rate;
  const _WinRateGauge({required this.rate});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: rate),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      builder: (_, v, ss) => SizedBox(
        width: 120, height: 120,
        child: CustomPaint(
          painter: _GaugePainter(progress: v),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${(v * 100).toStringAsFixed(1)}%', style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold, color: AppColors.profitGreen)),
                Text('Win Rate', style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  const _GaugePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final c  = Offset(size.width / 2, size.height / 2);
    final r  = math.min(c.dx, c.dy) - 10;
    const startAngle = math.pi * 0.75;
    const sweep      = math.pi * 1.5;

    final bg = Paint()..color = AppColors.backgroundTertiary..style = PaintingStyle.stroke..strokeWidth = 12..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), startAngle, sweep, false, bg);

    final fg = Paint()
      ..shader = const LinearGradient(colors: [AppColors.profitGreen, AppColors.oceanTeal]).createShader(Rect.fromCircle(center: c, radius: r))
      ..style = PaintingStyle.stroke..strokeWidth = 12..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), startAngle, sweep * progress, false, fg);
  }

  @override
  bool shouldRepaint(_GaugePainter old) => old.progress != progress;
}

// ─── Stat Row ─────────────────────────────────────────────────────────────────

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final Color  color;
  const _StatRow({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(label, style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
        ],
      ),
      Text(value, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.bold, color: color)),
    ],
  );
}
