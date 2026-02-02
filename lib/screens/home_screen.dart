import 'package:flutter/material.dart';
import '../shared/navigation/floating_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // Soft light background
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).padding.top + 20,
              20,
              100, // Bottom padding for floating nav
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TopNavBarPlaceholder(),
                const SizedBox(height: 30),
                const _ProgressTrackerSection(),
                const SizedBox(height: 30),
                const _MarketIndicesSection(),
                const SizedBox(height: 30),
                const _RecommendedSection(),
              ],
            ),
          ),
          // Floating Bottom Navigation Bar
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: const FloatingBottomNavBar(),
          ),
        ],
      ),
    );
  }
}

class _TopNavBarPlaceholder extends StatelessWidget {
  const _TopNavBarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back,',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Prince Surani',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _ProgressTrackerSection extends StatelessWidget {
  const _ProgressTrackerSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B4EF5), Color(0xFF907AF8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B4EF5).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Weekly Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'On Track',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                '65%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              _buildDayIndicator('M', true),
              _buildDayIndicator('T', true),
              _buildDayIndicator('W', true),
              _buildDayIndicator('T', false),
              _buildDayIndicator('F', false),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.65,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayIndicator(String day, bool completed) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: completed ? Colors.white : Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Text(
        day,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: completed ? const Color(0xFF6B4EF5) : Colors.white,
        ),
      ),
    );
  }
}

class _MarketIndicesSection extends StatelessWidget {
  const _MarketIndicesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Market Indices',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140, // Height for the horizontal list
          child: ListView(
            padding: const EdgeInsets.only(
              bottom: 10,
              left: 2,
              right: 2,
            ), // Add padding for shadow
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: const [
              _MarketIndexCard(
                name: 'NIFTY 50',
                value: '19,425.35',
                change: '+0.45%',
                isPositive: true,
              ),
              SizedBox(width: 16),
              _MarketIndexCard(
                name: 'SENSEX',
                value: '65,344.12',
                change: '-0.12%',
                isPositive: false,
              ),
              SizedBox(width: 16),
              _MarketIndexCard(
                name: 'BANK NIFTY',
                value: '44,213.90',
                change: '+1.20%',
                isPositive: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MarketIndexCard extends StatelessWidget {
  final String name;
  final String value;
  final String change;
  final bool isPositive;

  const _MarketIndexCard({
    required this.name,
    required this.value,
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isPositive
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              change,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isPositive ? Colors.green[700] : Colors.red[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendedSection extends StatelessWidget {
  const _RecommendedSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommended for you',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _RecommendedCard(
          title: 'Advanced Trading Strategies',
          subtitle: 'Master technical analysis and chart patterns',
          icon: Icons.candlestick_chart,
          color: Colors.orange[100]!,
          iconColor: Colors.orange[700]!,
        ),
        const SizedBox(height: 16),
        _RecommendedCard(
          title: 'Value Investing 101',
          subtitle: 'Learn how to find undervalued stocks',
          icon: Icons.savings_outlined,
          color: Colors.blue[100]!,
          iconColor: Colors.blue[700]!,
        ),
      ],
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color iconColor;

  const _RecommendedCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
