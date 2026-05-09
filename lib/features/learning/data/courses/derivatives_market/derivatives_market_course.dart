import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Derivatives Market Course — Advanced Instruments
/// Futures, Options, Calls, Puts, Margin, and Leverage
///
/// Course Structure: 8 Chapters, 18 Lessons, ~210 minutes
class DerivativesMarketCourse {
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
      id: 'c10-derivatives',
      title: 'Derivatives Market',
      subtitle: 'Advanced instruments',
      description:
          'Derivatives are weapons of mass destruction — or precision instruments. The difference is knowledge. Learn Futures, Options, Calls, Puts, and why leverage kills more accounts than bad analysis ever will.',
      categoryId: 'derivatives',
      difficulty: DifficultyLevel.advanced,
      thumbnailUrl: 'assets/images/courses/derivatives.png',
      modules: chapters,
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50,
      rating: 4.8,
      ratingsCount: 7600,
      enrolledCount: 18000,
      accentColor: const Color(0xFFF43F5E), // Rose
      isPremium: false,
      learningOutcomes: [
        'Understand why derivatives are called high-risk instruments',
        'Explain what Futures contracts are and how they work',
        'Understand Options basics — Calls and Puts in plain language',
        'Recognize the dangers of margin and leverage',
        'Know when derivatives are NOT appropriate for your level',
        'Avoid the top beginner mistakes that blow up derivative accounts',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      CourseModule(
        id: 'dm-chapter-1',
        title: 'High-Risk Instruments',
        description: 'Why this course comes with a WARNING label',
        order: 1,
        lessons: [
          Lesson(
            id: 'dm-1-1',
            title: 'The Derivatives Warning',
            description: 'Why SEBI requires a risk disclaimer before you trade',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'dm-1-2',
            title: 'The Leverage Illusion',
            description: 'How ₹50,000 can control ₹5,00,000 worth of assets',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'dm-chapter-2',
        title: 'What Are Derivatives',
        description: 'Contracts derived from underlying assets',
        order: 2,
        lessons: [
          Lesson(
            id: 'dm-2-1',
            title: 'The Concept of a Derivative',
            description: 'A contract whose value depends on something else',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'dm-2-2',
            title: 'Types of Derivatives',
            description: 'Futures, Options, Forwards, and Swaps',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'dm-chapter-3',
        title: 'Futures Basics',
        description: 'Agreements to buy or sell at a future date',
        order: 3,
        lessons: [
          Lesson(
            id: 'dm-3-1',
            title: 'How Futures Work',
            description: 'The farmer and the baker — a simple analogy',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'dm-3-2',
            title: 'Nifty Futures in Practice',
            description: 'Lot sizes, expiry dates, and daily settlement',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'dm-chapter-4',
        title: 'Options Basics',
        description: 'The right but not the obligation',
        order: 4,
        lessons: [
          Lesson(
            id: 'dm-4-1',
            title: 'What Is an Option?',
            description:
                'Buying the right to buy or sell — the movie ticket analogy',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'dm-4-2',
            title: 'Premium, Strike Price & Expiry',
            description: 'The three pillars of every options contract',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'dm-chapter-5',
        title: 'Calls & Puts',
        description: 'The two fundamental options strategies',
        order: 5,
        lessons: [
          Lesson(
            id: 'dm-5-1',
            title: 'Call Options — Betting on Rise',
            description: 'When you believe the price will go UP',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'dm-5-2',
            title: 'Put Options — Betting on Fall',
            description: 'When you believe the price will go DOWN',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'dm-chapter-6',
        title: 'Margin & Leverage Risks',
        description: 'The double-edged sword',
        order: 6,
        lessons: [
          Lesson(
            id: 'dm-6-1',
            title: 'Understanding Margin',
            description: 'Borrowing money from your broker to trade bigger',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'dm-6-2',
            title: 'The Margin Call Nightmare',
            description: 'When the broker forces you to sell at the worst time',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'dm-chapter-7',
        title: 'When NOT to Trade Derivatives',
        description: 'Knowing your limits saves your account',
        order: 7,
        lessons: [
          Lesson(
            id: 'dm-7-1',
            title: 'The Readiness Checklist',
            description: 'Are you actually ready for derivatives?',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'dm-7-2',
            title: 'Alternatives to Derivatives',
            description:
                'Cash market strategies that achieve similar goals safely',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'dm-chapter-8',
        title: 'Beginner Mistakes in Derivatives',
        description: 'The errors that destroy 93% of F&O traders',
        order: 8,
        lessons: [
          Lesson(
            id: 'dm-8-1',
            title: 'The Seven Deadly Derivative Sins',
            description: 'Every mistake that wipes out beginner accounts',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'dm-8-2',
            title: 'Final Challenge: Derivatives Pro',
            description: 'Comprehensive scenarios across all 8 chapters',
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
