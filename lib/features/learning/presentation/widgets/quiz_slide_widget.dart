import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'lesson_slide_header.dart';
import 'interaction_models.dart';

class QuizSlideWidget extends StatefulWidget {
  final QuizQuestion question;
  final Function(bool) onAnswered;

  const QuizSlideWidget({
    super.key,
    required this.question,
    required this.onAnswered,
  });

  @override
  State<QuizSlideWidget> createState() => _QuizSlideWidgetState();
}

class _QuizSlideWidgetState extends State<QuizSlideWidget> {
  int? _selectedIndex;
  bool _hasAnswered = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LessonSlideHeader(
            title: 'Quick Check',
            subtitle: 'Test your understanding',
            gradientColors: [
              AppColors.amber.withValues(alpha: 0.25), // Darker
              AppColors.sunsetOrange.withValues(alpha: 0.20), // Darker
            ],
            borderColor: AppColors.amber.withValues(
              alpha: 0.4,
            ), // Darker border
            titleColor: AppColors.deepOrange, // Strong contrast
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: AppColors.premiumGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.amber.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.quiz_rounded,
                color: AppColors.white,
                size: 22,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            widget.question.question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          ...widget.question.options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final isSelected = _selectedIndex == index;
            final isCorrect = index == widget.question.correctIndex;

            Color? backgroundColor;
            Color? borderColor;

            if (_hasAnswered) {
              if (isCorrect) {
                backgroundColor = AppColors.success.withValues(
                  alpha: 0.15,
                ); // Slightly darker
                borderColor = AppColors.success;
              } else if (isSelected && !isCorrect) {
                backgroundColor = AppColors.error.withValues(
                  alpha: 0.15,
                ); // Slightly darker
                borderColor = AppColors.error;
              }
            } else if (isSelected) {
              backgroundColor = AppColors.primaryPurple.withValues(
                alpha: 0.15,
              ); // Slightly darker
              borderColor = AppColors.primaryPurple;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: _hasAnswered
                    ? null
                    : () {
                        setState(() {
                          _selectedIndex = index;
                          _hasAnswered = true;
                        });
                        widget.onAnswered(isCorrect);
                      },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: backgroundColor ?? AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: borderColor ?? AppColors.border,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: borderColor ?? AppColors.textSecondary,
                            width: 2,
                          ),
                          color: isSelected && _hasAnswered
                              ? (isCorrect
                                    ? AppColors.success
                                    : AppColors.error)
                              : null,
                        ),
                        child: _hasAnswered && isCorrect
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: AppColors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          option,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          if (_hasAnswered) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundTertiary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.primaryPurple,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.question.explanation,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
