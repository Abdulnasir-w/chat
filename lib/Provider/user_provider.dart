import 'package:chat/Components/custom_snakbar.dart';
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

      if (response.isNotEmpty) {
        _user = UserModel.fromMap(response) as User?;
        notifyListeners();
      } else {
        const CustomSnackbar(
          message: "Data Not Found",
          alignment: Alignment.bottomCenter,
          type: SnackbarType.warnning,
        );
      }
    } catch (e) {
      const CustomSnackbar(
        message: "Error While Fetching Data",
        alignment: Alignment.bottomCenter,
        type: SnackbarType.error,
      );
    }
  }
}
