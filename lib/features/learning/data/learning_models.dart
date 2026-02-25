import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum DifficultyLevel {
  beginner(
    label: 'Beginner',
    color: AppColors.mintGreen,
    icon: Icons.spa_outlined,
    xpMultiplier: 1.0,
  ),

  elementary(
    label: 'Elementary',
    color: AppColors.oceanTeal,
    icon: Icons.eco_outlined,
    xpMultiplier: 1.2,
  ),

  intermediate(
    label: 'Intermediate',
    color: AppColors.electricBlue,
    icon: Icons.trending_up,
    xpMultiplier: 1.5,
  ),

  advanced(
    label: 'Advanced',
    color: AppColors.indigo,
    icon: Icons.psychology_outlined,
    xpMultiplier: 2.0,
  ),

  expert(
    label: 'Expert',
    color: AppColors.auroraPurple,
    icon: Icons.stars_outlined,
    xpMultiplier: 2.5,
  );

  const DifficultyLevel({
    required this.label,
    required this.color,
    required this.icon,
    required this.xpMultiplier,
  });

  final String label;
  final Color color;
  final IconData icon;
  final double xpMultiplier;
}

enum ContentType {
  video(icon: Icons.play_circle_outline, label: 'Video'),

  article(icon: Icons.article_outlined, label: 'Article'),

  interactive(icon: Icons.touch_app_outlined, label: 'Interactive'),

  quiz(icon: Icons.quiz_outlined, label: 'Quiz'),

  simulation(icon: Icons.candlestick_chart_outlined, label: 'Simulation'),

  caseStudy(icon: Icons.business_center_outlined, label: 'Case Study'),

  liveScenario(icon: Icons.show_chart, label: 'Live Scenario');

  const ContentType({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

enum ProgressStatus {
  notStarted(label: 'Not Started', color: AppColors.textTertiary),

  inProgress(label: 'In Progress', color: AppColors.electricBlue),

  completed(label: 'Completed', color: AppColors.success),

  needsReview(label: 'Needs Review', color: AppColors.warning);

  const ProgressStatus({required this.label, required this.color});

  final String label;
  final Color color;
}

class LearningCategory {
  const LearningCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.courseCount,
    required this.estimatedHours,
    this.imageUrl,
    this.isNew = false,
    this.isPremium = false,
  });

  final String id;

  final String name;

  final String description;

  final IconData icon;

  final Color color;

  final int courseCount;

  final double estimatedHours;

  final String? imageUrl;

  final bool isNew;

  final bool isPremium;

  Color get backgroundColor => color.withValues(alpha: 0.1);

  String get formattedDuration => '${estimatedHours.toInt()}h';
}

class Course {
  const Course({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.categoryId,
    required this.difficulty,
    required this.thumbnailUrl,
    required this.modules,
    required this.totalLessons,
    required this.estimatedMinutes,
    required this.xpReward,
    this.instructorName,
    this.instructorAvatarUrl,
    this.rating = 0.0,
    this.ratingsCount = 0,
    this.enrolledCount = 0,
    this.completedCount = 0,
    this.tags = const [],
    this.prerequisites = const [],
    this.learningOutcomes = const [],
    this.isNew = false,
    this.isFeatured = false,
    this.isPremium = false,
    this.lastUpdated,
    this.accentColor,
  });

  final String id;

  final String title;

  final String subtitle;

  final String description;

  final String categoryId;

  final DifficultyLevel difficulty;

  final String thumbnailUrl;

  final List<CourseModule> modules;

  final int totalLessons;

  final int estimatedMinutes;

  final int xpReward;

  final String? instructorName;

  final String? instructorAvatarUrl;

  final double rating;

  final int ratingsCount;

  final int enrolledCount;

  final int completedCount;

  final List<String> tags;

  final List<String> prerequisites;

  final List<String> learningOutcomes;

  final bool isNew;

  final bool isFeatured;

  final bool isPremium;

  final DateTime? lastUpdated;

  final Color? accentColor;

  String get formattedDuration {
    final hours = estimatedMinutes ~/ 60;
    final minutes = estimatedMinutes % 60;
    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${minutes}m';
    }
  }

  String get formattedEnrollment {
    if (enrolledCount >= 1000000) {
      return '${(enrolledCount / 1000000).toStringAsFixed(1)}M enrolled';
    } else if (enrolledCount >= 1000) {
      return '${(enrolledCount / 1000).toStringAsFixed(1)}K enrolled';
    }
    return '$enrolledCount enrolled';
  }

  Color get displayColor => accentColor ?? difficulty.color;

  double get estimatedHours => estimatedMinutes / 60;

  bool get isFree => !isPremium;
}

class CourseModule {
  const CourseModule({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
    required this.order,
    this.isLocked = false,
    this.unlockRequirement,
  });

  final String id;

  final String title;

  final String description;

  final List<Lesson> lessons;

  final int order;

  final bool isLocked;

  final String? unlockRequirement;

  int get totalMinutes =>
      lessons.fold(0, (sum, lesson) => sum + lesson.estimatedMinutes);

  int get lessonCount => lessons.length;
}

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.contentType,
    required this.estimatedMinutes,
    required this.order,
    required this.xpReward,
    this.thumbnailUrl,
    this.videoUrl,
    this.articleContent,
    this.interactiveData,
    this.quizQuestions,
    this.keyTakeaways = const [],
    this.resources = const [],
    this.isPreview = false,
    this.isPremium = false,
  });

  final String id;

  final String title;

  final String description;

  final ContentType contentType;

  final int estimatedMinutes;

  final int order;

  final int xpReward;

  final String? thumbnailUrl;

  final String? videoUrl;

  final String? articleContent;

  final Map<String, dynamic>? interactiveData;

  final List<QuizQuestion>? quizQuestions;

  final List<String> keyTakeaways;

  final List<LessonResource> resources;

  final bool isPreview;

  final bool isPremium;

  String get formattedDuration => '${estimatedMinutes}m';
}

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
    this.imageUrl,
    this.difficulty = DifficultyLevel.beginner,
  });

  final String id;

  final String question;

  final List<String> options;

  final int correctOptionIndex;

  final String explanation;

  final String? imageUrl;

  final DifficultyLevel difficulty;
}

class LessonResource {
  const LessonResource({
    required this.title,
    required this.url,
    required this.type,
  });

  final String title;
  final String url;
  final ResourceType type;
}

enum ResourceType { article, video, pdf, externalLink, tool, spreadsheet }

class UserLearningProgress {
  const UserLearningProgress({
    required this.userId,
    required this.totalXp,
    required this.currentLevel,
    required this.coursesStarted,
    required this.coursesCompleted,
    required this.lessonsCompleted,
    required this.totalLearningMinutes,
    required this.currentStreak,
    required this.longestStreak,
    required this.courseProgress,
    required this.achievements,
    required this.lastActivityDate,
    this.lastDailyChallengeDate,
  });

  final String userId;

  final int totalXp;

  final int currentLevel;

  final int coursesStarted;

  final int coursesCompleted;

  final int lessonsCompleted;

  final int totalLearningMinutes;

  final int currentStreak;

  final int longestStreak;

  final Map<String, CourseProgress> courseProgress;

  final List<Achievement> achievements;

  final DateTime lastActivityDate;

  final DateTime? lastDailyChallengeDate;

  int get xpToNextLevel => currentLevel * 1000 - totalXp;

  double get levelProgress {
    final currentLevelBaseXp = (currentLevel - 1) * 1000;
    final nextLevelXp = currentLevel * 1000;
    if (nextLevelXp - currentLevelBaseXp == 0) return 1.0;
    return (totalXp - currentLevelBaseXp) / (nextLevelXp - currentLevelBaseXp);
  }

  String get formattedLearningTime {
    final hours = totalLearningMinutes ~/ 60;
    if (hours > 0) {
      return '${hours}h ${totalLearningMinutes % 60}m';
    }
    return '${totalLearningMinutes}m';
  }
}

class CourseProgress {
  const CourseProgress({
    required this.courseId,
    required this.status,
    required this.completedLessons,
    required this.totalLessons,
    required this.lastAccessedDate,
    required this.startedDate,
    this.completedDate,
    required this.quizScores,
    required this.timeSpentMinutes,
    this.completedLessonIds = const [],
  });

  final String courseId;
  final ProgressStatus status;
  final int completedLessons;
  final int totalLessons;
  final DateTime lastAccessedDate;
  final DateTime startedDate;
  final DateTime? completedDate;
  final Map<String, int> quizScores;
  final int timeSpentMinutes;
  final List<String> completedLessonIds;

  double get completionPercentage => completedLessons / totalLessons;

  int get completionPercent => (completionPercentage * 100).round();
}

class Achievement {
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconData,
    required this.color,
    required this.xpReward,
    required this.rarity,
    this.earnedDate,
    this.progress,
    this.maxProgress,
  });

  final String id;
  final String title;
  final String description;
  final IconData iconData;
  final Color color;
  final int xpReward;
  final AchievementRarity rarity;
  final DateTime? earnedDate;
  final int? progress;
  final int? maxProgress;

  bool get isEarned => earnedDate != null;

  double? get progressPercentage {
    if (progress != null && maxProgress != null && maxProgress! > 0) {
      return progress! / maxProgress!;
    }
    return null;
  }
}

enum AchievementRarity {
  common(label: 'Common', color: AppColors.textSecondary),
  rare(label: 'Rare', color: AppColors.electricBlue),
  epic(label: 'Epic', color: AppColors.auroraPurple),
  legendary(label: 'Legendary', color: AppColors.goldenYellow);

  const AchievementRarity({required this.label, required this.color});

  final String label;
  final Color color;
}

class LearningPath {
  const LearningPath({
    required this.id,
    required this.title,
    required this.description,
    required this.courses,
    required this.estimatedWeeks,
    required this.difficulty,
    required this.skills,
    this.imageUrl,
    this.badgeOnCompletion,
    this.accentColor,
  });

  final String id;
  final String title;
  final String description;
  final List<String> courses;
  final int estimatedWeeks;
  final DifficultyLevel difficulty;
  final List<String> skills;
  final String? imageUrl;
  final Achievement? badgeOnCompletion;
  final Color? accentColor;

  int get totalCourses => courses.length;

  List<String> get courseIds => courses;

  Color get displayColor => accentColor ?? difficulty.color;
}
