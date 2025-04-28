import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:chat/features/chat/presentation/screens/chat_screen.dart';
import 'package:chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ConversationsScreen extends ConsumerWidget {
  const ConversationsScreen({super.key});

  PopupMenuItem menuItem({required String title, required dynamic value}) {
    return PopupMenuItem(value: value, child: Text(title));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationProviders);
    const setting = 'settings';
    const profile = 'profile';
    const starred = 'starred';
    const newGroup = 'newGroup';

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat", style: context.bodyLarge.copyWith(fontSize: 22)),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            position: PopupMenuPosition.under,
            onSelected: (value) {
              if (value == setting) {
                // Handle settings action
              } else if (value == profile) {
                // Handle profile action
              } else if (value == starred) {
                // Handle starred action
              } else if (value == newGroup) {
                // Handle new group action
              }
            },
            itemBuilder:
                (context) => [
                  menuItem(title: "Settings", value: setting),
                  menuItem(title: "Profile", value: profile),
                  menuItem(title: "Starred", value: starred),
                  menuItem(title: "New group", value: newGroup),
                ],
          ),
        ],
        actionsIconTheme: IconThemeData(color: context.onSurface),
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
