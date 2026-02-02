import 'package:flutter/material.dart';

class CommunityInsightsSection extends StatelessWidget {
  const CommunityInsightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Community Discussions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('View Forum')),
          ],
        ),
        const SizedBox(height: 10),
        const CommunityPostCard(
          userName: 'Sarah Jenkins',
          userTitle: 'Crypto Analyst',
          title: 'Bitcoin forming a Double Bottom pattern?',
          content:
              'Looking at the 4H chart, we are seeing strong rejection at \$28k support level with increasing volume. If this holds, next target is \$32k.',
          timeAgo: '2h ago',
          likes: 45,
          comments: 12,
          tag: 'Technical Analysis',
          tagColor: Colors.blue,
        ),
        const SizedBox(height: 16),
        const CommunityPostCard(
          userName: 'David Chen',
          userTitle: 'Value Investor',
          title: 'Thoughts on the latest Fed meeting',
          content:
              'The rate hike was expected, but the hawkish tone suggests we might see another 25bps hike. Defensive stocks might be the play here for the next quarter.',
          timeAgo: '5h ago',
          likes: 128,
          comments: 34,
          tag: 'Market Update',
          tagColor: Colors.orange,
        ),
      ],
    );
  }
}

class CommunityPostCard extends StatelessWidget {
  final String userName;
  final String userTitle;
  final String title;
  final String content;
  final String timeAgo;
  final int likes;
  final int comments;
  final String tag;
  final Color tagColor;

  const CommunityPostCard({
    super.key,
    required this.userName,
    required this.userTitle,
    required this.title,
    required this.content,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    required this.tag,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[200],
                backgroundImage: const NetworkImage(
                  'https://i.pravatar.cc/150?u=a042581f4e29026704d',
                ),
                onBackgroundImageError: (_, __) {},
                child: const Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    userTitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                timeAgo,
                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Post Content
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          // Footer / Engagement
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: tagColor,
                  ),
                ),
              ),
              const Spacer(),
              _EngagementItem(
                icon: Icons.thumb_up_alt_outlined,
                count: likes.toString(),
              ),
              const SizedBox(width: 16),
              _EngagementItem(
                icon: Icons.chat_bubble_outline_rounded,
                count: comments.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EngagementItem extends StatelessWidget {
  final IconData icon;
  final String count;

  const _EngagementItem({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[500]),
        const SizedBox(width: 4),
        Text(
          count,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
