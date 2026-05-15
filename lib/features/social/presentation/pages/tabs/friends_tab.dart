import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../bloc/social_bloc.dart';

class FriendsTab extends StatefulWidget {
  const FriendsTab({super.key});

  @override
  State<FriendsTab> createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    context.read<SocialBloc>().add(SearchUsers(query));
  }

  @override
  Widget build(BuildContext context) {
    final myUid = FirebaseAuth.instance.currentUser?.uid ?? '';

    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 20),
            // Search Bar
            Padding(
              padding: AppSpacing.screenPaddingH,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                  color: _isFocused ? AppColors.white : AppColors.surface,
                  borderRadius: AppSpacing.borderRadiusXL,
                  border: Border.all(
                    color: _isFocused
                        ? AppColors.primary.withValues(alpha: 0.5)
                        : AppColors.border,
                    width: _isFocused ? 1.5 : 1,
                  ),
                  boxShadow: _isFocused
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _isFocused
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : AppColors.backgroundTertiary,
                        borderRadius: AppSpacing.borderRadiusSM,
                      ),
                      child: Icon(
                        Icons.search_rounded,
                        color: _isFocused ? AppColors.primary : AppColors.textTertiary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        focusNode: _focusNode,
                        style: AppTypography.body.copyWith(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'Search traders by name...',
                          hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          isDense: true,
                        ),
                        onChanged: (value) {
                          setState(() {});
                          _onSearch(value);
                        },
                        onSubmitted: _onSearch,
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() {});
                          _onSearch('');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.textTertiary.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close_rounded, size: 14, color: AppColors.textSecondary),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Results or Empty State
            Expanded(
              child: _buildContent(state, myUid),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent(SocialState state, String myUid) {
    if (state.isSearching) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    if (_searchController.text.isNotEmpty && state.searchResults.isNotEmpty) {
      return _buildUserList(state.searchResults, myUid, state);
    }

    if (_searchController.text.isNotEmpty && state.searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 48, color: AppColors.textDisabled),
            const SizedBox(height: 16),
            Text('No traders found', style: AppTypography.bodySmall),
            const SizedBox(height: 4),
            Text('Try a different name', style: AppTypography.bodyXS),
          ],
        ),
      );
    }

    // Default state: Show Friends List if not empty
    if (state.friendsList.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenPaddingHorizontal, 10, AppSpacing.screenPaddingHorizontal, 10),
            child: Row(
              children: [
                Text('My Friends', style: AppTypography.h5),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: AppSpacing.borderRadiusFull,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    '${state.friendsList.length} ${state.friendsList.length == 1 ? 'Friend' : 'Friends'}',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildUserList(state.friendsList, myUid, state),
          ),
        ],
      );
    }

    // Default empty state
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.people_outline_rounded, size: 48, color: AppColors.primary),
          ),
          const SizedBox(height: 20),
          Text('Connect with Traders', style: AppTypography.h5),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Search for friends to compare XP, and climb the leaderboard together.',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList(List users, String myUid, SocialState state) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPaddingHorizontal, 0,
        AppSpacing.screenPaddingHorizontal, 100,
      ),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final isMe = user.firebaseUid == myUid;
        final isFollowing = state.following.contains(user.firebaseUid);

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppSpacing.borderRadiusLG,
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: Text(
                  user.displayName[0].toUpperCase(),
                  style: AppTypography.labelLarge.copyWith(color: AppColors.primary),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.displayName, style: AppTypography.bodyMedium),
                    Row(
                      children: [
                        Text('Lvl ${user.level}', style: AppTypography.bodyXS),
                        const SizedBox(width: 8),
                        Text('${user.totalXp} XP', style: AppTypography.bodyXS.copyWith(color: AppColors.primary)),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isMe)
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    if (isFollowing) {
                      context.read<SocialBloc>().add(UnfollowUser(myUid, user.firebaseUid));
                    } else {
                      context.read<SocialBloc>().add(FollowUser(myUid, user.firebaseUid));
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isFollowing ? AppColors.surface : AppColors.primary,
                      borderRadius: AppSpacing.borderRadiusFull,
                      border: Border.all(
                        color: isFollowing
                            ? AppColors.textTertiary.withValues(alpha: 0.4)
                            : AppColors.primary,
                      ),
                    ),
                    child: Text(
                      isFollowing ? 'Unfriend' : 'Add Friend',
                      style: AppTypography.labelSmall.copyWith(
                        color: isFollowing ? AppColors.textSecondary : AppColors.white,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
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
