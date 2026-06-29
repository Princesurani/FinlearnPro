import 'dart:convert';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:http/http.dart' as http;
import '../network/api_constants.dart';
import '../../features/notifications/data/notification_model.dart';

class ApiNotificationService {
  final http.Client _client = http.Client();
  final String _baseUrl = '${ApiConstants.baseUrl}/notifications';

  // Shared instance helper
  static final ApiNotificationService instance = ApiNotificationService._internal();
  ApiNotificationService._internal();

  // Retrieve notifications
  Future<List<NotificationModel>> getNotifications(String userId) async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/$userId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('Failed to fetch notifications: $e');
    }
    return [];
  }

  // Mark single read
  Future<bool> markAsRead(int notificationId) async {
    try {
      final response = await _client.post(Uri.parse('$_baseUrl/$notificationId/read'));
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Failed to mark notification read: $e');
    }
    return false;
  }

  // Mark all read
  Future<bool> markAllAsRead(String userId) async {
    try {
      final response = await _client.post(Uri.parse('$_baseUrl/read-all/$userId'));
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Failed to mark all notifications read: $e');
    }
    return false;
  }

  // Trigger custom notifications
  Future<bool> createNotification({
    required String userId,
    required String title,
    required String description,
    required String category,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'firebase_uid': userId,
          'title': title,
          'description': description,
          'category': category,
        }),
      );
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Failed to post notification: $e');
    }
    return false;
  }

  void dispose() {
    _client.close();
  }
}
