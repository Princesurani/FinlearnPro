class TradeSharePost {
  final int id;
  final String firebaseUid;
  final String authorName;
  final String? authorAvatar;
  final int authorLevel;
  final int? tradeId;
  final String symbol;
  final String side;
  final int quantity;
  final double price;
  final double? pnlPercent;
  final String? caption;
  final int likesCount;
  final int commentsCount;
  final bool isLikedByMe;
  final DateTime createdAt;

  TradeSharePost({
    required this.id,
    required this.firebaseUid,
    required this.authorName,
    this.authorAvatar,
    required this.authorLevel,
    this.tradeId,
    required this.symbol,
    required this.side,
    required this.quantity,
    required this.price,
    this.pnlPercent,
    this.caption,
    required this.likesCount,
    required this.commentsCount,
    required this.isLikedByMe,
    required this.createdAt,
  });

  factory TradeSharePost.fromJson(Map<String, dynamic> json) {
    return TradeSharePost(
      id: json['id'] as int,
      firebaseUid: json['firebase_uid'] as String,
      authorName: json['author_name'] as String,
      authorAvatar: json['author_avatar'] as String?,
      authorLevel: json['author_level'] as int,
      tradeId: json['trade_id'] as int?,
      symbol: json['symbol'] as String,
      side: json['side'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      pnlPercent: json['pnl_percent'] != null ? (json['pnl_percent'] as num).toDouble() : null,
      caption: json['caption'] as String?,
      likesCount: json['likes_count'] as int,
      commentsCount: json['comments_count'] as int,
      isLikedByMe: json['is_liked_by_me'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
