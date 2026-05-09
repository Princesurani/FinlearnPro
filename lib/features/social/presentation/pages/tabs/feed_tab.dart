import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../bloc/social_bloc.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        if (state.status == SocialStatus.loading && state.feed.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple));
        }

        final feed = state.feed;

        if (feed.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.feed_outlined, size: 64, color: AppColors.white.withValues(alpha: 0.2)),
                const SizedBox(height: 16),
                Text(
                  'No trades to show.',
                  style: TextStyle(color: AppColors.white.withValues(alpha: 0.5), fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Follow traders to see their activity!',
                  style: TextStyle(color: AppColors.white.withValues(alpha: 0.4), fontSize: 14),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          itemCount: feed.length,
          itemBuilder: (context, index) {
            final post = feed[index];
            final isBuy = post.side.toLowerCase() == 'buy';
            final sideColor = isBuy ? AppColors.electricBlue : AppColors.sunsetOrange;

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.white.withValues(alpha: 0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.primaryPurple.withValues(alpha: 0.2),
                        child: Text(
                          post.authorName[0].toUpperCase(),
                          style: const TextStyle(color: AppColors.white, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.authorName,
                              style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Level ${post.authorLevel}',
                              style: TextStyle(color: AppColors.white.withValues(alpha: 0.5), fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _formatTimeAgo(post.createdAt),
                        style: TextStyle(color: AppColors.white.withValues(alpha: 0.4), fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (post.caption != null && post.caption!.isNotEmpty) ...[
                    Text(
                      post.caption!,
                      style: const TextStyle(color: AppColors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                  ],
                  // Trade Card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundPrimary.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: sideColor.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: sideColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            post.side.toUpperCase(),
                            style: TextStyle(color: sideColor, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${post.quantity} ${post.symbol}',
                            style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '@ ₹${post.price.toStringAsFixed(2)}',
                          style: TextStyle(color: AppColors.white.withValues(alpha: 0.7)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
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
                              post.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                              color: post.isLikedByMe ? AppColors.coralPink : AppColors.white.withValues(alpha: 0.5),
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              post.likesCount.toString(),
                              style: TextStyle(color: AppColors.white.withValues(alpha: 0.7)),
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
