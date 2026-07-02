import 'package:flutter/material.dart';
import '../../../../../core/domain/instrument.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

class FnoTab extends StatelessWidget {
  final Instrument instrument;

  const FnoTab({super.key, required this.instrument});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFuturesSummary(),
          const SizedBox(height: AppSpacing.xl),
          _buildOptionsChainHeader(),
          const SizedBox(height: AppSpacing.md),
          _buildOptionsChain(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildFuturesSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Futures Summary', style: AppTypography.h5),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${instrument.symbol} JUN FUT', style: AppTypography.body.copyWith(fontWeight: FontWeight.bold)),
                      Text('Exp: 27 Jun 2026', style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${instrument.currencySymbol}142.80', style: AppTypography.body.copyWith(fontWeight: FontWeight.bold)),
                      Text('+0.45 (+0.31%)', style: AppTypography.labelSmall.copyWith(color: AppColors.profitGreen)),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Divider(color: AppColors.border),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatColumn('Lot Size', '250'),
                  _buildStatColumn('Premium', '${instrument.currencySymbol}0.70', color: AppColors.profitGreen),
                  _buildStatColumn('OI', '14.2M'),
                  _buildStatColumn('OI Chg', '+2.4%', color: AppColors.profitGreen),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatColumn(String label, String value, {Color? color}) {
    return Column(
      children: [
        Text(label, style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary)),
        const SizedBox(height: 4),
        Text(value, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.bold, color: color ?? AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildOptionsChainHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Option Chain', style: AppTypography.h5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.backgroundPrimary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Text('27 Jun', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
              const Icon(Icons.keyboard_arrow_down, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsChain() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('CALLS', textAlign: TextAlign.center, style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.lossRed))),
                Expanded(flex: 2, child: Text('STRIKE', textAlign: TextAlign.center, style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('PUTS', textAlign: TextAlign.center, style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.profitGreen))),
              ],
            ),
          ),
          // Subheader
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(child: Text('OI(L)', style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary, fontSize: 10))),
                Expanded(child: Text('LTP', textAlign: TextAlign.right, style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary, fontSize: 10))),
                const Expanded(flex: 2, child: SizedBox()), // Center Strike spacing
                Expanded(child: Text('LTP', style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary, fontSize: 10))),
                Expanded(child: Text('OI(L)', textAlign: TextAlign.right, style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary, fontSize: 10))),
              ],
            ),
          ),
          // Rows
          _buildOptionRow('45.2', '12.40', '130', '0.05', '2.1'),
          _buildOptionRow('38.1', '8.90', '135', '0.15', '4.5'),
          _buildOptionRow('52.4', '4.20', '140', '1.20', '28.4'),
          // Center Spot price line
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            color: AppColors.primary.withValues(alpha: 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Spot Price: 142.10', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          _buildOptionRow('22.8', '1.10', '145', '4.60', '32.1', isITMCall: false, isITMPut: true),
          _buildOptionRow('15.4', '0.35', '150', '8.20', '12.5', isITMCall: false, isITMPut: true),
          _buildOptionRow('8.2', '0.10', '155', '12.80', '5.2', isLast: true, isITMCall: false, isITMPut: true),
        ],
      ),
    );
  }

  Widget _buildOptionRow(String callOI, String callLTP, String strike, String putLTP, String putOI, {bool isLast = false, bool isITMCall = true, bool isITMPut = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(callOI, style: AppTypography.bodySmall),
          ),
          Expanded(
            child: Container(
              color: isITMCall ? AppColors.lossRed.withValues(alpha: 0.05) : Colors.transparent,
              child: Text(callLTP, textAlign: TextAlign.right, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.backgroundPrimary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(strike, textAlign: TextAlign.center, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: Container(
              color: isITMPut ? AppColors.profitGreen.withValues(alpha: 0.05) : Colors.transparent,
              child: Text(putLTP, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: Text(putOI, textAlign: TextAlign.right, style: AppTypography.bodySmall),
          ),
        ],
      ),
    );
  }
}
