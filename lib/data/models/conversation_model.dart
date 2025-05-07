class ConversationModel {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String> participantIds; // These will be UUID strings
  final String? lastMessage;

  ConversationModel({
    required this.id,
    required this.createdAt,
    required this.participantIds,
    this.lastMessage,
    this.updatedAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      participantIds: (json['participant_ids'] as List<dynamic>).cast<String>(),
      lastMessage: json['last_message'] as String?,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'] as String)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'participant_ids': participantIds,
      'last_message': lastMessage,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
