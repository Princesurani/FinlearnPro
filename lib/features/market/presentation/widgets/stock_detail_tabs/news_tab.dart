import 'package:flutter/material.dart';
import '../../../../../core/domain/instrument.dart';
import '../../../../../core/services/api_market_service.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

class NewsTab extends StatefulWidget {
  final Instrument instrument;

  const NewsTab({super.key, required this.instrument});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  final ApiMarketService _marketService = ApiMarketService();
  List<dynamic> _newsEvents = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    try {
      final news = await _marketService.getNews(symbol: widget.instrument.symbol);
      if (mounted) {
        setState(() {
          _newsEvents = news;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  String _formatRelativeTime(String timestampStr) {
    try {
      final timestamp = DateTime.parse(timestampStr).toLocal();
      final diff = DateTime.now().difference(timestamp);
      if (diff.inMinutes < 1) return 'just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      return '${diff.inDays}d ago';
    } catch (_) {
      return 'recently';
    }
  }

  String _getDeterministicSource(String category, int index) {
    if (category == 'macro_economic') {
      return index % 2 == 0 ? 'Bloomberg' : 'Financial Times';
    } else if (category == 'company_specific') {
      return index % 2 == 0 ? 'Reuters' : 'CNBC';
    } else {
      return 'Wall Street Journal';
    }
  }

  String _getImpactLabel(double impact) {
    if (impact > 0.005) {
      return 'Positive';
    } else if (impact < -0.005) {
      return 'Negative';
    }
    return 'Neutral';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text(
            'Failed to load news. Please try again.',
            style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_newsEvents.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.newspaper_rounded, size: 48, color: AppColors.textDisabled),
              const SizedBox(height: 12),
              Text(
                'No recent news for ${widget.instrument.symbol}',
                style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: _newsEvents.length + 1,
      separatorBuilder: (context, index) => const Divider(color: AppColors.border, height: 32),
      itemBuilder: (context, index) {
        if (index == _newsEvents.length) {
          return const SizedBox(height: 100); // Bottom padding
        }

        final event = _newsEvents[index] as Map<String, dynamic>;
        final headline = event['headline'] as String? ?? '';
        final category = event['category'] as String? ?? '';
        final timestamp = event['timestamp'] as String? ?? '';
        final impactVal = (event['impact'] as num? ?? 0.0).toDouble();

        final source = _getDeterministicSource(category, index);
        final timeStr = _formatRelativeTime(timestamp);
        final impactStr = _getImpactLabel(impactVal);

        return _buildNewsItem(
          headline: headline,
          source: source,
          time: timeStr,
          impact: impactStr,
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
        impactBg = AppColors.profitGreen.withValues(alpha: 0.1);
        break;
      case 'Negative':
        impactColor = AppColors.lossRed;
        impactBg = AppColors.lossRed.withValues(alpha: 0.1);
        break;
      default:
        impactColor = AppColors.textSecondary;
        impactBg = AppColors.neutralGray.withValues(alpha: 0.2);
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
                Text(
                  source,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
              child: Text(
                impact,
                style: AppTypography.labelSmall.copyWith(
                  color: impactColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
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
            Text(
              'Read More',
              style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward_ios, size: 10, color: AppColors.primary),
          ],
        ),
      ],
    );
  }
}
