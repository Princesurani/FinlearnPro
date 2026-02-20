import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'lesson_slide_header.dart';
import 'interaction_models.dart';

class ScenarioSlideWidget extends StatefulWidget {
  final Scenario scenario;
  final Function(int) onChoice;

  const ScenarioSlideWidget({
    super.key,
    required this.scenario,
    required this.onChoice,
  });

  @override
  State<ScenarioSlideWidget> createState() => _ScenarioSlideWidgetState();
}

class _ScenarioSlideWidgetState extends State<ScenarioSlideWidget> {
  int? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LessonSlideHeader(
            title: 'What Would You Do?',
            subtitle: 'Apply your knowledge',
            gradientColors: [
              AppColors.oceanTeal.withValues(alpha: 0.25), // Darker
              AppColors.mintGreen.withValues(alpha: 0.20), // Darker
            ],
            borderColor: AppColors.oceanTeal.withValues(
              alpha: 0.4,
            ), // Darker border
            titleColor: AppColors.oceanTeal,
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: AppColors.successGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.oceanTeal.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.psychology_rounded,
                color: AppColors.white,
                size: 22,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryPurple.withValues(alpha: 0.15), // Darker
                  AppColors.oceanTeal.withValues(alpha: 0.15), // Darker
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              widget.scenario.situation,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ...widget.scenario.choices.asMap().entries.map((entry) {
            final index = entry.key;
            final choice = entry.value;
            final isSelected = _selectedChoice == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: _selectedChoice != null
                    ? null
                    : () {
                        setState(() => _selectedChoice = index);
                        widget.onChoice(index);
                      },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (choice.isCorrect
                              ? AppColors.success.withValues(
                                  alpha: 0.15,
                                ) // Darker
                              : AppColors.warning.withValues(
                                  alpha: 0.15,
                                )) // Darker
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? (choice.isCorrect
                                ? AppColors.success
                                : AppColors.warning)
                          : AppColors.border,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        choice.text,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (isSelected) ...[
                        const SizedBox(height: 12),
                        Text(
                          choice.feedback,
                          style: TextStyle(
                            fontSize: 14,
                            color: choice.isCorrect
                                ? AppColors.success
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
