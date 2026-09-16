class UserModel {
  final String name;
  final String email;
  final String password;
  final String role;

  UserModel({
    required this.name,
    required this.email,
    required this.role,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password, 'role': role};
  }
}
