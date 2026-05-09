import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Commodities Market Course — Interactive Content
/// Complete guide to trading physical assets: metals, energy, and agriculture
///
/// Course Structure: 8 Chapters, 20 Lessons, ~200 minutes
class CommoditiesMarketCourse {
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
      id: 'c5-commodities',
      title: 'Commodities Market',
      subtitle: 'Physical assets trading',
      description:
          'Gold, crude oil, wheat — commodities are the raw materials that power the world. Learn how these physical assets are traded, what drives their prices, and how Indian traders can participate through MCX and NCDEX.',
      categoryId: 'commodities',
      difficulty: DifficultyLevel.intermediate,
      thumbnailUrl: 'assets/images/courses/commodities_market.png',
      modules: chapters,
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50,
      rating: 4.5,
      ratingsCount: 4280,
      enrolledCount: 18200,
      accentColor: const Color(0xFFD97706), // Amber/Gold
      isPremium: false,
      learningOutcomes: [
        'Understand what commodities are and why they matter to the economy',
        'Differentiate between metals, energy, and agricultural commodities',
        'Know how commodity trading works on MCX and NCDEX',
        'Understand the difference between spot and derivative trading',
        'Identify factors that move commodity prices globally',
        'Assess whether commodity trading fits your risk profile',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      // Chapter 1: Physical Assets Trading
      CourseModule(
        id: 'comm-chapter-1',
        title: 'Physical Assets Trading',
        description: 'The oldest markets in human history',
        order: 1,
        lessons: [
          Lesson(
            id: 'comm-1-1',
            title: 'Trading the Real World',
            description: 'How physical goods became financial instruments',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
            keyTakeaways: [
              'Commodities are the raw materials that power every economy',
              'Commodity trading has existed for thousands of years',
              'Modern commodity markets combine physical goods with financial derivatives',
            ],
          ),
          Lesson(
            id: 'comm-1-2',
            title: 'Why Commodities Matter to You',
            description:
                'How gold, oil, and wheat prices affect your daily life',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 2: What Are Commodities
      CourseModule(
        id: 'comm-chapter-2',
        title: 'What Are Commodities',
        description: 'Definition, characteristics, and market structure',
        order: 2,
        lessons: [
          Lesson(
            id: 'comm-2-1',
            title: 'The Building Blocks of the Economy',
            description: 'What makes something a tradeable commodity',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'comm-2-2',
            title: 'India\'s Commodity Exchanges',
            description: 'MCX, NCDEX, and how Indian markets work',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 3: Types of Commodities
      CourseModule(
        id: 'comm-chapter-3',
        title: 'Types of Commodities',
        description: 'Metals, energy, and agricultural products',
        order: 3,
        lessons: [
          Lesson(
            id: 'comm-3-1',
            title: 'Precious & Industrial Metals',
            description: 'Gold, silver, copper, and aluminum decoded',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'comm-3-2',
            title: 'Energy: The Lifeblood',
            description: 'Crude oil, natural gas, and the power market',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'comm-3-3',
            title: 'Agricultural Commodities',
            description: 'Cotton, wheat, soybean — food as finance',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 4: How Commodity Trading Works
      CourseModule(
        id: 'comm-chapter-4',
        title: 'How Commodity Trading Works',
        description: 'Contracts, margins, and the mechanics of a trade',
        order: 4,
        lessons: [
          Lesson(
            id: 'comm-4-1',
            title: 'Futures Contracts Explained',
            description:
                'What you\'re actually buying when you trade commodities',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'comm-4-2',
            title: 'Your First Commodity Trade',
            description: 'Step-by-step walkthrough on MCX',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 5: Spot vs Derivative Trading
      CourseModule(
        id: 'comm-chapter-5',
        title: 'Spot vs Derivative Trading',
        description: 'Physical delivery vs financial settlement',
        order: 5,
        lessons: [
          Lesson(
            id: 'comm-5-1',
            title: 'Spot Markets: Buy It Now',
            description: 'Physical buying and selling of commodities',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'comm-5-2',
            title: 'Derivatives: Trade the Price',
            description: 'Futures and options without touching the goods',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 6: Factors Affecting Commodity Prices
      CourseModule(
        id: 'comm-chapter-6',
        title: 'Factors Affecting Commodity Prices',
        description: 'Supply, demand, geopolitics, and weather',
        order: 6,
        lessons: [
          Lesson(
            id: 'comm-6-1',
            title: 'Supply & Demand Forces',
            description: 'The fundamental drivers of every commodity',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'comm-6-2',
            title: 'Geopolitics, Weather & the Dollar',
            description: 'External shocks that move prices overnight',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 7: Risks in Commodity Trading
      CourseModule(
        id: 'comm-chapter-7',
        title: 'Risks in Commodity Trading',
        description: 'Unique dangers of trading physical assets',
        order: 7,
        lessons: [
          Lesson(
            id: 'comm-7-1',
            title: 'The Six Commodity Risks',
            description: 'Leverage, expiry, storage, and more',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'comm-7-2',
            title: 'Risk Management for Commodities',
            description: 'Hedging, diversification, and position limits',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 8: Who Should Trade Commodities
      CourseModule(
        id: 'comm-chapter-8',
        title: 'Who Should Trade Commodities',
        description: 'Honest self-assessment and final challenge',
        order: 8,
        lessons: [
          Lesson(
            id: 'comm-8-1',
            title: 'The Commodity Readiness Checklist',
            description: 'Is commodity trading right for you?',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'comm-8-2',
            title: 'Final Challenge: Commodity Pro',
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
