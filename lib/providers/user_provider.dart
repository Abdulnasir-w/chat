import 'package:chat/data/models/user_model.dart';
import 'package:chat/providers/supabase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = FutureProvider.family<UserModel?, String>((
  ref,
  userId,
) async {
  if (userId.isEmpty) return null;
  final supabase = ref.watch(supabaseProvider);
  try {
    final response =
        await supabase.from('users').select().eq('id', userId).maybeSingle();
    if (response == null) return null;

    String? avatarUrl;
    if (response['avatar_url'] != null) {
      try {
        avatarUrl = await supabase.storage
            .from('avatars')
            .createSignedUrl(response['avatar_url'], 3600);
      } catch (e) {
        // Handle failure to generate signed URL
        debugPrint('Failed to generate signed URL for avatar: $e');
        avatarUrl = null; // Fallback to null if signed URL generation fails
      }
    }

    return UserModel(
      id: response['id'],
      userName: response['user_name'],
      avatarUrl: avatarUrl,
      email: response['email'],
      phoneNumber: response['phone_number'],
      createdAt: DateTime.parse(response['created_at']),
    );
  } catch (e) {
    debugPrint('Failed to fetch user: $e');
    throw Exception('Failed to fetch user: $e');
  }
});
