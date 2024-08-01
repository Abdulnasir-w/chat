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
    const int maxRetries = 3;
    int retryCount = 0;
    const int retryDelay = 2;
    while (retryCount < maxRetries) {
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
          return;
        }
      } on AuthException catch (error) {
        if (error.statusCode == 429.toString()) {
          retryCount++;
          if (retryCount == maxRetries) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Too many requests. Please try again later.')),
              );
            }
            return;
          }
          await Future.delayed(Duration(seconds: retryDelay * retryCount));
        } else {
          print("the Sign Up AuthException Error is ::::: $error");
          if (context.mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error.toString())));
          }
          return;
        }
      } catch (e) {
        print("The Sign Up try and catch block error is ::::::=> $e");
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
        return;
      }
    }
  }
}
