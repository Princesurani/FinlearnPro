import 'package:flutter/material.dart';

class MarketIndicesSection extends StatelessWidget {
  const MarketIndicesSection({super.key});

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
            padding: const EdgeInsets.only(bottom: 10, left: 2, right: 2),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: const [
              MarketIndexCard(
                name: 'NIFTY 50',
                value: '19,425.35',
                change: '+0.45%',
                isPositive: true,
              ),
              SizedBox(width: 16),
              MarketIndexCard(
                name: 'SENSEX',
                value: '65,344.12',
                change: '-0.12%',
                isPositive: false,
              ),
              SizedBox(width: 16),
              MarketIndexCard(
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

class MarketIndexCard extends StatelessWidget {
  final String name;
  final String value;
  final String change;
  final bool isPositive;

  const MarketIndexCard({
    super.key,
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
