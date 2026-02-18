import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../bloc/market_bloc.dart';
import 'stock_detail_screen.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key, required this.onExplore, required this.state});

  final VoidCallback onExplore;
  final MarketState state;

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final orders = [
      _Order(
        symbol: 'RELIANCE',
        type: _OrderType.buy,
        qty: 10,
        price: 2400,
        status: _OrderStatus.executed,
        time: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      _Order(
        symbol: 'TCS',
        type: _OrderType.buy,
        qty: 5,
        price: 3450,
        status: _OrderStatus.executed,
        time: DateTime.now().subtract(const Duration(days: 1)),
      ),
      _Order(
        symbol: 'INFY',
        type: _OrderType.sell,
        qty: 10,
        price: 1550,
        status: _OrderStatus.pending,
        time: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      _Order(
        symbol: 'HDFCBANK',
        type: _OrderType.buy,
        qty: 20,
        price: 1580,
        status: _OrderStatus.rejected,
        time: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];

    if (orders.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingHorizontal,
        vertical: AppSpacing.lg,
      ),
      itemCount: orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        return _buildOrderItem(context, orders[index]);
      },
    );
  }

  Widget _buildOrderItem(BuildContext context, _Order order) {
    // Attempt to find real instrument
    final instrument = state.tradableInstruments
        .where((i) => i.symbol.contains(order.symbol))
        .firstOrNull;
    final snapshot = instrument != null
        ? state.snapshots[instrument.symbol]
        : null;

    final isBuy = order.type == _OrderType.buy;
    final statusColor = _getStatusColor(order.status);
    final statusLabel = order.status.name.toUpperCase();

    Widget content = Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMD,
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isBuy
                          ? AppColors.profitGreen.withValues(alpha: 0.1)
                          : AppColors.lossRed.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isBuy ? 'BUY' : 'SELL',
                      style: AppTypography.label.copyWith(
                        color: isBuy
                            ? AppColors.profitGreen
                            : AppColors.lossRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    order.symbol,
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  statusLabel,
                  style: AppTypography.label.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOrderStat('Qty', '${order.qty}'),
              _buildOrderStat('Price', '₹${order.price.toStringAsFixed(2)}'),
              _buildOrderStat(
                'Time',
                _formatTime(order.time),
                alignment: CrossAxisAlignment.end,
              ),
            ],
          ),
        ],
      ),
    );

    if (instrument != null) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  StockDetailScreen(instrument: instrument, snapshot: snapshot),
            ),
          );
        },
        child: content,
      );
    }
    return content;
  }

  Widget _buildOrderStat(
    String label,
    String value, {
    CrossAxisAlignment alignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textTertiary,
            fontSize: 11,
          ),
        ),
        Text(
          value,
          style: AppTypography.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.surface, // Used surface as safer default
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.list_alt_rounded,
                size: 48,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No orders yet',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your order history will appear here once you place a trade.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton(
              onPressed: onExplore,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.md,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                elevation: 0,
              ),
              child: const Text('Start Trading'),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(_OrderStatus status) {
    switch (status) {
      case _OrderStatus.executed:
        return AppColors.profitGreen;
      case _OrderStatus.pending:
        return AppColors.primaryPurple;
      case _OrderStatus.rejected:
        return AppColors.lossRed;
      case _OrderStatus.cancelled:
        return AppColors.textSecondary;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

enum _OrderType { buy, sell }

enum _OrderStatus { executed, pending, rejected, cancelled }

class _Order {
  _Order({
    required this.symbol,
    required this.type,
    required this.qty,
    required this.price,
    required this.status,
    required this.time,
  });

  final String symbol;
  final _OrderType type;
  final int qty;
  final double price;
  final _OrderStatus status;
  final DateTime time;
}
