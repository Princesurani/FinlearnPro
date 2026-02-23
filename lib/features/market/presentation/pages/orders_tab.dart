import 'package:flutter/material.dart';

import '../../../../core/domain/market_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../bloc/market_bloc.dart';
import 'stock_detail_screen.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({
    super.key,
    required this.onExplore,
    required this.state,
    required this.bloc,
  });

  final VoidCallback onExplore;
  final MarketState state;
  final MarketBloc bloc;

  @override
  Widget build(BuildContext context) {
    // Filter to only orders for the active market
    final orders = state.orders.where((order) {
      return state.tradableInstruments.any((i) => i.symbol == order.symbol);
    }).toList();

    if (orders.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.separated(
      padding: const EdgeInsets.only(
        left: AppSpacing.screenPaddingHorizontal,
        right: AppSpacing.screenPaddingHorizontal,
        top: AppSpacing.lg,
        bottom: 120,
      ),
      itemCount: orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) => _buildOrderItem(context, orders[index]),
    );
  }

  Widget _buildOrderItem(BuildContext context, Order order) {
    final isBuy = order.isBuy;
    final instrument = state.tradableInstruments
        .where((i) => i.symbol == order.symbol)
        .firstOrNull;
    final snapshot = instrument != null
        ? state.snapshots[instrument.symbol]
        : null;

    final statusColor = _statusColor(order.status);

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
                  order.status.toUpperCase(),
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
              _stat('Qty', '${order.quantity}'),
              _stat(
                'Price',
                order.price != null
                    ? '${state.activeMarket.currencySymbol}${order.price!.toStringAsFixed(2)}'
                    : '—',
              ),
              _stat(
                'Total',
                order.price != null
                    ? '${state.activeMarket.currencySymbol}${(order.price! * order.quantity).toStringAsFixed(2)}'
                    : '—',
              ),
              _stat(
                'Time',
                _formatDateTime(order.createdAt),
                align: CrossAxisAlignment.end,
              ),
            ],
          ),
        ],
      ),
    );

    if (instrument != null) {
      return GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => StockDetailScreen(
              instrument: instrument,
              snapshot: snapshot,
              bloc: bloc,
            ),
          ),
        ),
        child: content,
      );
    }
    return content;
  }

  Widget _stat(
    String label,
    String value, {
    CrossAxisAlignment align = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: align,
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
                color: AppColors.backgroundSecondary,
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

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'filled':
        return AppColors.profitGreen;
      case 'pending':
        return AppColors.primaryPurple;
      case 'rejected':
        return AppColors.lossRed;
      default:
        return AppColors.textSecondary;
    }
  }

  String _formatDateTime(DateTime? time) {
    if (time == null) return '—';
    final local = time.toLocal();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    final period = local.hour >= 12 ? 'PM' : 'AM';
    return '${local.day} ${months[local.month - 1]}, $hour:$minute $period';
  }
}
