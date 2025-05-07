import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:chat/data/models/conversation_model.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConversationTile extends StatelessWidget {
  final ConversationModel convo;
  final UserModel user;
  final bool isDarkMode;
  final VoidCallback onTap;
  final int index;
  const ConversationTile({
    super.key,
    required this.convo,
    required this.user,
    required this.isDarkMode,
    required this.onTap,
    required this.index,
  });

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final msgDate = DateTime(date.year, date.month, date.day);
    if (msgDate == today) return DateFormat('HH:mm').format(date);
    if (date.isAfter(today.subtract(const Duration(days: 7)))) {
      return DateFormat('EEE').format(date);
    }
    return DateFormat('MMM dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: context.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color:
                    isDarkMode
                        ? context.onSurface.withAlpha(26)
                        : context.onSurface.withAlpha(50),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar
              Stack(
                children: [
                  user.avatarUrl?.isNotEmpty == true
                      ? CircleAvatar(
                        radius: 30,
                        backgroundColor: context.onSurface.withAlpha(26),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: user.avatarUrl!,
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                            placeholder:
                                (c, _) => const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                ),
                            errorWidget:
                                (c, _, __) => const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Icon(Icons.error, color: Colors.red),
                                ),
                          ),
                        ),
                      )
                      : const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                  // Online status indicator
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.surfaceContainerHighest,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              // Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.userName,
                      style: context.bodyLarge.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      convo.lastMessage ?? 'No messages yet',
                      style: context.bodyMedium.copyWith(
                        color:
                            convo.lastMessage == null
                                ? context.onSurface.withAlpha(128)
                                : context.onSurface,
                        fontStyle:
                            convo.lastMessage == null
                                ? FontStyle.italic
                                : FontStyle.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Trailing timestamp
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatDate(convo.updatedAt ?? convo.createdAt),
                    style: context.bodyMedium.copyWith(
                      color: context.onSurface.withAlpha(179),
                    ),
                  ),
                  if (index % 3 == 0) // Simulate unread messages for demo
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: context.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '3', // Simulate unread count
                        style: context.bodyMedium.copyWith(
                          color: context.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
