import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'learning_models.dart';

abstract final class LearningMockData {
  static const List<LearningCategory> categories = [
    LearningCategory(
      id: 'stock-basics',
      name: 'Stock Market Basics',
      description: 'Master the fundamentals of stock market investing',
      icon: Icons.candlestick_chart_outlined,
      color: AppColors.electricBlue,
      courseCount: 12,
      estimatedHours: 18,
      isNew: false,
    ),
    LearningCategory(
      id: 'technical-analysis',
      name: 'Technical Analysis',
      description: 'Chart patterns, indicators, and price action',
      icon: Icons.show_chart_rounded,
      color: AppColors.auroraPurple,
      courseCount: 15,
      estimatedHours: 24,
      isNew: false,
    ),
    LearningCategory(
      id: 'options-trading',
      name: 'Options Trading',
      description: 'From basics to advanced options strategies',
      icon: Icons.call_split_rounded,
      color: AppColors.coralPink,
      courseCount: 10,
      estimatedHours: 20,
      isPremium: true,
    ),
    LearningCategory(
      id: 'crypto',
      name: 'Cryptocurrency',
      description: 'Bitcoin, Ethereum, DeFi, and blockchain',
      icon: Icons.currency_bitcoin,
      color: AppColors.sunsetOrange,
      courseCount: 8,
      estimatedHours: 14,
      isNew: true,
    ),
    LearningCategory(
      id: 'fundamental-analysis',
      name: 'Fundamental Analysis',
      description: 'Financial statements and company valuation',
      icon: Icons.account_balance_outlined,
      color: AppColors.indigo,
      courseCount: 9,
      estimatedHours: 16,
    ),
    LearningCategory(
      id: 'risk-management',
      name: 'Risk Management',
      description: 'Protect your portfolio and manage exposure',
      icon: Icons.shield_outlined,
      color: AppColors.amber,
      courseCount: 6,
      estimatedHours: 10,
    ),
    LearningCategory(
      id: 'psychology',
      name: 'Trading Psychology',
      description: 'Master your emotions and trading mindset',
      icon: Icons.psychology_outlined,
      color: AppColors.rose,
      courseCount: 5,
      estimatedHours: 8,
    ),
    LearningCategory(
      id: 'retirement',
      name: 'Retirement Planning',
      description: 'Build wealth for your future',
      icon: Icons.beach_access_outlined,
      color: AppColors.emerald,
      courseCount: 7,
      estimatedHours: 12,
    ),
  ];

  static List<Course> get featuredCourses => [
    Course(
      id: 'course-001',
      title: 'Stock Market Fundamentals',
      subtitle: 'Your journey to financial literacy begins here',
      description:
          'A comprehensive introduction to the stock market. Learn how exchanges work, what drives prices, and how to analyze your first stock. Perfect for complete beginners.',
      categoryId: 'stock-basics',
      difficulty: DifficultyLevel.beginner,
      thumbnailUrl: 'assets/courses/stock_fundamentals.jpg',
      modules: _stockFundamentalsModules,
      totalLessons: 24,
      estimatedMinutes: 180,
      xpReward: 500,
      instructorName: 'Sarah Mitchell',
      instructorAvatarUrl: 'assets/instructors/sarah.jpg',
      rating: 4.9,
      ratingsCount: 12543,
      enrolledCount: 45620,
      tags: ['stocks', 'beginner', 'fundamentals', 'investing'],
      learningOutcomes: [
        'Understand how stock markets work',
        'Read and interpret stock quotes',
        'Analyze basic financial metrics',
        'Execute your first simulated trade',
      ],
      isFeatured: true,
      accentColor: AppColors.electricBlue,
    ),
    Course(
      id: 'course-002',
      title: 'Mastering Candlestick Patterns',
      subtitle: 'Read the language of price action',
      description:
          'Discover the art and science of candlestick chart analysis. Learn to identify powerful patterns that signal market reversals, continuations, and breakouts.',
      categoryId: 'technical-analysis',
      difficulty: DifficultyLevel.intermediate,
      thumbnailUrl: 'assets/courses/candlesticks.jpg',
      modules: _candlestickModules,
      totalLessons: 32,
      estimatedMinutes: 240,
      xpReward: 750,
      instructorName: 'Michael Chen',
      instructorAvatarUrl: 'assets/instructors/michael.jpg',
      rating: 4.8,
      ratingsCount: 8921,
      enrolledCount: 32150,
      tags: ['technical', 'charts', 'patterns', 'trading'],
      learningOutcomes: [
        'Identify all major candlestick patterns',
        'Understand pattern psychology',
        'Combine patterns with volume analysis',
        'Apply patterns in live market scenarios',
      ],
      isFeatured: true,
      accentColor: AppColors.auroraPurple,
    ),
    Course(
      id: 'course-003',
      title: 'Options Trading: Zero to Hero',
      subtitle: 'Unlock the power of derivatives',
      description:
          'Go from options novice to confident trader. Master calls, puts, the Greeks, and profitable strategies used by professional traders.',
      categoryId: 'options-trading',
      difficulty: DifficultyLevel.advanced,
      thumbnailUrl: 'assets/courses/options.jpg',
      modules: _optionsModules,
      totalLessons: 40,
      estimatedMinutes: 360,
      xpReward: 1000,
      instructorName: 'James Rodriguez',
      instructorAvatarUrl: 'assets/instructors/james.jpg',
      rating: 4.9,
      ratingsCount: 6234,
      enrolledCount: 18750,
      tags: ['options', 'derivatives', 'strategies', 'advanced'],
      learningOutcomes: [
        'Understand options mechanics completely',
        'Calculate and interpret the Greeks',
        'Build income-generating strategies',
        'Manage options portfolio risk',
      ],
      isFeatured: true,
      isPremium: true,
      accentColor: AppColors.coralPink,
    ),
    Course(
      id: 'course-004',
      title: 'Crypto Fundamentals',
      subtitle: 'Navigate the digital asset revolution',
      description:
          'Understand blockchain technology, evaluate crypto projects, and learn safe trading practices in the exciting world of digital currencies.',
      categoryId: 'crypto',
      difficulty: DifficultyLevel.beginner,
      thumbnailUrl: 'assets/courses/crypto.jpg',
      modules: _cryptoModules,
      totalLessons: 28,
      estimatedMinutes: 200,
      xpReward: 600,
      instructorName: 'Alex Kim',
      instructorAvatarUrl: 'assets/instructors/alex.jpg',
      rating: 4.7,
      ratingsCount: 4521,
      enrolledCount: 21340,
      tags: ['crypto', 'blockchain', 'bitcoin', 'defi'],
      learningOutcomes: [
        'Understand blockchain technology',
        'Evaluate cryptocurrency projects',
        'Use exchanges safely',
        'Build a crypto portfolio strategy',
      ],
      isFeatured: true,
      isNew: true,
      accentColor: AppColors.sunsetOrange,
    ),
    Course(
      id: 'course-005',
      title: 'Trading Psychology Mastery',
      subtitle: 'Your mindset is your edge',
      description:
          'Conquer fear, greed, and emotional trading. Develop the mental discipline that separates successful traders from the rest.',
      categoryId: 'psychology',
      difficulty: DifficultyLevel.intermediate,
      thumbnailUrl: 'assets/courses/psychology.jpg',
      modules: _psychologyModules,
      totalLessons: 20,
      estimatedMinutes: 150,
      xpReward: 450,
      instructorName: 'Dr. Emily Parker',
      instructorAvatarUrl: 'assets/instructors/emily.jpg',
      rating: 4.9,
      ratingsCount: 7832,
      enrolledCount: 28900,
      tags: ['psychology', 'mindset', 'discipline', 'emotions'],
      learningOutcomes: [
        'Identify your trading biases',
        'Build a trading journal practice',
        'Manage fear and greed effectively',
        'Develop unshakeable discipline',
      ],
      isFeatured: true,
      accentColor: AppColors.rose,
    ),
  ];

  static List<Map<String, dynamic>> get continueLearning => [
    {
      'course': featuredCourses[0],
      'progress': 0.65,
      'lastLesson': 'Understanding Order Types',
      'nextLesson': 'Market vs Limit Orders',
      'minutesLeft': 63,
    },
    {
      'course': featuredCourses[1],
      'progress': 0.32,
      'lastLesson': 'Doji Patterns Explained',
      'nextLesson': 'Hammer and Hanging Man',
      'minutesLeft': 163,
    },
    {
      'course': featuredCourses[4],
      'progress': 0.15,
      'lastLesson': 'The Psychology of Fear',
      'nextLesson': 'Managing Greed in Trading',
      'minutesLeft': 128,
    },
  ];

  static List<LearningPath> get learningPaths => [
    const LearningPath(
      id: 'path-001',
      title: 'Complete Stock Trader',
      description:
          'Go from complete beginner to confident stock trader with this comprehensive path',
      courses: ['course-001', 'course-002', 'course-risk-001', 'course-005'],
      estimatedWeeks: 8,
      difficulty: DifficultyLevel.beginner,
      skills: [
        'Stock Analysis',
        'Technical Trading',
        'Risk Management',
        'Trading Psychology',
      ],
    ),
    const LearningPath(
      id: 'path-002',
      title: 'Options Specialist',
      description:
          'Master options trading from basic concepts to advanced strategies',
      courses: ['course-001', 'course-003', 'course-options-adv'],
      estimatedWeeks: 12,
      difficulty: DifficultyLevel.advanced,
      skills: [
        'Options Mechanics',
        'Greeks Analysis',
        'Strategy Building',
        'Portfolio Hedging',
      ],
    ),
    const LearningPath(
      id: 'path-003',
      title: 'Crypto Navigator',
      description: 'Navigate the world of cryptocurrencies with confidence',
      courses: ['course-004', 'course-defi-001', 'course-nft-001'],
      estimatedWeeks: 6,
      difficulty: DifficultyLevel.intermediate,
      skills: ['Blockchain', 'DeFi', 'NFTs', 'Portfolio Management'],
    ),
  ];

  static UserLearningProgress get currentUserProgress => UserLearningProgress(
    userId: 'user-001',
    totalXp: 8450,
    currentLevel: 8,
    coursesStarted: 5,
    coursesCompleted: 2,
    lessonsCompleted: 87,
    totalLearningMinutes: 1240,
    currentStreak: 12,
    longestStreak: 28,
    courseProgress: {
      'course-001': CourseProgress(
        courseId: 'course-001',
        status: ProgressStatus.inProgress,
        completedLessons: 16,
        totalLessons: 24,
        lastAccessedDate: DateTime.now().subtract(const Duration(hours: 2)),
        startedDate: DateTime.now().subtract(const Duration(days: 14)),
        quizScores: {'quiz-1': 90, 'quiz-2': 85, 'quiz-3': 95},
        timeSpentMinutes: 145,
      ),
      'course-002': CourseProgress(
        courseId: 'course-002',
        status: ProgressStatus.inProgress,
        completedLessons: 10,
        totalLessons: 32,
        lastAccessedDate: DateTime.now().subtract(const Duration(days: 1)),
        startedDate: DateTime.now().subtract(const Duration(days: 21)),
        quizScores: {'quiz-1': 88},
        timeSpentMinutes: 98,
      ),
    },
    achievements: achievements.where((a) => a.isEarned).toList(),
    lastActivityDate: DateTime.now().subtract(const Duration(hours: 2)),
  );

  static List<Achievement> get achievements => [
    Achievement(
      id: 'ach-001',
      title: 'First Steps',
      description: 'Complete your first lesson',
      iconData: Icons.rocket_launch_outlined,
      color: AppColors.mintGreen,
      xpReward: 50,
      rarity: AchievementRarity.common,
      earnedDate: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Achievement(
      id: 'ach-002',
      title: 'Knowledge Seeker',
      description: 'Complete 10 lessons',
      iconData: Icons.auto_stories_outlined,
      color: AppColors.electricBlue,
      xpReward: 100,
      rarity: AchievementRarity.common,
      earnedDate: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Achievement(
      id: 'ach-003',
      title: 'Week Warrior',
      description: 'Maintain a 7-day learning streak',
      iconData: Icons.local_fire_department_rounded,
      color: AppColors.sunsetOrange,
      xpReward: 200,
      rarity: AchievementRarity.rare,
      earnedDate: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Achievement(
      id: 'ach-004',
      title: 'Quiz Master',
      description: 'Score 100% on 5 quizzes',
      iconData: Icons.emoji_events_outlined,
      color: AppColors.goldenYellow,
      xpReward: 300,
      rarity: AchievementRarity.rare,
      progress: 3,
      maxProgress: 5,
    ),
    Achievement(
      id: 'ach-005',
      title: 'Course Champion',
      description: 'Complete your first course',
      iconData: Icons.workspace_premium_outlined,
      color: AppColors.auroraPurple,
      xpReward: 500,
      rarity: AchievementRarity.epic,
      earnedDate: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Achievement(
      id: 'ach-006',
      title: 'Market Scholar',
      description: 'Complete 5 courses',
      iconData: Icons.school_outlined,
      color: AppColors.indigo,
      xpReward: 1000,
      rarity: AchievementRarity.epic,
      progress: 2,
      maxProgress: 5,
    ),
    Achievement(
      id: 'ach-007',
      title: 'Trading Legend',
      description: 'Reach Level 25',
      iconData: Icons.star_outline_rounded,
      color: AppColors.goldenYellow,
      xpReward: 2500,
      rarity: AchievementRarity.legendary,
      progress: 8,
      maxProgress: 25,
    ),
  ];

  static List<Map<String, String>> get dailyTips => [
    {
      'title': 'The Power of Compound Interest',
      'tip':
          'Einstein called compound interest the 8th wonder of the world. Even small, consistent investments can grow significantly over time.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Never Stop Learning',
      'tip':
          'Markets evolve constantly. The best traders dedicate time daily to learning and improving their strategies.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Risk Management First',
      'tip':
          'Professional traders focus on risk before reward. Always know your maximum loss before entering a trade.',
      'category': 'Risk Management',
    },
  ];

  static List<CourseModule> get _stockFundamentalsModules => [
    CourseModule(
      id: 'mod-001',
      title: 'Introduction to Markets',
      description: 'Understanding how financial markets work',
      lessons: _generateLessons(6, 'Introduction'),
      order: 1,
    ),
    CourseModule(
      id: 'mod-002',
      title: 'Types of Securities',
      description: 'Stocks, bonds, ETFs, and more',
      lessons: _generateLessons(6, 'Securities'),
      order: 2,
    ),
    CourseModule(
      id: 'mod-003',
      title: 'Order Types & Execution',
      description: 'How to buy and sell effectively',
      lessons: _generateLessons(6, 'Orders'),
      order: 3,
    ),
    CourseModule(
      id: 'mod-004',
      title: 'Building Your First Portfolio',
      description: 'Practical portfolio construction',
      lessons: _generateLessons(6, 'Portfolio'),
      order: 4,
    ),
  ];

  static List<CourseModule> get _candlestickModules => [
    CourseModule(
      id: 'mod-cs-001',
      title: 'Candlestick Basics',
      description: 'The anatomy of a candlestick',
      lessons: _generateLessons(8, 'Basics'),
      order: 1,
    ),
    CourseModule(
      id: 'mod-cs-002',
      title: 'Single Candle Patterns',
      description: 'Doji, Hammer, Shooting Star',
      lessons: _generateLessons(8, 'Single'),
      order: 2,
    ),
    CourseModule(
      id: 'mod-cs-003',
      title: 'Multi-Candle Patterns',
      description: 'Engulfing, Morning Star, Three Soldiers',
      lessons: _generateLessons(8, 'Multi'),
      order: 3,
    ),
    CourseModule(
      id: 'mod-cs-004',
      title: 'Pattern Application',
      description: 'Using patterns in real trading',
      lessons: _generateLessons(8, 'Application'),
      order: 4,
    ),
  ];

  static List<CourseModule> get _optionsModules => [
    CourseModule(
      id: 'mod-opt-001',
      title: 'Options Fundamentals',
      description: 'Understanding calls and puts',
      lessons: _generateLessons(10, 'Fundamentals'),
      order: 1,
    ),
    CourseModule(
      id: 'mod-opt-002',
      title: 'The Greeks Explained',
      description: 'Delta, Gamma, Theta, Vega',
      lessons: _generateLessons(10, 'Greeks'),
      order: 2,
    ),
    CourseModule(
      id: 'mod-opt-003',
      title: 'Basic Strategies',
      description: 'Covered calls, protective puts',
      lessons: _generateLessons(10, 'Basic'),
      order: 3,
    ),
    CourseModule(
      id: 'mod-opt-004',
      title: 'Advanced Strategies',
      description: 'Spreads, straddles, iron condors',
      lessons: _generateLessons(10, 'Advanced'),
      order: 4,
    ),
  ];

  static List<CourseModule> get _cryptoModules => [
    CourseModule(
      id: 'mod-cr-001',
      title: 'Blockchain Basics',
      description: 'How blockchain technology works',
      lessons: _generateLessons(7, 'Blockchain'),
      order: 1,
    ),
    CourseModule(
      id: 'mod-cr-002',
      title: 'Bitcoin Deep Dive',
      description: 'The original cryptocurrency',
      lessons: _generateLessons(7, 'Bitcoin'),
      order: 2,
    ),
    CourseModule(
      id: 'mod-cr-003',
      title: 'Altcoins & DeFi',
      description: 'Beyond Bitcoin',
      lessons: _generateLessons(7, 'Altcoins'),
      order: 3,
    ),
    CourseModule(
      id: 'mod-cr-004',
      title: 'Crypto Trading',
      description: 'Practical crypto trading',
      lessons: _generateLessons(7, 'Trading'),
      order: 4,
    ),
  ];

  static List<CourseModule> get _psychologyModules => [
    CourseModule(
      id: 'mod-psy-001',
      title: 'Understanding Trading Emotions',
      description: 'Fear, greed, and everything between',
      lessons: _generateLessons(5, 'Emotions'),
      order: 1,
    ),
    CourseModule(
      id: 'mod-psy-002',
      title: 'Cognitive Biases',
      description: 'How your brain tricks you',
      lessons: _generateLessons(5, 'Biases'),
      order: 2,
    ),
    CourseModule(
      id: 'mod-psy-003',
      title: 'Building Discipline',
      description: 'Creating sustainable habits',
      lessons: _generateLessons(5, 'Discipline'),
      order: 3,
    ),
    CourseModule(
      id: 'mod-psy-004',
      title: 'Peak Performance',
      description: 'Optimizing your trading mindset',
      lessons: _generateLessons(5, 'Performance'),
      order: 4,
    ),
  ];

  static List<Lesson> _generateLessons(int count, String prefix) {
    return List.generate(
      count,
      (index) => Lesson(
        id: '${prefix.toLowerCase()}-lesson-${index + 1}',
        title: '$prefix Lesson ${index + 1}',
        description: 'Learn about $prefix concept ${index + 1}',
        contentType: index % 3 == 0
            ? ContentType.video
            : index % 3 == 1
            ? ContentType.interactive
            : ContentType.quiz,
        estimatedMinutes: 8 + (index % 4) * 2,
        order: index + 1,
        xpReward: 25 + (index * 5),
      ),
    );
  }
}
