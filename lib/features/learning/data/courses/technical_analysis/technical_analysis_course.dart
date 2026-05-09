import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Technical Analysis Course — Cross-Market Skill
/// Master charts, trends, patterns, and indicators applicable to ALL markets
///
/// Course Structure: 8 Chapters, 22 Lessons, ~230 minutes
class TechnicalAnalysisCourse {
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
      id: 'c6-technical',
      title: 'Technical Analysis',
      subtitle: 'Master the charts',
      description:
          'Technical analysis works across stocks, crypto, forex, and commodities. Learn to read price charts, identify trends, decode candlestick patterns, and use indicators like RSI and MACD to time your entries and exits.',
      categoryId: 'analysis',
      difficulty: DifficultyLevel.intermediate,
      thumbnailUrl: 'assets/images/courses/technical_analysis.png',
      modules: chapters,
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50,
      rating: 4.9,
      ratingsCount: 8540,
      enrolledCount: 32000,
      accentColor: const Color(0xFF06B6D4), // Cyan
      isPremium: false,
      learningOutcomes: [
        'Read and interpret price charts across all timeframes',
        'Identify support, resistance, and trend lines',
        'Decode candlestick patterns (Doji, Engulfing, Hammer, etc.)',
        'Use key indicators: Moving Averages, RSI, MACD, Bollinger Bands',
        'Plan entries and exits with a systematic approach',
        'Avoid the most common technical analysis mistakes',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      // Chapter 1: Used in All Markets
      CourseModule(
        id: 'ta-chapter-1',
        title: 'Used in All Markets',
        description: 'Why technical analysis is the universal trading language',
        order: 1,
        lessons: [
          Lesson(
            id: 'ta-1-1',
            title: 'The Universal Language of Price',
            description:
                'Why charts work the same in stocks, crypto, and forex',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
            keyTakeaways: [
              'Technical analysis reads human psychology through price action',
              'The same patterns appear in every market across history',
              'Charts are a universal language — learn once, apply everywhere',
            ],
          ),
          Lesson(
            id: 'ta-1-2',
            title: 'Technical vs Fundamental Analysis',
            description: 'Two schools of thought — and why you need both',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 2: Price Charts & Timeframes
      CourseModule(
        id: 'ta-chapter-2',
        title: 'Price Charts & Timeframes',
        description: 'Line, bar, and candlestick charts decoded',
        order: 2,
        lessons: [
          Lesson(
            id: 'ta-2-1',
            title: 'Types of Charts',
            description: 'Line, bar, and candlestick — what each reveals',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ta-2-2',
            title: 'Timeframes & What They Mean',
            description: '1-minute to monthly — choosing the right lens',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 3: Support & Resistance
      CourseModule(
        id: 'ta-chapter-3',
        title: 'Support & Resistance',
        description: 'The invisible floors and ceilings of price',
        order: 3,
        lessons: [
          Lesson(
            id: 'ta-3-1',
            title: 'Finding Support & Resistance',
            description: 'Where prices bounce and where they break',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ta-3-2',
            title: 'Breakouts & Breakdowns',
            description:
                'When support breaks it becomes resistance (and vice versa)',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 4: Trend Analysis
      CourseModule(
        id: 'ta-chapter-4',
        title: 'Trend Analysis',
        description: 'The trend is your friend — until it ends',
        order: 4,
        lessons: [
          Lesson(
            id: 'ta-4-1',
            title: 'Identifying Trends',
            description: 'Uptrends, downtrends, and sideways markets',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ta-4-2',
            title: 'Trendlines & Channels',
            description: 'Drawing lines that predict future price movement',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 5: Candlestick Patterns
      CourseModule(
        id: 'ta-chapter-5',
        title: 'Candlestick Patterns',
        description: 'Reading the story each candle tells',
        order: 5,
        lessons: [
          Lesson(
            id: 'ta-5-1',
            title: 'Single Candle Patterns',
            description:
                'Doji, Hammer, Shooting Star — one candle, big signals',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ta-5-2',
            title: 'Multi-Candle Patterns',
            description:
                'Engulfing, Morning Star, Three Soldiers — pattern combos',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'ta-5-3',
            title: 'Chart Patterns',
            description:
                'Head & Shoulders, Double Top, Triangles — the big formations',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 6: Indicators
      CourseModule(
        id: 'ta-chapter-6',
        title: 'Indicators',
        description: 'Moving Averages, RSI, MACD, and Bollinger Bands',
        order: 6,
        lessons: [
          Lesson(
            id: 'ta-6-1',
            title: 'Moving Averages',
            description: 'SMA, EMA, and the Golden/Death Cross',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ta-6-2',
            title: 'RSI & MACD',
            description: 'Momentum indicators that time reversals',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'ta-6-3',
            title: 'Bollinger Bands & Volume',
            description: 'Volatility and confirmation indicators',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 7: Entry & Exit Planning
      CourseModule(
        id: 'ta-chapter-7',
        title: 'Entry & Exit Planning',
        description: 'Building a complete trading plan with TA',
        order: 7,
        lessons: [
          Lesson(
            id: 'ta-7-1',
            title: 'Planning Your Entry',
            description: 'Confluence, confirmation, and timing your buy',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ta-7-2',
            title: 'Planning Your Exit',
            description: 'Targets, trailing stops, and knowing when to leave',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 8: Common Technical Mistakes
      CourseModule(
        id: 'ta-chapter-8',
        title: 'Common Technical Mistakes',
        description: 'What most traders get wrong — and how to avoid it',
        order: 8,
        lessons: [
          Lesson(
            id: 'ta-8-1',
            title: 'The 7 Deadly TA Mistakes',
            description:
                'Overfitting, ignoring context, and indicator addiction',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'ta-8-2',
            title: 'Final Challenge: TA Pro',
            description: 'Comprehensive quiz across all 8 chapters',
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
