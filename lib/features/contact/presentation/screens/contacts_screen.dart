import 'dart:async';

import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:chat/data/models/contact_model.dart';
import 'package:chat/features/contact/application/contacts_controller.dart';
import 'package:chat/features/contact/presentation/widgets/contacts_lsit_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsScreen extends ConsumerStatefulWidget {
  const ContactsScreen({super.key});

  @override
  ConsumerState<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends ConsumerState<ContactsScreen> {
  final _searchController = TextEditingController();
  Timer? _searchDebounce;
  String _searchQuery = '';
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _focusNode = FocusNode();
  }

  void _onSearchChanged() {
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  List<ContactModel> _filteredContacts(List<ContactModel> contacts) {
    if (_searchQuery.isEmpty) return contacts;
    return contacts.where((contact) {
      final name = contact.contact.displayName.toLowerCase();
      final phones =
          contact.contact.phones.map((p) => p.number).join(' ').toLowerCase();
      return name.contains(_searchQuery) || phones.contains(_searchQuery);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchDebounce?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactAsync = ref.watch(contactsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'contacts',
          style: context.bodyLarge.copyWith(
            fontSize: 18,
            color: context.onSurface,
          ),
        ),
        iconTheme: IconThemeData(color: context.onSurface),
        actions: [
          IconButton(
            onPressed:
                () =>
                    ref
                        .read(contactsControllerProvider.notifier)
                        .loadContacts(),
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            searchBar(),
            Expanded(
              child: contactAsync.when(
                data: (contacts) {
                  final filtered = _filteredContacts(contacts);
                  return ContactList(contacts: filtered);
                },

                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) {
                  debugPrint('Error: ${error.toString()}');
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${error.toString()}'),

                        ElevatedButton(
                          onPressed:
                              () => ref.invalidate(contactsControllerProvider),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SearchBar(
        controller: _searchController,
        focusNode: _focusNode,
        hintText: 'Search contacts by name or number',
        textInputAction: TextInputAction.search,
        trailing:
            _searchController.text.isNotEmpty
                ? [
                  IconButton(
                    onPressed: () {
                      _searchController.clear();
                      _focusNode.requestFocus();
                    },
                    icon: Icon(
                      Icons.clear,
                      size: 20,
                      color:
                          _focusNode.hasFocus
                              ? context.primary
                              : context.onSurface,
                    ),
                  ),
                ]
                : null,
        onTapOutside: (event) {
          _focusNode.unfocus();
        },
        onTap: () {
          _focusNode.requestFocus();
        },
        onSubmitted: (value) {
          _focusNode.unfocus();
        },
        hintStyle: WidgetStateProperty.all(
          context.bodyMedium.copyWith(color: context.onSurface, fontSize: 16),
        ),
        leading: Icon(
          Icons.search_outlined,
          color: _focusNode.hasFocus ? context.primary : context.onSurface,
        ),
        textStyle: WidgetStateProperty.all(
          context.bodyMedium.copyWith(color: context.primary, fontSize: 16),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

class ContactList extends StatelessWidget {
  final List<ContactModel> contacts;

  const ContactList({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return const Center(child: Text('No contacts found'));
    }
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ContactsLsitItems(processedContact: contact);
      },
    );
  }
}
