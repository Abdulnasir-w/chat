class UserModel {
  final String id;
  final String name;
  final String avatarUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      avatarUrl: map['avatarUrl'] as String? ?? "",
    );
  }
}
