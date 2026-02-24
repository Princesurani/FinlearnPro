import 'package:finnn/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../pages/daily_challenge_screen.dart';

import '../../../learning/bloc/learning_bloc.dart';
import '../../../learning/bloc/learning_bloc_provider.dart';

class StreakBadge extends StatelessWidget {
  const StreakBadge({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.dependOnInheritedWidgetOfExactType<LearningBlocProvider>() ==
        null) {
      return const SizedBox();
    }

    final bloc = LearningBlocProvider.of(context);

    return StreamBuilder<LearningState>(
      stream: bloc.stream,
      initialData: bloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state == null) return const SizedBox();
        final streak = state.userProgress.currentStreak;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LearningBlocProvider(
                  bloc: bloc,
                  child: const DailyChallengeScreen(),
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.sunsetOrange.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.local_fire_department_rounded,
                  color: AppColors.deepOrange,
                  size: 18,
                ),
                const SizedBox(width: 3),
                Text(
                  '$streak',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
