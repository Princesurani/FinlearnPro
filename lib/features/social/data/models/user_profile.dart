class UserProfile {
  final String firebaseUid;
  final String username;
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
  final String? email;

  UserProfile({
    required this.firebaseUid,
    required this.username,
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
    this.email,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firebaseUid: json['firebase_uid'] ?? '',
      username: json['username'] ?? 'Trader',
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
      email: json['email'],
    );
  }

  UserProfile copyWith({String? username, String? avatarUrl, String? bio, String? email}) {
    return UserProfile(
      firebaseUid: firebaseUid,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      totalXp: totalXp,
      weeklyXp: weeklyXp,
      level: level,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      totalTrades: totalTrades,
      totalCoursesCompleted: totalCoursesCompleted,
      totalChallengesCompleted: totalChallengesCompleted,
      winRate: winRate,
      lastActivityDate: lastActivityDate,
      email: email ?? this.email,
    );
  }
}
