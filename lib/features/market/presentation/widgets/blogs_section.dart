import 'package:flutter/material.dart';

class BlogsSection extends StatelessWidget {
  const BlogsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Market Blogs',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E2C),
                letterSpacing: -0.5,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('View All')),
          ],
        ),
        const SizedBox(height: 16),
        const BlogCard(
          authorName: 'Warren Buffet Fan',
          authorTitle: 'Value Investor',
          blogTitle: 'Why the current dip is a buying opportunity',
          blogPreview:
              'History shows that market corrections are the best time to accumulate quality assets. Here is my analysis of the top 3 undervalued stocks right now...',
          readTime: '5 min read',
          likes: '1.2k',
          category: 'Strategy',
          categoryColor: Colors.blue,
        ),
        const SizedBox(height: 16),
        const BlogCard(
          authorName: 'Sarah Tradez',
          authorTitle: 'Technical Analyst',
          blogTitle: 'Nifty 50: Key levels to watch this week',
          blogPreview:
              'The market is approaching a critical resistance zone. If we break above 22,000, we could see a massive rally. Let talk about the charts...',
          readTime: '3 min read',
          likes: '856',
          category: 'Updates',
          categoryColor: Colors.orange,
        ),
        const SizedBox(height: 16),
        const BlogCard(
          authorName: 'Crypto King',
          authorTitle: 'Blockchain Expert',
          blogTitle: 'Is the Bitcoin halving already priced in?',
          blogPreview:
              'With the halving event just around the corner, miners are accumulating. Does this mean we will see a supply shock soon?',
          readTime: '6 min read',
          likes: '2.4k',
          category: 'Crypto',
          categoryColor: Colors.purple,
        ),
      ],
    );
  }
}

class BlogCard extends StatelessWidget {
  final String authorName;
  final String authorTitle;
  final String blogTitle;
  final String blogPreview;
  final String readTime;
  final String likes;
  final String category;
  final Color categoryColor;

  const BlogCard({
    super.key,
    required this.authorName,
    required this.authorTitle,
    required this.blogTitle,
    required this.blogPreview,
    required this.readTime,
    required this.likes,
    required this.category,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E1E2C).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: categoryColor.withValues(alpha: 0.1),
                child: Text(
                  authorName[0],
                  style: TextStyle(
                    color: categoryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF1E1E2C),
                    ),
                  ),
                  Text(
                    authorTitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: categoryColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            blogTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E2C),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            blogPreview,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 16,
                color: Colors.grey[400],
              ),
              const SizedBox(width: 4),
              Text(
                readTime,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
              const Spacer(),
              Icon(Icons.favorite_rounded, size: 16, color: Colors.red[300]),
              const SizedBox(width: 4),
              Text(
                likes,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
