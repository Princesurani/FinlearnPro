import 'package:finnn/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../pages/daily_challenge_screen.dart';

class StreakBadge extends StatelessWidget {
  const StreakBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DailyChallengeScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ), // Reduced from 12×8
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20), // Slightly smaller radius
          border: Border.all(
            color: AppColors.sunsetOrange.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(
              Icons.local_fire_department_rounded,
              color:
                  AppColors.deepOrange, // Slightly deeper orange for contrast
              size: 18, // Reduced from 20
            ),
            SizedBox(width: 3), // Reduced from 4
            Text(
              '12',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13, // Reduced from 14
                color: AppColors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
