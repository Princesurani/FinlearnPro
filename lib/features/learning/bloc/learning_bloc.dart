import 'dart:async';

import '../data/learning_models.dart';
import '../data/learning_mock_data.dart';
import '../../../core/services/learning_progress_service.dart';

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
  });
  final int xpReward;
  final bool isCorrect;
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
        achievements: LearningMockData
            .currentUserProgress
            .achievements, // Using mock achievements for now
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

      final verifiedProgress = UserLearningProgress(
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

    final updatedProgress = UserLearningProgress(
      userId: prog.userId,
      totalXp: prog.totalXp + earnedXp,
      currentLevel: prog.currentLevel,
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

    _state = _state.copyWith(userProgress: updatedProgress);
    _stateController.add(_state);

    // Save to local storage asynchronously
    _progressService.saveProgress(updatedProgress);
  }

  void _handleCompleteDailyChallenge(CompleteDailyChallengeEvent event) {
    final prog = _state.userProgress;

    int newStreak = prog.currentStreak;
    int longestStreak = prog.longestStreak;
    final now = DateTime.now();
    bool streakUpdated = false;

    if (event.isCorrect) {
      if (prog.lastDailyChallengeDate == null) {
        newStreak = 1;
        streakUpdated = true;
      } else {
        final last = prog.lastDailyChallengeDate!;
        final diff = DateTime(
          now.year,
          now.month,
          now.day,
        ).difference(DateTime(last.year, last.month, last.day)).inDays;

        if (diff == 1) {
          newStreak += 1;
          streakUpdated = true;
        } else if (diff > 1) {
          // Missed yesterday, streak breaks and restarts at 1
          newStreak = 1;
          streakUpdated = true;
        } else {
          // diff == 0, already completed today manually bypass if re-trying though the UI blocks this
          streakUpdated = true;
        }
      }
    } else {
      // Answered wrong. We just record they did it for XP, but we don't increase streak.
      streakUpdated = true;
      // Optionally break streak, but standard is just no change for wrong answer.
    }

    if (newStreak > longestStreak) {
      longestStreak = newStreak;
    }

    final updatedProgress = UserLearningProgress(
      userId: prog.userId,
      totalXp: prog.totalXp + event.xpReward,
      currentLevel: prog.currentLevel, // Advanced level calc could go here
      coursesStarted: prog.coursesStarted,
      coursesCompleted: prog.coursesCompleted,
      lessonsCompleted: prog.lessonsCompleted,
      totalLearningMinutes: prog.totalLearningMinutes + 5, // give 5 mins
      currentStreak: newStreak,
      longestStreak: longestStreak,
      courseProgress: prog.courseProgress,
      achievements: prog.achievements,
      lastActivityDate: now,
      lastDailyChallengeDate: streakUpdated ? now : prog.lastDailyChallengeDate,
    );

    _state = _state.copyWith(userProgress: updatedProgress);
    _stateController.add(_state);
    _progressService.saveProgress(updatedProgress);
  }

  void dispose() {
    _stateController.close();
  }
}
