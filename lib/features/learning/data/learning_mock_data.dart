import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'learning_models.dart';
import 'courses/foundations_of_trading/foundations_of_trading.dart';
import 'courses/stock_market/stock_market_course.dart';
import 'courses/cryptocurrency_market/cryptocurrency_market_course.dart';
import 'courses/forex_market/forex_market_course.dart';
import 'courses/commodities_market/commodities_market_course.dart';
import 'courses/technical_analysis/technical_analysis_course.dart';
import 'courses/fundamental_analysis/fundamental_analysis_course.dart';
import 'courses/risk_management/risk_management_course.dart';
import 'courses/practice_skill_building/practice_skill_building_course.dart';
import 'courses/derivatives_market/derivatives_market_course.dart';
import 'courses/trading_styles/trading_styles_course.dart';
import 'courses/real_world_setup/real_world_setup_course.dart';
import 'courses/consistent_trader/consistent_trader_course.dart';

abstract final class LearningMockData {
  // ── Categories that reflect the actual 13-course curriculum ──
  static const List<LearningCategory> categories = [
    LearningCategory(
      id: 'foundations',
      name: 'Foundations',
      description: 'Trading basics, market types, and order mechanics',
      icon: Icons.school_outlined,
      color: AppColors.electricBlue,
      courseCount: 5,
      estimatedHours: 16,
    ),
    LearningCategory(
      id: 'analysis',
      name: 'Analysis',
      description: 'Technical and fundamental analysis skills',
      icon: Icons.show_chart_rounded,
      color: AppColors.auroraPurple,
      courseCount: 2,
      estimatedHours: 12,
    ),
    LearningCategory(
      id: 'risk-psychology',
      name: 'Risk & Psychology',
      description: 'Risk management, trading psychology, and discipline',
      icon: Icons.shield_outlined,
      color: AppColors.amber,
      courseCount: 2,
      estimatedHours: 10,
    ),
    LearningCategory(
      id: 'advanced',
      name: 'Advanced',
      description: 'Derivatives, trading styles, and real-world setup',
      icon: Icons.rocket_launch_outlined,
      color: AppColors.coralPink,
      courseCount: 3,
      estimatedHours: 14,
    ),
    LearningCategory(
      id: 'mastery',
      name: 'Mastery',
      description: 'Consistency, performance, and becoming a pro',
      icon: Icons.emoji_events_outlined,
      color: AppColors.emerald,
      courseCount: 1,
      estimatedHours: 6,
    ),
  ];

  // ── All 13 fully interactive courses ──
  static List<Course> get allCourses => [
    // Course 1: Foundations of Trading
    FoundationsOfTradingCourse.getCourse(),
    // Course 2: Stock Market
    StockMarketCourse.getCourse(),
    // Course 3: Cryptocurrency Market
    CryptocurrencyMarketCourse.getCourse(),
    // Course 4: Forex Market
    ForexMarketCourse.getCourse(),
    // Course 5: Commodities Market
    CommoditiesMarketCourse.getCourse(),
    // Course 6: Technical Analysis
    TechnicalAnalysisCourse.getCourse(),
    // Course 7: Fundamental Analysis
    FundamentalAnalysisCourse.getCourse(),
    // Course 8: Risk Management & Trading Psychology
    RiskManagementCourse.getCourse(),
    // Course 9: Practice & Skill Building
    PracticeSkillBuildingCourse.getCourse(),
    // Course 10: Derivatives Market
    DerivativesMarketCourse.getCourse(),
    // Course 11: Trading Styles & Strategies
    TradingStylesCourse.getCourse(),
    // Course 12: Real-World Trading Setup
    RealWorldSetupCourse.getCourse(),
    // Course 13: Becoming a Consistent Trader
    ConsistentTraderCourse.getCourse(),
  ];

  // ── Continue Learning (references real courses) ──
  static List<Map<String, dynamic>> get continueLearning => [
    {
      'course': allCourses[0], // Foundations of Trading
      'progress': 0.65,
      'lastLesson': 'Understanding Order Types',
      'nextLesson': 'Market vs Limit Orders',
      'minutesLeft': 63,
    },
    {
      'course': allCourses[5], // Technical Analysis
      'progress': 0.32,
      'lastLesson': 'Candlestick Patterns',
      'nextLesson': 'Support & Resistance',
      'minutesLeft': 163,
    },
    {
      'course': allCourses[7], // Risk Management
      'progress': 0.15,
      'lastLesson': 'Why Most Traders Lose',
      'nextLesson': 'Risk vs Reward',
      'minutesLeft': 128,
    },
  ];

  // ── Learning Paths (references real course IDs) ──
  static List<LearningPath> get learningPaths => [
    const LearningPath(
      id: 'path-001',
      title: 'Complete Beginner to Trader',
      description:
          'Master the foundations, learn analysis, and build risk management skills',
      courses: [
        'c0-foundations',
        'c1-stocks',
        'c5-technical',
        'c7-risk',
        'c8-practice',
      ],
      estimatedWeeks: 10,
      difficulty: DifficultyLevel.beginner,
      skills: [
        'Market Fundamentals',
        'Technical Analysis',
        'Risk Management',
        'Paper Trading',
      ],
    ),
    const LearningPath(
      id: 'path-002',
      title: 'Advanced Trader',
      description:
          'Derivatives, trading styles, and building long-term consistency',
      courses: ['c10-derivatives', 'c11-styles', 'c12-setup', 'c13-consistent'],
      estimatedWeeks: 8,
      difficulty: DifficultyLevel.advanced,
      skills: [
        'Options & Futures',
        'Strategy Selection',
        'Tax & Compliance',
        'Performance Evaluation',
      ],
    ),
    const LearningPath(
      id: 'path-003',
      title: 'Multi-Market Explorer',
      description:
          'Stocks, crypto, forex, and commodities — understand all markets',
      courses: ['c1-stocks', 'c2-crypto', 'c3-forex', 'c4-commodities'],
      estimatedWeeks: 6,
      difficulty: DifficultyLevel.intermediate,
      skills: [
        'Stock Trading',
        'Crypto & Blockchain',
        'Forex Pairs',
        'Commodity Markets',
      ],
    ),
  ];

  // ── User Progress (clean starting state) ──
  static UserLearningProgress get currentUserProgress => UserLearningProgress(
    userId: 'user-001',
    totalXp: 0,
    currentLevel: 1,
    coursesStarted: 0,
    coursesCompleted: 0,
    lessonsCompleted: 0,
    totalLearningMinutes: 0,
    currentStreak: 0,
    longestStreak: 0,
    courseProgress: const {},
    achievements: achievements,
    lastActivityDate: DateTime.now(),
  );

  // ── Achievements ──
  static List<Achievement> get achievements => [
    Achievement(
      id: 'ach-001',
      title: 'First Steps',
      description: 'Complete your first lesson',
      iconData: Icons.rocket_launch_outlined,
      color: AppColors.mintGreen,
      xpReward: 50,
      rarity: AchievementRarity.common,
    ),
    Achievement(
      id: 'ach-002',
      title: 'Knowledge Seeker',
      description: 'Complete 10 lessons',
      iconData: Icons.auto_stories_outlined,
      color: AppColors.electricBlue,
      xpReward: 100,
      rarity: AchievementRarity.common,
      progress: 0,
      maxProgress: 10,
    ),
    Achievement(
      id: 'ach-003',
      title: 'Week Warrior',
      description: 'Maintain a 7-day learning streak',
      iconData: Icons.local_fire_department_rounded,
      color: AppColors.sunsetOrange,
      xpReward: 200,
      rarity: AchievementRarity.rare,
      progress: 0,
      maxProgress: 7,
    ),
    Achievement(
      id: 'ach-004',
      title: 'Quiz Master',
      description: 'Score 100% on 5 quizzes',
      iconData: Icons.emoji_events_outlined,
      color: AppColors.goldenYellow,
      xpReward: 300,
      rarity: AchievementRarity.rare,
      progress: 0,
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
      progress: 0,
      maxProgress: 1,
    ),
    Achievement(
      id: 'ach-006',
      title: 'Market Scholar',
      description: 'Complete 5 courses',
      iconData: Icons.school_outlined,
      color: AppColors.indigo,
      xpReward: 1000,
      rarity: AchievementRarity.epic,
      progress: 0,
      maxProgress: 5,
    ),
    Achievement(
      id: 'ach-007',
      title: 'Trading Legend',
      description: 'Complete all 13 courses',
      iconData: Icons.star_outline_rounded,
      color: AppColors.goldenYellow,
      xpReward: 2500,
      rarity: AchievementRarity.legendary,
      progress: 0,
      maxProgress: 13,
    ),
  ];

  // ── Daily Tips ──
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
}
