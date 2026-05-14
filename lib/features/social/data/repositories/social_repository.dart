import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/network/api_constants.dart';
import '../models/user_profile.dart';
import '../models/leaderboard_entry.dart';
import '../models/trade_share_post.dart';

class SocialRepository {
  final http.Client _client;

  SocialRepository({http.Client? client}) : _client = client ?? http.Client();

  Future<List<LeaderboardEntry>> searchUsers(String query) async {
    final response = await _client.get(
      Uri.parse('${ApiConstants.baseUrl}/social/search?q=${Uri.encodeComponent(query)}'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => LeaderboardEntry.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search users');
    }
  }

  Future<List<LeaderboardEntry>> getFriends(String uid) async {
    final response = await _client.get(
      Uri.parse('${ApiConstants.baseUrl}/social/friends/$uid'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => LeaderboardEntry.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load friends');
    }
  }

  Future<UserProfile> getProfile(String uid) async {
    final response = await _client.get(
      Uri.parse('${ApiConstants.baseUrl}/social/profile/$uid'),
    );

    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<UserProfile> updateProfile(String uid, {String? displayName, String? bio, String? avatarUrl}) async {
    final body = <String, dynamic>{};
    if (displayName != null) body['display_name'] = displayName;
    if (bio != null) body['bio'] = bio;
    if (avatarUrl != null) body['avatar_url'] = avatarUrl;

    final response = await _client.put(
      Uri.parse('${ApiConstants.baseUrl}/social/profile/$uid'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update profile');
    }
  }

  Future<List<LeaderboardEntry>> getLeaderboard({
    String type = 'xp',
    String period = 'allTime',
    int limit = 50,
  }) async {
    final response = await _client.get(
      Uri.parse('${ApiConstants.baseUrl}/social/leaderboard?type=$type&period=$period&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => LeaderboardEntry.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load leaderboard');
    }
  }

  Future<void> followUser(String myUid, String targetUid) async {
    final response = await _client.post(
      Uri.parse('${ApiConstants.baseUrl}/social/follow/$myUid/$targetUid'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to follow user');
    }
  }

  Future<void> unfollowUser(String myUid, String targetUid) async {
    final response = await _client.delete(
      Uri.parse('${ApiConstants.baseUrl}/social/follow/$myUid/$targetUid'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to unfollow user');
    }
  }

  Future<Map<String, List<String>>> getFollowers(String uid) async {
    final response = await _client.get(
      Uri.parse('${ApiConstants.baseUrl}/social/followers/$uid'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'followers': List<String>.from(data['followers']),
        'following': List<String>.from(data['following']),
      };
    } else {
      throw Exception('Failed to load followers');
    }
  }

  Future<List<TradeSharePost>> getFeed(String uid, {int page = 1}) async {
    final response = await _client.get(
      Uri.parse('${ApiConstants.baseUrl}/social/feed/$uid?page=$page'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => TradeSharePost.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load feed');
    }
  }

  Future<TradeSharePost> shareTrade(
    String uid, {
    required String symbol,
    required String side,
    required int quantity,
    required double price,
    double? pnlPercent,
    String? caption,
    int? tradeId,
  }) async {
    final body = {
      'symbol': symbol,
      'side': side,
      'quantity': quantity,
      'price': price,
      if (pnlPercent != null) 'pnl_percent': pnlPercent,
      if (caption != null) 'caption': caption,
      if (tradeId != null) 'trade_id': tradeId,
    };

    final response = await _client.post(
      Uri.parse('${ApiConstants.baseUrl}/social/share?uid=$uid'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return TradeSharePost.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to share trade');
    }
  }

  Future<void> likeShare(String uid, int shareId) async {
    final response = await _client.post(
      Uri.parse('${ApiConstants.baseUrl}/social/like/$shareId?uid=$uid'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to like post');
    }
  }

  Future<void> unlikeShare(String uid, int shareId) async {
    final response = await _client.delete(
      Uri.parse('${ApiConstants.baseUrl}/social/like/$shareId?uid=$uid'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to unlike post');
    }
  }
}
