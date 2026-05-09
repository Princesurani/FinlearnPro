import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/user_profile.dart';
import '../data/models/leaderboard_entry.dart';
import '../data/models/trade_share_post.dart';
import '../data/repositories/social_repository.dart';

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

  SocialState({
    this.status = SocialStatus.initial,
    this.myProfile,
    this.leaderboard = const [],
    this.feed = const [],
    this.following = const {},
    this.leaderboardType = 'xp',
    this.leaderboardPeriod = 'allTime',
    this.errorMessage,
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
    );
  }
}

class SocialBloc extends Bloc<SocialEvent, SocialState> {
  final SocialRepository repository;

  SocialBloc({required this.repository}) : super(SocialState()) {
    on<LoadProfile>(_onLoadProfile);
    on<LoadLeaderboard>(_onLoadLeaderboard);
    on<LoadFeed>(_onLoadFeed);
    on<LikePost>(_onLikePost);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<SocialState> emit) async {
    emit(state.copyWith(status: SocialStatus.loading));
    try {
      final profile = await repository.getProfile(event.uid);
      final followersData = await repository.getFollowers(event.uid);
      
      emit(state.copyWith(
        status: SocialStatus.loaded,
        myProfile: profile,
        following: Set.from(followersData['following'] ?? []),
      ));
    } catch (e) {
      emit(state.copyWith(status: SocialStatus.error, errorMessage: e.toString()));
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
      emit(state.copyWith(status: SocialStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onLoadFeed(LoadFeed event, Emitter<SocialState> emit) async {
    emit(state.copyWith(status: SocialStatus.loading));
    try {
      final feed = await repository.getFeed(event.uid);
      emit(state.copyWith(status: SocialStatus.loaded, feed: feed));
    } catch (e) {
      emit(state.copyWith(status: SocialStatus.error, errorMessage: e.toString()));
    }
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
