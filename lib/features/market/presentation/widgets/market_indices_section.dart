import 'package:flutter/material.dart';
import '../../data/market_data.dart';
import '../pages/market_detail_screen.dart';

class MarketIndicesSection extends StatelessWidget {
  const MarketIndicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the dummy data
    final indices = MarketData.indices;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Market Indices',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward, color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 140, // Height for the horizontal list
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 10, left: 2, right: 2),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: indices.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final instrument = indices[index];
              return MarketIndexCard(
                instrument: instrument,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MarketDetailScreen(instrument: instrument),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class MarketIndexCard extends StatelessWidget {
  final MarketInstrument instrument;
  final VoidCallback onTap;

  const MarketIndexCard({
    super.key,
    required this.instrument,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              instrument.symbol,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              '₹${instrument.price}',
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
                color: instrument.isPositive
                    ? const Color(0xFFE8F5E9)
                    : const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${instrument.isPositive ? "+" : ""}${instrument.changePercentage}%',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: instrument.isPositive
                      ? Colors.green[700]
                      : Colors.red[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
