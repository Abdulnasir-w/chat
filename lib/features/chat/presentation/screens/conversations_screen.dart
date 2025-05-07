import 'package:chat/core/exceptions/app_exceptions.dart';
import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/features/chat/presentation/screens/chat_screen.dart';
import 'package:chat/features/chat/presentation/widgets/conversation_tile.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:chat/providers/chat_provider.dart';
import 'package:chat/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConversationsScreen extends ConsumerWidget {
  const ConversationsScreen({super.key});

  PopupMenuItem<String> menuItem({
    required String title,
    required String value,
  }) {
    return PopupMenuItem(value: value, child: Text(title));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationProviders);
    final authState = ref.watch(authContollerProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat', style: context.bodyLarge.copyWith(fontSize: 22)),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            color: context.surface,
            onSelected: (value) {
              /* handle menu */
            },
            itemBuilder:
                (_) => [
                  menuItem(title: 'Settings', value: 'settings'),
                  menuItem(title: 'Profile', value: 'profile'),
                  menuItem(title: 'Starred', value: 'starred'),
                  menuItem(title: 'New Group', value: 'newGroup'),
                ],
          ),
        ],
        iconTheme: IconThemeData(
          color: isDarkMode ? context.onSurface : context.surface,
        ),
      ),
      body: authState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Auth Error: $err')),
        data: (currentUser) {
          if (currentUser == null) {
            return const Center(child: Text('Please log in'));
          }
          return conversationsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error:
                (err, _) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Conversation Error: $err'),
                      ElevatedButton(
                        onPressed: () => ref.refresh(conversationProviders),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
            data: (conversations) {
              if (conversations.isEmpty) {
                return const Center(child: Text('No conversations yet'));
              }
              return RefreshIndicator(
                onRefresh: () => ref.refresh(conversationProviders.future),
                child: ListView.builder(
                  cacheExtent: 1000,
                  itemCount: conversations.length,
                  itemBuilder: (context, index) {
                    final convo = conversations[index];
                    // Determine the other participant
                    final otherId = convo.participantIds.firstWhere(
                      (id) => id != currentUser.id,
                      orElse: () => '',
                    );
                    if (otherId.isEmpty) {
                      // Skip self-chat entries
                      return const SizedBox.shrink();
                    }
                    return FutureBuilder<UserModel?>(
                      future: _fetchUserInfo(ref, otherId),
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: context.onSurface,
                            ),
                            title: const Text('Loading...'),
                          );
                        }
                        if (snap.hasError) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: context.onSurface,
                              child: const Icon(Icons.error),
                            ),
                            title: const Text('Error loading user'),
                            subtitle: const Text('Tap to retry'),
                            onTap: () => ref.refresh(userProvider(otherId)),
                          );
                        }
                        final user = snap.data;
                        if (user == null) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: context.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: context.onSurface
                                      .withOpacity(0.1),
                                  child: const Icon(
                                    Icons.person_off,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text('Unknown user', style: context.bodyLarge),
                              ],
                            ),
                          );
                        }
                        // Display conversation tile
                        return ConversationTile(
                          convo: convo,
                          user: user,
                          isDarkMode: isDarkMode,
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => ChatScreen(
                                        conversationId: convo.id,
                                        user: user,
                                      ),
                                ),
                              ),
                          index: index,
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<UserModel?> _fetchUserInfo(WidgetRef ref, String userId) async {
    try {
      return await ref.read(userProvider(userId).future);
    } catch (e, st) {
      debugPrint('Error fetching user info: $e');
      throw AppException(message: e.toString(), stackTrace: st);
    }
  }
}
