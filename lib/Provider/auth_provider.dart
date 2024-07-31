import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  User? _user;
  User? get user => _user;

  // Login

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        _user = response.user;
        notifyListeners();
      }
    } on AuthException catch (error) {
      print("the login AuthException Error is ::::: $error");
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } catch (e) {
      print("The login try and catch block error is ::::::=> $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  // Sign Up

  Future<void> signUpWithEmailAndPassword(String userName, String email,
      String password, BuildContext context) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        final updateResponse = await _supabase.from("Profiles").insert([
          {
            'id': response.user!.id,
            'user name': userName,
          }
        ]);
        if (updateResponse.error != null) {
          throw updateResponse.error;
        }
        _user = response.user;
        notifyListeners();
      }
    } on AuthException catch (error) {
      print("the AuthException Error is ::::: $error");
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } catch (e) {
      print("The try and catch block error is ::::::=> $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }
}
