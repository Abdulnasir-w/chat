import 'package:chat/data/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactsLsitItems extends StatelessWidget {
  final ContactModel processedContact;
  const ContactsLsitItems({super.key, required this.processedContact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(processedContact.contact.displayName),
      subtitle: _buildPhoneNumbers(),
      trailing:
          processedContact.isRegistered
              ? IconButton(
                icon: const Icon(Icons.chat_bubble_outline),
                onPressed: () => _startChat(context),
              )
              : TextButton(onPressed: _sendInvite, child: const Text('Invite')),
    );
  }

  Widget _buildPhoneNumbers() {
    final phones = processedContact.contact.phones;
    if (phones.isEmpty) return const SizedBox.shrink();

    // Normalize and deduplicate phone numbers
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

  void _startChat(BuildContext context) {
    // TODO: Implement chat screen navigation

    // Implement navigation to chat screen
    if (processedContact.userIds.isNotEmpty) {
      // Navigate to chat with first user ID
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
