class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final DateTime? readAt;
  final DateTime createdAt;
  final List<Reaction>? reactions;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    this.readAt,
    required this.createdAt,
    this.reactions,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      conversationId: json['conversation_id'] as String,
      senderId: json['sender_id'] as String,
      content: json['content'] as String,
      readAt:
          json['read_at'] != null
              ? DateTime.parse(json['read_at'] as String)
              : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      reactions:
          json['reactions'] != null
              ? (json['reactions'] as List)
                  .map((r) => Reaction.fromJson(r as Map<String, dynamic>))
                  .toList()
              : null,
    );
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          conversationId == other.conversationId &&
          senderId == other.senderId &&
          content == other.content &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      Object.hash(id, conversationId, senderId, content, createdAt);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'sender_id': senderId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class Reaction {
  final String userId;
  final String emoji;
  final DateTime createdAt;

  Reaction({
    required this.userId,
    required this.emoji,
    required this.createdAt,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      userId: json['user_id'] as String,
      emoji: json['emoji'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'emoji': emoji,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Reaction &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          emoji == other.emoji &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(userId, emoji, createdAt);
}
