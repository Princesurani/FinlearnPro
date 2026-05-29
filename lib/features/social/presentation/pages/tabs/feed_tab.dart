import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../bloc/social_bloc.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        if (state.isFeedLoading && state.feed.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }

        final feed = state.feed;

        return RefreshIndicator(
          onRefresh: () async {
            final uid = context.read<SocialBloc>().state.myProfile?.firebaseUid ?? '';
            if (uid.isNotEmpty) {
              context.read<SocialBloc>().add(LoadFeed(uid));
              await Future.delayed(const Duration(milliseconds: 500));
            }
          },
          color: AppColors.primary,
          child: CustomScrollView(
            slivers: [
              if (feed.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.electricBlue.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.feed_outlined, size: 48, color: AppColors.electricBlue),
                        ),
                        const SizedBox(height: 20),
                        Text('No trades shared yet', style: AppTypography.h5),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Follow traders to see their activity, or share your own trades from the Markets tab!',
                            textAlign: TextAlign.center,
                            style: AppTypography.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPaddingHorizontal, 20,
                    AppSpacing.screenPaddingHorizontal, 100,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final post = feed[index];
                        final isBuy = post.side.toLowerCase() == 'buy';
                        final sideColor = isBuy ? AppColors.profitGreen : AppColors.lossRed;

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(AppSpacing.cardPaddingCompact),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppSpacing.borderRadiusLG,
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author Row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                        child: Text(
                          post.authorName[0].toUpperCase(),
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.authorName, style: AppTypography.bodyMedium.copyWith(fontSize: 14)),
                            Text('Level ${post.authorLevel}', style: AppTypography.bodyXS),
                          ],
                        ),
                      ),
                      Text(
                        _formatTimeAgo(post.createdAt),
                        style: AppTypography.bodyXS,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Caption
                  if (post.caption != null && post.caption!.isNotEmpty) ...[
                    Text(post.caption!, style: AppTypography.bodySmall.copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 12),
                  ],

                  // Trade Card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundTertiary,
                      borderRadius: AppSpacing.borderRadiusMD,
                      border: Border.all(color: sideColor.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: sideColor.withValues(alpha: 0.12),
                            borderRadius: AppSpacing.borderRadiusXS,
                          ),
                          child: Text(
                            post.side.toUpperCase(),
                            style: AppTypography.labelSmall.copyWith(
                              color: sideColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${post.quantity} ${post.symbol}',
                            style: AppTypography.bodyMedium.copyWith(fontSize: 14),
                          ),
                        ),
                        Text(
                          '@ ₹${post.price.toStringAsFixed(2)}',
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Like button
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final uid = state.myProfile?.firebaseUid ?? '';
                          context.read<SocialBloc>().add(LikePost(uid, post.id, post.isLikedByMe));
                        },
                        child: Row(
                          children: [
                            Icon(
                              post.isLikedByMe ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: post.isLikedByMe ? AppColors.coralPink : AppColors.textTertiary,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              post.likesCount.toString(),
                              style: AppTypography.bodySmall.copyWith(
                                color: post.isLikedByMe ? AppColors.coralPink : AppColors.textSecondary,
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
                      },
                      childCount: feed.length,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  String _formatTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
