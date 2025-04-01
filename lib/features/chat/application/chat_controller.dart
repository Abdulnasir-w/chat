import 'package:chat/data/repositories/chat_repository.dart';

class ChatController {
  final ChatRepository _chatRepository;

  ChatController(this._chatRepository);

  Future<void> sendMessages(String conversationId, String content) async {
    await _chatRepository.sendMessage(
      conversationId: conversationId,
      content: content,
    );
  }

  Future<String> createConversation(String otherUserId) async {
    return await _chatRepository.getOrCreateConversation(otherUserId);
  }
}
