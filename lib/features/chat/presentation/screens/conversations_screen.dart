import 'package:chat/features/chat/presentation/screens/chat_screen.dart';
import 'package:chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConversationsScreen extends ConsumerWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationProviders);
    return Scaffold(
      body: conversationsAsync.when(
        error: (error, _) => Center(child: Text('Error: $error')),
        loading: () => CircularProgressIndicator(),
        data:
            (conversation) => ListView.builder(
              itemCount: conversation.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Conversation ${index + 1}'),
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ChatScreen()),
                      ),
                );
              },
            ),
      ),
    );
  }
}
