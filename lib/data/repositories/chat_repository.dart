import 'package:chat/core/exceptions/app_exceptions.dart';
import 'package:chat/data/models/conversation_model.dart';
import 'package:chat/data/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRepository {
  final SupabaseClient _supabase;

  ChatRepository(this._supabase);

  // Get real-time message stream for a conversation
  Stream<List<MessageModel>> getMessages(String conversationId) {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at')
        .map((data) => data.map(MessageModel.fromJson).toList());
  }

  // Send new message
  Future<void> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _supabase.from('messages').insert({
      'conversation_id': conversationId,
      'sender_id': userId,
      'content': content,
    });
    await _supabase
        .from('conversations')
        .update({'last_message': content})
        .eq('id', conversationId);
  }

  // Get or create conversation between two users

  Future<String> getOrCreateConversation(String otherUserId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw AppException(message: 'Not authenticated');

    // Validate UUID format
    final uuidPattern = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
    );
    if (!uuidPattern.hasMatch(otherUserId)) {
      throw Exception('Invalid user ID format: $otherUserId');
    }

    try {
      final response = await _supabase.rpc(
        'get_or_create_conversation',
        params: {'user1_id': userId, 'user2_id': otherUserId},
      );
      if (response == null) {
        throw Exception('RPC returned null response');
      }
      if (response is! String) {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
      return response;
    } catch (e) {
      throw Exception('Failed to get or create conversation: $e');
    }
  }

  Stream<ConversationModel> watchConversation(String conversationId) {
    return _supabase
        .from('conversations')
        .stream(primaryKey: ['id'])
        .eq('id', conversationId)
        .map((data) => ConversationModel.fromJson(data.first));
  }

  // Get list of conversations for current user
  Stream<List<ConversationModel>> getConversations() {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('Not authenticated');
    return _supabase
        .from('participants')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .asyncMap((participants) async {
          final List<ConversationModel> conversations = [];
          for (final participants in participants) {
            final conversation =
                await _supabase
                    .from('conversations')
                    .select()
                    .eq('id', participants['conversation_id'])
                    .single();

            conversations.add(ConversationModel.fromJson(conversation));
          }
          return conversations;
        });
  }
}
