import 'package:chat/Models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageProvider extends ChangeNotifier {
  List<MessageModel> _message = [];
  List<MessageModel> get messages => _message;

  final _supabase = Supabase.instance.client;

  Future<void> fetchMessages(String userId1, String userId2) async {
    try {
      final res = await _supabase
          .from('message')
          .select()
          .or('sender_id.eq.$userId1,receiver_id.eq.$userId2,sender_id.eq.$userId2,receiver_id.eq.$userId1')
          .order('created_at', ascending: true);

      _message = (res as List).map((e) => MessageModel.fromMap(e)).toList();
      notifyListeners();
    } catch (e) {
      throw Exception("Fetch Message Error ::: $e");
    }
  }
}
