import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Real-World Trading Setup Course — Practical Execution
/// Brokers, fees, regulations, taxes, and trading safely
///
/// Course Structure: 6 Chapters, 14 Lessons, ~160 minutes
class RealWorldSetupCourse {
  static Course getCourse() {
    final chapters = _getChapters();
    final totalLessons = chapters.fold<int>(0, (s, c) => s + c.lessons.length);
    final estimatedMinutes = chapters.fold<int>(
      0,
      (s, c) => s + c.totalMinutes,
    );
    return Course(
      id: 'c12-setup',
      title: 'Real-World Trading Setup',
      subtitle: 'Practical execution',
      description:
          'Knowing the theory is useless if you can not execute in the real world. Learn how to choose a broker, minimize fees, understand regulations, handle taxes, and set up your trading infrastructure safely and legally.',
      categoryId: 'setup',
      difficulty: DifficultyLevel.beginner,
      thumbnailUrl: 'assets/images/courses/setup.png',
      modules: chapters,
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50,
      rating: 4.6,
      ratingsCount: 5200,
      enrolledCount: 14000,
      accentColor: const Color(0xFF3B82F6), // Blue
      isPremium: false,
      learningOutcomes: [
        'Choose the right broker based on your trading style',
        'Understand all fees, commissions, and hidden costs',
        'Know the basic regulations that protect you as a trader',
        'Handle trading taxes properly to avoid penalties',
        'Set up your trading workspace for professional execution',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      CourseModule(
        id: 'rw-chapter-1',
        title: 'Practical Execution',
        description: 'From theory to reality',
        order: 1,
        lessons: [
          Lesson(
            id: 'rw-1-1',
            title: 'Bridging Theory and Practice',
            description: 'What changes when real money is on the line',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rw-1-2',
            title: 'Your Trading Infrastructure',
            description:
                'Internet, devices, and the workspace that makes you serious',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'rw-chapter-2',
        title: 'Choosing the Right Broker',
        description: 'Your gateway to the markets',
        order: 2,
        lessons: [
          Lesson(
            id: 'rw-2-1',
            title: 'Types of Brokers',
            description: 'Full-service vs discount brokers — which one fits',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rw-2-2',
            title: 'Broker Comparison Matrix',
            description: 'Zerodha vs Groww vs Angel One vs Upstox',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'rw-chapter-3',
        title: 'Fees, Commissions & Hidden Costs',
        description: 'Where your profits secretly disappear',
        order: 3,
        lessons: [
          Lesson(
            id: 'rw-3-1',
            title: 'The True Cost of Trading',
            description: 'Brokerage, STT, GST, stamp duty, and exchange fees',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rw-3-2',
            title: 'Minimizing Your Costs',
            description: 'Strategies to keep more of your profits',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'rw-chapter-4',
        title: 'Regulations & Compliance',
        description: 'Playing by the rules',
        order: 4,
        lessons: [
          Lesson(
            id: 'rw-4-1',
            title: 'SEBI and Your Protection',
            description: 'How the regulator keeps markets fair',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rw-4-2',
            title: 'What You Can and Cannot Do',
            description:
                'Insider trading, front-running, and market manipulation',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'rw-chapter-5',
        title: 'Taxation Overview',
        description: 'The tax man always gets his share',
        order: 5,
        lessons: [
          Lesson(
            id: 'rw-5-1',
            title: 'Trading Taxes Simplified',
            description: 'STCG, LTCG, speculative income, and audit triggers',
            contentType: ContentType.interactive,
            estimatedMinutes: 14,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rw-5-2',
            title: 'Tax-Efficient Trading',
            description:
                'Harvesting losses, holding periods, and record keeping',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),
      CourseModule(
        id: 'rw-chapter-6',
        title: 'Trading Safely & Legally',
        description: 'Protecting yourself from scams and fraud',
        order: 6,
        lessons: [
          Lesson(
            id: 'rw-6-1',
            title: 'Scams, Fraud & Red Flags',
            description: 'Pump-and-dump, fake gurus, and phishing attacks',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'rw-6-2',
            title: 'Final Challenge: Setup Pro',
            description: 'Test your real-world trading knowledge',
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
