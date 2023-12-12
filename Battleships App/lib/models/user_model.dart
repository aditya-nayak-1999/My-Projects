class UserModel {
  String username;
  String token;

  UserModel({required this.username, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final username = json['username'] as String? ?? 'default_username';
    final token = json['access_token'] as String? ?? 'default_token';
    return UserModel(
      username: username,
      token: token,
    );
  }
}
