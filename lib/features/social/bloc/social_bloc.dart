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

class UpdateProfile extends SocialEvent {
  final String uid;
  final String? username;
  final String? bio;
  final String? avatarUrl;
  UpdateProfile(this.uid, {this.username, this.bio, this.avatarUrl});
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
  final String leaderboardType;
  final String leaderboardPeriod;
  final String? errorMessage;

  SocialState({
    this.status = SocialStatus.initial,
    this.isProfileLoading = false,
    this.isLeaderboardLoading = false,
    this.isFeedLoading = false,
    this.myProfile,
    this.leaderboard = const [],
    this.feed = const [],
    this.leaderboardType = 'xp',
    this.leaderboardPeriod = 'allTime',
    this.errorMessage,
  });

  SocialState copyWith({
    SocialStatus? status,
    bool? isProfileLoading,
    bool? isLeaderboardLoading,
    bool? isFeedLoading,
    UserProfile? myProfile,
    List<LeaderboardEntry>? leaderboard,
    List<TradeSharePost>? feed,
    String? leaderboardType,
    String? leaderboardPeriod,
    String? errorMessage,
  }) {
    return SocialState(
      status: status ?? this.status,
      isProfileLoading: isProfileLoading ?? this.isProfileLoading,
      isLeaderboardLoading: isLeaderboardLoading ?? this.isLeaderboardLoading,
      isFeedLoading: isFeedLoading ?? this.isFeedLoading,
      myProfile: myProfile ?? this.myProfile,
      leaderboard: leaderboard ?? this.leaderboard,
      feed: feed ?? this.feed,
      leaderboardType: leaderboardType ?? this.leaderboardType,
      leaderboardPeriod: leaderboardPeriod ?? this.leaderboardPeriod,
      errorMessage: errorMessage,
    );
  }
}

/// Returns the best available username for the current Firebase user.
/// Falls back in order: Firebase displayName → email prefix → 'Trader'.
String _resolveUsername() {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return 'Trader';

  final dn = user.displayName;
  if (dn != null && dn.isNotEmpty) return dn;

  final email = user.email;
  if (email != null && email.contains('@')) return email.split('@').first;

  return 'Trader';
}

// ─── Bloc ───────────────────────────────────────────────────────────────────

class SocialBloc extends Bloc<SocialEvent, SocialState> {
  final SocialRepository repository;

  SocialBloc({required this.repository}) : super(SocialState()) {
    on<LoadProfile>(_onLoadProfile);
    on<LoadLeaderboard>(_onLoadLeaderboard);
    on<LoadFeed>(_onLoadFeed);
    on<LikePost>(_onLikePost);
    on<UpdateProfile>(_onUpdateProfile);
  }

  // ── Profile ─────────────────────────────────────────────────────────────

  Future<void> _onLoadProfile(LoadProfile event, Emitter<SocialState> emit) async {
    emit(state.copyWith(isProfileLoading: true, status: SocialStatus.loading));
    try {
      final profile = await repository.getProfile(event.uid);

      emit(state.copyWith(
        status: SocialStatus.loaded,
        isProfileLoading: false,
        myProfile: profile,
      ));
    } catch (_) {
      // Backend unreachable — keep existing profile if we have one, otherwise build a local fallback profile
      if (state.myProfile != null) {
        emit(state.copyWith(
          status: SocialStatus.loaded,
          isProfileLoading: false,
        ));
      } else {
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

      final myUid = FirebaseAuth.instance.currentUser?.uid;

      final correctedLeaderboard = leaderboard.map((entry) {
        return LeaderboardEntry(
          firebaseUid: entry.firebaseUid,
          username: entry.username,
          avatarUrl: entry.firebaseUid == myUid ? (state.myProfile?.avatarUrl ?? entry.avatarUrl) : entry.avatarUrl,
          level: entry.level,
          totalXp: entry.totalXp,
          weeklyXp: entry.weeklyXp,
          currentStreak: entry.currentStreak,
          totalTrades: entry.totalTrades,
          winRate: entry.winRate,
          rank: entry.rank,
        );
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

      final myUid = FirebaseAuth.instance.currentUser?.uid;
      final correctedAvatar = state.myProfile?.avatarUrl ?? FirebaseAuth.instance.currentUser?.photoURL;

      final correctedFeed = feed.map((post) {
        return TradeSharePost(
          id: post.id,
          firebaseUid: post.firebaseUid,
          authorName: post.authorName,
          authorAvatar: post.firebaseUid == myUid ? (correctedAvatar ?? post.authorAvatar) : post.authorAvatar,
          authorLevel: post.authorLevel,
          tradeId: post.tradeId,
          symbol: post.symbol,
          side: post.side,
          quantity: post.quantity,
          price: post.price,
          pnlPercent: post.pnlPercent,
          caption: post.caption,
          likesCount: post.likesCount,
          commentsCount: post.commentsCount,
          isLikedByMe: post.isLikedByMe,
          createdAt: post.createdAt,
        );
      }).toList();

      emit(state.copyWith(status: SocialStatus.loaded, isFeedLoading: false, feed: correctedFeed));
    } catch (e) {
      emit(state.copyWith(status: SocialStatus.loaded, isFeedLoading: false, feed: []));
    }
  }

  // ── Update Profile ───────────────────────────────────────────────────────

  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<SocialState> emit) async {
    try {
      if (event.username != null) {
        await FirebaseAuth.instance.currentUser?.updateDisplayName(event.username);
        await FirebaseAuth.instance.currentUser?.reload();
      }
      final updated = await repository.updateProfile(
        event.uid,
        username: event.username,
        bio: event.bio,
        avatarUrl: event.avatarUrl,
      );

      // Instantly propagate username/avatar updates to current user's local leaderboard & feed lists
      final updatedLeaderboard = state.leaderboard.map((entry) {
        if (entry.firebaseUid == event.uid) {
          return LeaderboardEntry(
            firebaseUid: entry.firebaseUid,
            username: event.username ?? entry.username,
            avatarUrl: event.avatarUrl ?? entry.avatarUrl,
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

      final updatedFeed = state.feed.map((post) {
        if (post.firebaseUid == event.uid) {
          return TradeSharePost(
            id: post.id,
            firebaseUid: post.firebaseUid,
            authorName: event.username ?? post.authorName,
            authorAvatar: event.avatarUrl ?? post.authorAvatar,
            authorLevel: post.authorLevel,
            tradeId: post.tradeId,
            symbol: post.symbol,
            side: post.side,
            quantity: post.quantity,
            price: post.price,
            pnlPercent: post.pnlPercent,
            caption: post.caption,
            likesCount: post.likesCount,
            commentsCount: post.commentsCount,
            isLikedByMe: post.isLikedByMe,
            createdAt: post.createdAt,
          );
        }
        return post;
      }).toList();

      emit(state.copyWith(
        myProfile: updated,
        leaderboard: updatedLeaderboard,
        feed: updatedFeed,
      ));
    } catch (_) {
      // Fallback: update local state if backend is temporarily unreachable
      if (state.myProfile != null) {
        final localProfile = state.myProfile!.copyWith(
          username: event.username,
          bio: event.bio,
          avatarUrl: event.avatarUrl,
        );

        final updatedLeaderboard = state.leaderboard.map((entry) {
          if (entry.firebaseUid == event.uid) {
            return LeaderboardEntry(
              firebaseUid: entry.firebaseUid,
              username: event.username ?? entry.username,
              avatarUrl: event.avatarUrl ?? entry.avatarUrl,
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

        final updatedFeed = state.feed.map((post) {
          if (post.firebaseUid == event.uid) {
            return TradeSharePost(
              id: post.id,
              firebaseUid: post.firebaseUid,
              authorName: event.username ?? post.authorName,
              authorAvatar: event.avatarUrl ?? post.authorAvatar,
              authorLevel: post.authorLevel,
              tradeId: post.tradeId,
              symbol: post.symbol,
              side: post.side,
              quantity: post.quantity,
              price: post.price,
              pnlPercent: post.pnlPercent,
              caption: post.caption,
              likesCount: post.likesCount,
              commentsCount: post.commentsCount,
              isLikedByMe: post.isLikedByMe,
              createdAt: post.createdAt,
            );
          }
          return post;
        }).toList();

        emit(state.copyWith(
          myProfile: localProfile,
          leaderboard: updatedLeaderboard,
          feed: updatedFeed,
        ));
      }
    }
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
