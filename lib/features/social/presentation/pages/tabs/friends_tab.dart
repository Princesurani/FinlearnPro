import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../bloc/social_bloc.dart';

class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: AppColors.white.withValues(alpha: 0.5)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: AppColors.white),
                        decoration: InputDecoration(
                          hintText: 'Search traders by name...',
                          hintStyle: TextStyle(color: AppColors.white.withValues(alpha: 0.5)),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                          // Search logic would go here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Search functionality coming soon')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people_outline, size: 64, color: AppColors.white.withValues(alpha: 0.2)),
                      const SizedBox(height: 16),
                      Text(
                        'Connect with Traders',
                        style: TextStyle(color: AppColors.white.withValues(alpha: 0.8), fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Search for friends to see their trades and compare XP.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.white.withValues(alpha: 0.5), fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
