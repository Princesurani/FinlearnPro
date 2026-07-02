import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/services/api_market_service.dart';

class AiReviewSheet extends StatefulWidget {
  const AiReviewSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => const AiReviewSheet(),
    );
  }

  @override
  State<AiReviewSheet> createState() => _AiReviewSheetState();
}

class _AiReviewSheetState extends State<AiReviewSheet> with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  String? _error;
  Map<String, dynamic>? _reviewData;
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _fetchReview();
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  Future<void> _fetchReview() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception("User not logged in");
      
      final data = await ApiMarketService().getPortfolioReview(uid);
      if (mounted) {
        setState(() {
          _reviewData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildScoreGauge(int score) {
    Color color = AppColors.lossRed;
    if (score >= 75) {
      color = AppColors.profitGreen;
    } else if (score >= 50) {
      color = AppColors.warning;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: score.toDouble()),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 130,
              height: 130,
              child: CircularProgressIndicator(
                value: value / 100,
                strokeWidth: 10,
                backgroundColor: color.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                strokeCap: StrokeCap.round,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value.toInt().toString(),
                  style: AppTypography.h1.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                Text(
                  'SCORE',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md, top: AppSpacing.md),
      child: Text(
        title,
        style: AppTypography.h3.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildList(List<dynamic> items, Color cardColor, IconData icon) {
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Text("None identified.", style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
      );
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: cardColor.withValues(alpha: 0.05),
            border: Border.all(color: cardColor.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: cardColor, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  item.toString(),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 16),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: [
                    AnimatedBuilder(
                      animation: _glowController,
                      builder: (context, child) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.electricBlue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.2 + (_glowController.value * 0.4)),
                                blurRadius: 10 + (_glowController.value * 15),
                                spreadRadius: 2 + (_glowController.value * 5),
                              )
                            ]
                          ),
                          child: const Icon(Icons.auto_awesome, color: AppColors.white, size: 22),
                        );
                      }
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [AppColors.primary, AppColors.electricBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        'AI Portfolio Review',
                        style: AppTypography.h2.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Divider(height: 1, color: AppColors.border),
              
              // Content
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                    : _error != null
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.xl),
                              child: Text(
                                'Error generating review: $_error',
                                style: AppTypography.body.copyWith(color: AppColors.lossRed),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : ListView(
                            controller: controller,
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            children: [
                              Center(child: _buildScoreGauge(_reviewData!['overall_score'] ?? 0)),
                              const SizedBox(height: AppSpacing.xl),
                              
                              Container(
                                padding: const EdgeInsets.all(AppSpacing.lg),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceVariant,
                                  borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.format_quote_rounded, color: AppColors.textTertiary, size: 24),
                                    const SizedBox(height: AppSpacing.sm),
                                    Text(
                                      _reviewData!['summary'] ?? '',
                                      style: GoogleFonts.lora(
                                        color: AppColors.textPrimary,
                                        height: 1.5,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xl),
                              
                              _buildSectionTitle('Strengths'),
                              _buildList(_reviewData!['strengths'] ?? [], AppColors.profitGreen, Icons.check_circle_outline),
                              
                              _buildSectionTitle('Risk Factors'),
                              _buildList(_reviewData!['weaknesses'] ?? [], AppColors.lossRed, Icons.warning_amber_rounded),
                              
                              _buildSectionTitle('Recommendations'),
                              _buildList(_reviewData!['recommendations'] ?? [], AppColors.primary, Icons.lightbulb_outline),
                              const SizedBox(height: AppSpacing.xl),
                            ],
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}
