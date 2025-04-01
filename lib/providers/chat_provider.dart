import 'package:chat/data/models/message_model.dart';
import 'package:chat/data/repositories/chat_repository.dart';
import 'package:chat/features/chat/application/chat_controller.dart';
import 'package:chat/providers/supabase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRepositoryProvider = Provider((ref) {
  final supabase = ref.watch(supabaseProvider);
  return ChatRepository(supabase);
});

final conversationProviders = StreamProvider((ref) {
  return ref.watch(chatRepositoryProvider).getConversations();
});

final messageProvider = StreamProvider.family<List<MessageModel>, String>((
  ref,
  conversationId,
) {
  return ref.watch(chatRepositoryProvider).getMessages(conversationId);
});

final chatControllerProvider = Provider((ref) {
  return ChatController(ref.watch(chatRepositoryProvider));
});
