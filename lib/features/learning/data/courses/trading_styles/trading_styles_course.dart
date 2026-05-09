import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Trading Styles & Strategies Course
/// Choose based on personality, time, and capital
///
/// Course Structure: 7 Chapters, 16 Lessons, ~190 minutes
class TradingStylesCourse {
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
      id: 'c11-styles',
      title: 'Trading Styles & Strategies',
      subtitle: 'Find your fit',
      description:
          'Not every trader is built the same. Your personality, available time, and capital determine which style suits you. Learn Scalping, Intraday, Swing, and Long-term investing — and discover why copying someone else\'s strategy guarantees failure.',
      categoryId: 'strategies',
      difficulty: DifficultyLevel.intermediate,
      thumbnailUrl: 'assets/images/courses/trading_styles.png',
      modules: chapters,
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50,
      rating: 4.7,
      ratingsCount: 6800,
      enrolledCount: 19000,
      accentColor: const Color(0xFFF59E0B), // Amber
      isPremium: false,
      learningOutcomes: [
        'Identify which trading style matches your personality and lifestyle',
        'Understand the mechanics and risks of Scalping',
        'Master the basics of Intraday and Swing trading',
        'Know when long-term investing beats active trading',
        'Select a strategy based on your time and capital constraints',
        'Understand why copying strategies from others always fails',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      CourseModule(
        id: 'ts-chapter-1',
        title: 'Choose Based on Personality',
        description: 'Your trading style must fit your life',
        order: 1,
        lessons: [
          Lesson(
            id: 'ts-1-1',
            title: 'The Personality Test',
            description: 'Are you a sprinter or a marathon runner?',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ts-1-2',
            title: 'The Four Trading Styles',
            description: 'Scalping, Intraday, Swing, and Investing — overview',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'ts-chapter-2',
        title: 'Scalping (Overview)',
        description: 'Making money in seconds to minutes',
        order: 2,
        lessons: [
          Lesson(
            id: 'ts-2-1',
            title: 'What is Scalping?',
            description: 'Ultra-fast trades for tiny profits that add up',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ts-2-2',
            title: 'Why Scalping is NOT for Beginners',
            description: 'The reality behind the glamour',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'ts-chapter-3',
        title: 'Intraday Trading',
        description: 'Opening and closing positions within the same day',
        order: 3,
        lessons: [
          Lesson(
            id: 'ts-3-1',
            title: 'The Intraday Lifestyle',
            description: 'What a typical trading day looks like',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ts-3-2',
            title: 'Intraday Rules of Survival',
            description: 'The non-negotiable rules that keep you alive',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'ts-chapter-4',
        title: 'Swing Trading',
        description: 'Holding for days to weeks',
        order: 4,
        lessons: [
          Lesson(
            id: 'ts-4-1',
            title: 'The Sweet Spot',
            description: 'Why swing trading is ideal for working professionals',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ts-4-2',
            title: 'Swing Trading Mechanics',
            description: 'Entries, stops, and multi-day management',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'ts-chapter-5',
        title: 'Long-Term Investing',
        description: 'The compound interest machine',
        order: 5,
        lessons: [
          Lesson(
            id: 'ts-5-1',
            title: 'The Power of Compounding',
            description: 'How patience builds generational wealth',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ts-5-2',
            title: 'SIPs and Index Funds',
            description: 'The lazy genius strategy that beats 90% of traders',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'ts-chapter-6',
        title: 'Strategy Selection',
        description: 'Matching your style to your reality',
        order: 6,
        lessons: [
          Lesson(
            id: 'ts-6-1',
            title: 'Time, Capital & Risk Tolerance',
            description: 'The three variables that choose your style for you',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ts-6-2',
            title: 'The Hybrid Approach',
            description: 'Combining investing and active trading intelligently',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'ts-chapter-7',
        title: 'Why Copying Strategies Fails',
        description: 'The truth about following gurus and tip services',
        order: 7,
        lessons: [
          Lesson(
            id: 'ts-7-1',
            title: 'The Guru Illusion',
            description: 'Why following someone else\'s strategy never works',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ts-7-2',
            title: 'Final Challenge: Trading Styles Pro',
            description: 'Find your perfect trading fit',
            contentType: ContentType.quiz,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 100,
          ),
        ],
      ),
    ];
  }
}
