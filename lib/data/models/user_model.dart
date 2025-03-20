import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel {
  final String id;
  final String email;
  final String userName;
  final String? avatarUrl;
  final String? createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.userName,
    this.avatarUrl,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      userName: json['userName'],
      avatarUrl: json['avatarUrl'] ?? "",
      createdAt: json['createdAt'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'avatar_url': avatarUrl,
      'created_at': createdAt,
    };
  }

  static UserModel fromAuthUser(User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      userName: user.userMetadata?['userName'] as String,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
    );
  }
}
