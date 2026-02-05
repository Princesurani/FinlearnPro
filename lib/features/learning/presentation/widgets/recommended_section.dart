import 'package:flutter/material.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommended Courses',
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
        SizedBox(
          height: 260,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            children: const [
              RecommendedCard(
                title: 'Technical Analysis',
                subtitle: 'Master chart patterns & indicators',
                icon: Icons.candlestick_chart_rounded,
                color: Colors.blueAccent,
                modules: 12,
                chapterCount: 64,
              ),
              SizedBox(width: 20),
              RecommendedCard(
                title: 'Fundamental Analysis',
                subtitle: 'Learn to value companies',
                icon: Icons.pie_chart_rounded,
                color: Colors.green,
                modules: 8,
                chapterCount: 42,
              ),
              SizedBox(width: 20),
              RecommendedCard(
                title: 'Option Trading',
                subtitle: 'Strategies for hedging & profit',
                icon: Icons.graphic_eq_rounded,
                color: Colors.orange,
                modules: 15,
                chapterCount: 89,
              ),
              SizedBox(width: 20),
              RecommendedCard(
                title: 'Personal Finance',
                subtitle: 'Manage your money smartly',
                icon: Icons.savings_rounded,
                color: Colors.purple,
                modules: 10,
                chapterCount: 35,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RecommendedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final int modules;
  final int chapterCount;

  const RecommendedCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.modules,
    required this.chapterCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E1E2C).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E2C),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildBadge(Icons.view_module_rounded, '$modules Modules'),
              const Spacer(),
              _buildBadge(Icons.article_rounded, '$chapterCount Ch'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[400]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
