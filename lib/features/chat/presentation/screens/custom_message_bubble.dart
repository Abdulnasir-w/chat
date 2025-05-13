import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:chat/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MessageBubble extends ConsumerStatefulWidget {
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
  ConsumerState<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends ConsumerState<MessageBubble> {
  Widget _buildReaction(String emoji) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();

        print("Reacted with $emoji to message: ${widget.message.content}");
      },
      icon: Text(emoji, style: const TextStyle(fontSize: 22)),
    );
  }

  void _showReactionDialog(BuildContext context) {
    final RenderBox bubbleBox = context.findRenderObject() as RenderBox;
    final bubblePosition = bubbleBox.localToGlobal(Offset.zero);
    final bubbleSize = bubbleBox.size;
    final dialogWidth = 200.0;
    final dialogHeight = 50.0;

    // Calculate dialog position above the bubble, centered horizontally
    double dialogX = bubblePosition.dx + (bubbleSize.width - dialogWidth) / 3;
    double dialogY = bubblePosition.dy - dialogHeight - 10; // 10px above bubble

    // Ensure dialog stays within screen bounds
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    dialogX = dialogX.clamp(8.0, overlay.size.width - dialogWidth - 8.0);
    dialogY = dialogY.clamp(8.0, overlay.size.height - dialogHeight - 8.0);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      pageBuilder: (context, _, __) {
        return Stack(
          children: [
            Positioned(
              left: dialogX,
              top: dialogY,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: widget.isDarkMode ? context.surface : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: context.onSurface.withAlpha(40),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildReaction('❤️'),
                    _buildReaction('😂'),
                    _buildReaction('🔥'),
                    _buildReaction('👍'),
                    _buildReaction('😢'),
                    _buildReaction('😡'),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bubbleColor =
        widget.isMe
            ? context.primary
            : widget.isDarkMode
            ? context.onSurface.withAlpha(26)
            : context.onSurface.withAlpha(26);
    final textColor =
        widget.isMe
            ? context.surface
            : widget.isDarkMode
            ? context.onSurface
            : context.surface;

    final alignment =
        widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment: alignment,
        spacing: 4,
        children: [
          GestureDetector(
            onLongPress: () => _showReactionDialog(context),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(13).copyWith(
                  topLeft:
                      widget.isMe
                          ? const Radius.circular(13)
                          : const Radius.circular(3),
                  topRight:
                      widget.isMe
                          ? const Radius.circular(3)
                          : const Radius.circular(13),
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.onSurface.withAlpha(
                      widget.isDarkMode ? 26 : 128,
                    ),
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                widget.message.content,
                style: context.bodyMedium.copyWith(color: textColor),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment:
                widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('HH:mm').format(widget.message.createdAt),
                style: context.bodyMedium.copyWith(
                  color: context.onSurface,
                  fontSize: 10,
                ),
              ),

              if (widget.message.reactions != null &&
                  widget.message.reactions!.isNotEmpty) ...[
                const SizedBox(width: 4),
                Text(
                  widget.message.reactions!.map((r) => r.emoji).join(' '),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
