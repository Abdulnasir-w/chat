class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> data) {
    return MessageModel(
      id: data['id'] as String,
      conversationId: data['conversation_id'] as String,
      senderId: data['sender_id'] as String,
      content: data['content'] as String,
      createdAt: DateTime.parse(data['created_at'] as String),
    );
  }
}
