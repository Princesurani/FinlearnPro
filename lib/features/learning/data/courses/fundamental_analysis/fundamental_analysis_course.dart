import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Fundamental Analysis Course — Cross-Market Skill
/// Understand value, financials, economics, and what drives asset prices
///
/// Course Structure: 7 Chapters, 18 Lessons, ~190 minutes
class FundamentalAnalysisCourse {
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
      id: 'c7-fundamental',
      title: 'Fundamental Analysis',
      subtitle: 'Value & macro understanding',
      description:
          'Learn to evaluate the TRUE value of any asset. From reading company balance sheets and P/E ratios to understanding GDP, inflation, and RBI policy — fundamental analysis helps you separate winners from losers across stocks, crypto, and macro markets.',
      categoryId: 'analysis',
      difficulty: DifficultyLevel.intermediate,
      thumbnailUrl: 'assets/images/courses/fundamental_analysis.png',
      modules: chapters,
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50,
      rating: 4.7,
      ratingsCount: 6320,
      enrolledCount: 24500,
      accentColor: const Color(0xFF6366F1), // Indigo
      isPremium: false,
      learningOutcomes: [
        'Understand the difference between price and value',
        'Read company financials: revenue, profit, P/E ratio, debt levels',
        'Interpret economic indicators: GDP, inflation, interest rates',
        'Assess how news and events impact different asset classes',
        'Evaluate crypto projects using tokenomics and use-case analysis',
        'Know when fundamentals matter more than charts',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      // Chapter 1: Value & Macro Understanding
      CourseModule(
        id: 'fa-chapter-1',
        title: 'Value & Macro Understanding',
        description: 'The difference between price and value',
        order: 1,
        lessons: [
          Lesson(
            id: 'fa-1-1',
            title: 'Price vs Value: The Core Idea',
            description:
                'Why a ₹3,000 stock can be cheap and a ₹30 stock can be expensive',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'fa-1-2',
            title: 'The Macro Lens',
            description:
                'How the economy, government policy, and global events shape prices',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 2: What Is Fundamental Analysis
      CourseModule(
        id: 'fa-chapter-2',
        title: 'What Is Fundamental Analysis',
        description: 'The science of evaluating intrinsic value',
        order: 2,
        lessons: [
          Lesson(
            id: 'fa-2-1',
            title: 'The Fundamental Framework',
            description: 'Top-down vs bottom-up analysis approaches',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'fa-2-2',
            title: 'FA Across Asset Classes',
            description:
                'How fundamentals differ for stocks, crypto, forex, and commodities',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 3: Company Financial Basics (Stocks)
      CourseModule(
        id: 'fa-chapter-3',
        title: 'Company Financial Basics',
        description: 'Reading the three financial statements',
        order: 3,
        lessons: [
          Lesson(
            id: 'fa-3-1',
            title: 'The Three Financial Statements',
            description:
                'Income statement, balance sheet, and cash flow decoded',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'fa-3-2',
            title: 'Key Ratios Every Investor Must Know',
            description: 'P/E, P/B, ROE, Debt-to-Equity, and more',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'fa-3-3',
            title: 'Reading an Annual Report',
            description: 'What to look for in a real company filing',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 4: Economic Indicators
      CourseModule(
        id: 'fa-chapter-4',
        title: 'Economic Indicators',
        description: 'GDP, inflation, interest rates, and their market impact',
        order: 4,
        lessons: [
          Lesson(
            id: 'fa-4-1',
            title: 'GDP, Inflation & Interest Rates',
            description: 'The three pillars of macroeconomics',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'fa-4-2',
            title: 'RBI Policy & Market Reactions',
            description:
                'How monetary policy decisions move Nifty, bonds, and the Rupee',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 5: News & Event Impact
      CourseModule(
        id: 'fa-chapter-5',
        title: 'News & Event Impact on Markets',
        description: 'Earnings, elections, wars, and sentiment shifts',
        order: 5,
        lessons: [
          Lesson(
            id: 'fa-5-1',
            title: 'Earnings Season & Corporate Events',
            description:
                'How quarterly results, dividends, and splits move stock prices',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'fa-5-2',
            title: 'Geopolitics, Elections & Black Swans',
            description: 'When world events override all analysis',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 6: Crypto Fundamentals
      CourseModule(
        id: 'fa-chapter-6',
        title: 'Crypto Fundamentals',
        description: 'Use cases, tokenomics, and project evaluation',
        order: 6,
        lessons: [
          Lesson(
            id: 'fa-6-1',
            title: 'Evaluating Crypto Projects',
            description: 'Whitepapers, teams, use cases, and tokenomics',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'fa-6-2',
            title: 'Tokenomics: The Economics of Crypto',
            description:
                'Supply mechanics, inflation schedules, and value capture',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 7: When Fundamentals Matter More Than Charts
      CourseModule(
        id: 'fa-chapter-7',
        title: 'When Fundamentals Beat Charts',
        description: 'Combining FA with TA and final challenge',
        order: 7,
        lessons: [
          Lesson(
            id: 'fa-7-1',
            title: 'FA vs TA: When to Use Which',
            description: 'The right tool for the right situation',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'fa-7-2',
            title: 'Final Challenge: FA Pro',
            description: 'Comprehensive quiz across all 7 chapters',
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
