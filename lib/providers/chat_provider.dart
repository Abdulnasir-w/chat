import 'package:chat/data/repositories/chat_repository.dart';
import 'package:chat/features/chat/application/chat_controller.dart';
import 'package:chat/providers/supabase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRepositoryProvider = Provider((ref) {
  final supabase = ref.watch(supabaseProvider);
  return ChatRepository(supabase);
});

final chatControllerProvider =
    StateNotifierProvider<ChatController, AsyncValue<void>>((ref) {
      return ChatController(ref.watch(chatRepositoryProvider), ref);
    });

final conversationProviders = StreamProvider((ref) {
  return ref.watch(chatRepositoryProvider).getConversations();
});
