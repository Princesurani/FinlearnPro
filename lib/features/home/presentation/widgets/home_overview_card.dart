import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../learning/data/learning_models.dart';
import '../../../learning/bloc/learning_bloc.dart';
import '../../../market/bloc/market_bloc.dart';
import '../../../learning/bloc/learning_bloc_provider.dart';

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
    // 1. Calculate the real portfolio value exactly like HoldingsTab does
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
            color: AppColors.primaryPurple.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6B4EF5), Color(0xFF8B5CF6), Color(0xFF7C3AED)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${progress.totalXp}',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Text(
                              'XP',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
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
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Level ${progress.currentLevel}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${progress.xpToNextLevel} XP to Level ${progress.currentLevel + 1}',
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
                          progress: progress.levelProgress,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          foregroundColor: Colors.white,
                          strokeWidth: 5,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${(progress.levelProgress * 100).toInt()}%',
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
                        color: Colors.white.withValues(alpha: 0.9),
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
                        style: AppTypography.h3.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
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
                  ),
                  _buildDivider(),
                  _buildStatItem(
                    icon: Icons.school_outlined,
                    label: 'Courses',
                    value: '${progress.coursesCompleted}',
                  ),
                  _buildDivider(),
                  _buildStatItem(
                    icon: Icons.local_fire_department_rounded,
                    label: 'Streak',
                    value: '${progress.currentStreak}d',
                    valueColor: AppColors.goldenYellow,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 18, color: Colors.white.withValues(alpha: 0.7)),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
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
