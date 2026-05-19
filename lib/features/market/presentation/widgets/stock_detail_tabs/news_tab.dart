import 'package:flutter/material.dart';
import '../../../../../core/domain/instrument.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

class NewsTab extends StatelessWidget {
  final Instrument instrument;

  const NewsTab({super.key, required this.instrument});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: _mockNews.length + 1,
      separatorBuilder: (context, index) => const Divider(color: AppColors.border, height: 32),
      itemBuilder: (context, index) {
        if (index == _mockNews.length) {
          return const SizedBox(height: 100); // Bottom padding
        }
        
        final news = _mockNews[index];
        return _buildNewsItem(
          headline: news['headline']!.replaceAll('{symbol}', instrument.symbol),
          source: news['source']!,
          time: news['time']!,
          impact: news['impact']!,
        );
      },
    );
  }

  Widget _buildNewsItem({
    required String headline,
    required String source,
    required String time,
    required String impact,
  }) {
    Color impactColor;
    Color impactBg;
    
    switch (impact) {
      case 'Positive':
        impactColor = AppColors.profitGreen;
        impactBg = AppColors.profitGreen.withOpacity(0.1);
        break;
      case 'Negative':
        impactColor = AppColors.lossRed;
        impactBg = AppColors.lossRed.withOpacity(0.1);
        break;
      default:
        impactColor = AppColors.textSecondary;
        impactBg = AppColors.neutralGray.withOpacity(0.2);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.article_outlined, size: 16, color: AppColors.textTertiary),
                const SizedBox(width: 4),
                Text(source, style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Text('• $time', style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: impactBg,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(impact, style: AppTypography.labelSmall.copyWith(color: impactColor, fontWeight: FontWeight.bold, fontSize: 10)),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          headline,
          style: AppTypography.body.copyWith(fontWeight: FontWeight.w600, height: 1.4),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Text('Read More', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward_ios, size: 10, color: AppColors.primary),
          ],
        ),
      ],
    );
  }

  static const List<Map<String, String>> _mockNews = [
    {
      'headline': '{symbol} announces strong Q3 results, beats street estimates by 15%',
      'source': 'Financial Times',
      'time': '2 hours ago',
      'impact': 'Positive',
    },
    {
      'headline': 'Global market sentiment impacts {symbol} opening trades despite strong fundamentals',
      'source': 'Bloomberg',
      'time': '5 hours ago',
      'impact': 'Negative',
    },
    {
      'headline': '{symbol} Board of Directors to meet next week to discuss potential dividend payout',
      'source': 'Reuters',
      'time': '1 day ago',
      'impact': 'Positive',
    },
    {
      'headline': 'Sector rotation pushes investors towards {symbol} competitors',
      'source': 'Wall Street Journal',
      'time': '2 days ago',
      'impact': 'Negative',
    },
    {
      'headline': 'New regulatory filings show increased institutional holding in {symbol}',
      'source': 'CNBC',
      'time': '3 days ago',
      'impact': 'Positive',
    },
    {
      'headline': '{symbol} launches new product line, expects 20% YoY revenue growth',
      'source': 'TechCrunch',
      'time': '4 days ago',
      'impact': 'Positive',
    },
    {
      'headline': 'Market outlook: Technical analysis shows {symbol} entering consolidation phase',
      'source': 'Seeking Alpha',
      'time': '1 week ago',
      'impact': 'Neutral',
    },
  ];
}
