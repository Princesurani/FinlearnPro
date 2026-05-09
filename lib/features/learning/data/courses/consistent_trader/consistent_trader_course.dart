import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Becoming a Consistent Trader — Final Mindset Course
/// The capstone course of the entire curriculum
///
/// Course Structure: 6 Chapters, 14 Lessons, ~170 minutes
class ConsistentTraderCourse {
  static Course getCourse() {
    final chapters = _getChapters();
    final totalLessons = chapters.fold<int>(0, (s, c) => s + c.lessons.length);
    final estimatedMinutes = chapters.fold<int>(
      0,
      (s, c) => s + c.totalMinutes,
    );
    return Course(
      id: 'c13-consistent',
      title: 'Becoming a Consistent Trader',
      subtitle: 'The final mindset course',
      description:
          'This is the capstone of your FinlearnPro journey. You have the knowledge, the tools, and the discipline. Now learn how to build a personal trading plan, evaluate performance objectively, and commit to long-term consistency over short-term profits.',
      categoryId: 'mindset',
      difficulty: DifficultyLevel.expert,
      thumbnailUrl: 'assets/images/courses/consistency.png',
      modules: chapters,
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50,
      rating: 4.9,
      ratingsCount: 4800,
      enrolledCount: 12000,
      accentColor: const Color(0xFF14B8A6), // Teal
      isPremium: false,
      learningOutcomes: [
        'Build a complete, personalized trading plan',
        'Evaluate your trading performance with professional metrics',
        'Apply the risk-first approach to every trading decision',
        'Commit to continuous learning and adaptation',
        'Prioritize long-term consistency over short-term profits',
        'Graduate as a self-sufficient, disciplined trader',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      CourseModule(
        id: 'ct-chapter-1',
        title: 'Final Mindset Course',
        description: 'The capstone of your trading education',
        order: 1,
        lessons: [
          Lesson(
            id: 'ct-1-1',
            title: 'The Journey So Far',
            description:
                'Reviewing everything you have learned across 12 courses',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ct-1-2',
            title: 'The Professional Mindset Shift',
            description: 'From "making money" to "executing a process"',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'ct-chapter-2',
        title: 'Building a Personal Trading Plan',
        description: 'Your personalized rulebook',
        order: 2,
        lessons: [
          Lesson(
            id: 'ct-2-1',
            title: 'The Complete Trading Plan',
            description:
                'Markets, strategy, risk rules, and daily routine — all in one document',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ct-2-2',
            title: 'Writing Your Own Plan',
            description: 'A guided exercise to create YOUR trading plan',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'ct-chapter-3',
        title: 'Performance Evaluation',
        description: 'Measuring what matters',
        order: 3,
        lessons: [
          Lesson(
            id: 'ct-3-1',
            title: 'The Metrics That Matter',
            description:
                'Win rate, R:R, expectancy, and Sharpe ratio simplified',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ct-3-2',
            title: 'Monthly Performance Reviews',
            description: 'How to grade yourself honestly every month',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'ct-chapter-4',
        title: 'Risk-First Approach',
        description: 'The professional\'s default mode',
        order: 4,
        lessons: [
          Lesson(
            id: 'ct-4-1',
            title: 'Risk Budget vs Profit Target',
            description: 'Why you should plan your losses, not your profits',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ct-4-2',
            title: 'The Anti-Fragile Portfolio',
            description: 'Building a system that gets STRONGER from losses',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'ct-chapter-5',
        title: 'Continuous Learning',
        description: 'The market evolves. So must you.',
        order: 5,
        lessons: [
          Lesson(
            id: 'ct-5-1',
            title: 'The Learning Ecosystem',
            description: 'Books, mentors, communities, and market observation',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ct-5-2',
            title: 'Adapting to Market Regimes',
            description:
                'Bull markets, bear markets, and sideways chops require different strategies',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'ct-chapter-6',
        title: 'Consistency Over Profits',
        description: 'The final transformation',
        order: 6,
        lessons: [
          Lesson(
            id: 'ct-6-1',
            title: 'The 10,000-Hour Trader',
            description: 'Why mastery takes years, not weeks',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ct-6-2',
            title: 'Final Challenge: Graduation Exam',
            description: 'The comprehensive FinlearnPro graduation assessment',
            contentType: ContentType.quiz,
            estimatedMinutes: 16,
            order: 2,
            xpReward: 200,
          ),
        ],
      ),
    ];
  }
}
