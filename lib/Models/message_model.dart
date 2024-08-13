class MessageModel {
  final String id;
  final String content;
  final String senderId;
  final String receiverId;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
        id: map['id'],
        content: map['context'],
        senderId: map['senderId'],
        receiverId: map['receiverId'],
        createdAt: DateTime.parse(map['createdAt']));
  }
}
