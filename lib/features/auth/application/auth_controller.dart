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
  }) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _authRepository.signUpWithEmailPassword(
        email: email,
        password: password,
        userName: userName,
      );
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
