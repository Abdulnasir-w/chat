import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:chat/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;
  final bool isDarkMode;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor =
        isMe
            ? context.primary
            : isDarkMode
            ? context.onSurface.withAlpha(26)
            : context.onSurface.withAlpha(26);
    final textColor =
        isMe
            ? context.surface
            : isDarkMode
            ? context.onSurface
            : context.surface;

    final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(13).copyWith(
                topLeft:
                    isMe ? const Radius.circular(13) : const Radius.circular(3),
                topRight:
                    isMe ? const Radius.circular(3) : const Radius.circular(13),
              ),
              boxShadow: [
                BoxShadow(
                  color: context.onSurface.withAlpha(isDarkMode ? 26 : 128),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              message.content,
              style: context.bodyMedium.copyWith(color: textColor),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            DateFormat('HH:mm').format(message.createdAt),
            style: context.bodyMedium.copyWith(
              color: context.onSurface,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
