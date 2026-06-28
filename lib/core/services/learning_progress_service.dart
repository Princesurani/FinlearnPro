import 'dart:convert';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/learning/data/learning_models.dart';
import '../../features/learning/data/learning_data.dart';

import '../network/api_constants.dart';

class LearningProgressService {
  static const String _progressKeyPrefix = 'user_learning_progress_';
  final String _baseApiUrl = '${ApiConstants.baseUrl}/learning/progress';
  final http.Client _client = http.Client();

  // Saves the entire user learning progress to local storage
  Future<void> saveProgress(UserLearningProgress progress) async {
    final prefs = await SharedPreferences.getInstance();

    // Create a serializable map
    final map = _progressToMap(progress);

    // Convert to JSON and save locally
    final jsonString = json.encode(map);
    await prefs.setString('$_progressKeyPrefix${progress.userId}', jsonString);

    // Sync to cloud in the background
    _syncToCloud(progress.userId, map);
  }

  // Background cloud sync
  Future<void> _syncToCloud(String userId, Map<String, dynamic> data) async {
    try {
      await _client.post(
        Uri.parse('$_baseApiUrl/sync/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
    } catch (e) {
      debugPrint('Failed to sync progress to cloud: $e');
    }
  }

  // Loads the user learning progress from local storage
  Future<UserLearningProgress?> loadProgress(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('$_progressKeyPrefix$userId');

    try {
      // 1. Try to fetch the latest truth from the cloud
      final response = await _client.get(Uri.parse('$_baseApiUrl/$userId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null) {
          final cloudMap = data['data'] as Map<String, dynamic>;

          // Compare with local before overwriting
          final localJsonString = prefs.getString('$_progressKeyPrefix$userId');
          if (localJsonString != null) {
            try {
              final localMap = json.decode(localJsonString) as Map<String, dynamic>;
              final localDateStr = localMap['lastActivityDate'] as String?;
              final cloudDateStr = cloudMap['lastActivityDate'] as String?;
              
              if (localDateStr != null && cloudDateStr != null) {
                final localDate = DateTime.tryParse(localDateStr);
                final cloudDate = DateTime.tryParse(cloudDateStr);
                
                if (localDate != null && cloudDate != null && localDate.isAfter(cloudDate)) {
                  // Local is newer, so push local to cloud instead of overwriting
                  _syncToCloud(userId, localMap);
                  return _mapToProgress(localMap, userId);
                }
              }
            } catch (e) {
              debugPrint('Failed to compare local and cloud progress: $e');
            }
          }

          // Save cloud data locally
          await prefs.setString(
            '$_progressKeyPrefix$userId',
            json.encode(cloudMap),
          );
          return _mapToProgress(cloudMap, userId);
        }
      }
    } catch (e) {
      debugPrint('Cloud sync failed, falling back to local: $e');
    }

    if (jsonString == null) return null;

    try {
      final map = json.decode(jsonString) as Map<String, dynamic>;
      return _mapToProgress(map, userId);
    } catch (e) {
      return null;
    }
  }

  // Clean progress for user
  Future<void> clearProgress(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_progressKeyPrefix$userId');
  }

  // Fetches instructor biography details from the backend for a given course
  Future<Instructor?> getInstructor(String courseId) async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiConstants.baseUrl}/learning/instructor/$courseId'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Instructor.fromJson(data);
      }
    } catch (e) {
      debugPrint('Failed to load instructor: $e');
    }
    return null;
  }

  // Convert objects to and from map to keep it simple and independent of modifying existing models
  Map<String, dynamic> _progressToMap(UserLearningProgress progress) {
    return {
      'userId': progress.userId,
      'totalXp': progress.totalXp,
      'currentLevel': progress.currentLevel,
      'coursesStarted': progress.coursesStarted,
      'coursesCompleted': progress.coursesCompleted,
      'lessonsCompleted': progress.lessonsCompleted,
      'totalLearningMinutes': progress.totalLearningMinutes,
      'currentStreak': progress.currentStreak,
      'longestStreak': progress.longestStreak,
      'lastActivityDate': progress.lastActivityDate.toIso8601String(),
      'lastDailyChallengeDate': progress.lastDailyChallengeDate
          ?.toIso8601String(),
      'courseProgress': progress.courseProgress.map(
        (k, v) => MapEntry(k, {
          'courseId': v.courseId,
          'status': v.status.name,
          'completedLessons': v.completedLessons,
          'totalLessons': v.totalLessons,
          'lastAccessedDate': v.lastAccessedDate.toIso8601String(),
          'startedDate': v.startedDate.toIso8601String(),
          'completedDate': v.completedDate?.toIso8601String(),
          'quizScores': v.quizScores,
          'timeSpentMinutes': v.timeSpentMinutes,
          'completedLessonIds': v.completedLessonIds,
        }),
      ),
      // Only storing unlocked achievement IDs to simplify
      'achievements': progress.achievements
          .where((a) => a.isEarned)
          .map((a) => a.id)
          .toList(),
    };
  }

  UserLearningProgress _mapToProgress(Map<String, dynamic> map, String userId) {
    final cpMap = map['courseProgress'] as Map<String, dynamic>? ?? {};
    final courseProgressMap = cpMap.map((key, value) {
      final v = value as Map<String, dynamic>;

      final courseProg = CourseProgress(
        courseId: v['courseId'] as String? ?? key,
        status: ProgressStatus.values.firstWhere(
          (e) => e.name == (v['status'] as String? ?? ''),
          orElse: () => ProgressStatus.notStarted,
        ),
        completedLessons: v['completedLessons'] as int? ?? 0,
        totalLessons: v['totalLessons'] as int? ?? 0,
        lastAccessedDate:
            DateTime.tryParse(v['lastAccessedDate']?.toString() ?? '') ??
            DateTime.now(),
        startedDate:
            DateTime.tryParse(v['startedDate']?.toString() ?? '') ??
            DateTime.now(),
        completedDate: v['completedDate'] != null
            ? DateTime.tryParse(v['completedDate'].toString())
            : null,
        quizScores: Map<String, int>.from(v['quizScores'] as Map? ?? {}),
        timeSpentMinutes: v['timeSpentMinutes'] as int? ?? 0,
        completedLessonIds: List<String>.from(
          v['completedLessonIds'] as List? ?? [],
        ),
      );
      return MapEntry(key, courseProg);
    });

    final earnedIds = Set<String>.from(map['achievements'] as List? ?? []);
    final achievementsList = LearningData.achievements.map((achievement) {
      if (earnedIds.contains(achievement.id)) {
        return Achievement(
          id: achievement.id,
          title: achievement.title,
          description: achievement.description,
          iconData: achievement.iconData,
          color: achievement.color,
          xpReward: achievement.xpReward,
          rarity: achievement.rarity,
          progress: achievement.maxProgress ?? 0,
          maxProgress: achievement.maxProgress,
          earnedDate: DateTime.now(),
        );
      }
      return achievement;
    }).toList();

    return UserLearningProgress(
      userId: map['userId'] as String? ?? userId,
      totalXp: (map['totalXp'] as int?) ?? 0,
      currentLevel: (map['currentLevel'] as int?) ?? 1,
      coursesStarted: (map['coursesStarted'] as int?) ?? 0,
      coursesCompleted: (map['coursesCompleted'] as int?) ?? 0,
      lessonsCompleted: (map['lessonsCompleted'] as int?) ?? 0,
      totalLearningMinutes: (map['totalLearningMinutes'] as int?) ?? 0,
      currentStreak: (map['currentStreak'] as int?) ?? 0,
      longestStreak: (map['longestStreak'] as int?) ?? 0,
      courseProgress: courseProgressMap,
      achievements: achievementsList,
      lastActivityDate:
          DateTime.tryParse(map['lastActivityDate']?.toString() ?? '') ??
          DateTime.now(),
      lastDailyChallengeDate: map['lastDailyChallengeDate'] != null
          ? DateTime.tryParse(map['lastDailyChallengeDate'].toString())
          : null,
    );
  }
}
