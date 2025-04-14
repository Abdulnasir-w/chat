// File: contact_model.dart
import 'package:fast_contacts/fast_contacts.dart';

class ContactModel {
  final Contact contact;
  final bool isRegistered;
  final List<String> userIds;

  ContactModel({
    required this.contact,
    required this.isRegistered,
    required this.userIds,
  });
}
