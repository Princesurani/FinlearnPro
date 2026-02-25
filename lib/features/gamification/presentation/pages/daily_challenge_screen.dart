import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finnn/core/theme/app_colors.dart';

import '../../../learning/bloc/learning_bloc.dart';
import '../../../learning/bloc/learning_bloc_provider.dart';
import '../../bloc/challenge_cubit.dart';
import '../../data/models/daily_challenge.dart';

class DailyChallengeScreen extends StatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  State<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends State<DailyChallengeScreen> {
  int? _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    context.read<ChallengeCubit>().fetchDailyChallenge();
  }

  void _handleOptionSelect(int index, bool isSubmitted) {
    if (isSubmitted) return;
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _submitAnswer() {
    if (_selectedOptionIndex == null) return;
    context.read<ChallengeCubit>().submitAnswer(_selectedOptionIndex!);
  }

  void _showFeedbackBottomSheet({
    required BuildContext context,
    required bool isCorrect,
    required String title,
    required String description,
    required int xpAwarded,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (context) => SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? AppColors.successLight
                        : AppColors.errorLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCorrect ? Icons.check_rounded : Icons.close_rounded,
                    color: isCorrect ? AppColors.success : AppColors.error,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9A825).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.stars,
                        color: Color(0xFFF9A825),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '+\$xpAwarded XP',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF9A825),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close sheet
                      Navigator.pop(context); // Close screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B4EF5),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: AppColors.black87),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_fire_department_rounded,
              color: AppColors.sunsetOrange,
            ),
            SizedBox(width: 8),
            Text(
              'Daily Shield',
              style: TextStyle(
                color: AppColors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<ChallengeCubit, ChallengeState>(
        listener: (context, state) {
          if (state is ChallengeSubmitted) {
            // Give XP to global learning bloc
            try {
              final bloc = LearningBlocProvider.of(context);
              bloc.dispatch(
                CompleteDailyChallengeEvent(
                  xpReward: state.result.xpAwarded,
                  isCorrect: state.result.isCorrect,
                ),
              );
            } catch (e) {
              debugPrint('No learning bloc found: \$e');
            }

            // Also check if we should auto-select based on their previous completion
            // If they are revisiting the page and it was already completed globally:
            if (state.challenge.isCompleted) {
              setState(() {
                _selectedOptionIndex =
                    null; // Doesn't matter, we disable UI anyway
              });
            }

            // Only show bottom sheet if we JUST submitted it actively now
            if (!state.challenge.isCompleted) {
              _showFeedbackBottomSheet(
                context: context,
                isCorrect: state.result.isCorrect,
                title: state.result.isCorrect
                    ? 'Excellent Analysis!'
                    : 'Not quite.',
                description: state.result.explanation,
                xpAwarded: state.result.xpAwarded,
              );
            }
          } else if (state is ChallengeError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ChallengeLoading || state is ChallengeInitial) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6B4EF5)),
            );
          }

          if (state is ChallengeError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          DailyChallenge? challenge;
          bool isSubmitted = false;
          ChallengeSubmissionResult? submissionResult;

          if (state is ChallengeLoaded) {
            challenge = state.challenge;
          } else if (state is ChallengeSubmitted) {
            challenge = state.challenge;
            isSubmitted = true;
            submissionResult = state.result;
          }

          if (challenge == null) {
            return const Center(child: Text("No challenge data"));
          }

          // If the challenge was loaded already completed skip to submission state visuals
          if (challenge.isCompleted && !isSubmitted) {
            isSubmitted = true;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // Scenario Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.sunsetOrange.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.currency_bitcoin, // Generic icon
                              color: AppColors.sunsetOrange,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                challenge.assetSymbol,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black87,
                                ),
                              ),
                              Text(
                                challenge.timeframe,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.neutralGray,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Mock Chart Area
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FE),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.backgroundTertiary,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                5,
                                (index) => Divider(
                                  height: 1,
                                  color: AppColors.textDisabled,
                                ),
                              ),
                            ),
                            const Center(
                              child: Icon(
                                Icons.show_chart_rounded,
                                size: 100,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Scenario Analysis',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B4EF5),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        challenge.scenarioText,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.neutralGray,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                const Text(
                  'What is the most probable next move?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                // Dynamic Options
                ...challenge.choices.map((choice) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _buildOptionCard(
                      index: choice.id,
                      title: choice.text,
                      icon: Icons.analytics_outlined, // Generic icon
                      color: const Color(0xFF6B4EF5),
                      isSubmitted: isSubmitted,
                      correctOptionIndex: submissionResult != null
                          ? (submissionResult.isCorrect
                                ? _selectedOptionIndex
                                : null)
                          : (challenge?.isCompleted == true
                                ? (challenge!.wasCorrect == true ? null : null)
                                : null),
                      externalWasCorrect: challenge?.wasCorrect,
                    ),
                  );
                }),

                if (isSubmitted)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryPurple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Explanation",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            submissionResult?.explanation ??
                                challenge.explanation ??
                                "Already completed today.",
                            style: const TextStyle(
                              color: AppColors.black87,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 40),

                // Submit Button
                if (!isSubmitted)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedOptionIndex != null
                          ? _submitAnswer
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B4EF5),
                        disabledBackgroundColor: AppColors.textDisabled,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Submit Prediction',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _selectedOptionIndex != null
                              ? AppColors.white
                              : AppColors.neutralGray,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOptionCard({
    required int index,
    required String title,
    required IconData icon,
    required Color color,
    required bool isSubmitted,
    int? correctOptionIndex,
    bool? externalWasCorrect,
  }) {
    final bool isSelected = _selectedOptionIndex == index;

    Color borderColor = AppColors.transparent;
    Color backgroundColor = AppColors.white;

    // If already submitted and we know the exact result (for local submission UI)
    if (isSubmitted && correctOptionIndex != null) {
      if (index == correctOptionIndex) {
        borderColor = AppColors.success;
        backgroundColor = AppColors.success.withValues(alpha: 0.1);
      } else if (isSelected && index != correctOptionIndex) {
        borderColor = AppColors.error;
        backgroundColor = AppColors.error.withValues(alpha: 0.1);
      }
    } else if (isSubmitted && externalWasCorrect != null) {
      // If loaded from backend as already completed but we don't know which one user originally picked
      backgroundColor = AppColors.backgroundTertiary;
    } else if (!isSubmitted) {
      if (isSelected) {
        borderColor = const Color(0xFF6B4EF5);
        backgroundColor = const Color(0xFFF0EDFF);
      }
    }

    return GestureDetector(
      onTap: () => _handleOptionSelect(index, isSubmitted),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            if (!isSelected && !isSubmitted)
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black87,
                ),
              ),
            ),
            if (isSubmitted &&
                correctOptionIndex != null &&
                index == correctOptionIndex)
              const Icon(Icons.check_circle, color: AppColors.success),
            if (isSubmitted &&
                correctOptionIndex != null &&
                isSelected &&
                index != correctOptionIndex)
              const Icon(Icons.cancel, color: AppColors.error),
            if (!isSubmitted && isSelected)
              const Icon(Icons.radio_button_checked, color: Color(0xFF6B4EF5)),
            if (!isSubmitted && !isSelected)
              Icon(Icons.radio_button_unchecked, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
