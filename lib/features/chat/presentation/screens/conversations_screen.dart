import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:chat/features/chat/presentation/screens/chat_screen.dart';
import 'package:chat/features/chat/presentation/widgets/pop_menu.dart';
import 'package:chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ConversationsScreen extends ConsumerWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationProviders);
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder:
                (context) => [
                  menu(title: "Setting", onPressed: () {}),
                  menu(title: "Profile", onPressed: () {}),
                ],
          ),
        ],
        iconTheme: IconThemeData(color: context.primary),
      ),
      body: conversationsAsync.when(
        error: (error, _) => Center(child: Text('Error: $error')),
        loading: () => CircularProgressIndicator(),
        data:
            (conversations) => ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];

                return ListTile(
                  title: Text('Conversation ${index + 1}'),
                  subtitle: Text(_formatDate(conversation.createdAt)),

                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) =>
                                  ChatScreen(conversationId: conversation.id),
                        ),
                      ),
                );
              },
            ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, HH:mm').format(date);
  }
}
