import 'package:flutter/material.dart';
import '../../learning_models.dart';

/// Cryptocurrency Market Course — Interactive Content
/// Complete guide to digital assets, blockchain, and crypto trading
///
/// Course Structure: 8 Chapters, 20 Lessons, ~200 minutes
class CryptocurrencyMarketCourse {
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
      id: 'c3-crypto',
      title: 'Cryptocurrency Market',
      subtitle: 'Digital assets & blockchain-based trading',
      description:
          'Navigate the world of digital assets with confidence. From blockchain basics to trading on exchanges, this course covers everything you need to understand crypto — without the hype. Real risks, real examples, zero fluff.',
      categoryId: 'crypto',
      difficulty: DifficultyLevel.intermediate,
      thumbnailUrl: 'assets/images/courses/crypto_market.png',
      modules: chapters,
      totalLessons: totalLessons,
      estimatedMinutes: estimatedMinutes,
      xpReward: totalLessons * 50,
      rating: 4.7,
      ratingsCount: 6840,
      enrolledCount: 28500,
      accentColor: const Color(0xFFF59E0B), // Amber
      isPremium: false,
      learningOutcomes: [
        'Understand what cryptocurrency is and how blockchain works',
        'Differentiate between coins, tokens, and stablecoins',
        'Know how to trade crypto safely on CEX and DEX platforms',
        'Secure your assets with proper wallet management',
        'Identify and avoid common crypto scams and rug pulls',
        'Assess whether crypto trading fits your risk profile',
      ],
    );
  }

  static List<CourseModule> _getChapters() {
    return [
      // Chapter 1: Digital Assets & Blockchain-Based Trading
      CourseModule(
        id: 'crypto-chapter-1',
        title: 'Digital Assets & Blockchain-Based Trading',
        description: 'The evolution of money into programmable digital value',
        order: 1,
        lessons: [
          Lesson(
            id: 'crypto-1-1',
            title: 'The Digital Revolution',
            description:
                'How assets evolved from physical gold to programmable digital value',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
            keyTakeaways: [
              'Digital assets are a new form of programmable value',
              'The internet changed how we store and transfer wealth',
              'Understanding the shift is key before investing',
            ],
          ),
          Lesson(
            id: 'crypto-1-2',
            title: 'Why Digital Assets Matter',
            description:
                'The real-world problems that crypto is trying to solve',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
            keyTakeaways: [
              'Crypto solves real problems: cross-border payments, inflation hedge',
              'Not all digital assets are equal in utility',
              'Separating hype from genuine innovation is critical',
            ],
          ),
        ],
      ),

      // Chapter 2: What is Cryptocurrency
      CourseModule(
        id: 'crypto-chapter-2',
        title: 'What is Cryptocurrency',
        description: 'The origins, mechanics, and evolution of digital money',
        order: 2,
        lessons: [
          Lesson(
            id: 'crypto-2-1',
            title: 'The Birth of Bitcoin',
            description: 'How the 2008 financial crisis birthed a revolution',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
            keyTakeaways: [
              'Bitcoin was created as a response to centralized banking failures',
              'Satoshi Nakamoto solved the double-spend problem',
              'Understanding history helps you understand Bitcoin\'s value',
            ],
          ),
          Lesson(
            id: 'crypto-2-2',
            title: 'How Cryptocurrency Actually Works',
            description: 'Transactions, verification, and the trustless system',
            contentType: ContentType.interactive,
            estimatedMinutes: 15,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'crypto-2-3',
            title: 'Crypto Reality Check',
            description: 'Test your understanding of crypto fundamentals',
            contentType: ContentType.quiz,
            estimatedMinutes: 8,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 3: Blockchain Basics
      CourseModule(
        id: 'crypto-chapter-3',
        title: 'Blockchain Basics',
        description: 'The technology explained simply — no CS degree needed',
        order: 3,
        lessons: [
          Lesson(
            id: 'crypto-3-1',
            title: 'The Public Ledger',
            description:
                'How blockchain records every transaction transparently',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 1,
            xpReward: 50,
            keyTakeaways: [
              'Blockchain is a shared, immutable record book',
              'Blocks are chained using cryptographic hashes',
              'Tampering with one block breaks the entire chain',
            ],
          ),
          Lesson(
            id: 'crypto-3-2',
            title: 'Mining, Staking & Consensus',
            description: 'Proof-of-Work vs Proof-of-Stake explained',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 4: Types of Crypto Assets
      CourseModule(
        id: 'crypto-chapter-4',
        title: 'Types of Crypto Assets',
        description: 'Coins, tokens, stablecoins — not all crypto is equal',
        order: 4,
        lessons: [
          Lesson(
            id: 'crypto-4-1',
            title: 'Coins vs Tokens',
            description: 'The critical difference every investor must know',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'crypto-4-2',
            title: 'Stablecoins: The Bridge',
            description: 'How USDT and USDC keep the crypto world running',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'crypto-4-3',
            title: 'NFTs, DeFi & Beyond',
            description: 'The expanding universe of digital assets',
            contentType: ContentType.interactive,
            estimatedMinutes: 8,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 5: How Crypto Trading Works
      CourseModule(
        id: 'crypto-chapter-5',
        title: 'How Crypto Trading Works',
        description: 'From trading pairs to placing your first order',
        order: 5,
        lessons: [
          Lesson(
            id: 'crypto-5-1',
            title: 'Trading Pairs & Order Books',
            description: 'BTC/USDT, ETH/INR — how pairs work',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'crypto-5-2',
            title: 'Wallets & Security',
            description:
                'Hot wallets, cold wallets, and protecting your assets',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'crypto-5-3',
            title: 'Your First Crypto Trade',
            description: 'Step-by-step walkthrough of buying crypto',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 6: Centralized vs Decentralized Exchanges
      CourseModule(
        id: 'crypto-chapter-6',
        title: 'Centralized vs Decentralized Exchanges',
        description: 'Where to trade — and the tradeoffs of each',
        order: 6,
        lessons: [
          Lesson(
            id: 'crypto-6-1',
            title: 'CEX: The Familiar Path',
            description: 'How Binance, WazirX, and CoinDCX work',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'crypto-6-2',
            title: 'DEX: Trading Without Middlemen',
            description: 'Uniswap, PancakeSwap, and the DeFi revolution',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 7: Volatility & Crypto-Specific Risks
      CourseModule(
        id: 'crypto-chapter-7',
        title: 'Volatility & Crypto-Specific Risks',
        description: 'The dangers that are unique to cryptocurrency',
        order: 7,
        lessons: [
          Lesson(
            id: 'crypto-7-1',
            title: 'Why Crypto is So Volatile',
            description: 'The forces that cause 20% swings in a single day',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'crypto-7-2',
            title: 'Scams, Hacks & Rug Pulls',
            description: 'How to spot and avoid crypto fraud',
            contentType: ContentType.interactive,
            estimatedMinutes: 12,
            order: 2,
            xpReward: 50,
          ),
          Lesson(
            id: 'crypto-7-3',
            title: 'Risk Management for Crypto',
            description: 'Protecting your capital in wild markets',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 3,
            xpReward: 50,
          ),
        ],
      ),

      // Chapter 8: Who Should Trade Crypto
      CourseModule(
        id: 'crypto-chapter-8',
        title: 'Who Should Trade Crypto',
        description: 'Honest self-assessment before you invest a single rupee',
        order: 8,
        lessons: [
          Lesson(
            id: 'crypto-8-1',
            title: 'The Crypto Readiness Checklist',
            description: 'Are you financially and mentally prepared?',
            contentType: ContentType.interactive,
            estimatedMinutes: 10,
            order: 1,
            xpReward: 50,
          ),
          Lesson(
            id: 'crypto-8-2',
            title: 'Final Challenge: Crypto Pro',
            description: 'Comprehensive quiz covering all 8 chapters',
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
