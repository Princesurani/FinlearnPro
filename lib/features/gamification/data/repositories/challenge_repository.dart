import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/daily_challenge.dart';
import '../../../auth/data/auth_service.dart';
import '../../../../core/services/api_market_service.dart';

class ChallengeRepository {
  final AuthService _authService;
  final String _baseUrl;

  ChallengeRepository({AuthService? authService, String? baseUrl})
    : _authService = authService ?? AuthService(),
      _baseUrl = baseUrl ?? ApiMarketService().baseApiUrl;

  /// Fetches the current daily challenge
  Future<DailyChallenge?> getDailyChallenge() async {
    try {
      final user = _authService.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final url = Uri.parse(
        '$_baseUrl/challenges/daily?firebase_uid=${user.uid}',
      );
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return DailyChallenge.fromJson(data);
      } else if (response.statusCode == 404) {
        return null; // No challenge available
      } else {
        throw Exception('Failed to load challenge: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching daily challenge: $e');
      return null;
    }
  }

  /// Submits an answer to the daily challenge
  Future<ChallengeSubmissionResult> submitChallengeAnswer({
    required int choiceId,
  }) async {
    try {
      final user = _authService.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final url = Uri.parse('$_baseUrl/challenges/daily/submit');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'firebase_uid': user.uid, 'choice_id': choiceId}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ChallengeSubmissionResult.fromJson(data);
      } else {
        throw Exception('Failed to submit challenge: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error submitting challenge: $e');
      rethrow;
    }
  }
}
