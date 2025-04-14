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

  ContactsController({required this.ref}) : super(const AsyncValue.loading()) {
    loadContacts();
  }

  Future<void> loadContacts() async {
    state = const AsyncValue.loading();
    try {
      final contacts = await _fetchAndProcessContacts();
      state = AsyncValue.data(contacts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<List<ContactModel>> _fetchAndProcessContacts() async {
    final contacts = await FastContacts.getAllContacts();
    final filteredContacts =
        contacts.where((c) => c.phones.isNotEmpty).toList();

    final phoneNumbers = _extractPhoneNumbers(filteredContacts);
    final supabase = Supabase.instance.client;

    final existingUsers = await supabase
        .from('users')
        .select('id, phone_number')
        .inFilter('phone_number', phoneNumbers);

    final phoneToUserId = {
      for (var user in existingUsers)
        _normalizePhone(user['phone_number']): user['id'] as String,
    };

    // Create list and sort registered contacts first
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

    // Sort contacts with registered users first
    contactList.sort((a, b) {
      if (a.isRegistered && !b.isRegistered) return -1;
      if (!a.isRegistered && b.isRegistered) return 1;
      return 0;
    });
    return contactList;
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
