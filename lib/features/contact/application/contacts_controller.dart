import 'package:chat/data/models/contact_model.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final contactsControllerProvider =
    StateNotifierProvider<ContactsController, AsyncValue<List<ContactModel>>>(
      (ref) => ContactsController(ref: ref),
    );

class ContactsController extends StateNotifier<AsyncValue<List<ContactModel>>> {
  final Ref ref;

  ContactsController({required this.ref}) : super(const AsyncValue.data([]));
  // Initialize with an empty list instead of loading immediately

  Future<void> loadContacts() async {
    state = const AsyncValue.loading();
    try {
      final contacts = await _fetchAndProcessContacts();
      state = AsyncValue.data(contacts);
    } catch (e, st) {
      print('Error in loadContacts: $e\n$st');
      state = AsyncValue.error(e, st);
    }
  }

  Future<List<ContactModel>> _fetchAndProcessContacts() async {
    try {
      final contacts = await FastContacts.getAllContacts(
        fields: [
          ContactField.phoneNumbers,
          ContactField.displayName,
        ], // Limit fields
      );
      print('Fetched ${contacts.length} contacts.');

      final filteredContacts =
          contacts.where((c) => c.phones.isNotEmpty).toList();
      print('Filtered to ${filteredContacts.length} contacts with phones.');

      final phoneNumbers = _extractPhoneNumbers(filteredContacts);
      print('Extracted ${phoneNumbers.length} phone numbers.');

      final supabase = Supabase.instance.client;

      if (phoneNumbers.isEmpty) {
        print('No phone numbers to query.');
        return [];
      }

      final existingUsers = await supabase
          .from('users')
          .select('id, phone_number')
          .inFilter('phone_number', phoneNumbers);

      print('Fetched ${existingUsers.length} users from Supabase.');

      final phoneToUserId = {
        for (var user in existingUsers)
          _normalizePhone(user['phone_number'] ?? ''): user['id'] as String,
      };

      final contactList =
          filteredContacts.map((contact) {
            final registeredNumbers =
                contact.phones.where((phone) {
                  final normalized = _normalizePhone(phone.number);
                  return phoneToUserId.containsKey(normalized);
                }).toList();

            return ContactModel(
              contact: contact,
              isRegistered: registeredNumbers.isNotEmpty,
              userIds:
                  registeredNumbers
                      .map(
                        (phone) => phoneToUserId[_normalizePhone(phone.number)],
                      )
                      .whereType<String>()
                      .toList(),
            );
          }).toList();

      contactList.sort((a, b) {
        if (a.isRegistered && !b.isRegistered) return -1;
        if (!a.isRegistered && b.isRegistered) return 1;
        return 0;
      });

      print('Final contact list size: ${contactList.length}');
      return contactList;
    } catch (e, st) {
      print('Error in _fetchAndProcessContacts: $e\n$st');
      rethrow;
    }
  }

  List<String> _extractPhoneNumbers(List<Contact> contacts) {
    final numbers = <String>{};
    for (final contact in contacts) {
      for (final phone in contact.phones) {
        final normalized = _normalizePhone(phone.number);
        if (normalized.isNotEmpty) numbers.add(normalized);
      }
    }
    return numbers.toList();
  }

  String _normalizePhone(String phone) {
    return phone.replaceAll(RegExp(r'[^0-9+]'), '');
  }
}
