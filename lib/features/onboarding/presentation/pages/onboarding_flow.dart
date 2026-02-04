import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_animations.dart';
import '../../../../shared/widgets/aurora_background.dart';
import '../../../../shared/widgets/gradient_button.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({
    super.key,
    required this.onComplete,
    this.onSkip,
  });

  final void Function(OnboardingPreferences preferences) onComplete;

  final VoidCallback? onSkip;

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow>
    with TickerProviderStateMixin {

  int _currentStep = 0;
  ExperienceLevel? _selectedLevel;
  final Set<LearningGoal> _selectedGoals = {};
  final Set<InterestTopic> _selectedTopics = {};
  TimeCommitment? _selectedTimeCommitment;

  late PageController _pageController;
  late AnimationController _progressController;

  static const int _totalSteps = 4;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  bool get _canProceed {
    switch (_currentStep) {
      case 0:
        return _selectedLevel != null;
      case 1:
        return _selectedGoals.isNotEmpty;
      case 2:
        return _selectedTopics.isNotEmpty;
      case 3:
        return _selectedTimeCommitment != null;
      default:
        return false;
    }
  }

  void _nextStep() {
    if (!_canProceed) return;

    HapticFeedback.lightImpact();

    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: AppAnimations.mediumDuration,
        curve: AppAnimations.defaultCurve,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      HapticFeedback.lightImpact();
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: AppAnimations.mediumDuration,
        curve: AppAnimations.defaultCurve,
      );
    }
  }

  void _completeOnboarding() {
    HapticFeedback.mediumImpact();

    final preferences = OnboardingPreferences(
      experienceLevel: _selectedLevel!,
      learningGoals: _selectedGoals.toList(),
      interestTopics: _selectedTopics.toList(),
      timeCommitment: _selectedTimeCommitment!,
    );

    widget.onComplete(preferences);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Stack(
        children: [
          // Background
          const AuroraBackground(
            intensity: 0.15,
            enableAnimation: true,
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                _buildTopBar(),

                // Progress Indicator
                _buildProgressIndicator(),

                // Page Content
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _ExperienceLevelStep(
                        selectedLevel: _selectedLevel,
                        onSelect: (level) {
                          HapticFeedback.selectionClick();
                          setState(() => _selectedLevel = level);
                        },
                      ),
                      _LearningGoalsStep(
                        selectedGoals: _selectedGoals,
                        onToggle: (goal) {
                          HapticFeedback.selectionClick();
                          setState(() {
                            if (_selectedGoals.contains(goal)) {
                              _selectedGoals.remove(goal);
                            } else {
                              _selectedGoals.add(goal);
                            }
                          });
                        },
                      ),
                      _InterestTopicsStep(
                        selectedTopics: _selectedTopics,
                        onToggle: (topic) {
                          HapticFeedback.selectionClick();
                          setState(() {
                            if (_selectedTopics.contains(topic)) {
                              _selectedTopics.remove(topic);
                            } else {
                              _selectedTopics.add(topic);
                            }
                          });
                        },
                      ),
                      _TimeCommitmentStep(
                        selectedCommitment: _selectedTimeCommitment,
                        onSelect: (commitment) {
                          HapticFeedback.selectionClick();
                          setState(() => _selectedTimeCommitment = commitment);
                        },
                      ),
                    ],
                  ),
                ),

                // Bottom Buttons
                _buildBottomButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            IconButton(
              onPressed: _previousStep,
              icon: const Icon(Icons.arrow_back_rounded),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.textPrimary,
              ),
            )
          else
            const SizedBox(width: 48),
          const Spacer(),
          if (widget.onSkip != null)
            TextButton(
              onPressed: widget.onSkip,
              child: Text(
                'Skip',
                style: AppTypography.button.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        children: [
          // Step Counter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${_currentStep + 1} of $_totalSteps',
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '${((_currentStep + 1) / _totalSteps * 100).round()}%',
                style: AppTypography.label.copyWith(
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          AppSpacing.gapSM,
          // Progress Bar
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: (_currentStep + 1) / _totalSteps),
            duration: AppAnimations.mediumDuration,
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Container(
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    final isLastStep = _currentStep == _totalSteps - 1;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: PrimaryButton(
        onPressed: _canProceed ? _nextStep : null,
        text: isLastStep ? 'Get Started' : 'Continue',
        size: GradientButtonSize.large,
        trailingIcon: isLastStep
            ? Icons.check_rounded
            : Icons.arrow_forward_rounded,
      ),
    );
  }
}

class _ExperienceLevelStep extends StatelessWidget {
  const _ExperienceLevelStep({
    required this.selectedLevel,
    required this.onSelect,
  });

  final ExperienceLevel? selectedLevel;
  final void Function(ExperienceLevel) onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What\'s your experience\nlevel?',
            style: AppTypography.h1.copyWith(
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          AppSpacing.gapSM,
          Text(
            'We\'ll personalize your learning path based on this.',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppSpacing.gapXXL,
          ...ExperienceLevel.values.map((level) {
            final isSelected = selectedLevel == level;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _SelectionCard(
                title: level.title,
                subtitle: level.description,
                icon: level.icon,
                iconColor: level.color,
                isSelected: isSelected,
                onTap: () => onSelect(level),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _LearningGoalsStep extends StatelessWidget {
  const _LearningGoalsStep({
    required this.selectedGoals,
    required this.onToggle,
  });

  final Set<LearningGoal> selectedGoals;
  final void Function(LearningGoal) onToggle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What do you want\nto achieve?',
            style: AppTypography.h1.copyWith(
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          AppSpacing.gapSM,
          Text(
            'Select all that apply. You can change these later.',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppSpacing.gapXXL,
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: LearningGoal.values.map((goal) {
              final isSelected = selectedGoals.contains(goal);
              return _ChipSelection(
                label: goal.title,
                icon: goal.icon,
                isSelected: isSelected,
                onTap: () => onToggle(goal),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _InterestTopicsStep extends StatelessWidget {
  const _InterestTopicsStep({
    required this.selectedTopics,
    required this.onToggle,
  });

  final Set<InterestTopic> selectedTopics;
  final void Function(InterestTopic) onToggle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What topics interest\nyou most?',
            style: AppTypography.h1.copyWith(
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          AppSpacing.gapSM,
          Text(
            'Pick at least 3 topics for the best experience.',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppSpacing.gapXXL,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.4,
            ),
            itemCount: InterestTopic.values.length,
            itemBuilder: (context, index) {
              final topic = InterestTopic.values[index];
              final isSelected = selectedTopics.contains(topic);
              return _TopicCard(
                topic: topic,
                isSelected: isSelected,
                onTap: () => onToggle(topic),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TimeCommitmentStep extends StatelessWidget {
  const _TimeCommitmentStep({
    required this.selectedCommitment,
    required this.onSelect,
  });

  final TimeCommitment? selectedCommitment;
  final void Function(TimeCommitment) onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How much time can\nyou dedicate?',
            style: AppTypography.h1.copyWith(
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          AppSpacing.gapSM,
          Text(
            'We\'ll pace your learning accordingly.',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppSpacing.gapXXL,
          ...TimeCommitment.values.map((commitment) {
            final isSelected = selectedCommitment == commitment;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _SelectionCard(
                title: commitment.title,
                subtitle: commitment.description,
                icon: commitment.icon,
                iconColor: commitment.color,
                isSelected: isSelected,
                onTap: () => onSelect(commitment),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _SelectionCard extends StatefulWidget {
  const _SelectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_SelectionCard> createState() => _SelectionCardState();
}

class _SelectionCardState extends State<_SelectionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.98).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? widget.iconColor.withAlpha((0.1 * 255).round())
                : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
            border: Border.all(
              color: widget.isSelected
                  ? widget.iconColor
                  : AppColors.border,
              width: widget.isSelected ? 2 : 1,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: widget.iconColor.withAlpha((0.2 * 255).round()),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: widget.iconColor.withAlpha((0.15 * 255).round()),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.iconColor,
                  size: 28,
                ),
              ),
              AppSpacing.gapMD,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTypography.h4.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    AppSpacing.gapXXS,
                    Text(
                      widget.subtitle,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.isSelected
                      ? widget.iconColor
                      : Colors.transparent,
                  border: Border.all(
                    color: widget.isSelected
                        ? widget.iconColor
                        : AppColors.border,
                    width: 2,
                  ),
                ),
                child: widget.isSelected
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChipSelection extends StatelessWidget {
  const _ChipSelection({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryPurple.withAlpha((0.1 * 255).round())
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: Border.all(
            color: isSelected ? AppColors.primaryPurple : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? AppColors.primaryPurple
                  : AppColors.textSecondary,
            ),
            AppSpacing.gapSM,
            Text(
              label,
              style: AppTypography.button.copyWith(
                color: isSelected
                    ? AppColors.primaryPurple
                    : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({
    required this.topic,
    required this.isSelected,
    required this.onTap,
  });

  final InterestTopic topic;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    topic.color.withAlpha((0.15 * 255).round()),
                    topic.color.withAlpha((0.05 * 255).round()),
                  ],
                )
              : null,
          color: isSelected ? null : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
          border: Border.all(
            color: isSelected ? topic.color : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: topic.color.withAlpha((0.15 * 255).round()),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      topic.icon,
                      color: topic.color,
                      size: 22,
                    ),
                  ),
                  AppSpacing.gapSM,
                  Text(
                    topic.title,
                    style: AppTypography.button.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: AppSpacing.sm,
                right: AppSpacing.sm,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: topic.color,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

enum ExperienceLevel {
  beginner(
    title: 'Beginner',
    description: 'New to investing and trading',
    icon: Icons.emoji_nature_rounded,
    color: Color(0xFF4ADE80),
  ),
  intermediate(
    title: 'Intermediate',
    description: 'Some experience with basic concepts',
    icon: Icons.trending_up_rounded,
    color: Color(0xFF3B82F6),
  ),
  advanced(
    title: 'Advanced',
    description: 'Experienced trader looking to refine skills',
    icon: Icons.rocket_launch_rounded,
    color: Color(0xFF7C5CFF),
  );

  const ExperienceLevel({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

enum LearningGoal {
  buildWealth(
    title: 'Build Wealth',
    icon: Icons.savings_rounded,
  ),
  retirement(
    title: 'Retirement Planning',
    icon: Icons.beach_access_rounded,
  ),
  sideIncome(
    title: 'Side Income',
    icon: Icons.attach_money_rounded,
  ),
  careerChange(
    title: 'Career in Finance',
    icon: Icons.work_rounded,
  ),
  curiosity(
    title: 'Just Curious',
    icon: Icons.psychology_rounded,
  ),
  riskManagement(
    title: 'Manage Risk',
    icon: Icons.shield_rounded,
  );

  const LearningGoal({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;
}

enum InterestTopic {
  stocks(
    title: 'Stocks',
    icon: Icons.show_chart_rounded,
    color: Color(0xFF3B82F6),
  ),
  crypto(
    title: 'Crypto',
    icon: Icons.currency_bitcoin_rounded,
    color: Color(0xFFFF8A50),
  ),
  options(
    title: 'Options',
    icon: Icons.swap_horiz_rounded,
    color: Color(0xFFFF6B8A),
  ),
  forex(
    title: 'Forex',
    icon: Icons.currency_exchange_rounded,
    color: Color(0xFF00BFA5),
  ),
  etfs(
    title: 'ETFs',
    icon: Icons.pie_chart_rounded,
    color: Color(0xFFA78BFA),
  ),
  bonds(
    title: 'Bonds',
    icon: Icons.account_balance_rounded,
    color: Color(0xFF10B981),
  ),
  technicalAnalysis(
    title: 'Technical Analysis',
    icon: Icons.candlestick_chart_rounded,
    color: Color(0xFF6366F1),
  ),
  fundamentals(
    title: 'Fundamentals',
    icon: Icons.analytics_rounded,
    color: Color(0xFF22D3EE),
  );

  const InterestTopic({
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;
}

enum TimeCommitment {
  casual(
    title: '5-10 minutes/day',
    description: 'Light learning, perfect for busy schedules',
    icon: Icons.coffee_rounded,
    color: Color(0xFF4ADE80),
  ),
  regular(
    title: '15-30 minutes/day',
    description: 'Balanced approach for steady progress',
    icon: Icons.timer_rounded,
    color: Color(0xFF3B82F6),
  ),
  dedicated(
    title: '30-60 minutes/day',
    description: 'Accelerated learning for quick mastery',
    icon: Icons.speed_rounded,
    color: Color(0xFF7C5CFF),
  ),
  intensive(
    title: '1+ hours/day',
    description: 'Deep dive into financial markets',
    icon: Icons.local_fire_department_rounded,
    color: Color(0xFFFF6B8A),
  );

  const TimeCommitment({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

class OnboardingPreferences {
  const OnboardingPreferences({
    required this.experienceLevel,
    required this.learningGoals,
    required this.interestTopics,
    required this.timeCommitment,
  });

  final ExperienceLevel experienceLevel;
  final List<LearningGoal> learningGoals;
  final List<InterestTopic> interestTopics;
  final TimeCommitment timeCommitment;

  Map<String, dynamic> toJson() => {
        'experienceLevel': experienceLevel.name,
        'learningGoals': learningGoals.map((g) => g.name).toList(),
        'interestTopics': interestTopics.map((t) => t.name).toList(),
        'timeCommitment': timeCommitment.name,
      };
}
