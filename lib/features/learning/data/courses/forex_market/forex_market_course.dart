import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Forex (Currency Market) Course — Interactive Content
/// Complete guide to global currency trading, pairs, leverage, and risk
///
/// Course Structure: 9 Chapters, 22 Lessons, ~220 minutes
class ForexMarketCourse {
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
      id: 'c4-forex',
      title: 'Forex Trading',
      subtitle: 'Global currency trading explained',
      description:
          'The forex market trades \$7.5 trillion EVERY DAY — it\'s the largest financial market on Earth. Learn how currencies move, why countries devalue their money, and how retail traders navigate leverage, margin, and 24-hour markets.',
      categoryId: 'forex',
      difficulty: DifficultyLevel.intermediate,
      thumbnailUrl: 'assets/images/courses/forex_market.png',
      modules: chapters,
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50,
      rating: 4.6,
      ratingsCount: 5320,
      enrolledCount: 21800,
      accentColor: const Color(0xFF10B981), // Emerald green
      isPremium: false,
      learningOutcomes: [
        'Understand what the forex market is and why it\'s the world\'s largest',
        'Read and interpret currency pairs (EUR/USD, USD/INR)',
        'Know the difference between major, minor, and exotic pairs',
        'Understand trading sessions, liquidity windows, and market hours',
        'Grasp leverage and margin — the double-edged sword of forex',
        'Identify forex-specific risks and whether forex trading suits you',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      // Chapter 1: Global Currency Trading
      CourseModule(
        id: 'forex-chapter-1',
        title: 'Global Currency Trading',
        description: 'Why currencies move and who trades them',
        order: 1,
        lessons: [
          Lesson(
            id: 'forex-1-1',
            title: 'The Invisible Market',
            description:
                'How \$7.5 trillion changes hands daily without most people knowing',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
            keyTakeaways: [
              'Forex is the world\'s largest financial market by volume',
              'It operates 24 hours a day across global time zones',
              'Currency values affect everything from petrol prices to EMIs',
            ],
          ),
          Lesson(
            id: 'forex-1-2',
            title: 'Who Trades Currencies & Why',
            description:
                'Central banks, importers, speculators — the players and their motives',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 2: What is the Forex Market
      CourseModule(
        id: 'forex-chapter-2',
        title: 'What is the Forex Market',
        description: 'Structure, history, and how it differs from stocks',
        order: 2,
        lessons: [
          Lesson(
            id: 'forex-2-1',
            title: 'The Decentralized Giant',
            description:
                'No exchange building, no closing bell — how forex actually works',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'forex-2-2',
            title: 'Forex vs Stocks: Key Differences',
            description: 'Why currency trading is a completely different game',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 3: How Currencies Are Traded in Pairs
      CourseModule(
        id: 'forex-chapter-3',
        title: 'How Currencies Are Traded in Pairs',
        description: 'Base, quote, pips, and lots decoded',
        order: 3,
        lessons: [
          Lesson(
            id: 'forex-3-1',
            title: 'Reading a Currency Pair',
            description: 'EUR/USD, USD/INR — what the numbers actually mean',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'forex-3-2',
            title: 'Pips, Lots & Position Sizing',
            description: 'The math behind every forex trade',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 4: Major, Minor & Exotic Pairs
      CourseModule(
        id: 'forex-chapter-4',
        title: 'Major, Minor & Exotic Pairs',
        description: 'Which pairs to trade and which to avoid as a beginner',
        order: 4,
        lessons: [
          Lesson(
            id: 'forex-4-1',
            title: 'The Big Seven (Major Pairs)',
            description:
                'EUR/USD, GBP/USD, USD/JPY — the most liquid markets on Earth',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'forex-4-2',
            title: 'Minors, Exotics & USD/INR',
            description:
                'Cross pairs, emerging market currencies, and the Indian Rupee',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 5: How Forex Trading Works
      CourseModule(
        id: 'forex-chapter-5',
        title: 'How Forex Trading Works',
        description: 'Brokers, platforms, and executing your first trade',
        order: 5,
        lessons: [
          Lesson(
            id: 'forex-5-1',
            title: 'Forex Brokers & Platforms',
            description: 'Choosing the right broker and avoiding scams',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'forex-5-2',
            title: 'Your First Forex Trade',
            description:
                'Step-by-step: opening a position, setting stops, and closing',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 6: Trading Sessions & Liquidity
      CourseModule(
        id: 'forex-chapter-6',
        title: 'Trading Sessions & Liquidity',
        description: 'When to trade and when to stay away',
        order: 6,
        lessons: [
          Lesson(
            id: 'forex-6-1',
            title: 'The Three Sessions',
            description:
                'Asian, European, and American — the rhythm of global forex',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'forex-6-2',
            title: 'Liquidity, Spreads & Timing',
            description: 'Why trading at the wrong time costs you money',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 7: Leverage & Margin Basics
      CourseModule(
        id: 'forex-chapter-7',
        title: 'Leverage & Margin Basics',
        description: 'The most dangerous tool in forex — understand it or lose',
        order: 7,
        lessons: [
          Lesson(
            id: 'forex-7-1',
            title: 'What is Leverage?',
            description:
                'How ₹10,000 can control ₹10 Lakhs — and why that\'s terrifying',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'forex-7-2',
            title: 'Margin Calls & Liquidation',
            description: 'When the broker takes your money — automatically',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 8: Risks in Forex Trading
      CourseModule(
        id: 'forex-chapter-8',
        title: 'Risks in Forex Trading',
        description:
            'Unique dangers that make forex the riskiest retail market',
        order: 8,
        lessons: [
          Lesson(
            id: 'forex-8-1',
            title: 'The Seven Deadly Risks',
            description: 'Leverage, overnight gaps, broker fraud, and more',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'forex-8-2',
            title: 'Risk Management Toolkit',
            description: 'Stop losses, position sizing, and the 1% rule',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 9: Who Should Trade Forex
      CourseModule(
        id: 'forex-chapter-9',
        title: 'Who Should Trade Forex',
        description: 'Honest self-assessment and final challenge',
        order: 9,
        lessons: [
          Lesson(
            id: 'forex-9-1',
            title: 'The Forex Readiness Checklist',
            description: 'Are you really ready for the most volatile market?',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'forex-9-2',
            title: 'Final Challenge: Forex Pro',
            description: 'Comprehensive quiz across all 9 chapters',
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
