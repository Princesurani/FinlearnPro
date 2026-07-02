import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../learning/data/learning_models.dart';
import '../../../learning/bloc/learning_bloc.dart';
import '../../../market/bloc/market_bloc.dart';
import '../../../learning/bloc/learning_bloc_provider.dart';
import '../../../social/bloc/social_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeOverviewCard extends StatelessWidget {
  const HomeOverviewCard({super.key, required this.marketBloc});

  final MarketBloc marketBloc;

  @override
  Widget build(BuildContext context) {
    if (context.dependOnInheritedWidgetOfExactType<LearningBlocProvider>() ==
        null) {
      return const SizedBox();
    }

    final learningBloc = LearningBlocProvider.of(context);

    return StreamBuilder<LearningState>(
      stream: learningBloc.stream,
      initialData: learningBloc.state,
      builder: (context, learningSnapshot) {
        final learningState = learningSnapshot.data;
        if (learningState == null) return const SizedBox();

        return StreamBuilder<MarketState>(
          stream: marketBloc.stream,
          initialData: marketBloc.state,
          builder: (context, marketSnapshot) {
            final marketState = marketSnapshot.data ?? MarketState.initial();

            return _UnifiedOverviewCard(
              progress: learningState.userProgress,
              marketState: marketState,
            );
          },
        );
      },
    );
  }
}

class _UnifiedOverviewCard extends StatelessWidget {
  const _UnifiedOverviewCard({
    required this.progress,
    required this.marketState,
  });

  final UserLearningProgress progress;
  final MarketState marketState;

  @override
  Widget build(BuildContext context) {
    // 1. Calculate the real portfolio value exactly like PortfolioTab does
    final currency = marketState.activeMarket.currencySymbol;
    final positions = marketState.portfolioPositions.values.where((pos) {
      return marketState.instruments.any((i) => i.symbol == pos.symbol);
    }).toList();

    double totalCurrentValue = 0;
    double totalInvested = 0;

    for (final pos in positions) {
      final livePrice =
          marketState.snapshots[pos.symbol]?.price ?? pos.averageCost;
      totalCurrentValue += livePrice * pos.quantity;
      totalInvested += pos.averageCost * pos.quantity;
    }

    final totalPnl = totalCurrentValue - totalInvested;
    final totalPnlPercent = totalInvested == 0
        ? 0.0
        : (totalPnl / totalInvested) * 100;
    final isProfit = totalPnl >= 0;

    // Use totalCurrentValue (Holdings) + Available Balance for total portfolio
    final balance = marketState.portfolioBalance;
    final totalPortfolioValue = balance + totalCurrentValue;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceLayer1,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.isDark
                ? const Color(0xFF94A3B8).withValues(alpha: 0.22)
                : AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
            spreadRadius: 0,
          ),
        ],
      ),
      child: BlocBuilder<SocialBloc, SocialState>(
        builder: (context, socialState) {
          final displayXp = progress.totalXp;
          final displayLevel = progress.currentLevel;
          final displayStreak = progress.currentStreak;
          
          final nextLevelXp = displayLevel * displayLevel * 100;
          final currentLevelBaseXp = (displayLevel - 1) * (displayLevel - 1) * 100;
          final xpToNextLevel = nextLevelXp - displayXp;
          final levelProgress = (nextLevelXp - currentLevelBaseXp) > 0 
              ? ((displayXp - currentLevelBaseXp) / (nextLevelXp - currentLevelBaseXp)).clamp(0.0, 1.0) 
              : 0.0;

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.isDark
                  ? const LinearGradient(
                      colors: [Color(0xFF1E2130), Color(0xFF13151E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : const LinearGradient(
                      colors: [Color(0xFF2962FF), Color(0xFF2962FF), Color(0xFF023E8A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(24),
              border: AppColors.isDark
                  ? Border.all(color: AppColors.cardBorder, width: 1.5)
                  : null,
            ),
            child: Column(
              children: [
                // Top Section: Level, XP, Progress Ring
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '$displayXp',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'XP',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.stars_rounded,
                                  color: AppColors.goldenYellow,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Level $displayLevel',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$xpToNextLevel XP to Level ${displayLevel + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 64,
                  height: 64,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.2),
                              blurRadius: 16,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      CustomPaint(
                        size: const Size(56, 56),
                        painter: _ProgressRingPainter(
                          progress: levelProgress,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          foregroundColor: Colors.white,
                          strokeWidth: 5,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${(levelProgress * 100).toInt()}%',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Progress',
                            style: TextStyle(
                              fontSize: 7,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Middle Section: Embedded Virtual Portfolio Inside the Gamification Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        color: const Color(0xFF60A5FA), // Vibrant Blue-Sky
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Virtual Portfolio',
                        style: AppTypography.labelSmall.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$currency${totalPortfolioValue.toStringAsFixed(2)}',
                        style: AppTypography.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.3,
                        ),
                      ),
                      if (totalPnl != 0.0) ...[
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isProfit
                                    ? Icons.arrow_upward_rounded
                                    : Icons.arrow_downward_rounded,
                                size: 14,
                                color: isProfit
                                    ? AppColors.mintGreen
                                    : AppColors.coralPink,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${isProfit ? '+' : ''}$currency${totalPnl.abs().toStringAsFixed(2)} (${totalPnlPercent.toStringAsFixed(1)}%)',
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.white.withValues(alpha: 0.95),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Bottom Section: Gamification Stats
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  _buildStatItem(
                    icon: Icons.auto_stories_outlined,
                    label: 'Lessons',
                    value: '${progress.lessonsCompleted}',
                    iconColor: const Color(0xFF22D3EE), // Vibrant Cyan/Teal
                  ),
                  _buildDivider(),
                  _buildStatItem(
                    icon: Icons.school_outlined,
                    label: 'Courses',
                    value: '${progress.coursesCompleted}',
                    iconColor: const Color(0xFFA78BFA), // Lavender/Purple
                  ),
                  _buildDivider(),
                  _buildStatItem(
                    icon: Icons.local_fire_department_rounded,
                    label: 'Streak',
                    value: '${displayStreak}d',
                    iconColor: const Color(0xFFFF8A50), // Sunset Orange
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
    ),
  );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    Color? iconColor,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 18, color: iconColor ?? Colors.white.withValues(alpha: 0.7)),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 24,
      color: Colors.white.withValues(alpha: 0.15),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  _ProgressRingPainter({
    required this.progress,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color backgroundColor;
  final Color foregroundColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final foregroundPaint = Paint()
      ..color = foregroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(_ProgressRingPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
