import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/features/chat/presentation/screens/custom_message_bubble.dart';
import 'package:chat/features/chat/presentation/widgets/message_inputfield.dart';
import 'package:chat/features/chat/presentation/widgets/pop_menu.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String conversationId;
  final UserModel? user;
  const ChatScreen({super.key, required this.conversationId, this.user});
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

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
    final messageAsync = ref.watch(messageProvider(widget.conversationId));
    final authState = ref.watch(authContollerProvider);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: context.onSurface.withOpacity(0.1),
              child:
                  widget.user?.avatarUrl?.isNotEmpty == true
                      ? ClipOval(
                        child: Image.network(
                          widget.user!.avatarUrl!,
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.person),
                        ),
                      )
                      : const Icon(Icons.person),
            ),
            const SizedBox(width: 8),
            Text(widget.user!.userName, style: context.bodyLarge),
          ],
        ),
        actions: [
          AppPopupMenu(
            onSelected: (action) => _handleMenuSelection(action, context),
          ),
        ],
        iconTheme: IconThemeData(
          color: isDarkMode ? context.onSurface : context.surface,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              Expanded(
                child: authState.when(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (error, _) => Center(child: Text('Auth Error: $error')),
                  data: (currentUser) {
                    if (currentUser == null) {
                      return const Center(child: Text('Please log in'));
                    }
                    return messageAsync.when(
                      data: (messages) {
                        if (messages.isEmpty) {
                          return Center(
                            child: Text(
                              'No messages yet. Start the conversation!',
                              style: context.bodyMedium.copyWith(
                                color: context.onSurface,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final isMe = message.senderId == currentUser.id;
                            return MessageBubble(
                              message: message,
                              isMe: isMe,
                              isDarkMode: isDarkMode,
                            );
                          },
                        );
                      },
                      error:
                          (error, stackTrace) =>
                              Center(child: Text('Error: $error')),
                      loading:
                          () => const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MessageInputfield(
                  controller: _messageController,
                  onSendMessage: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      ref
                          .watch(chatControllerProvider.notifier)
                          .sendMessages(
                            conversationId: widget.conversationId,
                            content: _messageController.text.trim(),
                          );
                      _messageController.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
