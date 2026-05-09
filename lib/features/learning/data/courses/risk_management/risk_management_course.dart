import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Risk Management & Trading Psychology Course — THE CORE Course
/// The most important course in the entire curriculum
///
/// Course Structure: 10 Chapters, 24 Lessons, ~280 minutes
class RiskManagementCourse {
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
      id: 'c8-risk',
      title: 'Risk Management & Psychology',
      subtitle: 'The most important course',
      description:
          'This is the course that separates survivors from casualties. Learn why 90% of traders lose money, how to size positions, protect capital with stop losses, manage drawdowns, and master the psychological demons — fear, greed, overconfidence, and revenge trading.',
      categoryId: 'risk',
      difficulty: DifficultyLevel.beginner,
      thumbnailUrl: 'assets/images/courses/risk_management.png',
      modules: chapters,
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50,
      rating: 5.0,
      ratingsCount: 12400,
      enrolledCount: 45000,
      accentColor: const Color(0xFFEF4444), // Red — danger/importance
      isPremium: false,
      learningOutcomes: [
        'Understand why 90% of traders lose — and how to be in the 10%',
        'Think in probabilities and risk-reward ratios',
        'Size every position correctly using the 1-2% rule',
        'Set and honor stop losses without hesitation',
        'Survive drawdowns with a recovery mindset',
        'Recognize and defeat fear, greed, overconfidence, and revenge trading',
        'Build a discipline-first, risk-first trading system',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      // Chapter 1: Most Important Course
      CourseModule(
        id: 'rm-chapter-1',
        title: 'The Most Important Course',
        description: 'Why this course matters more than all others combined',
        order: 1,
        lessons: [
          Lesson(
            id: 'rm-1-1',
            title: 'Why Risk Management Is Everything',
            description:
                'The one skill that determines if you survive or get wiped out',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rm-1-2',
            title: 'The Trader\'s Survival Hierarchy',
            description: 'Capital preservation > Profits > Everything else',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 2: Why Most Traders Lose Money
      CourseModule(
        id: 'rm-chapter-2',
        title: 'Why Most Traders Lose Money',
        description: 'The brutal statistics and the real reasons behind them',
        order: 2,
        lessons: [
          Lesson(
            id: 'rm-2-1',
            title: 'The 90-90-90 Rule',
            description: '90% lose 90% of their capital in 90 days — why?',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rm-2-2',
            title: 'The Five Killers',
            description: 'No plan, no stop loss, overleveraged, FOMO, and ego',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 3: Risk vs Reward
      CourseModule(
        id: 'rm-chapter-3',
        title: 'Risk vs Reward',
        description: 'Thinking in probabilities, not certainties',
        order: 3,
        lessons: [
          Lesson(
            id: 'rm-3-1',
            title: 'Thinking in Probabilities',
            description: 'Why being right 40% of the time can still make money',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rm-3-2',
            title: 'The Risk-Reward Ratio',
            description: 'Why 1:2 R:R changes everything',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 4: Position Sizing
      CourseModule(
        id: 'rm-chapter-4',
        title: 'Position Sizing Basics',
        description: 'How much to risk on each trade',
        order: 4,
        lessons: [
          Lesson(
            id: 'rm-4-1',
            title: 'The 1-2% Rule',
            description:
                'Never risk more than 1-2% of your capital on one trade',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rm-4-2',
            title: 'Calculating Position Size',
            description: 'Step-by-step math for every trade',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 5: Stop-Loss & Capital Protection
      CourseModule(
        id: 'rm-chapter-5',
        title: 'Stop-Loss & Capital Protection',
        description: 'Your insurance policy against ruin',
        order: 5,
        lessons: [
          Lesson(
            id: 'rm-5-1',
            title: 'Types of Stop Losses',
            description: 'Fixed, trailing, time-based, and mental stops',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rm-5-2',
            title: 'The Daily & Weekly Loss Limits',
            description: 'When to STOP trading for the day',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 6: Drawdowns & Loss Recovery
      CourseModule(
        id: 'rm-chapter-6',
        title: 'Drawdowns & Loss Recovery',
        description: 'The math of losing — and the mindset of recovery',
        order: 6,
        lessons: [
          Lesson(
            id: 'rm-6-1',
            title: 'The Drawdown Math',
            description: 'Why a 50% loss needs a 100% gain to recover',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rm-6-2',
            title: 'Surviving a Losing Streak',
            description: 'How professionals handle 10 losses in a row',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 7: Fear, Greed & Overconfidence
      CourseModule(
        id: 'rm-chapter-7',
        title: 'Fear, Greed & Overconfidence',
        description: 'The three emotions that destroy traders',
        order: 7,
        lessons: [
          Lesson(
            id: 'rm-7-1',
            title: 'Fear & Greed',
            description:
                'How these two emotions control your trading decisions',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rm-7-2',
            title: 'Overconfidence Bias',
            description: 'The silent account killer after a winning streak',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 8: Overtrading & Revenge Trading
      CourseModule(
        id: 'rm-chapter-8',
        title: 'Overtrading & Revenge Trading',
        description: 'The destructive cycles that drain accounts',
        order: 8,
        lessons: [
          Lesson(
            id: 'rm-8-1',
            title: 'Overtrading: Death by a Thousand Cuts',
            description: 'Why more trades ≠ more profit',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rm-8-2',
            title: 'Revenge Trading: The Spiral',
            description: 'How one loss becomes ten when emotions take over',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 9: Discipline, Patience & Consistency
      CourseModule(
        id: 'rm-chapter-9',
        title: 'Discipline, Patience & Consistency',
        description: 'The habits that make profitable traders',
        order: 9,
        lessons: [
          Lesson(
            id: 'rm-9-1',
            title: 'The Trading Journal',
            description: 'Your most powerful self-improvement tool',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rm-9-2',
            title: 'Building Iron Discipline',
            description: 'Rules, routines, and the power of saying NO',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 10: Building a Risk-First Mindset
      CourseModule(
        id: 'rm-chapter-10',
        title: 'Building a Risk-First Mindset',
        description: 'The final transformation — thinking like a professional',
        order: 10,
        lessons: [
          Lesson(
            id: 'rm-10-1',
            title: 'The Professional Trader\'s Checklist',
            description:
                'A complete pre-trade, during-trade, and post-trade system',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rm-10-2',
            title: 'Final Challenge: Risk Management Pro',
            description: 'Comprehensive scenarios across all 10 chapters',
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
