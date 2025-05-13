import 'package:chat/data/models/message_model.dart';
import 'package:chat/providers/chat_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageProvider = StreamProvider.family<List<MessageModel>, String>((
  ref,
  conversationId,
) {
  final stream = ref.watch(chatRepositoryProvider).getMessages(conversationId);
  ref.onDispose(() {});
  return stream;
});
