// ignore_for_file: unnecessary_null_comparison

import 'package:chat/core/exceptions/app_exceptions.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  Future<UserModel> _completeUserProfile(User user) async {
    final response =
        await _supabase.from('users').select().eq('id', user.id).single();

    return UserModel.fromJson(response);
  }

  // sign in
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user!;

      return _completeUserProfile(user);
    } on AuthException catch (e) {
      throw AppAuthException(message: e.message);
    } catch (e) {
      throw AppException(message: 'Failed to sign in: ${e.toString()}');
    }
  }

  // sign up
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String userName,
    required String phone,
    required String avatar,
  }) async {
    try {
      // Step 1: Auth signup only
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'user_name': userName,
          'phone_number': phone,
          'avatar_url': avatar,
        },
      );
      if (response.user == null) {
        throw AppAuthException(message: 'User creation failed');
      }

      print("Auth signup successful: ${response.user!.id}");

      // // Step 2: Manual insert
      // await _supabase.from('users').insert({
      //   'id': response.user!.id,
      //   'email': email,
      //   'user_name': userName,
      //   'phone_number': phone,
      //   'avatar_url': avatar,
      //   'created_at': DateTime.now().toIso8601String(),
      // });

      print("Users table insert successful");

      final user = response.user!;
      return _completeUserProfile(user);
    } on AuthException catch (e) {
      print('AuthException: ${e.code}, ${e.message}, ${e.statusCode}');
      throw AppAuthException(message: e.message);
    } on PostgrestException catch (e) {
      print('PostgrestException: ${e.message}, ${e.code}');
      throw AppAuthException(message: e.message);
    } catch (e, stackTrace) {
      print('General Error: $e');
      print('Stack Trace: $stackTrace');
      throw AppException(message: 'Failed to sign up: ${e.toString()}');
    }
  }

  // reset Password
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
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
    final user = _supabase.auth.currentUser;
    return user != null ? UserModel.fromAuthUser(user) : null;
  }
}

class AuthResponse {
  final UserModel user;
  final Session? session;

  AuthResponse({required this.user, this.session});
}
