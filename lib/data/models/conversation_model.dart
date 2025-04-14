class ConversationModel {
  final String id;
  final DateTime createdAt;
  final List<String> participantIds; // These will be UUID strings
  final String? lastMessage;

  ConversationModel({
    required this.id,
    required this.createdAt,
    required this.participantIds,
    this.lastMessage,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      participantIds:
          (json['participant_ids'] as List<dynamic>)
              .map((id) => id as String)
              .toList(),
      lastMessage: json['last_message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'participant_ids': participantIds,
      'last_message': lastMessage,
    };
  }
}
