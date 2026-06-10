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
  final String id;   // stored as "emoji:id" in avatarUrl
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

_Persona? _personaForUrl(String? avatarUrl) {
  if (avatarUrl == null || !avatarUrl.startsWith('emoji:')) return null;
  final id = avatarUrl.substring(6);
  try {
    return _kPersonas.firstWhere((p) => p.id == id);
  } catch (_) {
    return null;
  }
}

// ─── Tab Widget ──────────────────────────────────────────────────────────────

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
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _animController.forward());

    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && context.read<SocialBloc>().state.myProfile == null) {
        setState(() => _timedOut = true);
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        final profile = state.myProfile;

        if (profile == null) {
          if (_timedOut) {
            return Center(child: Text('Unable to load profile', style: AppTypography.bodySmall));
          }
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }

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
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── Avatar + Name + Bio + Edit button
              SliverToBoxAdapter(
                child: _buildAnimated(
                  index: 0,
                  child: Column(
                    children: [
                      // Avatar with gradient ring
                      GestureDetector(
                        onTap: () => _showEditProfileSheet(context, profile),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            _buildAvatar(profile, radius: 48),
                            Container(
                              padding: const EdgeInsets.all(4),
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
                      Text(profile.username, style: AppTypography.h4),
                      if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            profile.bio!,
                            style: AppTypography.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: () => _showEditProfileSheet(context, profile),
                        icon: const Icon(Icons.edit_outlined, size: 14),
                        label: Text(
                          'Edit Profile',
                          style: AppTypography.bodyXS.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          side: const BorderSide(color: AppColors.border),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 12)),

              // ── Level + XP Progress Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenPaddingH,
                  child: _buildAnimated(index: 1, child: _buildLevelCard(profile)),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 12)),

              // ── Streak Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenPaddingH,
                  child: _buildAnimated(index: 2, child: _buildStreakCard(profile)),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 12)),

              // ── Stats Grid
              SliverPadding(
                padding: AppSpacing.screenPaddingH,
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.8,
                  children: [
                    _buildAnimated(
                      index: 3,
                      child: _StatCard(
                        title: 'Total Trades',
                        value: profile.totalTrades.toString(),
                        icon: Icons.compare_arrows_rounded,
                        color: AppColors.electricBlue,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          _showTradesDetailSheet(context, profile);
                        },
                      ),
                    ),
                    _buildAnimated(
                      index: 4,
                      child: _StatCard(
                        title: 'Win Rate',
                        value: '${(profile.winRate * 100).toStringAsFixed(1)}%',
                        icon: Icons.trending_up_rounded,
                        color: AppColors.profitGreen,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          _showWinRateDetailSheet(context, profile);
                        },
                      ),
                    ),
                    _buildAnimated(
                      index: 5,
                      child: _StatCard(
                        title: 'Courses Done',
                        value: profile.totalCoursesCompleted.toString(),
                        icon: Icons.menu_book_rounded,
                        color: AppColors.indigo,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          _showCoursesDetailSheet(context, profile);
                        },
                      ),
                    ),
                    _buildAnimated(
                      index: 6,
                      child: _StatCard(
                        title: 'Challenges',
                        value: profile.totalChallengesCompleted.toString(),
                        icon: Icons.military_tech_rounded,
                        color: AppColors.goldenYellow,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          _showAchievementsSheet(context, profile);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── Trading Journal Access
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenPaddingH,
                  child: _buildAnimated(
                    index: 7,
                    child: InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const TradingJournalScreen()),
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
          ),
        );
      },
    );
  }

  // ─── Avatar builder ───────────────────────────────────────────────────────

  Widget _buildAvatar(UserProfile profile, {double radius = 44}) {
    final persona = _personaForUrl(profile.avatarUrl);

    Widget inner;
    if (persona != null) {
      inner = Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(shape: BoxShape.circle, gradient: persona.gradient),
        alignment: Alignment.center,
        child: Text(persona.emoji, style: TextStyle(fontSize: radius * 0.8)),
      );
    } else if (profile.avatarUrl != null && !profile.avatarUrl!.startsWith('emoji:')) {
      inner = CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.backgroundPrimary,
        backgroundImage: NetworkImage(profile.avatarUrl!),
      );
    } else {
      inner = CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.backgroundPrimary,
        child: Icon(Icons.person_rounded, size: radius, color: AppColors.primary),
      );
    }

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        gradient: AppColors.auroraGradient,
        shape: BoxShape.circle,
      ),
      child: inner,
    );
  }

  // ─── Edit Profile Sheet ───────────────────────────────────────────────────

  void _showEditProfileSheet(BuildContext context, UserProfile profile) {
    final nameController = TextEditingController(text: profile.username);
    final bioController  = TextEditingController(text: profile.bio ?? '');
    String? selectedAvatarUrl = profile.avatarUrl;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
              child: Container(
                padding: const EdgeInsets.all(24),
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
                          decoration: BoxDecoration(
                            color: AppColors.textTertiary.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Edit Profile', style: AppTypography.h4),
                          IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () => Navigator.pop(ctx),
                          ),
                        ],
                      ),

                      // ── Persona Picker
                      const SizedBox(height: 12),
                      Text('Choose Persona', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 90,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _kPersonas.length,
                          separatorBuilder: (_, ss) => const SizedBox(width: 12),
                          itemBuilder: (_, i) {
                            final persona = _kPersonas[i];
                            final isSelected = selectedAvatarUrl == 'emoji:${persona.id}';
                            return GestureDetector(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                setSheetState(() => selectedAvatarUrl = 'emoji:${persona.id}');
                              },
                              child: Column(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 56, height: 56,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: persona.gradient,
                                      border: Border.all(
                                        color: isSelected ? AppColors.primary : Colors.transparent,
                                        width: 3,
                                      ),
                                      boxShadow: isSelected
                                          ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.35), blurRadius: 10, offset: const Offset(0, 4))]
                                          : null,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(persona.emoji, style: const TextStyle(fontSize: 24)),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    persona.name,
                                    style: AppTypography.bodyXS.copyWith(
                                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
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
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter username',
                          filled: true,
                          fillColor: AppColors.surface,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                        ),
                        style: AppTypography.bodySmall,
                      ),

                      const SizedBox(height: 16),
                      Text('Bio', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: bioController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Tell others about your trading style...',
                          filled: true,
                          fillColor: AppColors.surface,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                        ),
                        style: AppTypography.bodySmall,
                      ),

                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final newName = nameController.text.trim();
                            final newBio  = bioController.text.trim();
                            if (newName.isNotEmpty) {
                              context.read<SocialBloc>().add(
                                UpdateProfile(
                                  profile.firebaseUid,
                                  username: newName,
                                  bio: newBio,
                                  avatarUrl: selectedAvatarUrl,
                                ),
                              );
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile updated successfully!'),
                                  backgroundColor: AppColors.profitGreen,
                                ),
                              );
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
            );
          },
        );
      },
    );
  }

  // ─── Level Breakdown Sheet ────────────────────────────────────────────────

  void _showLevelBreakdownSheet(BuildContext context, UserProfile profile) {
    final currentLevelBaseXp = (profile.level - 1) * (profile.level - 1) * 100;
    final nextLevelXp = profile.level * profile.level * 100;
    final progress = (nextLevelXp - currentLevelBaseXp) > 0
        ? ((profile.totalXp - currentLevelBaseXp) / (nextLevelXp - currentLevelBaseXp)).clamp(0.0, 1.0)
        : 0.0;

    final levels = [
      {'lvl': 1, 'title': 'Beginner Trader',       'xp': '0 - 100 XP'},
      {'lvl': 2, 'title': 'Novice Speculator',      'xp': '100 - 400 XP'},
      {'lvl': 3, 'title': 'Intermediate Investor',  'xp': '400 - 900 XP'},
      {'lvl': 4, 'title': 'Savvy Strategist',       'xp': '900 - 1,600 XP'},
      {'lvl': 5, 'title': 'Market Master',          'xp': '1,600+ XP'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.7,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.backgroundPrimary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sheetDragHandle(),
              const SizedBox(height: 16),
              _sheetHeader('Level & Milestones', () => Navigator.pop(ctx)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 20,
                      child: Icon(Icons.star_rounded, color: AppColors.white),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Current Level: ${profile.level}', style: AppTypography.labelLarge.copyWith(color: AppColors.white, fontWeight: FontWeight.bold)),
                          Text('${profile.totalXp} Total XP • Need ${nextLevelXp - profile.totalXp} XP to level up', style: AppTypography.bodyXS.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 6,
                              backgroundColor: AppColors.white.withValues(alpha: 0.2),
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('XP Levels', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: levels.length,
                  itemBuilder: (_, i) {
                    final lvlItem = levels[i];
                    final isCurrent = profile.level == lvlItem['lvl'];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isCurrent ? AppColors.white : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isCurrent ? AppColors.primary : AppColors.border, width: isCurrent ? 2 : 1),
                        boxShadow: isCurrent ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2))] : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 32, height: 32,
                                decoration: BoxDecoration(
                                  color: isCurrent ? AppColors.primary : AppColors.backgroundTertiary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(lvlItem['lvl'].toString(), style: TextStyle(color: isCurrent ? AppColors.white : AppColors.textSecondary, fontWeight: FontWeight.bold)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(lvlItem['title'] as String, style: AppTypography.bodySmall.copyWith(fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal, color: AppColors.textPrimary)),
                                  Text(lvlItem['xp'] as String, style: AppTypography.bodyXS),
                                ],
                              ),
                            ],
                          ),
                          if (isCurrent)
                            const Icon(Icons.check_circle_rounded, color: AppColors.primary)
                          else if (profile.level > (lvlItem['lvl'] as int))
                            const Icon(Icons.check_circle_outline_rounded, color: AppColors.textTertiary)
                          else
                            const Icon(Icons.lock_outline_rounded, color: AppColors.textTertiary),
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

  // ─── Streak Milestones Sheet ──────────────────────────────────────────────

  void _showStreakMilestonesSheet(BuildContext context, UserProfile profile) {
    // Build a simple 7-day activity simulation based on streak & lastActivityDate
    final today = DateTime.now();
    final streak = profile.currentStreak.clamp(0, 7);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.backgroundPrimary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sheetDragHandle(),
              const SizedBox(height: 16),
              _sheetHeader('Daily Streak Activity', () => Navigator.pop(ctx)),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppColors.sunsetOrange.withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: const Icon(Icons.local_fire_department_rounded, color: AppColors.sunsetOrange, size: 64),
                    ),
                    const SizedBox(height: 12),
                    Text('${profile.currentStreak} Day Streak!', style: AppTypography.h3.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Best streak: ${profile.longestStreak} days', style: AppTypography.bodySmall),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text('This week', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              // 7-day grid
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (i) {
                  final day = today.subtract(Duration(days: 6 - i));
                  final dayLabel = ['M', 'T', 'W', 'T', 'F', 'S', 'S'][day.weekday % 7];
                  final isActive = i >= (7 - streak);
                  return Column(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200 + i * 60),
                        width: 38, height: 38,
                        decoration: BoxDecoration(
                          color: isActive ? AppColors.sunsetOrange : AppColors.backgroundTertiary,
                          shape: BoxShape.circle,
                          boxShadow: isActive
                              ? [BoxShadow(color: AppColors.sunsetOrange.withValues(alpha: 0.35), blurRadius: 8)]
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          isActive ? Icons.local_fire_department_rounded : Icons.circle_outlined,
                          color: isActive ? AppColors.white : AppColors.textTertiary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(dayLabel, style: AppTypography.bodyXS.copyWith(color: isActive ? AppColors.sunsetOrange : AppColors.textTertiary)),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.backgroundTertiary, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const Icon(Icons.bolt_rounded, color: Colors.amber, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Maintaining streaks increases daily XP bonuses and levels you up faster.',
                        style: AppTypography.bodyXS,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // ─── Win Rate Detail Sheet ────────────────────────────────────────────────

  void _showWinRateDetailSheet(BuildContext context, UserProfile profile) {
    final wins = (profile.totalTrades * profile.winRate).round();
    final losses = profile.totalTrades - wins;
    final rate = profile.winRate;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.6,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.backgroundPrimary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sheetDragHandle(),
              const SizedBox(height: 16),
              _sheetHeader('Win Rate Breakdown', () => Navigator.pop(ctx)),
              const SizedBox(height: 20),
              Center(
                child: _WinRateGauge(rate: rate),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _MiniStatTile(label: 'Wins', value: wins.toString(), color: AppColors.profitGreen, icon: Icons.thumb_up_rounded)),
                  const SizedBox(width: 12),
                  Expanded(child: _MiniStatTile(label: 'Losses', value: losses.toString(), color: AppColors.lossRed, icon: Icons.thumb_down_rounded)),
                  const SizedBox(width: 12),
                  Expanded(child: _MiniStatTile(label: 'Total', value: profile.totalTrades.toString(), color: AppColors.electricBlue, icon: Icons.compare_arrows_rounded)),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.backgroundTertiary, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb_outline_rounded, color: AppColors.goldenYellow, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        rate >= 0.6
                            ? 'Excellent win rate! Keep following your strategy and managing risk consistently.'
                            : rate >= 0.4
                                ? 'Solid foundation. Focus on cutting losses early and letting winners run.'
                                : 'Review your entry criteria and tighten stop-losses to improve consistency.',
                        style: AppTypography.bodyXS,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ─── Trades Detail Sheet ──────────────────────────────────────────────────

  void _showTradesDetailSheet(BuildContext context, UserProfile profile) {
    final wins   = (profile.totalTrades * profile.winRate).round();
    final losses = profile.totalTrades - wins;
    final longPct = profile.totalTrades > 0 ? (wins / profile.totalTrades).clamp(0.0, 1.0) : 0.5;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.6,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.backgroundPrimary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sheetDragHandle(),
              const SizedBox(height: 16),
              _sheetHeader('Trade Summary', () => Navigator.pop(ctx)),
              const SizedBox(height: 24),
              Text('Long vs Short Balance', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: longPct),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  builder: (_, v, ss) {
                    return Row(
                      children: [
                        if (v > 0.05)
                          Flexible(
                            flex: (v * 100).toInt(),
                            child: Container(
                              height: 32,
                              color: AppColors.profitGreen,
                              alignment: Alignment.center,
                              child: Text('${(v * 100).toInt()}% W', style: AppTypography.bodyXS.copyWith(color: AppColors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        if ((1 - v) > 0.05)
                          Flexible(
                            flex: ((1 - v) * 100).toInt(),
                            child: Container(
                              height: 32,
                              color: AppColors.lossRed,
                              alignment: Alignment.center,
                              child: Text('${((1 - v) * 100).toInt()}% L', style: AppTypography.bodyXS.copyWith(color: AppColors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _MiniStatTile(label: 'Wins',   value: wins.toString(),   color: AppColors.profitGreen, icon: Icons.trending_up_rounded)),
                  const SizedBox(width: 12),
                  Expanded(child: _MiniStatTile(label: 'Losses', value: losses.toString(), color: AppColors.lossRed,     icon: Icons.trending_down_rounded)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _MiniStatTile(label: 'Total Trades', value: profile.totalTrades.toString(), color: AppColors.electricBlue, icon: Icons.compare_arrows_rounded)),
                  const SizedBox(width: 12),
                  Expanded(child: _MiniStatTile(label: 'Win Rate', value: '${(profile.winRate * 100).toStringAsFixed(1)}%', color: AppColors.indigo, icon: Icons.percent_rounded)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ─── Courses Detail Sheet ─────────────────────────────────────────────────

  void _showCoursesDetailSheet(BuildContext context, UserProfile profile) {
    final courses = [
      {'title': 'Stock Market Basics',          'locked': false},
      {'title': 'Technical Analysis 101',        'locked': profile.totalCoursesCompleted < 1},
      {'title': 'Options & Derivatives',         'locked': profile.totalCoursesCompleted < 2},
      {'title': 'Portfolio Risk Management',     'locked': profile.totalCoursesCompleted < 3},
      {'title': 'Fundamental Analysis',          'locked': profile.totalCoursesCompleted < 4},
      {'title': 'Trading Psychology',            'locked': profile.totalCoursesCompleted < 5},
    ];
    final completed = profile.totalCoursesCompleted.clamp(0, courses.length);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.7,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.backgroundPrimary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sheetDragHandle(),
              const SizedBox(height: 16),
              _sheetHeader('Course Progress', () => Navigator.pop(ctx)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(gradient: AppColors.learningGradient, borderRadius: BorderRadius.circular(14)),
                child: Row(
                  children: [
                    const Icon(Icons.menu_book_rounded, color: AppColors.white, size: 28),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$completed / ${courses.length} Completed', style: AppTypography.h5.copyWith(color: AppColors.white)),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: completed / courses.length),
                              duration: const Duration(milliseconds: 900),
                              builder: (_, v, ss) => LinearProgressIndicator(
                                value: v,
                                minHeight: 6,
                                backgroundColor: AppColors.white.withValues(alpha: 0.2),
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (_, i) {
                    final c = courses[i];
                    final isDone   = i < completed;
                    final isNext   = i == completed;
                    final isLocked = c['locked'] as bool;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: isDone ? AppColors.indigo.withValues(alpha: 0.07) : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isNext ? AppColors.indigo : AppColors.border, width: isNext ? 1.5 : 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32, height: 32,
                            decoration: BoxDecoration(
                              color: isDone ? AppColors.indigo : isNext ? AppColors.indigo.withValues(alpha: 0.1) : AppColors.backgroundTertiary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: isDone
                                  ? const Icon(Icons.check_rounded, color: AppColors.white, size: 16)
                                  : isLocked
                                      ? const Icon(Icons.lock_rounded, color: AppColors.textTertiary, size: 14)
                                      : Text('${i + 1}', style: TextStyle(color: isNext ? AppColors.indigo : AppColors.textTertiary, fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(c['title'] as String, style: AppTypography.bodySmall.copyWith(color: isLocked ? AppColors.textTertiary : AppColors.textPrimary))),
                          if (isDone) const Icon(Icons.verified_rounded, color: AppColors.indigo, size: 16)
                          else if (isNext) const Icon(Icons.play_circle_fill_rounded, color: AppColors.indigo, size: 18),
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

  // ─── Achievements Sheet ───────────────────────────────────────────────────

  void _showAchievementsSheet(BuildContext context, UserProfile profile) {
    final badges = [
      {
        'icon': Icons.rocket_launch_rounded,
        'label': 'First Trade',
        'desc': 'Placed your first simulated trade',
        'color': AppColors.electricBlue,
        'unlocked': profile.totalTrades >= 1,
      },
      {
        'icon': Icons.local_fire_department_rounded,
        'label': 'Streak Starter',
        'desc': 'Maintained a 3-day streak',
        'color': AppColors.sunsetOrange,
        'unlocked': profile.currentStreak >= 3,
      },
      {
        'icon': Icons.school_rounded,
        'label': 'Scholar',
        'desc': 'Completed 3 or more courses',
        'color': AppColors.indigo,
        'unlocked': profile.totalCoursesCompleted >= 3,
      },
      {
        'icon': Icons.shield_rounded,
        'label': 'Risk Manager',
        'desc': 'Win rate above 50%',
        'color': AppColors.profitGreen,
        'unlocked': profile.winRate >= 0.5,
      },
      {
        'icon': Icons.military_tech_rounded,
        'label': 'Challenge Pro',
        'desc': 'Completed 5 challenges',
        'color': AppColors.goldenYellow,
        'unlocked': profile.totalChallengesCompleted >= 5,
      },
      {
        'icon': Icons.auto_graph_rounded,
        'label': 'Market Master',
        'desc': 'Reached level 5 or above',
        'color': AppColors.lavender,
        'unlocked': profile.level >= 5,
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.72,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.backgroundPrimary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sheetDragHandle(),
              const SizedBox(height: 16),
              _sheetHeader('Achievements', () => Navigator.pop(ctx)),
              const SizedBox(height: 8),
              Text(
                '${badges.where((b) => b['unlocked'] == true).length} / ${badges.length} unlocked',
                style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: badges.length,
                  itemBuilder: (_, i) {
                    final b = badges[i];
                    final unlocked = b['unlocked'] as bool;
                    final color    = b['color'] as Color;
                    return AnimatedOpacity(
                      duration: Duration(milliseconds: 300 + i * 80),
                      opacity: unlocked ? 1.0 : 0.45,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: unlocked ? color.withValues(alpha: 0.08) : AppColors.backgroundTertiary,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: unlocked ? color.withValues(alpha: 0.3) : AppColors.border),
                          boxShadow: unlocked
                              ? [BoxShadow(color: color.withValues(alpha: 0.15), blurRadius: 10, offset: const Offset(0, 3))]
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: unlocked ? color.withValues(alpha: 0.15) : AppColors.border,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(b['icon'] as IconData, color: unlocked ? color : AppColors.textTertiary, size: 18),
                                ),
                                const Spacer(),
                                if (unlocked) const Icon(Icons.verified_rounded, color: AppColors.profitGreen, size: 14),
                              ],
                            ),
                            const Spacer(),
                            Text(b['label'] as String, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.bold, color: unlocked ? AppColors.textPrimary : AppColors.textTertiary)),
                            const SizedBox(height: 2),
                            Text(b['desc'] as String, style: AppTypography.bodyXS.copyWith(color: AppColors.textTertiary), maxLines: 2, overflow: TextOverflow.ellipsis),
                          ],
                        ),
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

  // ─── Level Card ───────────────────────────────────────────────────────────

  Widget _buildLevelCard(UserProfile profile) {
    final currentLevelBaseXp = (profile.level - 1) * (profile.level - 1) * 100;
    final nextLevelXp = profile.level * profile.level * 100;
    final progress = (nextLevelXp - currentLevelBaseXp) > 0
        ? ((profile.totalXp - currentLevelBaseXp) / (nextLevelXp - currentLevelBaseXp)).clamp(0.0, 1.0)
        : 0.0;

    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        _showLevelBreakdownSheet(context, profile);
      },
      borderRadius: AppSpacing.borderRadiusLG,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.cardPaddingCompact),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: AppSpacing.borderRadiusLG,
          boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.white.withValues(alpha: 0.2), borderRadius: AppSpacing.borderRadiusSM),
                  child: const Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Level ${profile.level}', style: AppTypography.h5.copyWith(color: AppColors.white)),
                      Text('${profile.totalXp} / $nextLevelXp XP (${(progress * 100).toInt()}%)', style: AppTypography.bodyXS.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: AppColors.white.withValues(alpha: 0.2), borderRadius: AppSpacing.borderRadiusFull),
                  child: Text('${profile.weeklyXp} this week', style: AppTypography.labelSmall.copyWith(color: AppColors.white, letterSpacing: 0)),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: AppSpacing.borderRadiusFull,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutCubic,
                builder: (_, value, ss) {
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

  // ─── Streak Card ──────────────────────────────────────────────────────────

  Widget _buildStreakCard(UserProfile profile) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        _showStreakMilestonesSheet(context, profile);
      },
      borderRadius: AppSpacing.borderRadiusLG,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusLG,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColors.sunsetOrange.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusMD),
              child: const Icon(Icons.local_fire_department_rounded, color: AppColors.sunsetOrange, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current Streak', style: AppTypography.labelSmall.copyWith(letterSpacing: 0)),
                  const SizedBox(height: 2),
                  Text('${profile.currentStreak} day${profile.currentStreak != 1 ? "s" : ""}', style: AppTypography.h5),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Best', style: AppTypography.labelSmall.copyWith(letterSpacing: 0)),
                const SizedBox(height: 2),
                Text(
                  '${profile.longestStreak} days',
                  style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600, color: AppColors.profitGreen),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── Animation wrapper ────────────────────────────────────────────────────

  Widget _buildAnimated({required int index, required Widget child}) {
    final begin    = (index * 0.08).clamp(0.0, 0.7);
    final end      = (begin + 0.3).clamp(0.0, 1.0);
    final interval = Interval(begin, end, curve: Curves.easeOutCubic);
    final fade  = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: interval));
    final slide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _animController, curve: interval));
    return FadeTransition(opacity: fade, child: SlideTransition(position: slide, child: child));
  }

  // ─── Shared helpers ───────────────────────────────────────────────────────

  Widget _sheetDragHandle() => Center(
        child: Container(
          width: 40, height: 4,
          decoration: BoxDecoration(color: AppColors.textTertiary.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2)),
        ),
      );

  Widget _sheetHeader(String title, VoidCallback onClose) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.h4),
          IconButton(icon: const Icon(Icons.close_rounded), onPressed: onClose),
        ],
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
      builder: (_, v, ss) {
        return SizedBox(
          width: 160, height: 160,
          child: CustomPaint(
            painter: _GaugePainter(progress: v),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${(v * 100).toStringAsFixed(1)}%', style: AppTypography.h3.copyWith(fontWeight: FontWeight.bold, color: AppColors.profitGreen)),
                  Text('Win Rate', style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  const _GaugePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r  = math.min(cx, cy) - 10;
    const startAngle = math.pi * 0.75;
    const sweepTotal = math.pi * 1.5;

    final bgPaint = Paint()
      ..color = AppColors.backgroundTertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: r), startAngle, sweepTotal, false, bgPaint);

    final fgPaint = Paint()
      ..shader = const LinearGradient(colors: [AppColors.profitGreen, AppColors.oceanTeal]).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: r), startAngle, sweepTotal * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(_GaugePainter old) => old.progress != progress;
}

// ─── Mini Stat Tile ───────────────────────────────────────────────────────────

class _MiniStatTile extends StatelessWidget {
  final String label;
  final String value;
  final Color  color;
  final IconData icon;
  const _MiniStatTile({required this.label, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: AppTypography.h5.copyWith(color: color, fontSize: 15)),
                Text(label, style: AppTypography.bodyXS.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stat Card ────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color  color;
  final VoidCallback? onTap;

  const _StatCard({required this.title, required this.value, required this.icon, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.borderRadiusLG,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusLG,
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusSM),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: AppTypography.labelSmall.copyWith(letterSpacing: 0, fontSize: 10), overflow: TextOverflow.ellipsis),
                  Text(value, style: AppTypography.h5.copyWith(fontSize: 16), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 10, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
