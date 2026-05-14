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
  final String? displayName;
  final String? bio;
  UpdateProfile(this.uid, {this.displayName, this.bio});
}

// ─── State ──────────────────────────────────────────────────────────────────

enum SocialStatus { initial, loading, loaded, error }

class SocialState {
  final SocialStatus status;
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

  /// Build a fallback profile from Firebase Auth when the backend is unreachable.
  UserProfile _buildLocalProfile(String uid) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    return UserProfile(
      firebaseUid: uid,
      displayName: firebaseUser?.displayName ?? 'Trader',
      avatarUrl: firebaseUser?.photoURL,
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
    );
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<SocialState> emit) async {
    emit(state.copyWith(status: SocialStatus.loading));
    try {
      final profile = await repository.getProfile(event.uid);
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
        myProfile: profile,
        following: followingSet,
        followersCount: followersCount,
        followingCount: followingCount,
        friendsList: friends,
      ));
    } catch (e) {
      // Fallback to local Firebase Auth profile so the screen is always usable
      emit(state.copyWith(
        status: SocialStatus.loaded,
        myProfile: _buildLocalProfile(event.uid),
      ));
    }
  }

  Future<void> _onLoadLeaderboard(LoadLeaderboard event, Emitter<SocialState> emit) async {
    emit(state.copyWith(
      status: SocialStatus.loading,
      leaderboardType: event.type,
      leaderboardPeriod: event.period,
    ));
    try {
      final leaderboard = await repository.getLeaderboard(
        type: event.type,
        period: event.period,
      );
      emit(state.copyWith(status: SocialStatus.loaded, leaderboard: leaderboard));
    } catch (e) {
      emit(state.copyWith(status: SocialStatus.loaded, leaderboard: []));
    }
  }

  Future<void> _onLoadFeed(LoadFeed event, Emitter<SocialState> emit) async {
    emit(state.copyWith(status: SocialStatus.loading));
    try {
      final feed = await repository.getFeed(event.uid);
      emit(state.copyWith(status: SocialStatus.loaded, feed: feed));
    } catch (e) {
      emit(state.copyWith(status: SocialStatus.loaded, feed: []));
    }
  }

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

  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<SocialState> emit) async {
    try {
      final updated = await repository.updateProfile(
        event.uid,
        displayName: event.displayName,
        bio: event.bio,
      );
      emit(state.copyWith(myProfile: updated));
    } catch (_) {}
  }

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
