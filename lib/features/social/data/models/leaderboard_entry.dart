class LeaderboardEntry {
  final String firebaseUid;
  final String displayName;
  final String? avatarUrl;
  final int level;
  final int totalXp;
  final int weeklyXp;
  final int currentStreak;
  final int totalTrades;
  final double winRate;
  final int rank;

  LeaderboardEntry({
    required this.firebaseUid,
    required this.displayName,
    this.avatarUrl,
    required this.level,
    required this.totalXp,
    required this.weeklyXp,
    required this.currentStreak,
    required this.totalTrades,
    required this.winRate,
    required this.rank,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      firebaseUid: json['firebase_uid'] ?? '',
      displayName: json['display_name'] ?? 'Trader',
      avatarUrl: json['avatar_url'],
      level: json['level'] ?? 1,
      totalXp: json['total_xp'] ?? 0,
      weeklyXp: json['weekly_xp'] ?? 0,
      currentStreak: json['current_streak'] ?? 0,
      totalTrades: json['total_trades'] ?? 0,
      winRate: (json['win_rate'] ?? 0.0).toDouble(),
      rank: json['rank'] ?? 0,
    );
  }
}
