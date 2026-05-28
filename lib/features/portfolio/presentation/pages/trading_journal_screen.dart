import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/domain/market_data.dart';
import '../../../../shared/navigation/top_navigation_shell.dart';
import '../../../market/bloc/market_bloc.dart';

class TradingJournalScreen extends StatefulWidget {
  const TradingJournalScreen({super.key});

  @override
  State<TradingJournalScreen> createState() => _TradingJournalScreenState();
}

class _TradingJournalScreenState extends State<TradingJournalScreen> {
  late final MarketBloc _bloc;

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    _bloc = MarketBloc(firebaseUid: uid);
    // MarketBloc's LoadInstruments event (dispatched on init) triggers LoadOrders
    // We can explicitly request LoadOrders just in case
    _bloc.add(LoadOrders());
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TopNavigationShell(
                showMenu: false, // No sidebar
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Your Performance',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      'Trading Journal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<MarketState>(
                stream: _bloc.stream,
                initialData: _bloc.state,
                builder: (context, snapshot) {
                  final state = snapshot.data!;
                  final filledOrders = state.orders.where((o) => o.status == 'filled').toList();

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInsightsCard(),
                        const SizedBox(height: 24),
                        const Text(
                          'Recent Trade Reviews',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (state.status == MarketStatus.loading && filledOrders.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: CircularProgressIndicator(color: AppColors.primary),
                            ),
                          )
                        else if (filledOrders.isEmpty)
                          _buildEmptyState()
                        else
                          ...filledOrders.map((o) => _buildDynamicEntry(o, state)),
                        const SizedBox(height: 40),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            const Icon(Icons.menu_book_rounded, size: 48, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            const Text(
              'No trades reviewed yet',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicEntry(Order order, MarketState state) {
    // Deterministic mock based on order ID
    final hash = order.id.hashCode.abs();
    
    final isWin = hash % 3 != 0; // 66% win rate
    final profitAmt = (hash % 500) + 10.0;
    final currency = state.activeMarket.currencySymbol;
    final profitStr = isWin ? '+$currency${profitAmt.toStringAsFixed(2)}' : '-$currency${profitAmt.toStringAsFixed(2)}';
    
    final emotions = [
      {'name': 'Patient', 'icon': Icons.self_improvement_rounded, 'color': AppColors.oceanTeal},
      {'name': 'Confident', 'icon': Icons.emoji_emotions_rounded, 'color': AppColors.success},
      {'name': 'FOMO', 'icon': Icons.warning_rounded, 'color': AppColors.error},
      {'name': 'Anxious', 'icon': Icons.sentiment_dissatisfied_rounded, 'color': AppColors.amber},
    ];
    final emotion = emotions[hash % emotions.length];

    final lessons = [
      'Waited for the pullback to support level before entering.',
      'Followed my moving average crossover strategy perfectly.',
      'Chased a breakout without waiting for confirmation. Hit stop-loss.',
      'Sized too large and panicked during a normal drawdown.',
    ];
    final lesson = lessons[hash % lessons.length];

    final dt = order.filledAt ?? order.createdAt;
    final dateStr = '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';

    return _buildJournalEntry(
      symbol: order.symbol,
      type: order.side.toUpperCase(),
      profit: profitStr,
      isWin: isWin,
      date: dateStr,
      emotion: emotion['name'] as String,
      emotionIcon: emotion['icon'] as IconData,
      emotionColor: emotion['color'] as Color,
      lesson: lesson,
    );
  }

  Widget _buildInsightsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Psychology Insight',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.psychology_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'You trade best when Patient.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '75% win rate when you wait for setups.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJournalEntry({
    required String symbol,
    required String type,
    required String profit,
    required bool isWin,
    required String date,
    required String emotion,
    required IconData emotionIcon,
    required Color emotionColor,
    required String lesson,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: type == 'BUY'
                          ? AppColors.success.withValues(alpha: 0.1)
                          : AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: type == 'BUY' ? AppColors.success : AppColors.error,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    symbol,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Text(
                profit,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isWin ? AppColors.success : AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(emotionIcon, color: emotionColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Emotion: $emotion',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: emotionColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lesson,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            date,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.neutralGray,
            ),
          ),
        ],
      ),
    );
  }
}
