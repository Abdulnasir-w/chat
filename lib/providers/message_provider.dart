import 'package:chat/data/models/message_model.dart';
import 'package:chat/providers/supabase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageProvider = StreamProvider.family<List<MessageModel>, String>((
  ref,
  conversationId,
) {
  final supabase = ref.watch(supabaseProvider);

  final stream = supabase
      .from('messages')
      .stream(primaryKey: ['id'])
      .eq("conversation_id", conversationId)
      .order('created_at', ascending: false)
      .map(
        (messages) =>
            messages.map((json) => MessageModel.fromJson(json)).toList(),
      );

  ref.onDispose(() {});
  return stream;
});
