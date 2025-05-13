import 'package:chat/core/exceptions/app_exceptions.dart';
import 'package:chat/data/models/conversation_model.dart';
import 'package:chat/data/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRepository {
  final SupabaseClient _supabase;

  ChatRepository(this._supabase);

  Future<String> getOrCreateConversation(String otherUserId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      throw AppException(message: 'Not authenticated');
    }

    // Validate UUID format
    final uuidPattern = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
    );
    if (!uuidPattern.hasMatch(otherUserId)) {
      throw AppException(message: 'Invalid user ID format: $otherUserId');
    }

    try {
      // Verify otherUserId exists
      final userExists =
          await _supabase
              .from('users')
              .select('id')
              .eq('id', otherUserId)
              .maybeSingle();
      if (userExists == null) {
        throw AppException(message: 'User with ID $otherUserId does not exist');
      }

      print(
        'Calling RPC get_or_create_conversation with user1_id: $userId, user2_id: $otherUserId',
      );
      final response = await _supabase.rpc(
        'get_or_create_conversation',
        params: {'user1_id': userId, 'user2_id': otherUserId},
      );
      print('RPC response: $response');
      if (response == null) {
        throw AppException(
          message: 'RPC get_or_create_conversation returned null',
        );
      }
      if (response is! String) {
        throw AppException(
          message:
              'Unexpected response type: ${response.runtimeType}, value: $response',
        );
      }
      print('RPC returned conversation ID: $response');
      return response;
    } on PostgrestException catch (e, st) {
      final errorMsg =
          'PostgrestException: ${e.message}, code: ${e.code}, details: ${e.details}';
      print('$errorMsg, stack: $st');
      throw AppException(message: errorMsg, stackTrace: st);
    } catch (e, st) {
      final errorMsg = 'Unexpected error: $e';
      print('$errorMsg, stack: $st');
      throw AppException(message: errorMsg, stackTrace: st);
    }
  }

  Stream<List<MessageModel>> getMessages(String conversationId) {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at')
        .map((data) => data.map(MessageModel.fromJson).toList());
  }

  Future<void> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw AppException(message: 'User not authenticated');

    await _supabase.from('messages').insert({
      'conversation_id': conversationId,
      'sender_id': userId,
      'content': content,
      'created_at': DateTime.now().toIso8601String(),
    });
    await _supabase
        .from('conversations')
        .update({
          'last_message': content,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', conversationId);
  }

  Stream<ConversationModel> watchConversation(String conversationId) {
    return _supabase
        .from('conversations')
        .stream(primaryKey: ['id'])
        .eq('id', conversationId)
        .map((data) => ConversationModel.fromJson(data.first));
  }

  Stream<List<ConversationModel>> getConversations() async* {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw AppException(message: 'Not authenticated');
    print('Fetching conversations for user ID: $userId');

    try {
      // Initial fetch using RPC
      final initialResponse =
          await _supabase.rpc('get_user_conversations').select();
      print('Initial conversation data: $initialResponse');
      List<ConversationModel> conversations =
          initialResponse.map(ConversationModel.fromJson).toList();
      yield conversations;

      // Stream updates from the conversations table
      yield* _supabase
          .from('conversations')
          .stream(primaryKey: ['id'])
          .order('updated_at', ascending: false)
          .map((data) {
            print('Streamed conversation data: $data');
            final filteredData =
                data.where((row) {
                  final participantIds =
                      row['participant_ids'] as List<dynamic>;
                  return participantIds.contains(userId);
                }).toList();
            return filteredData.map(ConversationModel.fromJson).toList();
          });
    } catch (e, st) {
      print('Error in getConversations: $e');
      throw AppException(
        message: 'Failed to fetch conversations: $e',
        stackTrace: st,
      );
    }
  }

  Future<void> sendReaction({
    required String messageId,
    required String emoji,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw AppException(message: 'User not authenticated');

    try {
      // Check if the message exists
      final messageExists = await _supabase
          .from('messages')
          .select('id, reactions')
          .eq('id', messageId)
          .maybeSingle();
      if (messageExists == null) {
        throw AppException(message: 'Message with ID $messageId does not exist');
      }

      // Check for existing reaction to prevent duplicates
      final existingReactions = messageExists['reactions'] != null
          ? (messageExists['reactions'] as List<dynamic>).cast<Map<String, dynamic>>()
          : <Map<String, dynamic>>[];
      final hasReaction = existingReactions.any(
        (r) => r['user_id'] == userId && r['emoji'] == emoji,
      );
      if (hasReaction) {
        throw AppException(message: 'User already reacted with $emoji');
      }

      // Append new reaction
      final newReaction = {
        'user_id': userId,
        'emoji': emoji,
        'created_at': DateTime.now().toIso8601String(),
      };
      await _supabase
          .from('messages')
          .update({
            'reactions': [...existingReactions, newReaction],
          })
          .eq('id', messageId);
    } on PostgrestException catch (e, st) {
      final errorMsg =
          'PostgrestException: ${e.message}, code: ${e.code}, details: ${e.details}';
      print('$errorMsg, stack: $st');
      throw AppException(message: errorMsg, stackTrace: st);
    } catch (e, st) {
      final errorMsg = 'Unexpected error: $e';
      print('$errorMsg, stack: $st');
      throw AppException(message: errorMsg, stackTrace: st);
    }
  }
}
