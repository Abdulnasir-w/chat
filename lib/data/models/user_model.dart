import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel {
  final String id;
  final String email;
  final String userName;
  final String phoneNumber;
  final String? avatarUrl;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.phoneNumber,
    this.avatarUrl,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      userName: json['user_name'],
      phoneNumber: json['phone_number'],
      avatarUrl: json['avatar_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  static UserModel fromAuthUser(User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      userName: (user.userMetadata?['user_name'] ?? 'User') as String,
      phoneNumber: (user.userMetadata?['phone_number'] ?? '') as String,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      createdAt: DateTime.now(),
    );
  }
}
