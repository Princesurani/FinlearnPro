import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/navigation/top_navigation_shell.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 12,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopNavigationShell(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Your wealth,', // Shortened from 'Track wealth,'
                    style: TextStyle(
                      fontSize: 11, // Standardized across all pages
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    'Portfolio', // Shortened from 'My Portfolio'
                    style: TextStyle(
                      fontSize: 16, // Standardized across all pages
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
              actions: [
                TopBarButton(icon: Icons.visibility_off_outlined, onTap: () {}),
                const SizedBox(width: 12),
                TopBarButton(icon: Icons.settings_outlined, onTap: () {}),
              ],
            ),
            const SizedBox(height: 20),
            // Stub content for now
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Value',
                    style: TextStyle(fontSize: 16, color: AppColors.neutralGray),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$12,450.00',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildStat('Invested', '\$10,000.00'),
                      const SizedBox(width: 20),
                      _buildStat(
                        'Returns',
                        '+\$2,450 (24.5%)',
                        isPositive: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Holdings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            const Center(child: Text('coming soon...')),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, {bool isPositive = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isPositive ? AppColors.success : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
