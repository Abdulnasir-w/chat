import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatProvider extends ChangeNotifier {
  final SupabaseClient _supabaseClient;
  List<Map<String, dynamic>> _chats = [];
  List<Map<String, dynamic>> _messages = [];
  String? currentChatId;

  // Constructor that initializes the Supabase client and starts listening for chat changes
  ChatProvider(this._supabaseClient) {
    _listenForChatChanges();
  }
  List<Map<String, dynamic>> get chats => _chats;
  List<Map<String, dynamic>> get messages => _messages;

// Stream of chats for real-time updates
  Stream<List<Map<String, dynamic>>> get chatStream async* {
    yield* _supabaseClient
        .from("chats")
        .stream(primaryKey: ['id']).order('created_at', ascending: false);
  }

  // Stream of messages for real-time updates for a specific chat
  Stream<List<Map<String, dynamic>>> messageStream(String chatId) async* {
    yield* _supabaseClient
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order("created_at", ascending: true);
  }

  // Method to listen for chat changes and update the local _chats list
  void _listenForChatChanges() {
    _supabaseClient
        .from('chats')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .listen((data) {
          _chats = data;
          notifyListeners();
        });
  }

  // Fetch chats for a specific user (for initial data load)

  Future<void> fetchChats(String userId) async {
    final response = await _supabaseClient
        .from('chats')
        .select()
        .or("user1_id.eq.$userId,user2_id.eq.$userId")
        .order("created_at", ascending: false);
  }
}
