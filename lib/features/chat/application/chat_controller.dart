import 'package:chat/core/exceptions/app_exceptions.dart';
import 'package:chat/data/models/conversation_model.dart';
import 'package:chat/data/models/message_model.dart';
import 'package:chat/data/repositories/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatController extends StateNotifier<AsyncValue<void>> {
  final ChatRepository _chatRepository;

  ChatController(this._chatRepository) : super(const AsyncValue.data(null));

  Future<void> sendMessages({
    required String conversationId,
    required String content,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _chatRepository.sendMessage(
        conversationId: conversationId,
        content: content,
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      throw AppException(message: 'Failed to send message: $e', stackTrace: st);
    }
  }

  Future<String> createConversation(String otherUserId) async {
    try {
      print('Creating conversation with otherUserId: $otherUserId');
      final conversationId = await _chatRepository.getOrCreateConversation(
        otherUserId,
      );
      print('Conversation created with ID: $conversationId');
      return conversationId;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      print('Error in createConversation: $e, stack: $st');
      throw AppException(
        message: 'Failed to create conversation: $e',
        stackTrace: st,
      );
    }
  }

  Stream<List<ConversationModel>> watchConversations() {
    return _chatRepository.getConversations();
  }

  Stream<List<MessageModel>> watchMessages(String conversationId) {
    return _chatRepository.getMessages(conversationId);
  }

  Stream<ConversationModel> watchSingleConversation(String conversationId) {
    return _chatRepository.watchConversation(conversationId);
  }
}
