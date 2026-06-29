import 'dart:async';
import 'dart:convert';
import '../data/learning_models.dart';
import 'package:http/http.dart' as http;
import '../../../core/network/api_constants.dart';
import '../../../core/services/learning_progress_service.dart';
import 'package:finnn/core/services/api_notification_service.dart';

abstract class LearningEvent {}

class CompleteLessonEvent extends LearningEvent {
  CompleteLessonEvent({
    required this.courseId,
    required this.lessonId,
    required this.xpReward,
    required this.totalLessonsInCourse,
  });
  final String courseId;
  final String lessonId;
  final int xpReward;
  final int totalLessonsInCourse;
}

class CompleteDailyChallengeEvent extends LearningEvent {
  CompleteDailyChallengeEvent({
    required this.xpReward,
    required this.isCorrect,
    required this.currentStreak,
  });
  final int xpReward;
  final bool isCorrect;
  final int currentStreak;
}

class LearningState {
  const LearningState({required this.userProgress});

  final UserLearningProgress userProgress;

  LearningState copyWith({UserLearningProgress? userProgress}) {
    return LearningState(userProgress: userProgress ?? this.userProgress);
  }

  factory LearningState.initial(String userId) {
    return LearningState(
      userProgress: UserLearningProgress(
        userId: userId,
        totalXp: 0,
        currentLevel: 1,
        coursesStarted: 0,
        coursesCompleted: 0,
        lessonsCompleted: 0,
        totalLearningMinutes: 0,
        currentStreak: 0,
        longestStreak: 0,
        courseProgress: const {},
        achievements: const [],
        lastActivityDate: DateTime.now(),
      ),
    );
  }
}

class LearningBloc {
  LearningBloc({required this.userId}) {
    _state = LearningState.initial(userId);
    _stateController.add(_state);

    // Asynchronously load the user's progress
    _loadProgress();
  }

  final String userId;
  final _progressService = LearningProgressService();
  final _stateController = StreamController<LearningState>.broadcast();

  late LearningState _state;

  Stream<LearningState> get stream => _stateController.stream;
  LearningState get state => _state;

  Future<void> _loadProgress() async {
    final savedProgress = await _progressService.loadProgress(userId);

    if (savedProgress != null) {
      // Restore the full achievements list back into the progress object
      // based on the mock data logic since we stripped it in the service
      final mergedProgress = UserLearningProgress(
        userId: savedProgress.userId,
        totalXp: savedProgress.totalXp,
        currentLevel: savedProgress.currentLevel,
        coursesStarted: savedProgress.coursesStarted,
        coursesCompleted: savedProgress.coursesCompleted,
        lessonsCompleted: savedProgress.lessonsCompleted,
        totalLearningMinutes: savedProgress.totalLearningMinutes,
        currentStreak: savedProgress.currentStreak,
        longestStreak: savedProgress.longestStreak,
        courseProgress: savedProgress.courseProgress,
        achievements: savedProgress.achievements,
        lastActivityDate: savedProgress.lastActivityDate,
        lastDailyChallengeDate: savedProgress.lastDailyChallengeDate,
      );

      // Check if streak was broken (missed yesterday)
      int currentStreak = mergedProgress.currentStreak;
      if (mergedProgress.lastDailyChallengeDate != null) {
        final now = DateTime.now();
        final last = mergedProgress.lastDailyChallengeDate!;
        final diff = DateTime(
          now.year,
          now.month,
          now.day,
        ).difference(DateTime(last.year, last.month, last.day)).inDays;

        if (diff > 1) {
          currentStreak = 0;
        }
      }

      UserLearningProgress verifiedProgress = UserLearningProgress(
        userId: mergedProgress.userId,
        totalXp: mergedProgress.totalXp,
        currentLevel: mergedProgress.currentLevel,
        coursesStarted: mergedProgress.coursesStarted,
        coursesCompleted: mergedProgress.coursesCompleted,
        lessonsCompleted: mergedProgress.lessonsCompleted,
        totalLearningMinutes: mergedProgress.totalLearningMinutes,
        currentStreak: currentStreak,
        longestStreak: mergedProgress.longestStreak,
        courseProgress: mergedProgress.courseProgress,
        achievements: mergedProgress.achievements,
        lastActivityDate: mergedProgress.lastActivityDate,
        lastDailyChallengeDate: mergedProgress.lastDailyChallengeDate,
      );

      // --- Backend Sync Logic ---
      try {
        final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/social/profile/$userId'));
        if (response.statusCode == 200) {
          final profileData = jsonDecode(response.body);
          final backendXp = profileData['total_xp'] ?? 0;
          
          if (verifiedProgress.totalXp > backendXp) {
            // Local is ahead (likely due to offline progress), push to backend
            final diff = verifiedProgress.totalXp - backendXp;
            await http.post(Uri.parse('${ApiConstants.baseUrl}/social/xp/award?uid=$userId&xp=$diff'));
          } else if (backendXp > verifiedProgress.totalXp) {
            // Backend is ahead (likely logged in on new device)
            verifiedProgress = UserLearningProgress(
              userId: verifiedProgress.userId,
              totalXp: backendXp,
              currentLevel: verifiedProgress.currentLevel,
              coursesStarted: verifiedProgress.coursesStarted,
              coursesCompleted: verifiedProgress.coursesCompleted,
              lessonsCompleted: verifiedProgress.lessonsCompleted,
              totalLearningMinutes: verifiedProgress.totalLearningMinutes,
              currentStreak: verifiedProgress.currentStreak,
              longestStreak: verifiedProgress.longestStreak,
              courseProgress: verifiedProgress.courseProgress,
              achievements: verifiedProgress.achievements,
              lastActivityDate: verifiedProgress.lastActivityDate,
              lastDailyChallengeDate: verifiedProgress.lastDailyChallengeDate,
            );
            _progressService.saveProgress(verifiedProgress);
          }
        } else if (response.statusCode == 404) {
          // Profile doesn't exist yet, push our local XP to initialize it
          await http.post(Uri.parse('${ApiConstants.baseUrl}/social/xp/award?uid=$userId&xp=${verifiedProgress.totalXp}'));
        }
      } catch (_) {
        // Ignore network errors, fallback to local progress
      }
      // --------------------------

      _state = _state.copyWith(userProgress: verifiedProgress);
      _stateController.add(_state);

      if (currentStreak == 0 && mergedProgress.currentStreak > 0) {
        // Automatically save the broken streak to the backend
        _progressService.saveProgress(verifiedProgress);
      }
    }
  }

  void dispatch(LearningEvent event) {
    if (event is CompleteLessonEvent) {
      _handleCompleteLesson(event);
    } else if (event is CompleteDailyChallengeEvent) {
      _handleCompleteDailyChallenge(event);
    }
  }

  void _handleCompleteLesson(CompleteLessonEvent event) {
    final prog = _state.userProgress;
    final courseProg = prog.courseProgress[event.courseId];

    final bool isAlreadyCompleted =
        courseProg?.completedLessonIds.contains(event.lessonId) ?? false;

    // Create new maps to avoid mutability issues
    final newCourseProgressMap = Map<String, CourseProgress>.from(
      prog.courseProgress,
    );
    CourseProgress updatedCourseProg;

    int newCoursesStarted = prog.coursesStarted;
    int newCoursesCompleted = prog.coursesCompleted;
    int earnedXp = isAlreadyCompleted ? 0 : event.xpReward;
    int additionalCompletedLesson = isAlreadyCompleted ? 0 : 1;

    if (courseProg != null) {
      final List<String> newCompletedIds = List<String>.from(
        courseProg.completedLessonIds,
      );
      if (!isAlreadyCompleted) {
        newCompletedIds.add(event.lessonId);
      }

      final int newCompleted = newCompletedIds.length;

      if (newCompleted == courseProg.totalLessons &&
          courseProg.completedLessons < courseProg.totalLessons) {
        newCoursesCompleted += 1; // Course just completed
      }

      updatedCourseProg = CourseProgress(
        courseId: courseProg.courseId,
        status: newCompleted == courseProg.totalLessons
            ? ProgressStatus.completed
            : ProgressStatus.inProgress,
        completedLessons: newCompleted,
        totalLessons: courseProg.totalLessons,
        lastAccessedDate: DateTime.now(),
        startedDate: courseProg.startedDate,
        completedDate: newCompleted == courseProg.totalLessons
            ? (courseProg.completedDate ?? DateTime.now())
            : null,
        quizScores: courseProg.quizScores,
        timeSpentMinutes: courseProg.timeSpentMinutes + 10,
        completedLessonIds: newCompletedIds,
      );

      newCourseProgressMap[event.courseId] = updatedCourseProg;
    } else {
      // First lesson of the course
      newCoursesStarted += 1;
      final int newCompleted = 1;

      if (newCompleted == event.totalLessonsInCourse) {
        newCoursesCompleted += 1;
      }

      updatedCourseProg = CourseProgress(
        courseId: event.courseId,
        status: newCompleted == event.totalLessonsInCourse
            ? ProgressStatus.completed
            : ProgressStatus.inProgress,
        completedLessons: newCompleted,
        totalLessons: event.totalLessonsInCourse,
        lastAccessedDate: DateTime.now(),
        startedDate: DateTime.now(),
        completedDate: newCompleted == event.totalLessonsInCourse
            ? DateTime.now()
            : null,
        quizScores: const {}, // empty
        timeSpentMinutes: 10,
        completedLessonIds: [event.lessonId],
      );

      newCourseProgressMap[event.courseId] = updatedCourseProg;
    }

    final baseTotalXp = prog.totalXp + earnedXp;
    final draftProgress = UserLearningProgress(
      userId: prog.userId,
      totalXp: baseTotalXp,
      currentLevel: UserLearningProgress.calculateLevel(baseTotalXp),
      coursesStarted: newCoursesStarted,
      coursesCompleted: newCoursesCompleted,
      lessonsCompleted: prog.lessonsCompleted + additionalCompletedLesson,
      totalLearningMinutes: prog.totalLearningMinutes + 10,
      currentStreak: prog.currentStreak,
      longestStreak: prog.longestStreak,
      courseProgress: newCourseProgressMap,
      achievements: prog.achievements,
      lastActivityDate: DateTime.now(),
    );

    final evaluatedAchievements = _evaluateAchievements(draftProgress);
    int extraXp = 0;
    for (int i = 0; i < evaluatedAchievements.length; i++) {
      if (evaluatedAchievements[i].isEarned && !prog.achievements[i].isEarned) {
        final achievement = evaluatedAchievements[i];
        extraXp += achievement.xpReward;
        
        // Log database notification for the achievement unlock
        ApiNotificationService.instance.createNotification(
          userId: prog.userId,
          title: 'Achievement Unlocked!',
          description: '${achievement.title} - ${achievement.description}',
          category: 'achievement',
        );
      }
    }

    final nextTotalXp = baseTotalXp + extraXp;
    final updatedProgress = UserLearningProgress(
      userId: draftProgress.userId,
      totalXp: nextTotalXp,
      currentLevel: UserLearningProgress.calculateLevel(nextTotalXp),
      coursesStarted: draftProgress.coursesStarted,
      coursesCompleted: draftProgress.coursesCompleted,
      lessonsCompleted: draftProgress.lessonsCompleted,
      totalLearningMinutes: draftProgress.totalLearningMinutes,
      currentStreak: draftProgress.currentStreak,
      longestStreak: draftProgress.longestStreak,
      courseProgress: draftProgress.courseProgress,
      achievements: evaluatedAchievements,
      lastActivityDate: draftProgress.lastActivityDate,
    );

    _state = _state.copyWith(userProgress: updatedProgress);
    _stateController.add(_state);

    // Save to local storage asynchronously
    _progressService.saveProgress(updatedProgress);
    
    // Send XP to backend Gamification Profile
    final totalAwardedXp = earnedXp + extraXp;
    if (totalAwardedXp > 0) {
      http.post(Uri.parse('${ApiConstants.baseUrl}/social/xp/award?uid=${prog.userId}&xp=$totalAwardedXp')).catchError((_) => http.Response('', 500));
    }
  }

  void _handleCompleteDailyChallenge(CompleteDailyChallengeEvent event) {
    final prog = _state.userProgress;

    int newStreak = event.currentStreak;
    int longestStreak = prog.longestStreak;
    final now = DateTime.now();

    if (newStreak > longestStreak) {
      longestStreak = newStreak;
    }

    final baseTotalXp = prog.totalXp + event.xpReward;
    final draftProgress = UserLearningProgress(
      userId: prog.userId,
      totalXp: baseTotalXp,
      currentLevel: UserLearningProgress.calculateLevel(baseTotalXp),
      coursesStarted: prog.coursesStarted,
      coursesCompleted: prog.coursesCompleted,
      lessonsCompleted: prog.lessonsCompleted,
      totalLearningMinutes: prog.totalLearningMinutes + 5, // give 5 mins
      currentStreak: newStreak,
      longestStreak: longestStreak,
      courseProgress: prog.courseProgress,
      achievements: prog.achievements,
      lastActivityDate: now,
      lastDailyChallengeDate: now,
    );

    final evaluatedAchievements = _evaluateAchievements(draftProgress);
    int extraXp = 0;
    for (int i = 0; i < evaluatedAchievements.length; i++) {
      if (evaluatedAchievements[i].isEarned && !prog.achievements[i].isEarned) {
        extraXp += evaluatedAchievements[i].xpReward;
      }
    }

    final nextTotalXp = baseTotalXp + extraXp;
    final updatedProgress = UserLearningProgress(
      userId: draftProgress.userId,
      totalXp: nextTotalXp,
      currentLevel: UserLearningProgress.calculateLevel(nextTotalXp),
      coursesStarted: draftProgress.coursesStarted,
      coursesCompleted: draftProgress.coursesCompleted,
      lessonsCompleted: draftProgress.lessonsCompleted,
      totalLearningMinutes: draftProgress.totalLearningMinutes,
      currentStreak: draftProgress.currentStreak,
      longestStreak: draftProgress.longestStreak,
      courseProgress: draftProgress.courseProgress,
      achievements: evaluatedAchievements,
      lastActivityDate: draftProgress.lastActivityDate,
      lastDailyChallengeDate: draftProgress.lastDailyChallengeDate,
    );

    _state = _state.copyWith(userProgress: updatedProgress);
    _stateController.add(_state);
    _progressService.saveProgress(updatedProgress);

    // Send XP to backend Gamification Profile
    final totalAwardedXp = event.xpReward + extraXp;
    if (totalAwardedXp > 0) {
      http.post(Uri.parse('${ApiConstants.baseUrl}/social/xp/award?uid=${prog.userId}&xp=$totalAwardedXp')).catchError((_) => http.Response('', 500));
    }
  }

  List<Achievement> _evaluateAchievements(UserLearningProgress updatedProgress) {
    return updatedProgress.achievements.map((achievement) {
      if (achievement.isEarned) return achievement; // Already earned
      
      bool shouldUnlock = false;
      int currentProgress = 0;
      
      switch (achievement.id) {
        case 'ach-001': // First Steps (1 lesson)
          shouldUnlock = updatedProgress.lessonsCompleted >= 1;
          currentProgress = updatedProgress.lessonsCompleted.clamp(0, 1);
          break;
        case 'ach-002': // Knowledge Seeker (10 lessons)
          shouldUnlock = updatedProgress.lessonsCompleted >= 10;
          currentProgress = updatedProgress.lessonsCompleted.clamp(0, 10);
          break;
        case 'ach-003': // Week Warrior (7-day streak)
          shouldUnlock = updatedProgress.currentStreak >= 7;
          currentProgress = updatedProgress.currentStreak.clamp(0, 7);
          break;
        case 'ach-004': // Quiz Master (5 quizzes with 100%)
          int quizCount = 0;
          for (final cp in updatedProgress.courseProgress.values) {
            quizCount += cp.quizScores.values.where((score) => score >= 100).length;
          }
          shouldUnlock = quizCount >= 5;
          currentProgress = quizCount.clamp(0, 5);
          break;
        case 'ach-005': // Course Champion (1 course)
          shouldUnlock = updatedProgress.coursesCompleted >= 1;
          currentProgress = updatedProgress.coursesCompleted.clamp(0, 1);
          break;
        case 'ach-006': // Market Scholar (5 courses)
          shouldUnlock = updatedProgress.coursesCompleted >= 5;
          currentProgress = updatedProgress.coursesCompleted.clamp(0, 5);
          break;
        case 'ach-007': // Trading Legend (13 courses)
          shouldUnlock = updatedProgress.coursesCompleted >= 13;
          currentProgress = updatedProgress.coursesCompleted.clamp(0, 13);
          break;
      }
      
      if (shouldUnlock) {
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
      } else if (currentProgress != achievement.progress) {
        return Achievement(
          id: achievement.id,
          title: achievement.title,
          description: achievement.description,
          iconData: achievement.iconData,
          color: achievement.color,
          xpReward: achievement.xpReward,
          rarity: achievement.rarity,
          progress: currentProgress,
          maxProgress: achievement.maxProgress,
          earnedDate: null,
        );
      }
      return achievement;
    }).toList();
  }

  void dispose() {
    _stateController.close();
  }
}
