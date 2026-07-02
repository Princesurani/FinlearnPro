import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../bloc/social_bloc.dart';
import '../../../data/models/user_profile.dart';

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
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    WidgetsBinding.instance.addPostFrameCallback((_) => _animController.forward());
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && context.read<SocialBloc>().state.myProfile == null) {
        setState(() => _timedOut = true);
      }
    });
  }

  @override
  void dispose() { _animController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        final profile = state.myProfile;
        if (profile == null) {
          if (_timedOut) return Center(child: Text('Unable to load profile', style: AppTypography.bodySmall));
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }

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
              _gap(AppSpacing.md),
              SliverToBoxAdapter(child: _anim(0, _buildHeader(context, profile))),
              _gap(AppSpacing.md),
              SliverToBoxAdapter(
                child: Padding(padding: AppSpacing.screenPaddingH,
                  child: _anim(1, _buildLevelSection(profile, xpProgress, nextLevelXp))),
              ),
              _gap(AppSpacing.md),
              SliverToBoxAdapter(
                child: Padding(padding: AppSpacing.screenPaddingH,
                  child: _anim(2, _buildStreakSection(profile))),
              ),
              _gap(AppSpacing.md),
              SliverToBoxAdapter(
                child: Padding(padding: AppSpacing.screenPaddingH,
                  child: _anim(3, _buildPerformanceSection(profile, wins, losses))),
              ),
              _gap(AppSpacing.md),
              SliverToBoxAdapter(
                child: Padding(padding: AppSpacing.screenPaddingH,
                  child: _anim(4, _buildAchievementsSection(profile))),
              ),
              _gap(AppSpacing.md),
              SliverToBoxAdapter(
                child: Padding(padding: AppSpacing.screenPaddingH,
                  child: _anim(5, _buildCoursesSection(profile))),
              ),
              _gap(100),
            ],
          ),
        );
      },
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context, UserProfile profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar (tappable → edit sheet)
          GestureDetector(
            onTap: () { HapticFeedback.lightImpact(); _showEditProfileSheet(context, profile); },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                _buildAvatar(profile, radius: 48),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.backgroundPrimary, width: 2),
                  ),
                  child: const Icon(Icons.edit_rounded, color: AppColors.white, size: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Name + bio
          Text(
            profile.username,
            style: AppTypography.h4.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                profile.bio!,
                style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          const SizedBox(height: 12),
          // Level badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Lv.${profile.level}',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 1,
                  height: 12,
                  color: AppColors.white.withValues(alpha: 0.4),
                ),
                const SizedBox(width: 8),
                Text(
                  '${profile.totalXp} XP',
                  style: AppTypography.bodyXS.copyWith(
                    color: AppColors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Level Section ────────────────────────────────────────────────────────

  Widget _buildLevelSection(UserProfile profile, double xpProgress, int nextLevelXp) {
    final levels = [
      {'lvl': 1, 'title': 'Beginner'},
      {'lvl': 2, 'title': 'Novice'},
      {'lvl': 3, 'title': 'Interm.'},
      {'lvl': 4, 'title': 'Strategist'},
      {'lvl': 5, 'title': 'Master'},
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
              const SizedBox(width: 6),
              Text('XP Progress', style: _label),
              const Spacer(),
              Text('${profile.totalXp} / $nextLevelXp XP', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: xpProgress),
              duration: const Duration(milliseconds: 1100),
              curve: Curves.easeOutCubic,
              builder: (_, v, ss) => LinearProgressIndicator(
                value: v, minHeight: 10,
                backgroundColor: AppColors.backgroundTertiary,
                valueColor: AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 14),
          // Level strip
          Row(
            children: levels.map((lvl) {
              final n      = lvl['lvl'] as int;
              final isCur  = profile.level == n;
              final isDone = profile.level > n;
              final isLast = n == levels.length;
              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 34, height: 34,
                            decoration: BoxDecoration(
                              color: isCur ? AppColors.primary : isDone ? AppColors.profitGreen.withValues(alpha: 0.15) : AppColors.backgroundTertiary,
                              shape: BoxShape.circle,
                              border: isDone && !isCur ? Border.all(color: AppColors.profitGreen, width: 1.5) : null,
                            ),
                            child: Center(
                              child: isDone && !isCur
                                  ? const Icon(Icons.check_rounded, color: AppColors.profitGreen, size: 16)
                                  : Text('$n', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isCur ? AppColors.white : AppColors.textTertiary)),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(lvl['title'] as String,
                            style: AppTypography.bodyXS.copyWith(color: isCur ? AppColors.primary : AppColors.textTertiary, fontWeight: isCur ? FontWeight.bold : FontWeight.normal),
                            textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(height: 1.5, color: isDone ? AppColors.profitGreen.withValues(alpha: 0.4) : AppColors.border),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ─── Streak Section ───────────────────────────────────────────────────────

  Widget _buildStreakSection(UserProfile profile) {
    final today  = DateTime.now();
    final streak = profile.currentStreak.clamp(0, 7);

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.local_fire_department_rounded, color: AppColors.sunsetOrange, size: 18),
              const SizedBox(width: 6),
              Text('Daily Streak', style: _label),
              const Spacer(),
              RichText(
                text: TextSpan(children: [
                  TextSpan(text: '${profile.currentStreak}', style: AppTypography.h5.copyWith(color: AppColors.sunsetOrange, fontWeight: FontWeight.bold)),
                  TextSpan(text: ' days  ', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                  TextSpan(text: '🏆 ${profile.longestStreak}', style: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary)),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
                    duration: Duration(milliseconds: 180 + i * 50),
                    width: 38, height: 38,
                    decoration: BoxDecoration(
                      gradient: isActive ? const LinearGradient(colors: [AppColors.sunsetOrange, AppColors.deepOrange], begin: Alignment.topLeft, end: Alignment.bottomRight) : null,
                      color: isActive ? null : AppColors.backgroundTertiary,
                      shape: BoxShape.circle,
                      border: isToday && !isActive ? Border.all(color: AppColors.sunsetOrange, width: 1.5) : null,
                      boxShadow: isActive ? [BoxShadow(color: AppColors.sunsetOrange.withValues(alpha: 0.35), blurRadius: 8)] : null,
                    ),
                    alignment: Alignment.center,
                    child: Icon(isActive ? Icons.local_fire_department_rounded : Icons.circle_outlined,
                      color: isActive ? AppColors.white : AppColors.textTertiary, size: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(dayName, style: AppTypography.bodySmall.copyWith(color: isActive ? AppColors.sunsetOrange : AppColors.textTertiary, fontWeight: isToday ? FontWeight.bold : FontWeight.normal)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  // ─── Performance Section ──────────────────────────────────────────────────

  Widget _buildPerformanceSection(UserProfile profile, int wins, int losses) {
    final winPct = profile.totalTrades > 0 ? (wins / profile.totalTrades).clamp(0.0, 1.0) : 0.0;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.analytics_outlined, color: AppColors.electricBlue, size: 18),
              const SizedBox(width: 6),
              Text('Performance', style: _label),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _WinRateGauge(rate: profile.winRate),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    _StatRow(label: 'Wins',    value: '$wins',   color: AppColors.profitGreen),
                    const SizedBox(height: 8),
                    _StatRow(label: 'Losses',  value: '$losses', color: AppColors.lossRed),
                    const SizedBox(height: 8),
                    _StatRow(label: 'Total',   value: '${profile.totalTrades}', color: AppColors.electricBlue),
                  ],
                ),
              ),
            ],
          ),
          if (profile.totalTrades > 0) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: winPct),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (_, v, ss) => Row(
                  children: [
                    Flexible(
                      flex: (v * 100).toInt().clamp(1, 99),
                      child: Container(height: 28, color: AppColors.profitGreen, alignment: Alignment.center,
                        child: Text('${(v * 100).toInt()}% W', style: AppTypography.bodySmall.copyWith(color: AppColors.white, fontWeight: FontWeight.bold))),
                    ),
                    Flexible(
                      flex: ((1 - v) * 100).toInt().clamp(1, 99),
                      child: Container(height: 28, color: AppColors.lossRed, alignment: Alignment.center,
                        child: Text('${((1 - v) * 100).toInt()}% L', style: AppTypography.bodySmall.copyWith(color: AppColors.white, fontWeight: FontWeight.bold))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ─── Achievements Section ─────────────────────────────────────────────────

  Widget _buildAchievementsSection(UserProfile profile) {
    final badges = [
      {'icon': Icons.rocket_launch_rounded,        'label': 'First Trade',    'desc': 'Placed your first trade',  'color': AppColors.electricBlue,  'unlocked': profile.totalTrades >= 1},
      {'icon': Icons.local_fire_department_rounded, 'label': 'Streak Start',  'desc': '3-day streak',             'color': AppColors.sunsetOrange,  'unlocked': profile.currentStreak >= 3},
      {'icon': Icons.school_rounded,               'label': 'Scholar',        'desc': '3+ courses done',          'color': AppColors.indigo,        'unlocked': profile.totalCoursesCompleted >= 3},
      {'icon': Icons.shield_rounded,               'label': 'Risk Manager',   'desc': 'Win rate >50%',            'color': AppColors.profitGreen,   'unlocked': profile.winRate >= 0.5},
      {'icon': Icons.military_tech_rounded,        'label': 'Chall. Pro',     'desc': '5 challenges done',        'color': AppColors.goldenYellow,  'unlocked': profile.totalChallengesCompleted >= 5},
      {'icon': Icons.auto_graph_rounded,           'label': 'Mkt Master',     'desc': 'Reached level 5',          'color': AppColors.lavender,      'unlocked': profile.level >= 5},
    ];
    final unlockedCount = badges.where((b) => b['unlocked'] == true).length;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.military_tech_rounded, color: AppColors.goldenYellow, size: 18),
              const SizedBox(width: 6),
              Text('Achievements', style: _label),
              const Spacer(),
              Text('$unlockedCount / ${badges.length} unlocked', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 12),
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
                duration: Duration(milliseconds: 300 + i * 70),
                opacity: unlocked ? 1.0 : 0.4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: unlocked ? color.withValues(alpha: 0.08) : AppColors.backgroundTertiary,
                    borderRadius: BorderRadius.circular(12),
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
                          if (unlocked) const Icon(Icons.verified_rounded, color: AppColors.profitGreen, size: 14),
                        ],
                      ),
                      const Spacer(),
                      Text(b['label'] as String,
                        style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.bold, color: unlocked ? AppColors.textPrimary : AppColors.textTertiary),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(b['desc'] as String,
                        style: AppTypography.bodyXS.copyWith(color: AppColors.textTertiary),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
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

  // ─── Courses Section ──────────────────────────────────────────────────────

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

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book_rounded, color: AppColors.indigo, size: 18),
              const SizedBox(width: 6),
              Text('Courses', style: _label),
              const Spacer(),
              Text('$completed / ${courses.length}', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: completed / courses.length),
              duration: const Duration(milliseconds: 900),
              builder: (_, v, ss) => LinearProgressIndicator(
                value: v, minHeight: 7,
                backgroundColor: AppColors.backgroundTertiary,
                valueColor: AlwaysStoppedAnimation(AppColors.indigo),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(courses.length, (i) {
            final isDone = i < completed;
            final isNext = i == completed;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 28, height: 28,
                    decoration: BoxDecoration(
                      color: isDone ? AppColors.indigo : isNext ? AppColors.indigo.withValues(alpha: 0.1) : AppColors.backgroundTertiary,
                      shape: BoxShape.circle,
                      border: isNext ? Border.all(color: AppColors.indigo, width: 1.5) : null,
                    ),
                    child: Center(
                      child: isDone
                          ? const Icon(Icons.check_rounded, color: AppColors.white, size: 14)
                          : Icon(isNext ? Icons.play_arrow_rounded : Icons.lock_rounded,
                              color: isNext ? AppColors.indigo : AppColors.textTertiary, size: 14),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(courses[i], style: AppTypography.bodySmall.copyWith(
                      color: isDone ? AppColors.textPrimary : isNext ? AppColors.indigo : AppColors.textTertiary,
                      fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
                    )),
                  ),
                  if (isDone) const Icon(Icons.check_circle_rounded, color: AppColors.indigo, size: 16),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─── Edit Profile Modal ───────────────────────────────────────────────────

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
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            decoration: BoxDecoration(
              color: AppColors.backgroundPrimary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Container(width: 36, height: 4, decoration: BoxDecoration(color: AppColors.textTertiary.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Edit Profile', style: AppTypography.h5),
                      IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(ctx)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Persona', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 88,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _kPersonas.length,
                      separatorBuilder: (_, ss) => const SizedBox(width: 12),
                      itemBuilder: (_, i) {
                        final p = _kPersonas[i];
                        final isSelected = selectedAvatarUrl == 'emoji:${p.id}';
                        return GestureDetector(
                          onTap: () { HapticFeedback.selectionClick(); setSheetState(() => selectedAvatarUrl = 'emoji:${p.id}'); },
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                width: 54, height: 54,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle, gradient: p.gradient,
                                  border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent, width: 2.5),
                                  boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 8)] : null,
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
                  const SizedBox(height: 16),
                  Text('Username', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(controller: nameCtrl, decoration: _inputDeco('Enter username'), style: AppTypography.bodySmall),
                  const SizedBox(height: 14),
                  Text('Bio', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(controller: bioCtrl, maxLines: 2, decoration: _inputDeco('Your trading style...'), style: AppTypography.bodySmall),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final newName = nameCtrl.text.trim();
                        if (newName.isNotEmpty) {
                          context.read<SocialBloc>().add(UpdateProfile(profile.firebaseUid, username: newName, bio: bioCtrl.text.trim(), avatarUrl: selectedAvatarUrl));
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

  // ─── Avatar ───────────────────────────────────────────────────────────────

  Widget _buildAvatar(UserProfile profile, {double radius = 40}) {
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
      inner = CircleAvatar(radius: radius, backgroundColor: AppColors.backgroundPrimary, child: Icon(Icons.person_rounded, size: radius * 0.9, color: AppColors.primary));
    }
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(gradient: AppColors.auroraGradient, shape: BoxShape.circle),
      child: inner,
    );
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  Widget _anim(int i, Widget child) {
    final begin = (i * 0.09).clamp(0.0, 0.6);
    final end   = (begin + 0.4).clamp(0.0, 1.0);
    final curve = Interval(begin, end, curve: Curves.easeOutCubic);
    final fade  = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: curve));
    final slide = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(CurvedAnimation(parent: _animController, curve: curve));
    return FadeTransition(opacity: fade, child: SlideTransition(position: slide, child: child));
  }

  SliverToBoxAdapter _gap(double h) => SliverToBoxAdapter(child: SizedBox(height: h));

  // Section header style — readable 13sp bold
  TextStyle get _label => AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.2, fontSize: 13);

  InputDecoration _inputDeco(String hint) => InputDecoration(
    hintText: hint, filled: true, fillColor: AppColors.surface, isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
  );
}

// ─── Card wrapper ─────────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: AppSpacing.borderRadiusLG,
        border: Border.all(color: AppColors.cardBorder, width: 1),
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
        width: 110, height: 110,
        child: CustomPaint(
          painter: _GaugePainter(progress: v),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${(v * 100).toStringAsFixed(1)}%', style: AppTypography.h5.copyWith(fontWeight: FontWeight.bold, color: AppColors.profitGreen)),
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
    final c = Offset(size.width / 2, size.height / 2);
    final r = math.min(c.dx, c.dy) - 10;
    const start = math.pi * 0.75;
    const sweep = math.pi * 1.5;
    final bg = Paint()..color = AppColors.backgroundTertiary..style = PaintingStyle.stroke..strokeWidth = 11..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), start, sweep, false, bg);
    final fg = Paint()
      ..shader = const LinearGradient(colors: [AppColors.profitGreen, AppColors.oceanTeal]).createShader(Rect.fromCircle(center: c, radius: r))
      ..style = PaintingStyle.stroke..strokeWidth = 11..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), start, sweep * progress, false, fg);
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
    children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 8),
      Expanded(child: Text(label, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary))),
      Text(value, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.bold, color: color)),
    ],
  );
}
