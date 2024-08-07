import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatProvider extends ChangeNotifier {
  SupabaseClient _supabaseClient;
  final List<Map<String, dynamic>> _chats = [];
  final List<Map<String, dynamic>> _messages = [];
  String? currentChatId;

  ChatProvider(this._supabaseClient) {}
  List<Map<String, dynamic>> get chats => _chats;
  List<Map<String, dynamic>> get messages => _messages;
}
