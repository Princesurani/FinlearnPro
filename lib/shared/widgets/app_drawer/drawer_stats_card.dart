
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_animations.dart';

class DrawerStatsCard extends StatefulWidget {
  const DrawerStatsCard({super.key});

  @override
  State<DrawerStatsCard> createState() => _DrawerStatsCardState();
}

class _DrawerStatsCardState extends State<DrawerStatsCard>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  // Mock data - In production, this comes from state management
  final _stats = const _QuickStats(
    portfolioValue: 127450.82,
    portfolioChange: 2.34,
    portfolioChangePercent: 1.87,
    isPortfolioUp: true,
    coursesCompleted: 8,
    totalCourses: 24,
    lessonsToday: 3,
    achievementsUnlocked: 15,
    totalAchievements: 50,
    tradesToday: 5,
    winRate: 67,
  );

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final fadeValue = CurvedAnimation(
          parent: _controller,
          curve: const Interval(0, 0.5, curve: Curves.easeOut),
        ).value;

        final slideValue = CurvedAnimation(
          parent: _controller,
          curve: AppAnimations.entranceCurve,
        ).value;

        return Transform.translate(
          offset: Offset(0, 20 * (1 - slideValue)),
          child: Opacity(
            opacity: fadeValue,
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.08),
              Colors.white.withValues(alpha: 0.04),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryPurple.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.insights_rounded,
                          color: AppColors.primaryPurpleLight,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Flexible(
                        child: Text(
                          'Quick Overview',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _LiveIndicator(),
              ],
            ),

            const SizedBox(height: 16),

            // Portfolio value highlight
            _buildPortfolioSection(),

            const SizedBox(height: 12),

            // Stats grid
            Row(
              children: [
                Expanded(
                  child: _StatTile(
                    icon: Icons.school_rounded,
                    iconColor: AppColors.electricBlue,
                    title: 'Learning',
                    value: '${_stats.coursesCompleted}/${_stats.totalCourses}',
                    subtitle: 'courses',
                    progress: _stats.coursesCompleted / _stats.totalCourses,
                    progressColor: AppColors.electricBlue,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatTile(
                    icon: Icons.emoji_events_rounded,
                    iconColor: AppColors.goldenYellow,
                    title: 'Achievements',
                    value: '${_stats.achievementsUnlocked}/${_stats.totalAchievements}',
                    subtitle: 'unlocked',
                    progress: _stats.achievementsUnlocked / _stats.totalAchievements,
                    progressColor: AppColors.goldenYellow,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioSection() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        // Navigate to portfolio
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _stats.isPortfolioUp 
                  ? AppColors.profitGreen.withValues(alpha: 0.15)
                  : AppColors.lossRed.withValues(alpha: 0.15),
              _stats.isPortfolioUp 
                  ? AppColors.profitGreen.withValues(alpha: 0.05)
                  : AppColors.lossRed.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: (_stats.isPortfolioUp 
                ? AppColors.profitGreen 
                : AppColors.lossRed).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Portfolio Value',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$${_formatCurrency(_stats.portfolioValue)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (_stats.isPortfolioUp 
                    ? AppColors.profitGreen 
                    : AppColors.lossRed).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _stats.isPortfolioUp 
                        ? Icons.trending_up_rounded 
                        : Icons.trending_down_rounded,
                    size: 14,
                    color: _stats.isPortfolioUp 
                        ? AppColors.profitGreen 
                        : AppColors.lossRed,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${_stats.isPortfolioUp ? '+' : '-'}${_stats.portfolioChangePercent}%',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: _stats.isPortfolioUp 
                          ? AppColors.profitGreen 
                          : AppColors.lossRed,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(2)}K';
    }
    return value.toStringAsFixed(2);
  }
}

class _LiveIndicator extends StatefulWidget {
  @override
  State<_LiveIndicator> createState() => _LiveIndicatorState();
}

class _LiveIndicatorState extends State<_LiveIndicator>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    // Only pulse once on mount for performance, then stop
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final pulseValue = Curves.easeOut.transform(
              _controller.value < 0.5 
                  ? _controller.value * 2 
                  : 2 - _controller.value * 2
            );
            return Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.profitGreen,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.profitGreen.withValues(alpha: 0.5 * pulseValue),
                    blurRadius: 6,
                    spreadRadius: 2 * pulseValue,
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(width: 6),
        const Text(
          'LIVE',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: Colors.white54,
            letterSpacing: 0.5,
          ),
          maxLines: 1,
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String subtitle;
  final double progress;
  final Color progressColor;

  const _StatTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.progress,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 3,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickStats {
  final double portfolioValue;
  final double portfolioChange;
  final double portfolioChangePercent;
  final bool isPortfolioUp;
  final int coursesCompleted;
  final int totalCourses;
  final int lessonsToday;
  final int achievementsUnlocked;
  final int totalAchievements;
  final int tradesToday;
  final int winRate;

  const _QuickStats({
    required this.portfolioValue,
    required this.portfolioChange,
    required this.portfolioChangePercent,
    required this.isPortfolioUp,
    required this.coursesCompleted,
    required this.totalCourses,
    required this.lessonsToday,
    required this.achievementsUnlocked,
    required this.totalAchievements,
    required this.tradesToday,
    required this.winRate,
  });
}
