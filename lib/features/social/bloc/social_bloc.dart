import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/models/user_profile.dart';
import '../data/models/leaderboard_entry.dart';
import '../data/models/trade_share_post.dart';
import '../data/repositories/social_repository.dart';

// ─── Events ─────────────────────────────────────────────────────────────────

abstract class SocialEvent {}

class LoadProfile extends SocialEvent {
  final String uid;
  LoadProfile(this.uid);
}

class LoadLeaderboard extends SocialEvent {
  final String type;
  final String period;
  LoadLeaderboard({this.type = 'xp', this.period = 'allTime'});
}

class LoadFeed extends SocialEvent {
  final String uid;
  LoadFeed(this.uid);
}

class LikePost extends SocialEvent {
  final String uid;
  final int shareId;
  final bool isCurrentlyLiked;
  LikePost(this.uid, this.shareId, this.isCurrentlyLiked);
}

class SearchUsers extends SocialEvent {
  final String query;
  SearchUsers(this.query);
}

class FollowUser extends SocialEvent {
  final String myUid;
  final String targetUid;
  FollowUser(this.myUid, this.targetUid);
}

class UnfollowUser extends SocialEvent {
  final String myUid;
  final String targetUid;
  UnfollowUser(this.myUid, this.targetUid);
}

class UpdateProfile extends SocialEvent {
  final String uid;
  final String? username;
  final String? bio;
  UpdateProfile(this.uid, {this.username, this.bio});
}

// ─── State ──────────────────────────────────────────────────────────────────

/// Keep the old enum for backward compatibility with existing BlocBuilder checks.
enum SocialStatus { initial, loading, loaded, error }

class SocialState {
  final SocialStatus status;

  /// Independent loading flags — prevents races between profile/leaderboard/feed.
  final bool isProfileLoading;
  final bool isLeaderboardLoading;
  final bool isFeedLoading;

  final UserProfile? myProfile;
  final List<LeaderboardEntry> leaderboard;
  final List<TradeSharePost> feed;
  final Set<String> following;
  final String leaderboardType;
  final String leaderboardPeriod;
  final String? errorMessage;
  final List<LeaderboardEntry> searchResults;
  final bool isSearching;
  final int followersCount;
  final int followingCount;
  final List<LeaderboardEntry> friendsList;

  SocialState({
    this.status = SocialStatus.initial,
    this.isProfileLoading = false,
    this.isLeaderboardLoading = false,
    this.isFeedLoading = false,
    this.myProfile,
    this.leaderboard = const [],
    this.feed = const [],
    this.following = const {},
    this.leaderboardType = 'xp',
    this.leaderboardPeriod = 'allTime',
    this.errorMessage,
    this.searchResults = const [],
    this.isSearching = false,
    this.followersCount = 0,
    this.followingCount = 0,
    this.friendsList = const [],
  });

  SocialState copyWith({
    SocialStatus? status,
    bool? isProfileLoading,
    bool? isLeaderboardLoading,
    bool? isFeedLoading,
    UserProfile? myProfile,
    List<LeaderboardEntry>? leaderboard,
    List<TradeSharePost>? feed,
    Set<String>? following,
    String? leaderboardType,
    String? leaderboardPeriod,
    String? errorMessage,
    List<LeaderboardEntry>? searchResults,
    bool? isSearching,
    int? followersCount,
    int? followingCount,
    List<LeaderboardEntry>? friendsList,
  }) {
    return SocialState(
      status: status ?? this.status,
      isProfileLoading: isProfileLoading ?? this.isProfileLoading,
      isLeaderboardLoading: isLeaderboardLoading ?? this.isLeaderboardLoading,
      isFeedLoading: isFeedLoading ?? this.isFeedLoading,
      myProfile: myProfile ?? this.myProfile,
      leaderboard: leaderboard ?? this.leaderboard,
      feed: feed ?? this.feed,
      following: following ?? this.following,
      leaderboardType: leaderboardType ?? this.leaderboardType,
      leaderboardPeriod: leaderboardPeriod ?? this.leaderboardPeriod,
      errorMessage: errorMessage,
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      friendsList: friendsList ?? this.friendsList,
    );
  }
}

// ─── Helpers ────────────────────────────────────────────────────────────────

/// Returns the best available username for the current Firebase user.
/// Falls back in order: Firebase displayName → email prefix → 'Trader'.
String _resolveUsername() {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return 'Trader';

  final dn = user.displayName;
  if (dn != null && dn.isNotEmpty && !_isDummyName(dn)) return dn;

  final email = user.email;
  if (email != null && email.contains('@')) return email.split('@').first;

  return 'Trader';
}

/// Whether the name is an auto-generated placeholder.
bool _isDummyName(String name) =>
    name == 'Trader' || name.startsWith('Trader_');

// ─── Bloc ───────────────────────────────────────────────────────────────────

class SocialBloc extends Bloc<SocialEvent, SocialState> {
  final SocialRepository repository;

  SocialBloc({required this.repository}) : super(SocialState()) {
    on<LoadProfile>(_onLoadProfile);
    on<LoadLeaderboard>(_onLoadLeaderboard);
    on<LoadFeed>(_onLoadFeed);
    on<LikePost>(_onLikePost);
    on<SearchUsers>(_onSearchUsers);
    on<FollowUser>(_onFollowUser);
    on<UnfollowUser>(_onUnfollowUser);
    on<UpdateProfile>(_onUpdateProfile);
  }

  // ── Profile ─────────────────────────────────────────────────────────────

  Future<void> _onLoadProfile(LoadProfile event, Emitter<SocialState> emit) async {
    emit(state.copyWith(isProfileLoading: true, status: SocialStatus.loading));
    try {
      final profile = await repository.getProfile(event.uid);

      // If the backend has a dummy name, sync a real name from Firebase Auth.
      UserProfile finalProfile = profile;
      if (_isDummyName(profile.username)) {
        final realName = _resolveUsername();
        if (!_isDummyName(realName)) {
          // Fire-and-forget: push to backend + update Firebase Auth
          repository.updateProfile(event.uid, username: realName).catchError((_) => profile);
          FirebaseAuth.instance.currentUser?.updateDisplayName(realName).catchError((_) {});
          finalProfile = profile.copyWith(username: realName);
        }
      }

      // Fetch social graph (non-critical — silently ignore errors)
      Set<String> followingSet = {};
      int followersCount = 0;
      int followingCount = 0;
      List<LeaderboardEntry> friends = [];
      try {
        final followersData = await repository.getFollowers(event.uid);
        followingSet = Set.from(followersData['following'] ?? []);
        followersCount = (followersData['followers'] ?? []).length;
        followingCount = followingSet.length;
        friends = await repository.getFriends(event.uid);
      } catch (_) {}

      emit(state.copyWith(
        status: SocialStatus.loaded,
        isProfileLoading: false,
        myProfile: finalProfile,
        following: followingSet,
        followersCount: followersCount,
        followingCount: followingCount,
        friendsList: friends,
      ));
    } catch (_) {
      // Backend unreachable — build a local profile from Firebase Auth
      emit(state.copyWith(
        status: SocialStatus.loaded,
        isProfileLoading: false,
        myProfile: UserProfile(
          firebaseUid: event.uid,
          username: _resolveUsername(),
          avatarUrl: FirebaseAuth.instance.currentUser?.photoURL,
          bio: null,
          totalXp: 0,
          weeklyXp: 0,
          level: 1,
          currentStreak: 0,
          longestStreak: 0,
          totalTrades: 0,
          totalCoursesCompleted: 0,
          totalChallengesCompleted: 0,
          winRate: 0.0,
          lastActivityDate: null,
        ),
      ));
    }
  }

  // ── Leaderboard ─────────────────────────────────────────────────────────

  Future<void> _onLoadLeaderboard(LoadLeaderboard event, Emitter<SocialState> emit) async {
    emit(state.copyWith(
      isLeaderboardLoading: true,
      leaderboardType: event.type,
      leaderboardPeriod: event.period,
    ));
    try {
      final leaderboard = await repository.getLeaderboard(
        type: event.type,
        period: event.period,
      );

      // Fix the current user's name in the leaderboard if the backend still
      // has a dummy Trader_xxx. We already know the correct name locally.
      final myUid = FirebaseAuth.instance.currentUser?.uid;
      final correctedName = _resolveUsername();
      final correctedLeaderboard = leaderboard.map((entry) {
        if (entry.firebaseUid == myUid && _isDummyName(entry.username) && !_isDummyName(correctedName)) {
          return LeaderboardEntry(
            firebaseUid: entry.firebaseUid,
            username: correctedName,
            avatarUrl: entry.avatarUrl,
            level: entry.level,
            totalXp: entry.totalXp,
            weeklyXp: entry.weeklyXp,
            currentStreak: entry.currentStreak,
            totalTrades: entry.totalTrades,
            winRate: entry.winRate,
            rank: entry.rank,
          );
        }
        return entry;
      }).toList();

      emit(state.copyWith(
        status: SocialStatus.loaded,
        isLeaderboardLoading: false,
        leaderboard: correctedLeaderboard,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SocialStatus.loaded,
        isLeaderboardLoading: false,
        leaderboard: [],
      ));
    }
  }

  // ── Feed ─────────────────────────────────────────────────────────────────

  Future<void> _onLoadFeed(LoadFeed event, Emitter<SocialState> emit) async {
    emit(state.copyWith(isFeedLoading: true));
    try {
      final feed = await repository.getFeed(event.uid);
      emit(state.copyWith(status: SocialStatus.loaded, isFeedLoading: false, feed: feed));
    } catch (e) {
      emit(state.copyWith(status: SocialStatus.loaded, isFeedLoading: false, feed: []));
    }
  }

  // ── Search ───────────────────────────────────────────────────────────────

  Future<void> _onSearchUsers(SearchUsers event, Emitter<SocialState> emit) async {
    if (event.query.trim().isEmpty) {
      emit(state.copyWith(searchResults: [], isSearching: false));
      return;
    }
    emit(state.copyWith(isSearching: true));
    try {
      final results = await repository.searchUsers(event.query);
      emit(state.copyWith(searchResults: results, isSearching: false));
    } catch (e) {
      emit(state.copyWith(searchResults: [], isSearching: false));
    }
  }

  // ── Follow / Unfollow ────────────────────────────────────────────────────

  Future<void> _onFollowUser(FollowUser event, Emitter<SocialState> emit) async {
    final newFollowing = Set<String>.from(state.following)..add(event.targetUid);
    final newFriends = List<LeaderboardEntry>.from(state.friendsList);
    // Optimistically add to friendsList if available in searchResults
    try {
      final user = state.searchResults.firstWhere((u) => u.firebaseUid == event.targetUid);
      if (!newFriends.any((f) => f.firebaseUid == event.targetUid)) {
        newFriends.add(user);
      }
    } catch (_) {}

    emit(state.copyWith(
      following: newFollowing,
      followingCount: newFollowing.length,
      friendsList: newFriends,
    ));
    try {
      await repository.followUser(event.myUid, event.targetUid);
    } catch (e) {
      // Revert
      final reverted = Set<String>.from(state.following)..remove(event.targetUid);
      newFriends.removeWhere((f) => f.firebaseUid == event.targetUid);
      emit(state.copyWith(following: reverted, followingCount: reverted.length, friendsList: newFriends));
    }
  }

  Future<void> _onUnfollowUser(UnfollowUser event, Emitter<SocialState> emit) async {
    // Optimistic update
    final newFollowing = Set<String>.from(state.following)..remove(event.targetUid);
    final newFriends = List<LeaderboardEntry>.from(state.friendsList)
      ..removeWhere((f) => f.firebaseUid == event.targetUid);
      
    emit(state.copyWith(
      following: newFollowing,
      followingCount: newFollowing.length,
      friendsList: newFriends,
    ));
    try {
      await repository.unfollowUser(event.myUid, event.targetUid);
    } catch (e) {
      // Revert
      final reverted = Set<String>.from(state.following)..add(event.targetUid);
      emit(state.copyWith(following: reverted, followingCount: reverted.length));
    }
  }

  // ── Update Profile ───────────────────────────────────────────────────────

  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<SocialState> emit) async {
    try {
      final updated = await repository.updateProfile(
        event.uid,
        username: event.username,
        bio: event.bio,
      );
      emit(state.copyWith(myProfile: updated));
    } catch (_) {}
  }

  // ── Like / Unlike ────────────────────────────────────────────────────────

  Future<void> _onLikePost(LikePost event, Emitter<SocialState> emit) async {
    // Optimistic UI update
    final newFeed = state.feed.map((post) {
      if (post.id == event.shareId) {
        return TradeSharePost(
          id: post.id,
          firebaseUid: post.firebaseUid,
          authorName: post.authorName,
          authorAvatar: post.authorAvatar,
          authorLevel: post.authorLevel,
          tradeId: post.tradeId,
          symbol: post.symbol,
          side: post.side,
          quantity: post.quantity,
          price: post.price,
          pnlPercent: post.pnlPercent,
          caption: post.caption,
          likesCount: event.isCurrentlyLiked ? post.likesCount - 1 : post.likesCount + 1,
          commentsCount: post.commentsCount,
          isLikedByMe: !event.isCurrentlyLiked,
          createdAt: post.createdAt,
        );
      }
      return post;
    }).toList();

    emit(state.copyWith(feed: newFeed));

    try {
      if (event.isCurrentlyLiked) {
        await repository.unlikeShare(event.uid, event.shareId);
      } else {
        await repository.likeShare(event.uid, event.shareId);
      }
    } catch (e) {
      // Revert if failed
      add(LoadFeed(event.uid));
    }
  }
}
