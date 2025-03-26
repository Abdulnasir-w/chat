import 'package:chat/core/exceptions/app_exceptions.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/data/repositories/auth_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository _authRepository;

  AuthController(this._authRepository) : super(AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _authRepository.currentUser;
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _authRepository.signInWithEmailPassword(
        email: email,
        password: password,
      );
    });
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
    required String phone,
    required String avatar,
  }) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _authRepository.signUpWithEmailPassword(
        email: email,
        password: password,
        userName: userName,
        phone: phone,
        avatar: avatar,
      );

      final currentUser = _authRepository.currentUser;
      if (currentUser == null) {
        throw AppAuthException(message: 'User creation failed unexpectedly');
      }

      return user;
    });
  }

  Future<void> resetPassword({required String email}) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepository.sendPasswordResetEmail(email: email);
      return null;
    });
  }

  Future<void> signOut() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepository.signOut();
      return null;
    });
  }
}
