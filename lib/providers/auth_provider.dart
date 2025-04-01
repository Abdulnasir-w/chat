import 'package:chat/data/models/user_model.dart';
import 'package:chat/data/repositories/auth_repository.dart';
import 'package:chat/features/auth/application/auth_controller.dart';
import 'package:chat/providers/supabase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final supabase = ref.watch(supabaseProvider);
  return AuthRepository(supabase);
});

final authContollerProvider =
    StateNotifierProvider<AuthController, AsyncValue<UserModel?>>((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
      return AuthController(authRepository);
    });
final authStateChangesProvider = StreamProvider<UserModel?>((ref) {
  final supabase = ref.watch(supabaseProvider);
  return supabase.auth.onAuthStateChange.map((event) {
    return event.session?.user != null
        ? UserModel.fromAuthUser(event.session!.user)
        : null;
  });
});
