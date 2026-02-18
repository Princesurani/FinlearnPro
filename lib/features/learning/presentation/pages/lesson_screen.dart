import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/learning_models.dart';
import '../../data/courses/foundations_of_trading/chapter1_content.dart';
import '../../data/courses/foundations_of_trading/chapter2_content.dart';
import '../../data/courses/foundations_of_trading/chapter3_content.dart';
import '../../data/courses/foundations_of_trading/chapter4_content.dart';
import '../../data/courses/foundations_of_trading/chapter5_content.dart';
import '../../data/courses/foundations_of_trading/chapter6_content.dart';
import '../widgets/concept_slide_widget.dart';

/// Interactive lesson screen with psychological engagement
class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  final Course course;
  final int lessonIndex;
  final int totalLessons;

  const LessonScreen({
    super.key,
    required this.lesson,
    required this.course,
    required this.lessonIndex,
    required this.totalLessons,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late List<LessonContent> _content;
  int _score = 0;
  late AnimationController _progressAnimController;
  late AnimationController _celebrationController;

  // Track which slides have been completed (for validation)
  final Set<int> _completedSlides = {};

  // Show validation warning banner
  bool _showValidationWarning = false;

  // Show quiz feedback banner
  bool _showQuizFeedback = false;
  bool _isQuizCorrect = false;
  String _quizFeedbackMessage = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _content = _generateLessonContent();
    _progressAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressAnimController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  List<LessonContent> _generateLessonContent() {
    // Load actual content based on lesson ID
    return _loadLessonContentById(widget.lesson.id);
  }

  List<LessonContent> _loadLessonContentById(String lessonId) {
    // Map lesson IDs to their content
    Map<String, dynamic>? contentData;

    switch (lessonId) {
      case 'lesson-1-1':
        contentData = Chapter1Content.getTradingVsInvestingContent();
        break;
      case 'lesson-1-2':
        contentData = Chapter1Content.getWhyPeopleTradeContent();
        break;
      case 'lesson-1-3':
        contentData = Chapter1Content.getRealityCheckContent();
        break;
      case 'lesson-2-1':
        contentData = Chapter2Content.getFinancialMarketContent();
        break;
      case 'lesson-2-2':
        contentData = Chapter2Content.getExchangesContent();
        break;
      case 'lesson-2-3':
        contentData = Chapter2Content.getTradeProcessContent();
        break;
      case 'lesson-3-1':
        contentData = Chapter3Content.getRetailTradersContent();
        break;
      case 'lesson-3-2':
        contentData = Chapter3Content.getInstitutionalPlayersContent();
        break;
      case 'lesson-3-3':
        contentData = Chapter3Content.getMarketMakersContent();
        break;
      case 'lesson-4-1':
        contentData = Chapter4Content.getMarketOrderContent();
        break;
      case 'lesson-4-2':
        contentData = Chapter4Content.getLimitOrderContent();
        break;
      case 'lesson-4-3':
        contentData = Chapter4Content.getStopOrderContent();
        break;
      case 'lesson-4-4':
        contentData = Chapter4Content.getPracticeContent();
        break;
      case 'lesson-5-1':
        contentData = Chapter5Content.getBidAskContent();
        break;
      case 'lesson-5-2':
        contentData = Chapter5Content.getVolumeLiquidityContent();
        break;
      case 'lesson-5-3':
        contentData = Chapter5Content.getBullsBearsContent();
        break;
      case 'lesson-6-1':
        contentData = Chapter6Content.getBrokerSelectionContent();
        break;
      case 'lesson-6-2':
        contentData = Chapter6Content.getPaperTradingContent();
        break;
      case 'lesson-6-3':
        contentData = Chapter6Content.getMistakeContent();
        break;
      case 'lesson-6-4':
        contentData = Chapter6Content.getFinalChallengeContent();
        break;
      default:
        // Fallback to placeholder content for lessons not yet implemented
        return _generatePlaceholderContent();
    }

    // Parse the content data and create LessonContent widgets
    return _parseContentData(contentData);
  }

  List<LessonContent> _parseContentData(Map<String, dynamic> contentData) {
    final slides = contentData['slides'] as List<dynamic>;
    final List<LessonContent> content = [];

    for (final slide in slides) {
      final slideMap = slide as Map<String, dynamic>;
      final type = slideMap['type'] as String;

      switch (type) {
        case 'intro':
          content.add(
            IntroContent(
              title: slideMap['title'] ?? widget.lesson.title,
              subtitle:
                  slideMap['content'] ?? 'Let\'s master this concept together',
              estimatedTime: widget.lesson.formattedDuration,
            ),
          );
          break;

        case 'story':
          content.add(
            StoryContent(
              story: slideMap['content'] ?? '',
              character: slideMap['emoji'] ?? '👤',
            ),
          );
          break;

        case 'concept':
          content.add(
            ConceptContent(
              concept: slideMap['content'] ?? '',
              keyPoints: List<String>.from(slideMap['keyPoints'] ?? []),
            ),
          );
          break;

        case 'quiz':
          content.add(
            InteractiveQuizContent(
              question: QuizQuestion(
                question: slideMap['question'] ?? '',
                options: List<String>.from(slideMap['options'] ?? []),
                correctIndex: slideMap['correctIndex'] ?? 0,
                explanation: slideMap['explanation'] ?? '',
              ),
              onAnswered: _handleQuizAnswer,
            ),
          );
          break;

        case 'scenario':
          final choices = (slideMap['choices'] as List<dynamic>).map((choice) {
            final choiceMap = choice as Map<String, dynamic>;
            return ScenarioChoice(
              text: choiceMap['text'] ?? '',
              isCorrect: choiceMap['isCorrect'] ?? false,
              feedback: choiceMap['feedback'] ?? '',
            );
          }).toList();

          content.add(
            ScenarioContent(
              scenario: Scenario(
                situation: slideMap['situation'] ?? '',
                choices: choices,
              ),
              onChoice: _handleScenarioChoice,
            ),
          );
          break;

        case 'interactive':
          content.add(
            ConceptContent(
              concept: slideMap['content'] ?? '',
              keyPoints: [], // Interactive slides don't need key points
            ),
          );
          break;

        case 'summary':
          content.add(
            SummaryContent(
              keyTakeaways: List<String>.from(slideMap['keyPoints'] ?? []),
              nextLesson: widget.lessonIndex < widget.totalLessons - 1
                  ? 'Next: Continue your learning journey'
                  : null,
            ),
          );
          break;
      }
    }

    return content;
  }

  List<LessonContent> _generatePlaceholderContent() {
    // Placeholder for lessons not yet implemented
    return [
      IntroContent(
        title: widget.lesson.title,
        subtitle: 'Content coming soon!',
        estimatedTime: widget.lesson.formattedDuration,
      ),
      ConceptContent(
        concept:
            'This lesson content is being developed. Check back soon for the full interactive experience!',
        keyPoints: [
          'Content is being created',
          'Will include stories, quizzes, and scenarios',
          'Stay tuned for updates',
        ],
      ),
      SummaryContent(
        keyTakeaways: ['Lesson content coming soon'],
        nextLesson: widget.lessonIndex < widget.totalLessons - 1
            ? 'Next: Continue to the next lesson'
            : null,
      ),
    ];
  }

  void _handleQuizAnswer(bool isCorrect) {
    // Mark this slide as completed
    _markSlideCompleted(_currentPage);

    // Hide validation warning if shown
    setState(() {
      _showValidationWarning = false;
      _showQuizFeedback = true;
      _isQuizCorrect = isCorrect;
      _quizFeedbackMessage = isCorrect
          ? '🎉 Correct! +10 points'
          : '💡 Not quite right, but keep learning!';
    });

    if (isCorrect) {
      setState(() => _score += 10);
      HapticFeedback.lightImpact();
    } else {
      HapticFeedback.mediumImpact();
    }

    // Auto-hide after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showQuizFeedback = false;
        });
      }
    });
  }

  void _handleScenarioChoice(int choiceIndex) {
    // Mark this slide as completed
    _markSlideCompleted(_currentPage);

    // Hide validation warning if shown
    setState(() {
      _showValidationWarning = false;
    });

    // Handle scenario-based learning
    setState(() => _score += 5);
  }

  void _nextPage() {
    // Check if current slide requires interaction and hasn't been completed
    if (_requiresInteraction(_currentPage) &&
        !_completedSlides.contains(_currentPage)) {
      setState(() {
        _showValidationWarning = true;
      });
      HapticFeedback.mediumImpact();

      // Auto-hide after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showValidationWarning = false;
          });
        }
      });
      return;
    }

    if (_currentPage < _content.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      _progressAnimController.forward(from: 0);
    } else {
      _completeLesson();
    }
  }

  bool _requiresInteraction(int pageIndex) {
    if (pageIndex >= _content.length) return false;

    final content = _content[pageIndex];
    // Quiz and Scenario slides require interaction
    return content is InteractiveQuizContent || content is ScenarioContent;
  }

  void _markSlideCompleted(int pageIndex) {
    setState(() {
      _completedSlides.add(pageIndex);
    });
  }

  String _getButtonText() {
    // Last slide
    if (_currentPage == _content.length - 1) {
      return 'Complete Lesson';
    }

    // Interactive slides that haven't been completed yet
    if (_requiresInteraction(_currentPage) &&
        !_completedSlides.contains(_currentPage)) {
      final content = _content[_currentPage];
      if (content is InteractiveQuizContent) {
        return 'Answer to Continue';
      } else if (content is ScenarioContent) {
        return 'Make a Choice';
      }
    }

    return 'Continue';
  }

  void _completeLesson() {
    _celebrationController.forward();
    HapticFeedback.heavyImpact();

    // Show completion dialog
    Future.delayed(const Duration(milliseconds: 500), () {
      _showCompletionDialog();
    });
  }

  void _showCompletionDialog() {
    // Check if there's a next lesson
    final hasNextLesson = widget.lessonIndex < widget.totalLessons - 1;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _CompletionDialog(
        score: _score,
        lessonTitle: widget.lesson.title,
        hasNextLesson: hasNextLesson,
        onContinue: () {
          Navigator.of(context).pop(); // Close dialog

          if (hasNextLesson) {
            // Navigate to next lesson
            _navigateToNextLesson();
          } else {
            // Last lesson - return to course
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  void _navigateToNextLesson() {
    // Find the next lesson in the course
    final allLessons = <Lesson>[];
    for (final module in widget.course.modules) {
      allLessons.addAll(module.lessons);
    }

    if (widget.lessonIndex + 1 < allLessons.length) {
      final nextLesson = allLessons[widget.lessonIndex + 1];

      // Replace current lesson screen with next lesson
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LessonScreen(
            lesson: nextLesson,
            course: widget.course,
            lessonIndex: widget.lessonIndex + 1,
            totalLessons: widget.totalLessons,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildProgressBar(),
            if (_showValidationWarning) _buildValidationBanner(),
            if (_showQuizFeedback) _buildQuizFeedbackBanner(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                    _showValidationWarning =
                        false; // Hide banner on page change
                    _showQuizFeedback =
                        false; // Hide quiz feedback on page change
                  });
                },
                itemCount: _content.length,
                itemBuilder: (context, index) {
                  return _content[index].build(context);
                },
              ),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => _showExitConfirmation(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.course.title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.lesson.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          _buildScoreBadge(),
        ],
      ),
    );
  }

  Widget _buildScoreBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.stars_rounded, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            '$_score',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationBanner() {
    final content = _content[_currentPage];
    String message = '⚠️ Please complete this section before continuing';

    if (content is InteractiveQuizContent) {
      message = '📝 Please answer the quiz to continue';
    } else if (content is ScenarioContent) {
      message = '🤔 Please make a choice to continue';
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.warning.withValues(alpha: 0.15),
            AppColors.warning.withValues(alpha: 0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.3),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.warning.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: AppColors.warning,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 18),
            color: AppColors.textSecondary,
            onPressed: () {
              setState(() {
                _showValidationWarning = false;
              });
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizFeedbackBanner() {
    final isCorrect = _isQuizCorrect;
    final color = isCorrect ? AppColors.success : AppColors.error;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isCorrect
                  ? Icons.check_circle_outline_rounded
                  : Icons.info_outline_rounded,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _quizFeedbackMessage,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 18),
            color: AppColors.textSecondary,
            onPressed: () {
              setState(() {
                _showQuizFeedback = false;
              });
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = (_currentPage + 1) / _content.length;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_currentPage + 1} of ${_content.length}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.backgroundTertiary,
              valueColor: const AlwaysStoppedAnimation(AppColors.primaryPurple),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentPage > 0)
            OutlinedButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Back'),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                _getButtonText(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Lesson?'),
        content: const Text(
          'Your progress will be saved, but you\'ll need to restart this lesson.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}

// Abstract base class for lesson content
abstract class LessonContent {
  Widget build(BuildContext context);
}

// Intro slide
class IntroContent extends LessonContent {
  final String title;
  final String subtitle;
  final String estimatedTime;

  IntroContent({
    required this.title,
    required this.subtitle,
    required this.estimatedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.school_rounded,
              size: 64,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.backgroundTertiary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.timer_outlined,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  estimatedTime,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Story-based content
class StoryContent extends LessonContent {
  final String story;
  final String character;

  StoryContent({required this.story, required this.character});

  @override
  Widget build(BuildContext context) {
    return _StorySlideWidget(story: story, character: character);
  }
}

class _StorySlideWidget extends StatefulWidget {
  final String story;
  final String character;

  const _StorySlideWidget({required this.story, required this.character});

  @override
  State<_StorySlideWidget> createState() => _StorySlideWidgetState();
}

class _StorySlideWidgetState extends State<_StorySlideWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Parse story sections (split by bold markers or line breaks)
    final sections = _parseStory(widget.story);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Immersive header with character
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryPurple.withValues(alpha: 0.15),
                        AppColors.electricBlue.withValues(alpha: 0.10),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primaryPurple.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Animated character emoji
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 600),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: 0.8 + (value * 0.2),
                            child: Text(
                              widget.character,
                              style: const TextStyle(fontSize: 56),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Real-World Story',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryPurple.withValues(
                                  alpha: 0.8,
                                ),
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Learn from real experiences',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Story content with visual hierarchy
                ...sections.asMap().entries.map((entry) {
                  final index = entry.key;
                  final section = entry.value;

                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 400 + (index * 100)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: _buildStorySection(section, index),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _parseStory(String story) {
    final sections = <Map<String, dynamic>>[];
    final lines = story.split('\n');

    for (final line in lines) {
      if (line.trim().isEmpty) continue;

      // Check if it's a bold section (starts with **)
      if (line.trim().startsWith('**') && line.trim().endsWith('**')) {
        sections.add({
          'type': 'heading',
          'text': line.trim().replaceAll('**', ''),
        });
      } else if (line.trim().startsWith('•') || line.trim().startsWith('-')) {
        sections.add({
          'type': 'bullet',
          'text': line.trim().substring(1).trim(),
        });
      } else {
        sections.add({'type': 'paragraph', 'text': line.trim()});
      }
    }

    return sections;
  }

  Widget _buildStorySection(Map<String, dynamic> section, int index) {
    final type = section['type'];
    final text = section['text'];

    switch (type) {
      case 'heading':
        return Padding(
          padding: EdgeInsets.only(bottom: 16, top: index == 0 ? 0 : 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.sunsetOrange.withValues(alpha: 0.12),
                  AppColors.sunsetOrange.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border(
                left: BorderSide(color: AppColors.sunsetOrange, width: 3),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        );

      case 'bullet':
        return Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPurple.withValues(alpha: 0.3),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFormattedText(
                  text,
                  const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        );

      case 'paragraph':
      default:
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _buildFormattedText(
            text,
            const TextStyle(
              fontSize: 15.5,
              height: 1.7,
              color: AppColors.textPrimary,
              letterSpacing: 0.2,
            ),
          ),
        );
    }
  }

  Widget _buildFormattedText(String text, TextStyle baseStyle) {
    if (!text.contains('**')) {
      return Text(text, style: baseStyle);
    }

    final spans = <InlineSpan>[];
    final pattern = RegExp(r'\*\*(.*?)\*\*');

    int lastMatchEnd = 0;

    for (final match in pattern.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }
      spans.add(
        TextSpan(
          text: match.group(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return Text.rich(TextSpan(style: baseStyle, children: spans));
  }
}

// Concept explanation
class ConceptContent extends LessonContent {
  final String concept;
  final List<String> keyPoints;

  ConceptContent({required this.concept, required this.keyPoints});

  @override
  Widget build(BuildContext context) {
    return ConceptSlideWidget(concept: concept, keyPoints: keyPoints);
  }
}

// Interactive quiz
class InteractiveQuizContent extends LessonContent {
  final QuizQuestion question;
  final Function(bool) onAnswered;

  InteractiveQuizContent({required this.question, required this.onAnswered});

  @override
  Widget build(BuildContext context) {
    return _QuizWidget(question: question, onAnswered: onAnswered);
  }
}

class _QuizWidget extends StatefulWidget {
  final QuizQuestion question;
  final Function(bool) onAnswered;

  const _QuizWidget({required this.question, required this.onAnswered});

  @override
  State<_QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<_QuizWidget> {
  int? _selectedIndex;
  bool _hasAnswered = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🎯 Quick Check',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
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
                backgroundColor = AppColors.success.withValues(alpha: 0.1);
                borderColor = AppColors.success;
              } else if (isSelected && !isCorrect) {
                backgroundColor = AppColors.error.withValues(alpha: 0.1);
                borderColor = AppColors.error;
              }
            } else if (isSelected) {
              backgroundColor = AppColors.primaryPurple.withValues(alpha: 0.1);
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
                    color: backgroundColor ?? Colors.white,
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
                                color: Colors.white,
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

// Scenario-based learning
class ScenarioContent extends LessonContent {
  final Scenario scenario;
  final Function(int) onChoice;

  ScenarioContent({required this.scenario, required this.onChoice});

  @override
  Widget build(BuildContext context) {
    return _ScenarioWidget(scenario: scenario, onChoice: onChoice);
  }
}

class _ScenarioWidget extends StatefulWidget {
  final Scenario scenario;
  final Function(int) onChoice;

  const _ScenarioWidget({required this.scenario, required this.onChoice});

  @override
  State<_ScenarioWidget> createState() => _ScenarioWidgetState();
}

class _ScenarioWidgetState extends State<_ScenarioWidget> {
  int? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🤔 What Would You Do?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryPurple.withValues(alpha: 0.1),
                  AppColors.oceanTeal.withValues(alpha: 0.1),
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
                              ? AppColors.success.withValues(alpha: 0.1)
                              : AppColors.warning.withValues(alpha: 0.1))
                        : Colors.white,
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

// Summary content
class SummaryContent extends LessonContent {
  final List<String> keyTakeaways;
  final String? nextLesson;

  SummaryContent({required this.keyTakeaways, this.nextLesson});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '✨ Key Takeaways',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          ...keyTakeaways.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundTertiary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primaryPurple,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${entry.key + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          if (nextLesson != null) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      nextLesson!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
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

// Completion dialog
class _CompletionDialog extends StatelessWidget {
  final int score;
  final String lessonTitle;
  final VoidCallback onContinue;
  final bool hasNextLesson;

  const _CompletionDialog({
    required this.score,
    required this.lessonTitle,
    required this.onContinue,
    required this.hasNextLesson,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '🎉 Lesson Complete!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Great job completing "$lessonTitle"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat('⭐', 'Points', '$score'),
                  _buildStat('🎯', 'Accuracy', '85%'),
                  _buildStat('⚡', 'Speed', 'Fast'),
                  _buildStat('🔥', 'Streak', '3'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  hasNextLesson ? 'Next Lesson →' : 'Back to Course',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String emoji, String label, String value) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

// Data models for lesson content
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class Scenario {
  final String situation;
  final List<ScenarioChoice> choices;

  Scenario({required this.situation, required this.choices});
}

class ScenarioChoice {
  final String text;
  final bool isCorrect;
  final String feedback;

  ScenarioChoice({
    required this.text,
    required this.isCorrect,
    required this.feedback,
  });
}
