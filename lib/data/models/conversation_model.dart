class ConversationModel {
  final String id;
  final DateTime createdAt;
  final List<String> participantIds;
  final String? lastMessage;

  ConversationModel({
    required this.id,
    required this.createdAt,
    required this.participantIds,
    this.lastMessage,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> data) {
    return ConversationModel(
      id: data['id'] as String,
      createdAt: DateTime.parse(data['created_at'] as String),
      participantIds: List<String>.from(data['participant_ids']),
      lastMessage: data['last_message'] as String?,
    );
  }
}
