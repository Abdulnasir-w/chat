import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:chat/features/chat/presentation/widgets/pop_menu.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String conversationId;
  const ChatScreen({super.key, required this.conversationId});
  void _handleMenuSelection(MenuAction action, BuildContext context) {
    switch (action) {
      case MenuAction.viewContact:
        // Handle view contact
        break;
      case MenuAction.search:
        // Handle search
        break;
      case MenuAction.addToList:
        // Handle add to list
        break;
      case MenuAction.media:
        // Handle media
        break;
      case MenuAction.disappearing:
        // Handle disappearing messages
        break;
      case MenuAction.mute:
        // Handle mute notifications
        break;
      case MenuAction.report:
        // Handle report
        break;
      case MenuAction.block:
        // Handle block
        break;
      case MenuAction.clearChat:
        // Handle clear chat
        break;
      case MenuAction.exportChat:
        // Handle export
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(conversationId, style: context.bodyLarge),
        actions: [
          AppPopupMenu(
            onSelected: (action) => _handleMenuSelection(action, context),
          ),
        ],
        iconTheme: IconThemeData(
          color: isDarkMode ? context.onSurface : context.surface,
        ),
      ),
      body: SafeArea(child: Column()),
    );
  }
}
