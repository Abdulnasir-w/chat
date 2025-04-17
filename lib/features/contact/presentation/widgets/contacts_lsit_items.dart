import 'package:chat/core/exceptions/app_exceptions.dart';
import 'package:chat/core/utils/extensions/snakbar_extension.dart';
import 'package:chat/data/models/contact_model.dart';
import 'package:chat/features/chat/presentation/screens/chat_screen.dart';
import 'package:chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsLsitItems extends StatelessWidget {
  final ContactModel processedContact;
  const ContactsLsitItems({super.key, required this.processedContact});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(processedContact.contact.displayName),
          subtitle: _buildPhoneNumbers(),
          trailing:
              processedContact.isRegistered
                  ? IconButton(
                    icon: const Icon(Icons.chat_bubble_outline),
                    onPressed: () => _startChat(context, ref),
                  )
                  : TextButton(
                    onPressed: _sendInvite,
                    child: const Text('Invite'),
                  ),
        );
      },
    );
  }

  Widget _buildPhoneNumbers() {
    final phones = processedContact.contact.phones;
    if (phones.isEmpty) return const SizedBox.shrink();

    final uniquePhones = <String>{};
    for (var phone in phones) {
      final normalized = _normalizePhone(phone.number);
      if (normalized.isNotEmpty) {
        uniquePhones.add(normalized);
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: uniquePhones.map((phone) => Text(phone)).toList(),
    );
  }

  String _normalizePhone(String phone) {
    return phone.replaceAll(RegExp(r'[^0-9+]'), '');
  }

  void _startChat(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(chatControllerProvider.notifier);
    try {
      if (processedContact.userIds.isEmpty) {
        context.showErrorSnackbar(
          'No registered user ID found for this contact',
        );
        throw AppException(
          message: 'No registered user ID found for this contact',
        );
      }
      final supabaseUserId = processedContact.userIds.first;
      print('Starting chat with userId: $supabaseUserId'); // Debug print
      final conversationId = await controller.createConversation(
        supabaseUserId,
      );
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(conversationId: conversationId),
          ),
        );
      }
    } catch (e, st) {
      if (context.mounted) {
        context.showErrorSnackbar('Failed to start chat: $e');
      }
      debugPrint('Error starting chat: $e, stack: $st');
      throw AppException(message: "Failed to start chat: $e", stackTrace: st);
    }
  }

  void _sendInvite() {
    // TODO: Implement SMS invitation logic
    final phone = processedContact.contact.phones.firstOrNull?.number;
    if (phone != null) {
      // Implement SMS invitation
    }
  }
}
