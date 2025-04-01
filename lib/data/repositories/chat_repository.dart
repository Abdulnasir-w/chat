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
        .order('created_ag')
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
  }

  // Get or create conversation between two users

  Future<String> getOrCreateConversation(String otherUserId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('Not authenticated');
    final response = await _supabase.rpc(
      'get_conversation',
      params: {'user_1': userId, 'user_2': otherUserId},
    );

    if (response == null) {
      final conversation =
          await _supabase.from('conversations').insert({}).select().single();

      await _supabase.from('participants').insert({
        {'user_id': userId, 'conversation_id': conversation['id']},
        {'user_id': otherUserId, 'conversation_id': conversation['id']},
      });

      return conversation['id'] as String;
    }
    return response['id'] as String;
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
