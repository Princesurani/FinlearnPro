import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'learning_models.dart';
import 'courses/foundations_of_trading/foundations_of_trading.dart';
import 'courses/stock_market/stock_market_course.dart';
import 'courses/cryptocurrency_market/cryptocurrency_market_course.dart';
import 'courses/forex_market/forex_market_course.dart';
import 'courses/commodities_market/commodities_market_course.dart';
import 'courses/technical_analysis/technical_analysis_course.dart';
import 'courses/fundamental_analysis/fundamental_analysis_course.dart';
import 'courses/risk_management/risk_management_course.dart';
import 'courses/practice_skill_building/practice_skill_building_course.dart';
import 'courses/derivatives_market/derivatives_market_course.dart';
import 'courses/trading_styles/trading_styles_course.dart';
import 'courses/real_world_setup/real_world_setup_course.dart';
import 'courses/consistent_trader/consistent_trader_course.dart';

abstract final class LearningData {
  // ── Categories that reflect the actual 13-course curriculum ──
  static const List<LearningCategory> categories = [
    LearningCategory(
      id: 'foundations',
      name: 'Foundations',
      description: 'Trading basics, market types, and order mechanics',
      icon: Icons.school_outlined,
      color: AppColors.electricBlue,
      courseCount: 5,
      estimatedHours: 16,
    ),
    LearningCategory(
      id: 'analysis',
      name: 'Analysis',
      description: 'Technical and fundamental analysis skills',
      icon: Icons.show_chart_rounded,
      color: AppColors.auroraPurple,
      courseCount: 2,
      estimatedHours: 12,
    ),
    LearningCategory(
      id: 'risk-psychology',
      name: 'Risk & Psychology',
      description: 'Risk management, trading psychology, and discipline',
      icon: Icons.shield_outlined,
      color: AppColors.amber,
      courseCount: 2,
      estimatedHours: 10,
    ),
    LearningCategory(
      id: 'advanced',
      name: 'Advanced',
      description: 'Derivatives, trading styles, and real-world setup',
      icon: Icons.rocket_launch_outlined,
      color: AppColors.coralPink,
      courseCount: 3,
      estimatedHours: 14,
    ),
    LearningCategory(
      id: 'mastery',
      name: 'Mastery',
      description: 'Consistency, performance, and becoming a pro',
      icon: Icons.emoji_events_outlined,
      color: AppColors.emerald,
      courseCount: 1,
      estimatedHours: 6,
    ),
  ];

  // ── All 13 fully interactive courses ──
  static List<Course> get allCourses => [
    // Course 1: Foundations of Trading
    FoundationsOfTradingCourse.getCourse(),
    // Course 2: Stock Market
    StockMarketCourse.getCourse(),
    // Course 3: Cryptocurrency Market
    CryptocurrencyMarketCourse.getCourse(),
    // Course 4: Forex Market
    ForexMarketCourse.getCourse(),
    // Course 5: Commodities Market
    CommoditiesMarketCourse.getCourse(),
    // Course 6: Technical Analysis
    TechnicalAnalysisCourse.getCourse(),
    // Course 7: Fundamental Analysis
    FundamentalAnalysisCourse.getCourse(),
    // Course 8: Risk Management & Trading Psychology
    RiskManagementCourse.getCourse(),
    // Course 9: Practice & Skill Building
    PracticeSkillBuildingCourse.getCourse(),
    // Course 10: Derivatives Market
    DerivativesMarketCourse.getCourse(),
    // Course 11: Trading Styles & Strategies
    TradingStylesCourse.getCourse(),
    // Course 12: Real-World Trading Setup
    RealWorldSetupCourse.getCourse(),
    // Course 13: Becoming a Consistent Trader
    ConsistentTraderCourse.getCourse(),
  ];

  // ── Continue Learning (references real courses) ──
  static List<Map<String, dynamic>> get continueLearning => [
    {
      'course': allCourses[0], // Foundations of Trading
      'progress': 0.65,
      'lastLesson': 'Understanding Order Types',
      'nextLesson': 'Market vs Limit Orders',
      'minutesLeft': 63,
    },
    {
      'course': allCourses[5], // Technical Analysis
      'progress': 0.32,
      'lastLesson': 'Candlestick Patterns',
      'nextLesson': 'Support & Resistance',
      'minutesLeft': 163,
    },
    {
      'course': allCourses[7], // Risk Management
      'progress': 0.15,
      'lastLesson': 'Why Most Traders Lose',
      'nextLesson': 'Risk vs Reward',
      'minutesLeft': 128,
    },
  ];

  // ── Learning Paths (references real course IDs) ──
  static List<LearningPath> get learningPaths => [
    const LearningPath(
      id: 'path-001',
      title: 'Complete Beginner to Trader',
      description:
          'Master the foundations, learn analysis, and build risk management skills',
      courses: [
        'c0-foundations',
        'c1-stocks',
        'c5-technical',
        'c7-risk',
        'c8-practice',
      ],
      estimatedWeeks: 10,
      difficulty: DifficultyLevel.beginner,
      skills: [
        'Market Fundamentals',
        'Technical Analysis',
        'Risk Management',
        'Paper Trading',
      ],
    ),
    const LearningPath(
      id: 'path-002',
      title: 'Advanced Trader',
      description:
          'Derivatives, trading styles, and building long-term consistency',
      courses: ['c10-derivatives', 'c11-styles', 'c12-setup', 'c13-consistent'],
      estimatedWeeks: 8,
      difficulty: DifficultyLevel.advanced,
      skills: [
        'Options & Futures',
        'Strategy Selection',
        'Tax & Compliance',
        'Performance Evaluation',
      ],
    ),
    const LearningPath(
      id: 'path-003',
      title: 'Multi-Market Explorer',
      description:
          'Stocks, crypto, forex, and commodities — understand all markets',
      courses: ['c1-stocks', 'c2-crypto', 'c3-forex', 'c4-commodities'],
      estimatedWeeks: 6,
      difficulty: DifficultyLevel.intermediate,
      skills: [
        'Stock Trading',
        'Crypto & Blockchain',
        'Forex Pairs',
        'Commodity Markets',
      ],
    ),
  ];

  // ── User Progress (clean starting state) ──
  static UserLearningProgress get currentUserProgress => UserLearningProgress(
    userId: 'user-001',
    totalXp: 0,
    currentLevel: 1,
    coursesStarted: 0,
    coursesCompleted: 0,
    lessonsCompleted: 0,
    totalLearningMinutes: 0,
    currentStreak: 0,
    longestStreak: 0,
    courseProgress: const {},
    achievements: achievements,
    lastActivityDate: DateTime.now(),
  );

  // ── Achievements ──
  static List<Achievement> get achievements => [
    Achievement(
      id: 'ach-001',
      title: 'First Steps',
      description: 'Complete your first lesson',
      iconData: Icons.rocket_launch_outlined,
      color: AppColors.mintGreen,
      xpReward: 50,
      rarity: AchievementRarity.common,
    ),
    Achievement(
      id: 'ach-002',
      title: 'Knowledge Seeker',
      description: 'Complete 10 lessons',
      iconData: Icons.auto_stories_outlined,
      color: AppColors.electricBlue,
      xpReward: 100,
      rarity: AchievementRarity.common,
      progress: 0,
      maxProgress: 10,
    ),
    Achievement(
      id: 'ach-003',
      title: 'Week Warrior',
      description: 'Maintain a 7-day learning streak',
      iconData: Icons.local_fire_department_rounded,
      color: AppColors.sunsetOrange,
      xpReward: 200,
      rarity: AchievementRarity.rare,
      progress: 0,
      maxProgress: 7,
    ),
    Achievement(
      id: 'ach-004',
      title: 'Quiz Master',
      description: 'Score 100% on 5 quizzes',
      iconData: Icons.emoji_events_outlined,
      color: AppColors.goldenYellow,
      xpReward: 300,
      rarity: AchievementRarity.rare,
      progress: 0,
      maxProgress: 5,
    ),
    Achievement(
      id: 'ach-005',
      title: 'Course Champion',
      description: 'Complete your first course',
      iconData: Icons.workspace_premium_outlined,
      color: AppColors.auroraPurple,
      xpReward: 500,
      rarity: AchievementRarity.epic,
      progress: 0,
      maxProgress: 1,
    ),
    Achievement(
      id: 'ach-006',
      title: 'Market Scholar',
      description: 'Complete 5 courses',
      iconData: Icons.school_outlined,
      color: AppColors.indigo,
      xpReward: 1000,
      rarity: AchievementRarity.epic,
      progress: 0,
      maxProgress: 5,
    ),
    Achievement(
      id: 'ach-007',
      title: 'Trading Legend',
      description: 'Complete all 13 courses',
      iconData: Icons.star_outline_rounded,
      color: AppColors.goldenYellow,
      xpReward: 2500,
      rarity: AchievementRarity.legendary,
      progress: 0,
      maxProgress: 13,
    ),
  ];

  // ── Daily Tips ──
  static List<Map<String, String>> get dailyTips => [
    {
      'title': 'The Power of Compound Interest',
      'tip': 'Einstein called compound interest the 8th wonder of the world. Even small, consistent investments can grow significantly over time.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Never Stop Learning',
      'tip': 'Markets evolve constantly. The best traders dedicate time daily to learning and improving their strategies.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Risk Management First',
      'tip': 'Professional traders focus on risk before reward. Always know your maximum loss before entering a trade.',
      'category': 'Risk Management',
    },
    {
      'title': 'Trend is Your Friend',
      'tip': 'Don\'t fight the overall market direction. Trading with the trend significantly increases your probability of success.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Cut Losses Quickly',
      'tip': 'The most important rule of trading is to cut your losses short. Never let a small loss turn into a big one.',
      'category': 'Risk Management',
    },
    {
      'title': 'Let Profits Run',
      'tip': 'Trailing stop-losses can help you stay in winning trades longer. Don\'t take profits too early out of fear.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Diversification',
      'tip': 'Don\'t put all your eggs in one basket. Spreading investments across different asset classes reduces overall portfolio risk.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Avoid Emotional Trading',
      'tip': 'Fear and greed destroy more accounts than bad strategies. Always stick to your predefined trading plan.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Keep a Trading Journal',
      'tip': 'Document every trade, including your emotional state. You can\'t improve what you don\'t measure.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'The 1% Rule',
      'tip': 'Never risk more than 1% to 2% of your total trading capital on a single trade. This ensures you survive losing streaks.',
      'category': 'Risk Management',
    },
    {
      'title': 'Support and Resistance',
      'tip': 'Price often reacts at historical price levels. Learn to identify major support and resistance zones.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Understand Market Cycles',
      'tip': 'Markets move in cycles of accumulation, markup, distribution, and markdown. Know which phase you are in.',
      'category': 'Investing Basics',
    },
    {
      'title': 'News vs. Price Action',
      'tip': 'News is often priced in. Pay more attention to how the market reacts to news rather than the news itself.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Patience Pays',
      'tip': 'Sometimes the best trade is no trade. Waiting for high-probability setups preserves capital.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Avoid Overtrading',
      'tip': 'Trading too frequently leads to higher fees and emotional exhaustion. Quality of setups beats quantity.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Use Stop-Loss Orders',
      'tip': 'A hard stop-loss protects your account from catastrophic, unexpected market drops. Use them religiously.',
      'category': 'Risk Management',
    },
    {
      'title': 'Position Sizing',
      'tip': 'Adjust your position size based on the volatility of the asset and your stop-loss distance.',
      'category': 'Risk Management',
    },
    {
      'title': 'Ignore the Noise',
      'tip': 'Social media and forums are filled with opinions. Trust your own analysis and trading system above all.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Understand Valuation',
      'tip': 'Price is what you pay, value is what you get. Learn to read basic financial statements for long-term investing.',
      'category': 'Fundamental Analysis',
    },
    {
      'title': 'Review Your Mistakes',
      'tip': 'Your biggest losses are your best teachers. Analyze what went wrong and adjust your rules.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Volume Precedes Price',
      'tip': 'Heavy volume often confirms a price breakout or breakdown. Watch volume for institutional activity.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'The Moving Average',
      'tip': 'Moving averages help smooth out price action and identify the core trend. The 200-day MA is a major institutional indicator.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Dollar-Cost Averaging',
      'tip': 'Investing a fixed amount regularly reduces the impact of volatility and removes the stress of timing the market.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Avoid Revenge Trading',
      'tip': 'Never jump immediately back into the market to win back a loss. Step away and clear your head.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Stick to Liquid Assets',
      'tip': 'Highly liquid stocks and pairs have tighter spreads and less risk of price manipulation.',
      'category': 'Risk Management',
    },
    {
      'title': 'Understand Margin Risk',
      'tip': 'Leverage multiplies both profits and losses. Use it very carefully, if at all, when starting out.',
      'category': 'Risk Management',
    },
    {
      'title': 'The R:R Ratio',
      'tip': 'Aim for a Risk-to-Reward ratio of at least 1:2. This means you can be wrong 50% of the time and still make money.',
      'category': 'Risk Management',
    },
    {
      'title': 'Earnings Reports',
      'tip': 'Trading right before earnings is a gamble. Consider waiting until after the report to see the market\'s true reaction.',
      'category': 'Fundamental Analysis',
    },
    {
      'title': 'Focus on the Process',
      'tip': 'Don\'t focus on the PnL of individual trades. Focus on executing your system flawlessly. The money will follow.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Respect Market Hours',
      'tip': 'The first and last hours of the stock market are the most volatile. Novices should often wait for the opening range to settle.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Sector Rotation',
      'tip': 'Money constantly flows between different market sectors. Watch for leading sectors to find the best stocks.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Beware of FOMO',
      'tip': 'Fear Of Missing Out leads to buying at the top. If a stock has gone parabolic, you are probably too late.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Understand the VIX',
      'tip': 'The Volatility Index (VIX) measures market fear. A high VIX often signals a market bottom, while a low VIX signals complacency.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Dividends Matter',
      'tip': 'For long-term investors, reinvested dividends account for a massive portion of total historical stock market returns.',
      'category': 'Fundamental Analysis',
    },
    {
      'title': 'Keep It Simple',
      'tip': 'You don\'t need 15 indicators on your chart. Price action, volume, and support/resistance are often enough.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Trade What You See',
      'tip': 'Don\'t trade what you think *should* happen. Trade what the chart is actually doing right now.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Macro vs Micro',
      'tip': 'Always check the higher timeframe trend before entering a trade on a lower timeframe.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Paper Trading',
      'tip': 'Test new strategies with fake money first. If you can\'t be profitable on paper, you won\'t be profitable with real cash.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Avoid Penny Stocks',
      'tip': 'Low-priced micro-caps are highly manipulated and volatile. Stick to established companies while learning.',
      'category': 'Risk Management',
    },
    {
      'title': 'The Power of Sleep',
      'tip': 'Fatigue destroys decision-making. Never trade when you are sleep-deprived or highly stressed.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Backtesting',
      'tip': 'Validate your trading strategy on historical data. Ensure your edge is real before risking capital.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Cash is a Position',
      'tip': 'Holding cash when there are no clear setups is a highly profitable defensive strategy.',
      'category': 'Risk Management',
    },
    {
      'title': 'Beware of \'Gurus\'',
      'tip': 'Anyone promising guaranteed returns is likely running a scam. Trading is about probabilities, not certainties.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Inflation\'s Impact',
      'tip': 'Inflation silently erodes purchasing power. Investing is essential to outpace inflation over decades.',
      'category': 'Investing Basics',
    },
    {
      'title': 'The PE Ratio',
      'tip': 'Price-to-Earnings ratio helps compare a company\'s valuation against its peers. A very high PE means high growth expectations.',
      'category': 'Fundamental Analysis',
    },
    {
      'title': 'Insider Buying',
      'tip': 'When executives buy their own company\'s stock, it\'s often a strong signal they believe the price will go up.',
      'category': 'Fundamental Analysis',
    },
    {
      'title': 'False Breakouts',
      'tip': 'Markets often break key levels briefly to trap amateur traders before reversing. Wait for confirmation.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Scaling Out',
      'tip': 'You don\'t have to sell your entire position at once. Take partial profits as the price hits your targets.',
      'category': 'Risk Management',
    },
    {
      'title': 'Correlations',
      'tip': 'Be aware of how your assets move together. Buying Bitcoin and Ethereum doesn\'t truly diversify your crypto risk.',
      'category': 'Risk Management',
    },
    {
      'title': 'Continuous Adaptation',
      'tip': 'A strategy that worked in a bull market might fail in a bear market. Be flexible and adapt.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'The 50-Day MA',
      'tip': 'The 50-day moving average is a key level watched by institutions to gauge medium-term momentum.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Options Are Derivatives',
      'tip': 'Options are complex instruments with time decay. Fully understand the \'Greeks\' before trading them.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Market Breadth',
      'tip': 'Watch the Advance/Decline line to see if a market rally is supported by many stocks or just a few heavyweights.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Avoid Averaging Down',
      'tip': 'Adding to a losing trade is a quick way to blow up an account. Average up into winners instead.',
      'category': 'Risk Management',
    },
    {
      'title': 'Expect the Unexpected',
      'tip': 'Black swan events happen. Never trade without a stop-loss because \'it can\'t possibly go lower.\'',
      'category': 'Risk Management',
    },
    {
      'title': 'Focus on One Market',
      'tip': 'Don\'t try to trade stocks, forex, crypto, and commodities all at once. Master one asset class first.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Read SEC Filings',
      'tip': 'The 10-K and 10-Q reports provide the unfiltered truth about a company\'s financial health.',
      'category': 'Fundamental Analysis',
    },
    {
      'title': 'Free Cash Flow',
      'tip': 'Earnings can be manipulated, but free cash flow is harder to fake. It\'s the lifeblood of a healthy business.',
      'category': 'Fundamental Analysis',
    },
    {
      'title': 'The RSI Indicator',
      'tip': 'The Relative Strength Index helps identify overbought and oversold conditions. Look for divergences.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Gap Fills',
      'tip': 'Stocks that \'gap\' up or down at the open often retrace to \'fill the gap\' before continuing their trend.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Mental Stops',
      'tip': 'A mental stop-loss is useless if you don\'t have the discipline to execute it. Use hard broker stops.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Trade Your Personality',
      'tip': 'If you are impatient, day trading might suit you. If you are analytical and slow, try swing trading.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'The Spread',
      'tip': 'In forex and crypto, always factor in the bid-ask spread. It acts as an immediate fee on your trade.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Economic Calendars',
      'tip': 'Always check the economic calendar before trading. CPI data or Fed announcements cause extreme volatility.',
      'category': 'Fundamental Analysis',
    },
    {
      'title': 'Confirmation Bias',
      'tip': 'Don\'t just look for evidence that supports your trade idea. Actively search for reasons why it might fail.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Focus on Liquidity',
      'tip': 'Slippage occurs when there aren\'t enough buyers/sellers at your price. Trade highly liquid assets to avoid it.',
      'category': 'Risk Management',
    },
    {
      'title': 'The 80/20 Rule',
      'tip': '80% of your profits will likely come from 20% of your trades. Let those winners run.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Avoid the Herd',
      'tip': 'When everyone is heavily on one side of a trade, the market usually does the exact opposite.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Fibonacci Retracements',
      'tip': 'Markets rarely move in straight lines. Fibonacci levels (like 50% or 61.8%) often act as hidden support.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Debt-to-Equity',
      'tip': 'A high D/E ratio means a company is highly leveraged, which can be dangerous in a high-interest-rate environment.',
      'category': 'Fundamental Analysis',
    },
    {
      'title': 'Market Orders vs Limit',
      'tip': 'Use Limit orders to control your entry price. Market orders are only for when you must exit immediately.',
      'category': 'Risk Management',
    },
    {
      'title': 'Price Action is King',
      'tip': 'Indicators are lagging derivatives of price. Mastering pure price action gives you the truest signal.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Trade the Reaction',
      'tip': 'Don\'t try to predict earnings. Wait for the report, see how the market reacts, and trade the ensuing trend.',
      'category': 'Investing Basics',
    },
    {
      'title': 'The Daily Chart',
      'tip': 'The daily chart is the gold standard for swing trading. It filters out the intraday noise and shows the true trend.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Re-enter if Stopped Out',
      'tip': 'If you get stopped out but the setup reforms perfectly, don\'t let ego prevent you from re-entering.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Don\'t Fight the Fed',
      'tip': 'Central bank policies dictate global liquidity. Always align your macro view with the current Fed monetary stance.',
      'category': 'Fundamental Analysis',
    },
    {
      'title': 'Volume Profile',
      'tip': 'Unlike traditional volume, volume profile shows you where the most trading occurred at specific price levels.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Avoid Illiquid Options',
      'tip': 'Options with wide bid/ask spreads are incredibly hard to profit from, even if you are right on direction.',
      'category': 'Risk Management',
    },
    {
      'title': 'Take Breaks',
      'tip': 'Staring at screens all day diminishes focus. Step away regularly to maintain a clear, objective mindset.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'The Trendline',
      'tip': 'A valid trendline requires at least three touches. It remains valid until definitively broken with volume.',
      'category': 'Technical Analysis',
    },
    {
      'title': 'Understand Yields',
      'tip': 'Bond yields often dictate stock market valuations. When yields rise rapidly, growth stocks usually suffer.',
      'category': 'Fundamental Analysis',
    },
    {
      'title': 'Avoid \'Tipsters\'',
      'tip': 'Relying on others for stock picks prevents you from learning. Build your own conviction and do your own research.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'The 2% Rule',
      'tip': 'If you lose 2% of your account on a single trade, it\'s a minor setback. If you lose 50%, you need a 100% gain just to break even.',
      'category': 'Risk Management',
    },
    {
      'title': 'Don\'t Average Down',
      'tip': 'Never add money to a losing trade. It\'s the hallmark of amateur trading and leads to massive losses.',
      'category': 'Risk Management',
    },
    {
      'title': 'Be Patient',
      'tip': 'The market will always be there tomorrow. Don\'t force trades when the setup isn\'t perfect.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Track Your Equity Curve',
      'tip': 'Your account balance over time is a chart itself. If it\'s in a downtrend, reduce position size until you recover.',
      'category': 'Risk Management',
    },
    {
      'title': 'Keep a Watchlist',
      'tip': 'Maintain a small, curated list of high-quality assets. Familiarity with how an asset moves provides a distinct edge.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Review Weekly',
      'tip': 'Spend the weekend reviewing your trades and preparing your levels and plans for the upcoming week.',
      'category': 'Investing Basics',
    },
    {
      'title': 'Accept Uncertainty',
      'tip': 'Trading is an exercise in probability. You can do everything right and still lose. Accept it.',
      'category': 'Trading Psychology',
    },
    {
      'title': 'Master One Setup',
      'tip': 'You only need one highly profitable setup to make a career. Don\'t try to be a jack-of-all-trades.',
      'category': 'Investing Basics',
    },
  ];
}
