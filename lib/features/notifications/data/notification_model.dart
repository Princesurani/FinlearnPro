class NotificationModel {
  final int id;
  final String firebaseUid;
  final String title;
  final String description;
  final String category; // 'trade', 'achievement', 'challenge', 'social'
  final DateTime timestamp;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.firebaseUid,
    required this.title,
    required this.description,
    required this.category,
    required this.timestamp,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int? ?? 0,
      firebaseUid: json['firebase_uid'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? 'social',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String).toLocal()
          : DateTime.now(),
      isRead: json['is_read'] as bool? ?? false,
    );
  }

  NotificationModel copyWith({
    int? id,
    String? firebaseUid,
    String? title,
    String? description,
    String? category,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }
}
