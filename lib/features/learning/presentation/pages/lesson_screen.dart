import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/learning_models.dart' hide QuizQuestion;
import '../../data/courses/foundations_of_trading/what_is_trading_investing.dart';
import '../../data/courses/foundations_of_trading/how_financial_markets_work.dart';
import '../../data/courses/foundations_of_trading/whos_in_the_market.dart';
import '../../data/courses/foundations_of_trading/mastering_order_types.dart';
import '../../data/courses/foundations_of_trading/speaking_the_language.dart';
import '../../data/courses/foundations_of_trading/before_you_start_trading.dart';
import '../../data/courses/stock_market/what_is_the_stock_market.dart';
import '../../data/courses/stock_market/from_startup_to_stock_exchange.dart';
import '../../data/courses/stock_market/know_your_stocks.dart';
import '../../data/courses/stock_market/how_stock_trading_works.dart';
import '../../data/courses/stock_market/the_two_paths.dart';
import '../../data/courses/stock_market/risks_management.dart';
import '../../data/courses/cryptocurrency_market/digital_assets_trading.dart';
import '../../data/courses/cryptocurrency_market/what_is_cryptocurrency.dart';
import '../../data/courses/cryptocurrency_market/blockchain_basics.dart';
import '../../data/courses/cryptocurrency_market/crypto_assets_types.dart';
import '../../data/courses/cryptocurrency_market/how_crypto_trading_works.dart';
import '../../data/courses/cryptocurrency_market/cex_vs_dex.dart';
import '../../data/courses/cryptocurrency_market/volatility_and_risks.dart';
import '../../data/courses/cryptocurrency_market/who_should_trade.dart';
import '../../data/courses/forex_market/global_currency_trading.dart';
import '../../data/courses/forex_market/what_is_forex_market.dart';
import '../../data/courses/forex_market/currency_pairs.dart';
import '../../data/courses/forex_market/major_minor_exotic_pairs.dart';
import '../../data/courses/forex_market/how_forex_trading_works.dart';
import '../../data/courses/forex_market/trading_sessions.dart';
import '../../data/courses/forex_market/leverage_margin.dart';
import '../../data/courses/forex_market/forex_risks.dart';
import '../../data/courses/forex_market/who_should_trade_forex.dart';
import '../../data/courses/commodities_market/physical_assets_trading.dart';
import '../../data/courses/commodities_market/what_are_commodities.dart';
import '../../data/courses/commodities_market/commodity_types.dart';
import '../../data/courses/commodities_market/how_commodity_trading_works.dart';
import '../../data/courses/commodities_market/spot_vs_derivative.dart';
import '../../data/courses/commodities_market/commodity_price_factors.dart';
import '../../data/courses/commodities_market/commodity_risks.dart';
import '../../data/courses/commodities_market/who_should_trade_commodities.dart';
import '../../data/courses/technical_analysis/used_in_all_markets.dart';
import '../../data/courses/technical_analysis/price_charts.dart';
import '../../data/courses/technical_analysis/support_resistance.dart';
import '../../data/courses/technical_analysis/trend_analysis.dart';
import '../../data/courses/technical_analysis/candlestick_patterns.dart';
import '../../data/courses/technical_analysis/indicators.dart';
import '../../data/courses/technical_analysis/entry_exit_planning.dart';
import '../../data/courses/technical_analysis/technical_mistakes.dart';
import '../../data/courses/fundamental_analysis/value_macro.dart';
import '../../data/courses/fundamental_analysis/what_is_fa.dart';
import '../../data/courses/fundamental_analysis/company_financials.dart';
import '../../data/courses/fundamental_analysis/economic_indicators.dart';
import '../../data/courses/fundamental_analysis/news_event_impact.dart';
import '../../data/courses/fundamental_analysis/crypto_fundamentals.dart';
import '../../data/courses/fundamental_analysis/fundamentals_vs_charts.dart';
import '../../data/courses/risk_management/most_important_course.dart';
import '../../data/courses/risk_management/why_traders_lose.dart';
import '../../data/courses/risk_management/risk_vs_reward.dart';
import '../../data/courses/risk_management/position_sizing.dart';
import '../../data/courses/risk_management/stop_loss_protection.dart';
import '../../data/courses/risk_management/drawdowns_recovery.dart';
import '../../data/courses/risk_management/fear_greed_overconfidence.dart';
import '../../data/courses/risk_management/overtrading_revenge.dart';
import '../../data/courses/risk_management/discipline_patience.dart';
import '../../data/courses/risk_management/risk_first_mindset.dart';
import '../../data/courses/practice_skill_building/no_real_money.dart';
import '../../data/courses/practice_skill_building/paper_trading.dart';
import '../../data/courses/practice_skill_building/trade_planning.dart';
import '../../data/courses/practice_skill_building/backtesting_basics.dart';
import '../../data/courses/practice_skill_building/maintaining_journal.dart';
import '../../data/courses/practice_skill_building/reviewing_trades.dart';
import '../../data/courses/practice_skill_building/improving_decision_making.dart';
import '../../data/courses/derivatives_market/high_risk_instruments.dart';
import '../../data/courses/derivatives_market/what_are_derivatives.dart';
import '../../data/courses/derivatives_market/futures_basics.dart';
import '../../data/courses/derivatives_market/options_basics.dart';
import '../../data/courses/derivatives_market/calls_and_puts.dart';
import '../../data/courses/derivatives_market/margin_leverage.dart';
import '../../data/courses/derivatives_market/when_not_derivatives.dart';
import '../../data/courses/derivatives_market/derivative_mistakes.dart';
import '../../data/courses/trading_styles/personality_style.dart';
import '../../data/courses/trading_styles/scalping_overview.dart';
import '../../data/courses/trading_styles/intraday_trading.dart';
import '../../data/courses/trading_styles/swing_trading.dart';
import '../../data/courses/trading_styles/long_term_investing.dart';
import '../../data/courses/trading_styles/strategy_selection.dart';
import '../../data/courses/trading_styles/copying_strategies.dart';
import '../../data/courses/real_world_setup/practical_execution.dart';
import '../../data/courses/real_world_setup/fees_regulations.dart';
import '../../data/courses/real_world_setup/taxes_safety.dart';
import '../../data/courses/consistent_trader/mindset_plan_performance.dart';
import '../../data/courses/consistent_trader/risk_learning_consistency.dart';
import '../widgets/concept_slide_widget.dart';
import '../widgets/story_slide_widget.dart';
import '../widgets/quiz_slide_widget.dart';
import '../widgets/scenario_slide_widget.dart';
import '../widgets/summary_slide_widget.dart';
import '../widgets/interaction_models.dart';
import '../../bloc/learning_bloc.dart';
import '../../bloc/learning_bloc_provider.dart';

/// Interactive lesson screen with psychological engagement
class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  final Course course;
  final int lessonIndex;
  final int totalLessons;

  const LessonScreen({
    super.key,
    required this.lesson,
    required this.course,
    required this.lessonIndex,
    required this.totalLessons,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late List<LessonContent> _content;
  int _score = 0;
  late AnimationController _progressAnimController;
  late AnimationController _celebrationController;

  // Track which slides have been completed (for validation)
  final Set<int> _completedSlides = {};

  // Show validation warning banner
  bool _showValidationWarning = false;

  // Show quiz feedback banner
  bool _showQuizFeedback = false;
  bool _isQuizCorrect = false;
  String _quizFeedbackMessage = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _content = _generateLessonContent();
    _progressAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressAnimController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  List<LessonContent> _generateLessonContent() {
    // Load actual content based on lesson ID
    return _loadLessonContentById(widget.lesson.id);
  }

  List<LessonContent> _loadLessonContentById(String lessonId) {
    // Map lesson IDs to their content
    Map<String, dynamic>? contentData;

    switch (lessonId) {
      case 'lesson-1-1':
        contentData =
            WhatIsTradingInvestingContent.getTradingVsInvestingContent();
        break;
      case 'lesson-1-2':
        contentData = WhatIsTradingInvestingContent.getWhyPeopleTradeContent();
        break;
      case 'lesson-1-3':
        contentData = WhatIsTradingInvestingContent.getRealityCheckContent();
        break;
      case 'lesson-2-1':
        contentData =
            HowFinancialMarketsWorkContent.getFinancialMarketContent();
        break;
      case 'lesson-2-2':
        contentData = HowFinancialMarketsWorkContent.getExchangesContent();
        break;
      case 'lesson-2-3':
        contentData = HowFinancialMarketsWorkContent.getTradeProcessContent();
        break;
      case 'lesson-3-1':
        contentData = WhosInTheMarketContent.getRetailTradersContent();
        break;
      case 'lesson-3-2':
        contentData = WhosInTheMarketContent.getInstitutionalPlayersContent();
        break;
      case 'lesson-3-3':
        contentData = WhosInTheMarketContent.getMarketMakersContent();
        break;
      case 'lesson-4-1':
        contentData = MasteringOrderTypesContent.getMarketOrderContent();
        break;
      case 'lesson-4-2':
        contentData = MasteringOrderTypesContent.getLimitOrderContent();
        break;
      case 'lesson-4-3':
        contentData = MasteringOrderTypesContent.getStopOrderContent();
        break;
      case 'lesson-4-4':
        contentData = MasteringOrderTypesContent.getPracticeContent();
        break;
      case 'lesson-5-1':
        contentData = SpeakingTheLanguageContent.getBidAskContent();
        break;
      case 'lesson-5-2':
        contentData = SpeakingTheLanguageContent.getVolumeLiquidityContent();
        break;
      case 'lesson-5-3':
        contentData = SpeakingTheLanguageContent.getBullsBearsContent();
        break;
      case 'lesson-6-1':
        contentData = BeforeYouStartTradingContent.getBrokerSelectionContent();
        break;
      case 'lesson-6-2':
        contentData = BeforeYouStartTradingContent.getPaperTradingContent();
        break;
      case 'lesson-6-3':
        contentData = BeforeYouStartTradingContent.getMistakeContent();
        break;
      case 'lesson-6-4':
        contentData = BeforeYouStartTradingContent.getFinalChallengeContent();
        break;

      // ── Stock Market Course (Course 1) ──
      case 'sm-1-1':
        contentData = WhatIsTheStockMarketContent.getMarketplaceContent();
        break;
      case 'sm-1-2':
        contentData = WhatIsTheStockMarketContent.getShareMeaningContent();
        break;
      case 'sm-1-3':
        contentData = WhatIsTheStockMarketContent.getRealityCheckContent();
        break;
      case 'sm-2-1':
        contentData =
            FromStartupToStockExchangeContent.getWhyCompaniesSellContent();
        break;
      case 'sm-2-2':
        contentData = FromStartupToStockExchangeContent.getIPOJourneyContent();
        break;
      case 'sm-2-3':
        contentData =
            FromStartupToStockExchangeContent.getPrimarySecondaryContent();
        break;
      case 'sm-3-1':
        contentData = KnowYourStocksContent.getMarketCapContent();
        break;
      case 'sm-3-2':
        contentData = KnowYourStocksContent.getCapCategoriesContent();
        break;
      case 'sm-3-3':
        contentData = KnowYourStocksContent.getSectorsContent();
        break;
      case 'sm-4-1':
        contentData = HowStockTradingWorksContent.getTradingToolkitContent();
        break;
      case 'sm-4-2':
        contentData = HowStockTradingWorksContent.getFirstTradeContent();
        break;
      case 'sm-4-3':
        contentData = HowStockTradingWorksContent.getTradingDayContent();
        break;
      case 'sm-4-4':
        contentData = HowStockTradingWorksContent.getPracticeTradeContent();
        break;
      case 'sm-5-1':
        contentData = TheTwoPathsContent.getLongTermContent();
        break;
      case 'sm-5-2':
        contentData = TheTwoPathsContent.getShortTermContent();
        break;
      case 'sm-5-3':
        contentData = TheTwoPathsContent.getFindStyleContent();
        break;
      case 'sm-6-1':
        contentData = RisksManagementContent.getRisksContent();
        break;
      case 'sm-6-2':
        contentData = RisksManagementContent.getWhoShouldTradeContent();
        break;
      case 'sm-6-3':
        contentData = RisksManagementContent.getFirstPlanContent();
        break;
      case 'sm-6-4':
        contentData = RisksManagementContent.getFinalChallengeContent();
        break;

      // ── Cryptocurrency Market Course (Course 3) ──
      case 'crypto-1-1':
        contentData = DigitalAssetsTradingContent.getDigitalRevolutionContent();
        break;
      case 'crypto-1-2':
        contentData =
            DigitalAssetsTradingContent.getWhyDigitalAssetsMatterContent();
        break;
      case 'crypto-2-1':
        contentData = WhatIsCryptocurrencyContent.getBirthOfBitcoinContent();
        break;
      case 'crypto-2-2':
        contentData = WhatIsCryptocurrencyContent.getHowCryptoWorksContent();
        break;
      case 'crypto-2-3':
        contentData =
            WhatIsCryptocurrencyContent.getCryptoRealityCheckContent();
        break;
      case 'crypto-3-1':
        contentData = BlockchainBasicsContent.getPublicLedgerContent();
        break;
      case 'crypto-3-2':
        contentData = BlockchainBasicsContent.getMiningStakingContent();
        break;
      case 'crypto-4-1':
        contentData = CryptoAssetsTypesContent.getCoinsVsTokensContent();
        break;
      case 'crypto-4-2':
        contentData = CryptoAssetsTypesContent.getStablecoinsContent();
        break;
      case 'crypto-4-3':
        contentData = CryptoAssetsTypesContent.getNftsDeFiContent();
        break;
      case 'crypto-5-1':
        contentData = HowCryptoTradingWorksContent.getTradingPairsContent();
        break;
      case 'crypto-5-2':
        contentData = HowCryptoTradingWorksContent.getWalletsSecurityContent();
        break;
      case 'crypto-5-3':
        contentData = HowCryptoTradingWorksContent.getFirstTradeContent();
        break;
      case 'crypto-6-1':
        contentData = CexVsDexContent.getCexBasicsContent();
        break;
      case 'crypto-6-2':
        contentData = CexVsDexContent.getDexBasicsContent();
        break;
      case 'crypto-7-1':
        contentData = VolatilityAndRisksContent.getWhyVolatileContent();
        break;
      case 'crypto-7-2':
        contentData = VolatilityAndRisksContent.getScamsHacksContent();
        break;
      case 'crypto-7-3':
        contentData = VolatilityAndRisksContent.getRiskManagementContent();
        break;
      case 'crypto-8-1':
        contentData =
            WhoShouldTradeCryptoContent.getReadinessChecklistContent();
        break;
      case 'crypto-8-2':
        contentData = WhoShouldTradeCryptoContent.getFinalChallengeContent();
        break;

      // ── Forex Market Course (Course 4) ──
      case 'forex-1-1':
        contentData = GlobalCurrencyTradingContent.getInvisibleMarketContent();
        break;
      case 'forex-1-2':
        contentData =
            GlobalCurrencyTradingContent.getWhoTradesCurrenciesContent();
        break;
      case 'forex-2-1':
        contentData = WhatIsForexMarketContent.getDecentralizedGiantContent();
        break;
      case 'forex-2-2':
        contentData = WhatIsForexMarketContent.getForexVsStocksContent();
        break;
      case 'forex-3-1':
        contentData = CurrencyPairsContent.getReadingPairsContent();
        break;
      case 'forex-3-2':
        contentData = CurrencyPairsContent.getPipsLotsContent();
        break;
      case 'forex-4-1':
        contentData = MajorMinorExoticPairsContent.getMajorPairsContent();
        break;
      case 'forex-4-2':
        contentData = MajorMinorExoticPairsContent.getMinorsExoticsContent();
        break;
      case 'forex-5-1':
        contentData = HowForexTradingWorksContent.getForexBrokersContent();
        break;
      case 'forex-5-2':
        contentData = HowForexTradingWorksContent.getFirstForexTradeContent();
        break;
      case 'forex-6-1':
        contentData = TradingSessionsContent.getThreeSessionsContent();
        break;
      case 'forex-6-2':
        contentData = TradingSessionsContent.getLiquiditySpreadsContent();
        break;
      case 'forex-7-1':
        contentData = LeverageMarginContent.getWhatIsLeverageContent();
        break;
      case 'forex-7-2':
        contentData = LeverageMarginContent.getMarginCallsContent();
        break;
      case 'forex-8-1':
        contentData = ForexRisksContent.getSevenRisksContent();
        break;
      case 'forex-8-2':
        contentData = ForexRisksContent.getRiskToolkitContent();
        break;
      case 'forex-9-1':
        contentData = WhoShouldTradeForexContent.getReadinessChecklistContent();
        break;
      case 'forex-9-2':
        contentData = WhoShouldTradeForexContent.getFinalChallengeContent();
        break;

      // ── Commodities Market Course (Course 5) ──
      case 'comm-1-1':
        contentData = PhysicalAssetsTradingContent.getTradingRealWorldContent();
        break;
      case 'comm-1-2':
        contentData =
            PhysicalAssetsTradingContent.getWhyCommoditiesMatterContent();
        break;
      case 'comm-2-1':
        contentData = WhatAreCommoditiesContent.getBuildingBlocksContent();
        break;
      case 'comm-2-2':
        contentData = WhatAreCommoditiesContent.getIndiaExchangesContent();
        break;
      case 'comm-3-1':
        contentData = CommodityTypesContent.getMetalsContent();
        break;
      case 'comm-3-2':
        contentData = CommodityTypesContent.getEnergyContent();
        break;
      case 'comm-3-3':
        contentData = CommodityTypesContent.getAgricultureContent();
        break;
      case 'comm-4-1':
        contentData =
            HowCommodityTradingWorksContent.getFuturesContractsContent();
        break;
      case 'comm-4-2':
        contentData = HowCommodityTradingWorksContent.getFirstTradeContent();
        break;
      case 'comm-5-1':
        contentData = SpotVsDerivativeContent.getSpotMarketsContent();
        break;
      case 'comm-5-2':
        contentData = SpotVsDerivativeContent.getDerivativesContent();
        break;
      case 'comm-6-1':
        contentData = CommodityPriceFactorsContent.getSupplyDemandContent();
        break;
      case 'comm-6-2':
        contentData = CommodityPriceFactorsContent.getExternalFactorsContent();
        break;
      case 'comm-7-1':
        contentData = CommodityRisksContent.getSixRisksContent();
        break;
      case 'comm-7-2':
        contentData = CommodityRisksContent.getRiskManagementContent();
        break;
      case 'comm-8-1':
        contentData =
            WhoShouldTradeCommoditiesContent.getReadinessChecklistContent();
        break;
      case 'comm-8-2':
        contentData =
            WhoShouldTradeCommoditiesContent.getFinalChallengeContent();
        break;

      // ── Technical Analysis Course (Course 6) ──
      case 'ta-1-1':
        contentData = UsedInAllMarketsContent.getUniversalLanguageContent();
        break;
      case 'ta-1-2':
        contentData = UsedInAllMarketsContent.getTaVsFaContent();
        break;
      case 'ta-2-1':
        contentData = PriceChartsContent.getChartTypesContent();
        break;
      case 'ta-2-2':
        contentData = PriceChartsContent.getTimeframesContent();
        break;
      case 'ta-3-1':
        contentData = SupportResistanceContent.getFindingSRContent();
        break;
      case 'ta-3-2':
        contentData = SupportResistanceContent.getBreakoutsContent();
        break;
      case 'ta-4-1':
        contentData = TrendAnalysisContent.getIdentifyingTrendsContent();
        break;
      case 'ta-4-2':
        contentData = TrendAnalysisContent.getTrendlinesContent();
        break;
      case 'ta-5-1':
        contentData = CandlestickPatternsContent.getSingleCandleContent();
        break;
      case 'ta-5-2':
        contentData = CandlestickPatternsContent.getMultiCandleContent();
        break;
      case 'ta-5-3':
        contentData = CandlestickPatternsContent.getChartPatternsContent();
        break;
      case 'ta-6-1':
        contentData = IndicatorsContent.getMovingAveragesContent();
        break;
      case 'ta-6-2':
        contentData = IndicatorsContent.getRsiMacdContent();
        break;
      case 'ta-6-3':
        contentData = IndicatorsContent.getBollingerVolumeContent();
        break;
      case 'ta-7-1':
        contentData = EntryExitPlanningContent.getPlanningEntryContent();
        break;
      case 'ta-7-2':
        contentData = EntryExitPlanningContent.getPlanningExitContent();
        break;
      case 'ta-8-1':
        contentData = TechnicalMistakesContent.getSevenMistakesContent();
        break;
      case 'ta-8-2':
        contentData = TechnicalMistakesContent.getFinalChallengeContent();
        break;

      // ── Fundamental Analysis Course (Course 7) ──
      case 'fa-1-1':
        contentData = ValueMacroContent.getPriceVsValueContent();
        break;
      case 'fa-1-2':
        contentData = ValueMacroContent.getMacroLensContent();
        break;
      case 'fa-2-1':
        contentData =
            WhatIsFundamentalAnalysisContent.getFundamentalFrameworkContent();
        break;
      case 'fa-2-2':
        contentData =
            WhatIsFundamentalAnalysisContent.getFaAcrossAssetsContent();
        break;
      case 'fa-3-1':
        contentData = CompanyFinancialsContent.getThreeStatementsContent();
        break;
      case 'fa-3-2':
        contentData = CompanyFinancialsContent.getKeyRatiosContent();
        break;
      case 'fa-3-3':
        contentData = CompanyFinancialsContent.getAnnualReportContent();
        break;
      case 'fa-4-1':
        contentData = EconomicIndicatorsContent.getGdpInflationRatesContent();
        break;
      case 'fa-4-2':
        contentData = EconomicIndicatorsContent.getRbiPolicyContent();
        break;
      case 'fa-5-1':
        contentData = NewsEventImpactContent.getEarningsSeasonContent();
        break;
      case 'fa-5-2':
        contentData = NewsEventImpactContent.getGeopoliticsContent();
        break;
      case 'fa-6-1':
        contentData = CryptoFundamentalsContent.getEvaluatingProjectsContent();
        break;
      case 'fa-6-2':
        contentData = CryptoFundamentalsContent.getTokenomicsContent();
        break;
      case 'fa-7-1':
        contentData = FundamentalsVsChartsContent.getFaVsTaContent();
        break;
      case 'fa-7-2':
        contentData = FundamentalsVsChartsContent.getFinalChallengeContent();
        break;

      // ── Risk Management Course (Course 8) ──
      case 'rm-1-1':
        contentData = MostImportantCourseContent.getWhyRmIsEverythingContent();
        break;
      case 'rm-1-2':
        contentData = MostImportantCourseContent.getSurvivalHierarchyContent();
        break;
      case 'rm-2-1':
        contentData = WhyTradersLoseContent.getNinetyRuleContent();
        break;
      case 'rm-2-2':
        contentData = WhyTradersLoseContent.getFiveKillersContent();
        break;
      case 'rm-3-1':
        contentData = RiskVsRewardContent.getProbabilitiesContent();
        break;
      case 'rm-3-2':
        contentData = RiskVsRewardContent.getRiskRewardContent();
        break;
      case 'rm-4-1':
        contentData = PositionSizingContent.getOneTwoPercentContent();
        break;
      case 'rm-4-2':
        contentData = PositionSizingContent.getCalculatingSizeContent();
        break;
      case 'rm-5-1':
        contentData = StopLossContent.getTypesOfStopsContent();
        break;
      case 'rm-5-2':
        contentData = StopLossContent.getLossLimitsContent();
        break;
      case 'rm-6-1':
        contentData = DrawdownRecoveryContent.getDrawdownMathContent();
        break;
      case 'rm-6-2':
        contentData = DrawdownRecoveryContent.getSurvivingLosingStreakContent();
        break;
      case 'rm-7-1':
        contentData = FearGreedOverconfidenceContent.getFearGreedContent();
        break;
      case 'rm-7-2':
        contentData = FearGreedOverconfidenceContent.getOverconfidenceContent();
        break;
      case 'rm-8-1':
        contentData = OvertradingRevengeContent.getOvertradingContent();
        break;
      case 'rm-8-2':
        contentData = OvertradingRevengeContent.getRevengeTradingContent();
        break;
      case 'rm-9-1':
        contentData = DisciplinePatienceContent.getTradingJournalContent();
        break;
      case 'rm-9-2':
        contentData = DisciplinePatienceContent.getBuildingDisciplineContent();
        break;
      case 'rm-10-1':
        contentData = RiskFirstMindsetContent.getChecklistContent();
        break;
      case 'rm-10-2':
        contentData = RiskFirstMindsetContent.getFinalChallengeContent();
        break;

      // ── Practice & Skill Building Course (Course 9) ──
      case 'ps-1-1':
        contentData = NoRealMoneyContent.getCostOfImpatienceContent();
        break;
      case 'ps-1-2':
        contentData = NoRealMoneyContent.getSimulationRuleContent();
        break;
      case 'ps-2-1':
        contentData = PaperTradingContent.getWhatIsPaperTradingContent();
        break;
      case 'ps-2-2':
        contentData = PaperTradingContent.getPaperTradingTrapContent();
        break;
      case 'ps-3-1':
        contentData = TradePlanningContent.getPreTradePlanContent();
        break;
      case 'ps-3-2':
        contentData = TradePlanningContent.getContingencyPlanningContent();
        break;
      case 'ps-4-1':
        contentData = BacktestingBasicsContent.getConceptOfBacktestingContent();
        break;
      case 'ps-4-2':
        contentData = BacktestingBasicsContent.getManualVsAutomatedContent();
        break;
      case 'ps-5-1':
        contentData = MaintainingJournalContent.getSettingUpJournalContent();
        break;
      case 'ps-5-2':
        contentData = MaintainingJournalContent.getJournalingEmotionsContent();
        break;
      case 'ps-6-1':
        contentData = ReviewingTradesContent.getWeeklyReviewContent();
        break;
      case 'ps-6-2':
        contentData = ReviewingTradesContent.getCategorizingMistakesContent();
        break;
      case 'ps-7-1':
        contentData = ImprovingDecisionMakingContent.getFeedbackLoopContent();
        break;
      case 'ps-7-2':
        contentData = ImprovingDecisionMakingContent.getFinalChallengeContent();
        break;

      // ── Derivatives Market Course (Course 10) ──
      case 'dm-1-1':
        contentData = HighRiskInstrumentsContent.getDerivativesWarningContent();
        break;
      case 'dm-1-2':
        contentData = HighRiskInstrumentsContent.getLeverageIllusionContent();
        break;
      case 'dm-2-1':
        contentData = WhatAreDerivativesContent.getConceptContent();
        break;
      case 'dm-2-2':
        contentData = WhatAreDerivativesContent.getTypesContent();
        break;
      case 'dm-3-1':
        contentData = FuturesBasicsContent.getHowFuturesWorkContent();
        break;
      case 'dm-3-2':
        contentData = FuturesBasicsContent.getNiftyFuturesContent();
        break;
      case 'dm-4-1':
        contentData = OptionsBasicsContent.getWhatIsOptionContent();
        break;
      case 'dm-4-2':
        contentData = OptionsBasicsContent.getPremiumStrikeExpiryContent();
        break;
      case 'dm-5-1':
        contentData = CallsPutsContent.getCallOptionsContent();
        break;
      case 'dm-5-2':
        contentData = CallsPutsContent.getPutOptionsContent();
        break;
      case 'dm-6-1':
        contentData = MarginLeverageContent.getUnderstandingMarginContent();
        break;
      case 'dm-6-2':
        contentData = MarginLeverageContent.getMarginCallContent();
        break;
      case 'dm-7-1':
        contentData = WhenNotDerivativesContent.getReadinessChecklistContent();
        break;
      case 'dm-7-2':
        contentData = WhenNotDerivativesContent.getAlternativesContent();
        break;
      case 'dm-8-1':
        contentData = DerivativeMistakesContent.getSevenSinsContent();
        break;
      case 'dm-8-2':
        contentData = DerivativeMistakesContent.getFinalChallengeContent();
        break;

      // ── Trading Styles & Strategies Course (Course 11) ──
      case 'ts-1-1':
        contentData = PersonalityStyleContent.getPersonalityTestContent();
        break;
      case 'ts-1-2':
        contentData = PersonalityStyleContent.getFourStylesContent();
        break;
      case 'ts-2-1':
        contentData = ScalpingOverviewContent.getWhatIsScalpingContent();
        break;
      case 'ts-2-2':
        contentData = ScalpingOverviewContent.getWhyNotBeginnersContent();
        break;
      case 'ts-3-1':
        contentData = IntradayTradingContent.getIntradayLifestyleContent();
        break;
      case 'ts-3-2':
        contentData = IntradayTradingContent.getIntradayRulesContent();
        break;
      case 'ts-4-1':
        contentData = SwingTradingContent.getSweetSpotContent();
        break;
      case 'ts-4-2':
        contentData = SwingTradingContent.getSwingMechanicsContent();
        break;
      case 'ts-5-1':
        contentData = LongTermInvestingContent.getCompoundingContent();
        break;
      case 'ts-5-2':
        contentData = LongTermInvestingContent.getSipIndexContent();
        break;
      case 'ts-6-1':
        contentData = StrategySelectionContent.getTimeCapitalContent();
        break;
      case 'ts-6-2':
        contentData = StrategySelectionContent.getHybridApproachContent();
        break;
      case 'ts-7-1':
        contentData = CopyingStrategiesContent.getGuruIllusionContent();
        break;
      case 'ts-7-2':
        contentData = CopyingStrategiesContent.getFinalChallengeContent();
        break;

      // ── Real-World Trading Setup Course (Course 12) ──
      case 'rw-1-1':
        contentData = PracticalExecutionContent.getBridgingTheoryContent();
        break;
      case 'rw-1-2':
        contentData = PracticalExecutionContent.getInfrastructureContent();
        break;
      case 'rw-2-1':
        contentData = ChoosingBrokerContent.getTypesOfBrokersContent();
        break;
      case 'rw-2-2':
        contentData = ChoosingBrokerContent.getBrokerComparisonContent();
        break;
      case 'rw-3-1':
        contentData = FeesAndCostsContent.getTrueCostContent();
        break;
      case 'rw-3-2':
        contentData = FeesAndCostsContent.getMinimizingCostsContent();
        break;
      case 'rw-4-1':
        contentData = RegulationsComplianceContent.getSebiProtectionContent();
        break;
      case 'rw-4-2':
        contentData = RegulationsComplianceContent.getMarketRulesContent();
        break;
      case 'rw-5-1':
        contentData = TaxationContent.getTradingTaxesContent();
        break;
      case 'rw-5-2':
        contentData = TaxationContent.getTaxEfficientContent();
        break;
      case 'rw-6-1':
        contentData = TradingSafetyContent.getScamsFraudContent();
        break;
      case 'rw-6-2':
        contentData = TradingSafetyContent.getFinalChallengeContent();
        break;

      // ── Becoming a Consistent Trader Course (Course 13) ──
      case 'ct-1-1':
        contentData = FinalMindsetContent.getJourneySoFarContent();
        break;
      case 'ct-1-2':
        contentData = FinalMindsetContent.getMindsetShiftContent();
        break;
      case 'ct-2-1':
        contentData = TradingPlanContent.getCompletePlanContent();
        break;
      case 'ct-2-2':
        contentData = TradingPlanContent.getWritingYourPlanContent();
        break;
      case 'ct-3-1':
        contentData = PerformanceEvalContent.getMetricsContent();
        break;
      case 'ct-3-2':
        contentData = PerformanceEvalContent.getMonthlyReviewContent();
        break;
      case 'ct-4-1':
        contentData = RiskFirstApproachContent.getRiskBudgetContent();
        break;
      case 'ct-4-2':
        contentData = RiskFirstApproachContent.getAntifragileContent();
        break;
      case 'ct-5-1':
        contentData = ContinuousLearningContent.getLearningEcosystemContent();
        break;
      case 'ct-5-2':
        contentData = ContinuousLearningContent.getAdaptingContent();
        break;
      case 'ct-6-1':
        contentData = ConsistencyContent.getTenThousandHoursContent();
        break;
      case 'ct-6-2':
        contentData = ConsistencyContent.getFinalGraduationContent();
        break;

      default:
        // Fallback to placeholder content for lessons not yet implemented
        return _generatePlaceholderContent();
    }

    // Parse the content data and create LessonContent widgets
    return _parseContentData(contentData);
  }

  List<LessonContent> _parseContentData(Map<String, dynamic> contentData) {
    final slides = contentData['slides'] as List<dynamic>;
    final List<LessonContent> content = [];

    for (final slide in slides) {
      final slideMap = slide as Map<String, dynamic>;
      final type = slideMap['type'] as String;

      switch (type) {
        case 'intro':
          content.add(
            IntroContent(
              title: slideMap['title'] ?? widget.lesson.title,
              subtitle:
                  slideMap['content'] ?? 'Let\'s master this concept together',
              estimatedTime: widget.lesson.formattedDuration,
            ),
          );
          break;

        case 'story':
          content.add(
            StoryContent(
              story: slideMap['content'] ?? '',
              character: slideMap['emoji'] ?? '👤',
            ),
          );
          break;

        case 'concept':
          content.add(
            ConceptContent(
              concept: slideMap['content'] ?? '',
              keyPoints: List<String>.from(slideMap['keyPoints'] ?? []),
            ),
          );
          break;

        case 'quiz':
          content.add(
            InteractiveQuizContent(
              question: QuizQuestion(
                question: slideMap['question'] ?? '',
                options: List<String>.from(slideMap['options'] ?? []),
                correctIndex: slideMap['correctIndex'] ?? 0,
                explanation: slideMap['explanation'] ?? '',
              ),
              onAnswered: _handleQuizAnswer,
            ),
          );
          break;

        case 'scenario':
          final choices = (slideMap['choices'] as List<dynamic>).map((choice) {
            final choiceMap = choice as Map<String, dynamic>;
            return ScenarioChoice(
              text: choiceMap['text'] ?? '',
              isCorrect: choiceMap['isCorrect'] ?? false,
              feedback: choiceMap['feedback'] ?? '',
            );
          }).toList();

          content.add(
            ScenarioContent(
              scenario: Scenario(
                situation: slideMap['situation'] ?? '',
                choices: choices,
              ),
              onChoice: _handleScenarioChoice,
            ),
          );
          break;

        case 'interactive':
          content.add(
            ConceptContent(
              concept: slideMap['content'] ?? '',
              keyPoints: [], // Interactive slides don't need key points
            ),
          );
          break;

        case 'summary':
          content.add(
            SummaryContent(
              keyTakeaways: List<String>.from(slideMap['keyPoints'] ?? []),
            ),
          );
          break;
      }
    }

    return content;
  }

  List<LessonContent> _generatePlaceholderContent() {
    // Placeholder for lessons not yet implemented
    return [
      IntroContent(
        title: widget.lesson.title,
        subtitle: 'Content coming soon!',
        estimatedTime: widget.lesson.formattedDuration,
      ),
      ConceptContent(
        concept:
            'This lesson content is being developed. Check back soon for the full interactive experience!',
        keyPoints: [
          'Content is being created',
          'Will include stories, quizzes, and scenarios',
          'Stay tuned for updates',
        ],
      ),
      SummaryContent(keyTakeaways: ['Lesson content coming soon']),
    ];
  }

  void _handleQuizAnswer(bool isCorrect) {
    // Mark this slide as completed
    _markSlideCompleted(_currentPage);

    // Hide validation warning if shown
    setState(() {
      _showValidationWarning = false;
      _showQuizFeedback = true;
      _isQuizCorrect = isCorrect;
      _quizFeedbackMessage = isCorrect
          ? '🎉 Correct! +10 points'
          : '💡 Not quite right, but keep learning!';
    });

    if (isCorrect) {
      setState(() => _score += 10);
      HapticFeedback.lightImpact();
    } else {
      HapticFeedback.mediumImpact();
    }

    // Auto-hide after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showQuizFeedback = false;
        });
      }
    });
  }

  void _handleScenarioChoice(int choiceIndex) {
    // Mark this slide as completed
    _markSlideCompleted(_currentPage);

    // Hide validation warning if shown
    setState(() {
      _showValidationWarning = false;
    });

    // Handle scenario-based learning
    setState(() => _score += 5);
  }

  void _nextPage() {
    // Check if current slide requires interaction and hasn't been completed
    if (_requiresInteraction(_currentPage) &&
        !_completedSlides.contains(_currentPage)) {
      setState(() {
        _showValidationWarning = true;
      });
      HapticFeedback.mediumImpact();

      // Auto-hide after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showValidationWarning = false;
          });
        }
      });
      return;
    }

    if (_currentPage < _content.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      _progressAnimController.forward(from: 0);
    } else {
      _completeLesson();
    }
  }

  bool _requiresInteraction(int pageIndex) {
    if (pageIndex >= _content.length) return false;

    final content = _content[pageIndex];
    // Quiz and Scenario slides require interaction
    return content is InteractiveQuizContent || content is ScenarioContent;
  }

  void _markSlideCompleted(int pageIndex) {
    setState(() {
      _completedSlides.add(pageIndex);
    });
  }

  String _getButtonText() {
    // Last slide
    if (_currentPage == _content.length - 1) {
      return 'Complete Lesson';
    }

    // Interactive slides that haven't been completed yet
    if (_requiresInteraction(_currentPage) &&
        !_completedSlides.contains(_currentPage)) {
      final content = _content[_currentPage];
      if (content is InteractiveQuizContent) {
        return 'Answer to Continue';
      } else if (content is ScenarioContent) {
        return 'Make a Choice';
      }
    }

    return 'Continue';
  }

  void _completeLesson() {
    _celebrationController.forward();
    HapticFeedback.heavyImpact();

    // Dispatch lesson completion to update progress
    try {
      final bloc = LearningBlocProvider.of(context);
      bloc.dispatch(
        CompleteLessonEvent(
          courseId: widget.course.id,
          lessonId: widget.lesson.id,
          xpReward: widget.lesson.xpReward,
          totalLessonsInCourse: widget.totalLessons,
        ),
      );
    } catch (e) {
      debugPrint('LearningBlocProvider not found: $e');
    }

    // Show completion dialog
    Future.delayed(const Duration(milliseconds: 500), () {
      _showCompletionDialog();
    });
  }

  void _showCompletionDialog() {
    // Check if there's a next lesson
    final hasNextLesson = widget.lessonIndex < widget.totalLessons - 1;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _CompletionDialog(
        score: widget
            .lesson
            .xpReward, // Used to be _score, but we want to show standard lesson XP reward
        lessonTitle: widget.lesson.title,
        hasNextLesson: hasNextLesson,
        onContinue: () {
          Navigator.of(context).pop(); // Close dialog

          if (hasNextLesson) {
            // Navigate to next lesson
            _navigateToNextLesson();
          } else {
            // Last lesson - return to course
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  void _navigateToNextLesson() {
    final allLessons = <Lesson>[];
    for (final module in widget.course.modules) {
      allLessons.addAll(module.lessons);
    }

    if (widget.lessonIndex + 1 < allLessons.length) {
      final nextLesson = allLessons[widget.lessonIndex + 1];
      // Preserve the LearningBlocProvider when pushing to next lesson
      final bloc = LearningBlocProvider.of(context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LearningBlocProvider(
            bloc: bloc,
            child: LessonScreen(
              lesson: nextLesson,
              course: widget.course,
              lessonIndex: widget.lessonIndex + 1,
              totalLessons: widget.totalLessons,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildTopBar(),
                _buildProgressBar(),
                if (_showValidationWarning) _buildValidationBanner(),
                if (_showQuizFeedback) _buildQuizFeedbackBanner(),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage = page;
                        _showValidationWarning =
                            false; // Hide banner on page change
                        _showQuizFeedback =
                            false; // Hide quiz feedback on page change
                      });
                    },
                    itemCount: _content.length,
                    itemBuilder: (context, index) {
                      return _content[index].build(context);
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => _showExitConfirmation(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.course.title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.lesson.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationBanner() {
    final content = _content[_currentPage];
    String message = '⚠️ Please complete this section before continuing';

    if (content is InteractiveQuizContent) {
      message = '📝 Please answer the quiz to continue';
    } else if (content is ScenarioContent) {
      message = '🤔 Please make a choice to continue';
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.warning.withValues(alpha: 0.15),
            AppColors.warning.withValues(alpha: 0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.3),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.warning.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: AppColors.warning,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 18),
            color: AppColors.textSecondary,
            onPressed: () {
              setState(() {
                _showValidationWarning = false;
              });
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizFeedbackBanner() {
    final isCorrect = _isQuizCorrect;
    final color = isCorrect ? AppColors.success : AppColors.error;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isCorrect
                  ? Icons.check_circle_outline_rounded
                  : Icons.info_outline_rounded,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _quizFeedbackMessage,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 18),
            color: AppColors.textSecondary,
            onPressed: () {
              setState(() {
                _showQuizFeedback = false;
              });
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = (_currentPage + 1) / _content.length;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_currentPage + 1} of ${_content.length}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.backgroundTertiary,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      color: Colors.transparent, // Ensure transparency
      child: Row(
        children: [
          if (_currentPage > 0)
            Container(
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
                padding: const EdgeInsets.all(10),
                constraints: const BoxConstraints(), // Minimize constraints
              ),
            ),
          Expanded(
            child: Container(
              height: 50, // Fixed height for compactness
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.zero, // Use Container height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getButtonText(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Lesson?'),
        content: const Text(
          'Your progress will be saved, but you\'ll need to restart this lesson.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}

// Abstract base class for lesson content
abstract class LessonContent {
  Widget build(BuildContext context);
}

// Intro slide
class IntroContent extends LessonContent {
  final String title;
  final String subtitle;
  final String estimatedTime;

  IntroContent({
    required this.title,
    required this.subtitle,
    required this.estimatedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.school_rounded,
              size: 64,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.backgroundTertiary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.timer_outlined,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  estimatedTime,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Story-based content
class StoryContent extends LessonContent {
  final String story;
  final String character;

  StoryContent({required this.story, required this.character});

  @override
  Widget build(BuildContext context) {
    return StorySlideWidget(story: story, character: character);
  }
}

// Concept explanation
class ConceptContent extends LessonContent {
  final String concept;
  final List<String> keyPoints;

  ConceptContent({required this.concept, required this.keyPoints});

  @override
  Widget build(BuildContext context) {
    return ConceptSlideWidget(concept: concept, keyPoints: keyPoints);
  }
}

// Interactive quiz
class InteractiveQuizContent extends LessonContent {
  final QuizQuestion question;
  final Function(bool) onAnswered;

  InteractiveQuizContent({required this.question, required this.onAnswered});

  @override
  Widget build(BuildContext context) {
    return QuizSlideWidget(question: question, onAnswered: onAnswered);
  }
}

// Scenario-based learning
class ScenarioContent extends LessonContent {
  final Scenario scenario;
  final Function(int) onChoice;

  ScenarioContent({required this.scenario, required this.onChoice});

  @override
  Widget build(BuildContext context) {
    return ScenarioSlideWidget(scenario: scenario, onChoice: onChoice);
  }
}

// Summary content
class SummaryContent extends LessonContent {
  final List<String> keyTakeaways;
  final String? nextLesson;

  SummaryContent({required this.keyTakeaways, this.nextLesson});

  @override
  Widget build(BuildContext context) {
    return SummarySlideWidget(
      keyTakeaways: keyTakeaways,
      nextLesson: nextLesson,
    );
  }
}

// Completion dialog
class _CompletionDialog extends StatelessWidget {
  final int score;
  final String lessonTitle;
  final VoidCallback onContinue;
  final bool hasNextLesson;

  const _CompletionDialog({
    required this.score,
    required this.lessonTitle,
    required this.onContinue,
    required this.hasNextLesson,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                size: 48,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '🎉 Lesson Complete!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Great job completing "$lessonTitle"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF0F4F8), Color(0xFFE1EDFE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: AppColors.primary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '+$score XP',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryDark,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Points Earned',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDark.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  shadowColor: AppColors.primary.withValues(alpha: 0.4),
                ),
                child: Text(
                  hasNextLesson ? 'Next Lesson →' : 'Back to Course',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data models for lesson content
