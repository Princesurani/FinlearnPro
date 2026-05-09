class UserProfile {
  final String firebaseUid;
  final String displayName;
  final String? avatarUrl;
  final String? bio;
  final int totalXp;
  final int weeklyXp;
  final int level;
  final int currentStreak;
  final int longestStreak;
  final int totalTrades;
  final int totalCoursesCompleted;
  final int totalChallengesCompleted;
  final double winRate;
  final String? lastActivityDate;

  UserProfile({
    required this.firebaseUid,
    required this.displayName,
    this.avatarUrl,
    this.bio,
    required this.totalXp,
    required this.weeklyXp,
    required this.level,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalTrades,
    required this.totalCoursesCompleted,
    required this.totalChallengesCompleted,
    required this.winRate,
    this.lastActivityDate,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firebaseUid: json['firebase_uid'] ?? '',
      displayName: json['display_name'] ?? 'Trader',
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      totalXp: json['total_xp'] ?? 0,
      weeklyXp: json['weekly_xp'] ?? 0,
      level: json['level'] ?? 1,
      currentStreak: json['current_streak'] ?? 0,
      longestStreak: json['longest_streak'] ?? 0,
      totalTrades: json['total_trades'] ?? 0,
      totalCoursesCompleted: json['total_courses_completed'] ?? 0,
      totalChallengesCompleted: json['total_challenges_completed'] ?? 0,
      winRate: (json['win_rate'] ?? 0.0).toDouble(),
      lastActivityDate: json['last_activity_date'],
    );
  }
}
