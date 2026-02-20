import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Stock Market Course - Interactive Content
/// Deep dive into equity markets, IPOs, stock types, and investing strategies
///
/// Course Structure: 6 Chapters, 20 Lessons, ~200 minutes
class StockMarketCourse {
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
      id: 'c1-stocks',
      title: 'Stock Market',
      subtitle: 'Equity trading & investing from zero to confident',
      description:
          'Everything you need to know about the stock market. From understanding what a share really is, to how companies go public through IPOs, to building your own investment strategy. Real Indian market examples, zero fluff.',
      categoryId: 'stocks',
      difficulty: DifficultyLevel.beginner,
      thumbnailUrl: 'assets/images/courses/stock_market.png',
      modules:
          chapters, // Using 'modules' field for chapters (model compatibility)
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50, // 50 XP per lesson
      rating: 4.8,
      ratingsCount: 9840,
      enrolledCount: 38500,
      accentColor: const Color(0xFF2563EB), // Royal Blue
      isPremium: false,
      learningOutcomes: [
        'Understand what a stock/share truly represents',
        'Learn the IPO process and how companies get listed',
        'Classify stocks by Market Cap, Sector, and Risk',
        'Know how a stock trade is executed step-by-step',
        'Choose between long-term investing and short-term trading',
        'Identify and manage stock market risks like a pro',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      // Chapter 1: What is the Stock Market?
      CourseModule(
        id: 'sm-chapter-1',
        title: 'What is the Stock Market?',
        description: 'The marketplace where ownership changes hands',
        order: 1,
        lessons: [
          Lesson(
            id: 'sm-1-1',
            title: 'The Marketplace of Ownership',
            description:
                'Understand the stock market as a place to buy and sell pieces of companies',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
            keyTakeaways: [
              'The stock market is a marketplace for buying company ownership',
              'NSE and BSE are India\'s two major stock exchanges',
              'Stock prices are set by supply and demand, not by companies',
            ],
          ),
          Lesson(
            id: 'sm-1-2',
            title: 'What Does a "Share" Mean?',
            description:
                'A share is a piece of a company — learn what you actually own',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
            keyTakeaways: [
              'A share represents partial ownership of a company',
              'Shareholders are partners, not lenders',
              'You share in both profits (dividends) and losses',
              'Equity = Ownership',
            ],
          ),
          Lesson(
            id: 'sm-1-3',
            title: 'Stock Market Reality Check',
            description: 'Test your understanding of market basics',
            contentType: ContentType.quiz,
            estimatedMinutes: 8,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 2: How Companies Issue Shares
      CourseModule(
        id: 'sm-chapter-2',
        title: 'From Startup to Stock Exchange',
        description: 'The journey of a company going public',
        order: 2,
        lessons: [
          Lesson(
            id: 'sm-2-1',
            title: 'Why Companies Sell Shares',
            description:
                'Understand why a founder gives up ownership for money',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'sm-2-2',
            title: 'The IPO Journey',
            description:
                'Follow a company from private startup to public listing',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'sm-2-3',
            title: 'Primary vs Secondary Market',
            description: 'Where new shares are born vs where they are traded',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 3: Types of Stocks
      CourseModule(
        id: 'sm-chapter-3',
        title: 'Know Your Stocks',
        description: 'Not all stocks are created equal',
        order: 3,
        lessons: [
          Lesson(
            id: 'sm-3-1',
            title: 'Market Capitalization Explained',
            description: 'The single number that tells you a company\'s size',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'sm-3-2',
            title: 'Large Cap, Mid Cap & Small Cap',
            description: 'Giants, growers, and gambles — pick your fighter',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'sm-3-3',
            title: 'Sectors & Stock Classification',
            description: 'Banking, IT, Pharma — why sectors matter',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 4: How Stock Trading Works
      CourseModule(
        id: 'sm-chapter-4',
        title: 'How Stock Trading Works',
        description: 'From opening a Demat account to placing your first order',
        order: 4,
        lessons: [
          Lesson(
            id: 'sm-4-1',
            title: 'Your Trading Toolkit',
            description: 'Demat, Trading, and Bank accounts — the 3-in-1 setup',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'sm-4-2',
            title: 'Placing Your First Trade',
            description: 'Step-by-step: buying and selling a stock on NSE',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'sm-4-3',
            title: 'The Indian Trading Day',
            description: 'Market hours, sessions, and why 9:15 AM is chaos',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 3,
            xpReward: 50,
          ),
          Lesson(
            id: 'sm-4-4',
            title: 'Practice: Execute a Trade',
            description: 'Interactive scenarios to test your trading skills',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 4,
            xpReward: 75,
          ),
        ],
      ),

      // Chapter 5: Investing vs Trading
      CourseModule(
        id: 'sm-chapter-5',
        title: 'The Two Paths',
        description: 'Long-term investing vs short-term trading',
        order: 5,
        lessons: [
          Lesson(
            id: 'sm-5-1',
            title: 'The Long-Term Investor',
            description: 'Buy, hold, and let compounding do the heavy lifting',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'sm-5-2',
            title: 'The Short-Term Trader',
            description: 'Intraday, swing, and positional — speed has a price',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'sm-5-3',
            title: 'Which Path Suits You?',
            description: 'Take a self-assessment to find your style',
            contentType: ContentType.interactive,
            estimatedMinutes: 8,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 6: Risks & Who Should Trade
      CourseModule(
        id: 'sm-chapter-6',
        title: 'Risks Management',
        description: 'Respect the risk, then take the leap',
        order: 6,
        lessons: [
          Lesson(
            id: 'sm-6-1',
            title: 'The Risks No One Talks About',
            description:
                'Market risk, company risk, and the one risk that kills portfolios',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'sm-6-2',
            title: 'Who Should (And Shouldn\'t) Trade Stocks?',
            description: 'Honest checklist to know if you\'re ready',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'sm-6-3',
            title: 'Your First Investment Plan',
            description: 'Build a beginner portfolio step by step',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 3,
            xpReward: 50,
          ),
          Lesson(
            id: 'sm-6-4',
            title: 'Final Challenge: Stock Market Pro',
            description: 'Comprehensive quiz covering all 6 chapters',
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
