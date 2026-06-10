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
              _gap(16),

              // ── Hero header (compact)
              SliverToBoxAdapter(child: _anim(0, _buildHeader(context, profile))),
              _gap(14),

              // ── Level progress
              SliverToBoxAdapter(
                child: Padding(padding: AppSpacing.screenPaddingH,
                  child: _anim(1, _buildLevelSection(profile, xpProgress, nextLevelXp))),
              ),
              _gap(10),

              // ── Streak
              SliverToBoxAdapter(
                child: Padding(padding: AppSpacing.screenPaddingH,
                  child: _anim(2, _buildStreakSection(profile))),
              ),
              _gap(10),

              // ── Performance
              SliverToBoxAdapter(
                child: Padding(padding: AppSpacing.screenPaddingH,
                  child: _anim(3, _buildPerformanceSection(profile, wins, losses))),
              ),
              _gap(10),

              // ── Achievements
              SliverToBoxAdapter(
                child: Padding(padding: AppSpacing.screenPaddingH,
                  child: _anim(4, _buildAchievementsSection(profile))),
              ),
              _gap(10),

              // ── Courses
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
      child: Row(
        children: [
          // Avatar with edit badge
          GestureDetector(
            onTap: () { HapticFeedback.lightImpact(); _showEditProfileSheet(context, profile); },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                _buildAvatar(profile, radius: 36),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.backgroundPrimary, width: 1.5),
                  ),
                  child: const Icon(Icons.edit_rounded, color: AppColors.white, size: 10),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          // Name + bio
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.username, style: AppTypography.h5.copyWith(fontWeight: FontWeight.bold)),
                if (profile.bio != null && profile.bio!.isNotEmpty)
                  Text(profile.bio!, style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary), maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          // XP badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text('Lv.${profile.level}', style: AppTypography.bodyXS.copyWith(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                Text('${profile.totalXp} XP', style: AppTypography.bodyXS.copyWith(color: AppColors.white.withValues(alpha: 0.85), fontSize: 9)),
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
      {'lvl': 3, 'title': 'Intermediate'},
      {'lvl': 4, 'title': 'Strategist'},
      {'lvl': 5, 'title': 'Market Master'},
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
              const SizedBox(width: 6),
              Text('XP Progress', style: _labelStyle),
              const Spacer(),
              Text('${profile.totalXp} / $nextLevelXp XP', style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: xpProgress),
              duration: const Duration(milliseconds: 1100),
              curve: Curves.easeOutCubic,
              builder: (_, v, ss) => LinearProgressIndicator(
                value: v, minHeight: 8,
                backgroundColor: AppColors.backgroundTertiary,
                valueColor: AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Compact milestone strip
          Row(
            children: levels.map((lvl) {
              final n       = lvl['lvl'] as int;
              final isCur   = profile.level == n;
              final isDone  = profile.level > n;
              final isLast  = n == levels.length;
              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 28, height: 28,
                            decoration: BoxDecoration(
                              color: isCur ? AppColors.primary : isDone ? AppColors.profitGreen.withValues(alpha: 0.15) : AppColors.backgroundTertiary,
                              shape: BoxShape.circle,
                              border: isDone && !isCur ? Border.all(color: AppColors.profitGreen, width: 1) : null,
                            ),
                            child: Center(
                              child: isDone && !isCur
                                  ? const Icon(Icons.check_rounded, color: AppColors.profitGreen, size: 12)
                                  : Text('$n', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isCur ? AppColors.white : AppColors.textTertiary)),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(lvl['title'] as String, style: AppTypography.bodyXS.copyWith(fontSize: 8, color: isCur ? AppColors.primary : AppColors.textTertiary), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(height: 1, color: isDone ? AppColors.profitGreen.withValues(alpha: 0.4) : AppColors.border),
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
              const Icon(Icons.local_fire_department_rounded, color: AppColors.sunsetOrange, size: 16),
              const SizedBox(width: 6),
              Text('Daily Streak', style: _labelStyle),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${profile.currentStreak}', style: AppTypography.h5.copyWith(color: AppColors.sunsetOrange, fontWeight: FontWeight.bold)),
                    TextSpan(text: ' days  ', style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
                    TextSpan(text: '🏆 ${profile.longestStreak}', style: AppTypography.bodyXS.copyWith(color: AppColors.textTertiary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
                    width: 34, height: 34,
                    decoration: BoxDecoration(
                      gradient: isActive
                          ? const LinearGradient(colors: [AppColors.sunsetOrange, AppColors.deepOrange], begin: Alignment.topLeft, end: Alignment.bottomRight)
                          : null,
                      color: isActive ? null : AppColors.backgroundTertiary,
                      shape: BoxShape.circle,
                      border: isToday && !isActive ? Border.all(color: AppColors.sunsetOrange, width: 1.5) : null,
                      boxShadow: isActive ? [BoxShadow(color: AppColors.sunsetOrange.withValues(alpha: 0.3), blurRadius: 6)] : null,
                    ),
                    alignment: Alignment.center,
                    child: Icon(isActive ? Icons.local_fire_department_rounded : Icons.circle_outlined, color: isActive ? AppColors.white : AppColors.textTertiary, size: 16),
                  ),
                  const SizedBox(height: 3),
                  Text(dayName, style: AppTypography.bodyXS.copyWith(fontSize: 9, color: isActive ? AppColors.sunsetOrange : AppColors.textTertiary, fontWeight: isToday ? FontWeight.bold : FontWeight.normal)),
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
              const Icon(Icons.analytics_outlined, color: AppColors.electricBlue, size: 16),
              const SizedBox(width: 6),
              Text('Performance', style: _labelStyle),
            ],
          ),
          const SizedBox(height: 12),

          // Gauge + stats side by side
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _WinRateGauge(rate: profile.winRate),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    _StatRow(label: 'Wins',    value: '$wins',   color: AppColors.profitGreen),
                    const SizedBox(height: 6),
                    _StatRow(label: 'Losses',  value: '$losses', color: AppColors.lossRed),
                    const SizedBox(height: 6),
                    _StatRow(label: 'Total',   value: '${profile.totalTrades}', color: AppColors.electricBlue),
                  ],
                ),
              ),
            ],
          ),

          if (profile.totalTrades > 0) ...[
            const SizedBox(height: 12),
            // Long vs Short bar
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: winPct),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (_, v, ss) => Row(
                  children: [
                    Flexible(
                      flex: (v * 100).toInt().clamp(1, 99),
                      child: Container(height: 22, color: AppColors.profitGreen, alignment: Alignment.center,
                        child: Text('${(v * 100).toInt()}% W', style: AppTypography.bodyXS.copyWith(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 9))),
                    ),
                    Flexible(
                      flex: ((1 - v) * 100).toInt().clamp(1, 99),
                      child: Container(height: 22, color: AppColors.lossRed, alignment: Alignment.center,
                        child: Text('${((1 - v) * 100).toInt()}% L', style: AppTypography.bodyXS.copyWith(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 9))),
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
      {'icon': Icons.rocket_launch_rounded,        'label': 'First Trade',    'color': AppColors.electricBlue,  'unlocked': profile.totalTrades >= 1},
      {'icon': Icons.local_fire_department_rounded, 'label': 'Streak Starter','color': AppColors.sunsetOrange,  'unlocked': profile.currentStreak >= 3},
      {'icon': Icons.school_rounded,               'label': 'Scholar',        'color': AppColors.indigo,        'unlocked': profile.totalCoursesCompleted >= 3},
      {'icon': Icons.shield_rounded,               'label': 'Risk Manager',   'color': AppColors.profitGreen,   'unlocked': profile.winRate >= 0.5},
      {'icon': Icons.military_tech_rounded,        'label': 'Challenge Pro',  'color': AppColors.goldenYellow,  'unlocked': profile.totalChallengesCompleted >= 5},
      {'icon': Icons.auto_graph_rounded,           'label': 'Market Master',  'color': AppColors.lavender,      'unlocked': profile.level >= 5},
    ];
    final unlockedCount = badges.where((b) => b['unlocked'] == true).length;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.military_tech_rounded, color: AppColors.goldenYellow, size: 16),
              const SizedBox(width: 6),
              Text('Achievements', style: _labelStyle),
              const Spacer(),
              Text('$unlockedCount/${badges.length}', style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: badges.map((b) {
              final unlocked = b['unlocked'] as bool;
              final color    = b['color'] as Color;
              return Expanded(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: unlocked ? 1.0 : 0.35,
                  child: Column(
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: unlocked ? color.withValues(alpha: 0.12) : AppColors.backgroundTertiary,
                          shape: BoxShape.circle,
                          border: Border.all(color: unlocked ? color.withValues(alpha: 0.3) : AppColors.border),
                          boxShadow: unlocked ? [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 6)] : null,
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Center(child: Icon(b['icon'] as IconData, color: unlocked ? color : AppColors.textTertiary, size: 18)),
                            if (unlocked) Container(width: 10, height: 10, decoration: const BoxDecoration(color: AppColors.profitGreen, shape: BoxShape.circle), child: const Icon(Icons.check, color: AppColors.white, size: 7)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(b['label'] as String, style: AppTypography.bodyXS.copyWith(fontSize: 8, color: unlocked ? AppColors.textPrimary : AppColors.textTertiary, fontWeight: unlocked ? FontWeight.bold : FontWeight.normal), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              );
            }).toList(),
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
              const Icon(Icons.menu_book_rounded, color: AppColors.indigo, size: 16),
              const SizedBox(width: 6),
              Text('Courses', style: _labelStyle),
              const Spacer(),
              Text('$completed / ${courses.length}', style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: completed / courses.length),
              duration: const Duration(milliseconds: 900),
              builder: (_, v, ss) => LinearProgressIndicator(
                value: v, minHeight: 5,
                backgroundColor: AppColors.backgroundTertiary,
                valueColor: AlwaysStoppedAnimation(AppColors.indigo),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(courses.length, (i) {
            final isDone = i < completed;
            final isNext = i == completed;
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Container(
                    width: 22, height: 22,
                    decoration: BoxDecoration(
                      color: isDone ? AppColors.indigo : isNext ? AppColors.indigo.withValues(alpha: 0.1) : AppColors.backgroundTertiary,
                      shape: BoxShape.circle,
                      border: isNext ? Border.all(color: AppColors.indigo) : null,
                    ),
                    child: Center(
                      child: isDone
                          ? const Icon(Icons.check_rounded, color: AppColors.white, size: 12)
                          : Icon(isNext ? Icons.play_arrow_rounded : Icons.lock_rounded,
                              color: isNext ? AppColors.indigo : AppColors.textTertiary, size: 11),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(courses[i], style: AppTypography.bodyXS.copyWith(
                      color: isDone ? AppColors.textPrimary : isNext ? AppColors.indigo : AppColors.textTertiary,
                      fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
                    )),
                  ),
                  if (isDone) const Icon(Icons.check_circle_rounded, color: AppColors.indigo, size: 13),
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
            decoration: const BoxDecoration(
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
                      IconButton(icon: const Icon(Icons.close_rounded, size: 20), onPressed: () => Navigator.pop(ctx)),
                    ],
                  ),
                  // Persona picker
                  const SizedBox(height: 4),
                  Text('Persona', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _kPersonas.length,
                      separatorBuilder: (_, ss) => const SizedBox(width: 10),
                      itemBuilder: (_, i) {
                        final p = _kPersonas[i];
                        final isSelected = selectedAvatarUrl == 'emoji:${p.id}';
                        return GestureDetector(
                          onTap: () { HapticFeedback.selectionClick(); setSheetState(() => selectedAvatarUrl = 'emoji:${p.id}'); },
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                width: 48, height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle, gradient: p.gradient,
                                  border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent, width: 2.5),
                                  boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 8)] : null,
                                ),
                                alignment: Alignment.center,
                                child: Text(p.emoji, style: const TextStyle(fontSize: 20)),
                              ),
                              const SizedBox(height: 3),
                              Text(p.name, style: AppTypography.bodyXS.copyWith(fontSize: 9, color: isSelected ? AppColors.primary : AppColors.textSecondary, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text('Username', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  TextField(controller: nameCtrl, decoration: _inputDeco('Enter username'), style: AppTypography.bodySmall),
                  const SizedBox(height: 12),
                  Text('Bio', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  TextField(controller: bioCtrl, maxLines: 2, decoration: _inputDeco('Your trading style...'), style: AppTypography.bodySmall),
                  const SizedBox(height: 18),
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
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryButton, foregroundColor: AppColors.white, padding: const EdgeInsets.symmetric(vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0),
                      child: Text('Save', style: AppTypography.buttonSmall),
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

  Widget _buildAvatar(UserProfile profile, {double radius = 36}) {
    final persona = _personaForUrl(profile.avatarUrl);
    Widget inner;
    if (persona != null) {
      inner = Container(
        width: radius * 2, height: radius * 2,
        decoration: BoxDecoration(shape: BoxShape.circle, gradient: persona.gradient),
        alignment: Alignment.center,
        child: Text(persona.emoji, style: TextStyle(fontSize: radius * 0.7)),
      );
    } else if (profile.avatarUrl != null) {
      inner = CircleAvatar(radius: radius, backgroundColor: AppColors.backgroundPrimary, backgroundImage: NetworkImage(profile.avatarUrl!));
    } else {
      inner = CircleAvatar(radius: radius, backgroundColor: AppColors.backgroundPrimary, child: Icon(Icons.person_rounded, size: radius * 0.9, color: AppColors.primary));
    }
    return Container(
      padding: const EdgeInsets.all(2),
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

  TextStyle get _labelStyle => AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.2);

  InputDecoration _inputDeco(String hint) => InputDecoration(
    hintText: hint, filled: true, fillColor: AppColors.surface, isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border)),
  );
}

// ─── Card wrapper ─────────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: AppSpacing.borderRadiusMD,
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
        width: 90, height: 90,
        child: CustomPaint(
          painter: _GaugePainter(progress: v),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${(v * 100).toStringAsFixed(0)}%', style: AppTypography.h5.copyWith(fontWeight: FontWeight.bold, color: AppColors.profitGreen, fontSize: 16)),
                Text('Win', style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary, fontSize: 9)),
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
    final r = math.min(c.dx, c.dy) - 8;
    const start = math.pi * 0.75;
    const sweep = math.pi * 1.5;
    final bg = Paint()..color = AppColors.backgroundTertiary..style = PaintingStyle.stroke..strokeWidth = 9..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), start, sweep, false, bg);
    final fg = Paint()
      ..shader = const LinearGradient(colors: [AppColors.profitGreen, AppColors.oceanTeal]).createShader(Rect.fromCircle(center: c, radius: r))
      ..style = PaintingStyle.stroke..strokeWidth = 9..strokeCap = StrokeCap.round;
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
      Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 6),
      Expanded(child: Text(label, style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary))),
      Text(value, style: AppTypography.bodyXS.copyWith(fontWeight: FontWeight.bold, color: color)),
    ],
  );
}
