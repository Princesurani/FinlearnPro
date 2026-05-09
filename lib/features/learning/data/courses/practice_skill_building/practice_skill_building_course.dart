import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Practice & Skill Building Course
/// Build skills without risk: Paper trading, backtesting, and trade planning
///
/// Course Structure: 7 Chapters, 14 Lessons, ~160 minutes
class PracticeSkillBuildingCourse {
  static Course getCourse() {
    final chapters = _getChapters();
    final totalLessons = chapters.fold<int>(
      0,
      (sum, chapter) => sum + chapter.lessons.length,
    );
    final estimatedMinutes = chapters.fold<int>(
      0,
      (sum, chapter) => sum + chapter.totalMinutes,
    );

    return Course(
      id: 'c9-practice', // Note: Placeholder was c8-practice, updating to c9 for sequence
      title: 'Practice & Skill Building',
      subtitle: 'Paper trading & journaling',
      description:
          'Before risking a single Rupee of real money, you must prove you can trade profitably in a simulated environment. Learn how to paper trade effectively, backtest strategies, create bulletproof trade plans, and build the ultimate trading journal.',
      categoryId: 'practice',
      difficulty: DifficultyLevel.beginner,
      thumbnailUrl: 'assets/images/courses/practice.png',
      modules: chapters,
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50,
      rating: 4.8,
      ratingsCount: 8200,
      enrolledCount: 22000,
      accentColor: const Color(0xFF10B981), // Emerald Green
      isPremium: false,
      learningOutcomes: [
        'Understand why starting with real money is the biggest mistake',
        'Master the art of paper trading (simulated trading)',
        'Build a comprehensive pre-trade plan for every setup',
        'Learn to backtest a strategy using historical data',
        'Set up and maintain a professional trading journal',
        'Conduct weekend reviews to identify mathematical edge',
        'Iteratively improve decision-making based on journal data',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      // Chapter 1: No Real Money Yet
      CourseModule(
        id: 'ps-chapter-1',
        title: 'No Real Money Yet',
        description: 'The mandatory proving ground before funding your account',
        order: 1,
        lessons: [
          Lesson(
            id: 'ps-1-1',
            title: 'The Cost of Impatience',
            description: 'Why starting with real money guarantees failure',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ps-1-2',
            title: 'The Simulation Rule',
            description: 'Prove profitability for 3 months before funding',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 2: Paper Trading
      CourseModule(
        id: 'ps-chapter-2',
        title: 'Paper Trading',
        description: 'Executing simulated trades with absolute seriousness',
        order: 2,
        lessons: [
          Lesson(
            id: 'ps-2-1',
            title: 'What is Paper Trading?',
            description: 'Using virtual money to test real strategies',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ps-2-2',
            title: 'The Paper Trading Trap',
            description: 'Why you must treat virtual money like real cash',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 3: Trade Planning
      CourseModule(
        id: 'ps-chapter-3',
        title: 'Trade Planning',
        description: 'If you fail to plan, you plan to fail',
        order: 3,
        lessons: [
          Lesson(
            id: 'ps-3-1',
            title: 'The Pre-Trade Plan',
            description:
                'Entry, stop loss, and target decided BEFORE the trade',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ps-3-2',
            title: 'Contingency Planning',
            description:
                'What to do when the market gaps up or down unexpectedly',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 4: Backtesting Basics
      CourseModule(
        id: 'ps-chapter-4',
        title: 'Backtesting Basics',
        description: 'Proving your strategy works on past data',
        order: 4,
        lessons: [
          Lesson(
            id: 'ps-4-1',
            title: 'The Concept of Backtesting',
            description: 'Testing your edge across 100 historical trades',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ps-4-2',
            title: 'Manual vs Automated Backtesting',
            description:
                'How to scroll back in time and log theoretical trades',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 5: Maintaining a Trade Journal
      CourseModule(
        id: 'ps-chapter-5',
        title: 'Maintaining a Trade Journal',
        description: 'Your personal trading database',
        order: 5,
        lessons: [
          Lesson(
            id: 'ps-5-1',
            title: 'Setting Up the Journal',
            description: 'Spreadsheet templates and essential data columns',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ps-5-2',
            title: 'Journaling Emotions',
            description:
                'Why tracking your mental state is more important than tracking price',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 6: Reviewing Past Trades
      CourseModule(
        id: 'ps-chapter-6',
        title: 'Reviewing Past Trades',
        description: 'The weekend routine that builds professional traders',
        order: 6,
        lessons: [
          Lesson(
            id: 'ps-6-1',
            title: 'The Weekly Review',
            description:
                'Analyzing your week\'s trades to find systemic errors',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ps-6-2',
            title: 'Categorizing Mistakes',
            description: 'Execution errors vs. Strategy errors',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 7: Improving Decision-Making
      CourseModule(
        id: 'ps-chapter-7',
        title: 'Improving Decision-Making',
        description: 'Using data to fix the trader',
        order: 7,
        lessons: [
          Lesson(
            id: 'ps-7-1',
            title: 'The Feedback Loop',
            description: 'Execute → Journal → Review → Adjust',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ps-7-2',
            title: 'Final Challenge: Practice Pro',
            description: 'Comprehensive quiz on process, planning, and review',
            contentType: ContentType.quiz,
            estimatedMinutes: 14,
            order: 2,
            xpReward: 100,
          ),
        ],
      ),
    ];
  }
}
