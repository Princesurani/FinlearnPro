import 'package:flutter/material.dart';
import '../../../../../core/domain/instrument.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

class EventsTab extends StatelessWidget {
  final Instrument instrument;

  const EventsTab({super.key, required this.instrument});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: _mockEvents.length + 1,
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Divider(color: AppColors.border, height: 32),
      ),
      itemBuilder: (context, index) {
        if (index == _mockEvents.length) {
          return const SizedBox(height: 100);
        }
        
        final event = _mockEvents[index];
        return _buildEventItem(
          date: event['date']!,
          month: event['month']!,
          title: event['title']!.replaceAll('{symbol}', instrument.symbol),
          description: event['description']!,
          type: event['type']!,
        );
      },
    );
  }

  Widget _buildEventItem({
    required String date,
    required String month,
    required String title,
    required String description,
    required String type,
  }) {
    IconData icon;
    Color iconBg;
    Color iconColor;

    switch (type) {
      case 'Earnings':
        icon = Icons.attach_money_rounded;
        iconBg = AppColors.profitGreen.withOpacity(0.1);
        iconColor = AppColors.profitGreen;
        break;
      case 'Dividend':
        icon = Icons.pie_chart_rounded;
        iconBg = AppColors.electricBlue.withOpacity(0.1);
        iconColor = AppColors.electricBlue;
        break;
      case 'Meeting':
        icon = Icons.people_alt_rounded;
        iconBg = AppColors.amber.withOpacity(0.1);
        iconColor = AppColors.amber;
        break;
      default:
        icon = Icons.event_note_rounded;
        iconBg = AppColors.neutralGray.withOpacity(0.2);
        iconColor = AppColors.textSecondary;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date Column
        Column(
          children: [
            Text(month, style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary, fontWeight: FontWeight.bold)),
            Text(date, style: AppTypography.h4.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(width: AppSpacing.lg),
        
        // Icon
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: AppSpacing.md),
        
        // Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(type, style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary, fontSize: 10)),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                title,
                style: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                description,
                style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static const List<Map<String, String>> _mockEvents = [
    {
      'date': '15',
      'month': 'JUL',
      'title': 'Q2 Earnings Release',
      'description': 'Estimated EPS: \$1.45. Conference call at 5:00 PM EST.',
      'type': 'Earnings',
    },
    {
      'date': '28',
      'month': 'JUL',
      'title': 'Ex-Dividend Date',
      'description': 'Quarterly cash dividend of \$0.45 per share.',
      'type': 'Dividend',
    },
    {
      'date': '10',
      'month': 'AUG',
      'title': 'Annual General Meeting',
      'description': 'Shareholders meeting to discuss annual performance and vote on board members.',
      'type': 'Meeting',
    },
    {
      'date': '12',
      'month': 'OCT',
      'title': 'Q3 Earnings Release',
      'description': 'Estimated EPS: \$1.52. Conference call at 5:00 PM EST.',
      'type': 'Earnings',
    },
    {
      'date': '05',
      'month': 'NOV',
      'title': 'Special Dividend',
      'description': 'Special one-time dividend payout of \$1.00 per share.',
      'type': 'Dividend',
    },
  ];
}
