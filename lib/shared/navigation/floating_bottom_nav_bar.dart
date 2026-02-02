import 'package:flutter/material.dart';

class FloatingBottomNavBar extends StatelessWidget {
  const FloatingBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_rounded, true),
          _buildNavItem(Icons.analytics_outlined, false),
          _buildNavItem(Icons.book_outlined, false),
          _buildNavItem(Icons.person_outline, false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            )
          : null,
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.grey[500],
        size: 24,
      ),
    );
  }
}
