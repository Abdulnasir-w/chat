import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final Supabase _supabase = Supabase.instance;
  User? _user;
  User? get user => _user;

  Future<void> fetchUser(String userId) async {
    try {
      final response = await _supabase.client
          .from("Profiles")
          .select()
          .eq("id", userId)
          .single();

      final data = response.data as Map
    } catch (e) {}
  }
}
