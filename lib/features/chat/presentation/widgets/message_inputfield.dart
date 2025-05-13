import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageInputfield extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSendMessage;
  final FocusNode focusNode;
  const MessageInputfield({
    super.key,
    required this.controller,
    required this.onSendMessage,
    required this.focusNode,
  });

  @override
  ConsumerState<MessageInputfield> createState() => _MessageInputfieldState();
}

class _MessageInputfieldState extends ConsumerState<MessageInputfield> {
  final hasTextProvider = StateProvider<bool>((ref) => false);
  final _scrollController = ScrollController();

  BoxBorder borderStyle() {
    return Border.all(width: 1, color: Colors.grey);
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChange);
  }

  void _onTextChange() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (ref.read(hasTextProvider.notifier).state != hasText) {
      ref.read(hasTextProvider.notifier).state = hasText;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChange);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = ref.watch(hasTextProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.17,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: borderStyle(),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                      color: context.onSurface,
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: TextField(
                        controller: widget.controller,
                        scrollController: _scrollController,
                        keyboardType: TextInputType.multiline,
                        focusNode: widget.focusNode,
                        minLines: 1,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.top,
                        textInputAction: TextInputAction.send,
                        onTapUpOutside: (_) => FocusScope.of(context).unfocus(),
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            widget.onSendMessage();
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Message',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.attach_file, color: context.onSurface),
                  ),
                  if (!hasText)
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: context.onSurface,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            widget.onSendMessage();
          },
          icon: CircleAvatar(
            backgroundColor: context.primary,
            radius: 20,
            child: Center(child: Icon(Icons.send, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
