import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/market_formatters.dart';
import '../../../../shared/navigation/top_navigation_shell.dart';
import '../../../market/bloc/market_bloc.dart';
import '../../../../core/domain/market_regime.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  late final MarketBloc _bloc;
  final MarketFormatter _formatter = MarketFormatterFactory.forMarket(
    MarketRegime.india,
  );

  static const Map<String, int> _mockHoldings = {
    'RELIANCE': 15,
    'TCS': 2,
    'HDFCBANK': 10,
    'INFY': 20,
  };

  static const Map<String, double> _averageBuyPrices = {
    'RELIANCE': 2500.0,
    'TCS': 3750.0,
    'HDFCBANK': 1620.0,
    'INFY': 1480.0,
  };

  @override
  void initState() {
    super.initState();
    _bloc = MarketBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: StreamBuilder<MarketState>(
        stream: _bloc.stream,
        initialData: _bloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data!;
          final snaps = state.snapshots;

          double totalInvested = 0;
          double currentTotalValue = 0;

          // Compute Portfolio value
          for (final entry in _mockHoldings.entries) {
            final symbol = entry.key;
            final qty = entry.value;
            final avgPrice = _averageBuyPrices[symbol] ?? 0.0;

            final currentPrice = snaps[symbol]?.price ?? avgPrice;

            totalInvested += avgPrice * qty;
            currentTotalValue += currentPrice * qty;
          }

          final totalReturns = currentTotalValue - totalInvested;
          final totalReturnsPercent = totalInvested > 0
              ? (totalReturns / totalInvested) * 100
              : 0.0;
          final isPositive = totalReturns >= 0;

          return SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.paddingOf(context).top + 12,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopNavigationShell(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Your wealth,', // Shortened from 'Track wealth,'
                        style: TextStyle(
                          fontSize: 11, // Standardized across all pages
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                        ),
                      ),
                      const SizedBox(height: 1),
                      const Text(
                        'Portfolio', // Shortened from 'My Portfolio'
                        style: TextStyle(
                          fontSize: 16, // Standardized across all pages
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TopBarButton(
                      icon: Icons.visibility_off_outlined,
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    TopBarButton(icon: Icons.settings_outlined, onTap: () {}),
                  ],
                ),
                const SizedBox(height: 20),
                // Stub content for now
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Value',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.neutralGray,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatter.formatPrice(currentTotalValue),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _buildStat(
                            'Invested',
                            _formatter.formatPrice(totalInvested),
                          ),
                          const SizedBox(width: 20),
                          _buildStat(
                            'Returns',
                            '${isPositive ? '+' : ''}${_formatter.formatPrice(totalReturns)} (${totalReturnsPercent.toStringAsFixed(2)}%)',
                            isPositive: isPositive,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Holdings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                ..._mockHoldings.entries.map((entry) {
                  final symbol = entry.key;
                  final qty = entry.value;
                  final avgPrice = _averageBuyPrices[symbol] ?? 0.0;
                  final currentPrice = snaps[symbol]?.price ?? avgPrice;
                  final invested = avgPrice * qty;
                  final currentValue = currentPrice * qty;
                  final returnAmt = currentValue - invested;
                  final returnPct = invested > 0
                      ? (returnAmt / invested) * 100
                      : 0.0;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              symbol,
                              style: AppTypography.bodySmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$qty shares • Avg ${_formatter.formatPrice(avgPrice)}',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _formatter.formatPrice(currentValue),
                              style: AppTypography.bodySmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${returnAmt >= 0 ? '+' : ''}${_formatter.formatPrice(returnAmt)} (${returnPct.toStringAsFixed(2)}%)',
                              style: AppTypography.labelSmall.copyWith(
                                color: returnAmt >= 0
                                    ? AppColors.profitGreen
                                    : AppColors.lossRed,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStat(String label, String value, {bool isPositive = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isPositive ? AppColors.success : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
