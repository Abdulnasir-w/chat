// ignore_for_file: unnecessary_null_comparison

import 'package:chat/core/exceptions/app_exceptions.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  UserModel _getUserFromAuthResponse(AuthResponse response) {
    if (response.user == null) {
      throw AppAuthException(message: 'Authentication failed');
    }
    return UserModel.fromAuthUser(response.user as User);
  }

  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return _getUserFromAuthResponse(response.user as AuthResponse);
    } on AuthException catch (e) {
      throw AppAuthException(message: e.message);
    } catch (e) {
      throw AppException(message: 'Failed to sign in: ${e.toString()}');
    }
  }

  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {"name": userName},
      );
      return _getUserFromAuthResponse(response as AuthResponse);
    } on AuthException catch (e) {
      throw AppAuthException(message: e.message);
    } catch (e) {
      throw AppException(message: 'Failed to sign up: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  UserModel? get currentUser {
    final user = _supabase.auth.currentUser!;
    return user != null ? UserModel.fromAuthUser(user) : null;
  }
}

class AuthResponse {
  final UserModel user;
  final Session? session;

  AuthResponse({required this.user, this.session});
}
