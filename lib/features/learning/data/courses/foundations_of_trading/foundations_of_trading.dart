import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Foundation of Trading Course - Interactive Content
/// Designed with psychological engagement and learning retention
///
/// Course Structure: 6 Chapters, 20 Lessons, ~210 minutes
class FoundationsOfTradingCourse {
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
      id: 'foundations-of-trading',
      title: 'Foundations of Trading',
      subtitle: 'Master the fundamentals before you invest a single rupee',
      description:
          'This course is your gateway to the financial markets. You\'ll learn what trading really is, how markets work, and the critical concepts every trader must know. No jargon, no fluff—just practical knowledge that will save you from costly mistakes.',
      categoryId: 'trading',
      difficulty: DifficultyLevel.beginner,
      thumbnailUrl: 'assets/images/courses/foundations_trading.png',
      modules:
          chapters, // Using 'modules' field for chapters (model compatibility)
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50, // 50 XP per lesson
      rating: 4.9,
      ratingsCount: 12453,
      enrolledCount: 45230,
      accentColor: const Color(0xFF6366F1), // Indigo
      isPremium: false,
      learningOutcomes: [
        'Understand what trading and investing really mean',
        'Learn how financial markets operate behind the scenes',
        'Master different order types and when to use them',
        'Recognize the key players in the market and their roles',
        'Avoid common beginner mistakes that cost money',
        'Build a solid foundation for advanced trading concepts',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      // Chapter 1: What is Trading & Investing?
      CourseModule(
        id: 'chapter-1',
        title: 'What is Trading & Investing?',
        description: 'Understand the core difference and what path suits you',
        order: 1,
        lessons: [
          Lesson(
            id: 'lesson-1-1',
            title: 'The Big Picture: Trading vs Investing',
            description:
                'Learn the fundamental difference between trading and investing through real-world stories',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
            keyTakeaways: [
              'Trading and investing are fundamentally different approaches',
              'Trading is short-term and requires active management',
              'Investing is long-term and focuses on wealth building',
              'Most beginners lose money trying to trade without proper education',
            ],
          ),
          Lesson(
            id: 'lesson-1-2',
            title: 'Why People Trade (And Why Most Fail)',
            description:
                'The harsh truth about trading success rates and what it really takes',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
            keyTakeaways: [
              '90% of traders lose money—it\'s not easy',
              'Success requires education, discipline, and patience',
              'Quick riches are a myth; consistent profits take time',
            ],
          ),
          Lesson(
            id: 'lesson-1-3',
            title: 'Your First Reality Check',
            description: 'Test your understanding with real scenarios',
            contentType: ContentType.quiz,
            estimatedMinutes: 8,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 2: How Financial Markets Work
      CourseModule(
        id: 'chapter-2',
        title: 'How Financial Markets Work',
        description: 'The machinery behind buying and selling',
        order: 2,
        lessons: [
          Lesson(
            id: 'lesson-2-1',
            title: 'What is a Financial Market?',
            description: 'Understand the concept of markets and why they exist',
            contentType: ContentType.interactive,
            estimatedMinutes: 15,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'lesson-2-2',
            title: 'Exchanges: Where the Magic Happens',
            description: 'Learn about NSE, BSE, and how exchanges operate',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'lesson-2-3',
            title: 'How a Trade Actually Happens',
            description:
                'Follow the journey of your order from click to execution',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 3: Market Participants
      CourseModule(
        id: 'chapter-3',
        title: 'Who\'s in the Market?',
        description: 'Understanding the players and their motivations',
        order: 3,
        lessons: [
          Lesson(
            id: 'lesson-3-1',
            title: 'Retail Traders (That\'s You!)',
            description: 'Your role in the market and what you\'re up against',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'lesson-3-2',
            title: 'Institutional Players: The Big Money',
            description:
                'How mutual funds, hedge funds, and banks move markets',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'lesson-3-3',
            title: 'Market Makers: The Invisible Hand',
            description: 'Who provides liquidity and how they profit',
            contentType: ContentType.interactive,
            estimatedMinutes: 11,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 4: Mastering Order Types
      CourseModule(
        id: 'chapter-4',
        title: 'Mastering Order Types',
        description: 'The tools you\'ll use every single day',
        order: 4,
        lessons: [
          Lesson(
            id: 'lesson-4-1',
            title: 'Market Orders: Fast but Risky',
            description: 'When to use market orders and when to avoid them',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'lesson-4-2',
            title: 'Limit Orders: Patience Pays',
            description: 'Control your entry and exit prices precisely',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'lesson-4-3',
            title: 'Stop Orders: Your Safety Net',
            description: 'Protect your capital with stop-loss orders',
            contentType: ContentType.interactive,
            estimatedMinutes: 11,
            order: 3,
            xpReward: 50,
          ),
          Lesson(
            id: 'lesson-4-4',
            title: 'Practice: Choosing the Right Order',
            description: 'Interactive scenarios to test your knowledge',
            contentType: ContentType.interactive,
            estimatedMinutes: 15,
            order: 4,
            xpReward: 75,
          ),
        ],
      ),

      // Chapter 5: Trading Terminology
      CourseModule(
        id: 'chapter-5',
        title: 'Speaking the Language',
        description: 'Essential terms every trader must know',
        order: 5,
        lessons: [
          Lesson(
            id: 'lesson-5-1',
            title: 'Bid, Ask, and Spread',
            description: 'Understand the two prices you see on every stock',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'lesson-5-2',
            title: 'Volume and Liquidity',
            description: 'Why some stocks are easier to trade than others',
            contentType: ContentType.interactive,
            estimatedMinutes: 11,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'lesson-5-3',
            title: 'Bulls, Bears, and Market Sentiment',
            description: 'Decode market psychology and trends',
            contentType: ContentType.interactive,
            estimatedMinutes: 9,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 6: Before You Start Trading
      CourseModule(
        id: 'chapter-6',
        title: 'Before You Start Trading',
        description: 'Critical preparation that most skip',
        order: 6,
        lessons: [
          Lesson(
            id: 'lesson-6-1',
            title: 'Choosing a Broker: What Actually Matters',
            description: 'Cut through the marketing and find the right broker',
            contentType: ContentType.interactive,
            estimatedMinutes: 13,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'lesson-6-2',
            title: 'Paper Trading: Your Practice Ground',
            description: 'Learn without risking real money',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'lesson-6-3',
            title: 'The #1 Mistake Beginners Make',
            description: 'Avoid the trap that catches 90% of new traders',
            contentType: ContentType.interactive,
            estimatedMinutes: 8,
            order: 3,
            xpReward: 50,
          ),
          Lesson(
            id: 'lesson-6-4',
            title: 'Final Challenge: Are You Ready?',
            description: 'Comprehensive quiz covering all chapters',
            contentType: ContentType.quiz,
            estimatedMinutes: 12,
            order: 4,
            xpReward: 100,
          ),
        ],
      ),
    ];
  }
}
