class UserModel {
  final String name;
  final String email;
  final String password;
  final String role;
  final String? avatar;
  // ignore: non_constant_identifier_names
  final String? created_at;
  // ignore: non_constant_identifier_names
  final String? updated_at;

  UserModel({
    required this.name,
    required this.email,
    required this.role,
    required this.password,
    // ignore: non_constant_identifier_names
    this.created_at,
    // ignore: non_constant_identifier_names
    this.updated_at,
    // ignore: non_constant_identifier_names
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      created_at: json['created_at'] ?? '',
      updated_at: json['updated_at'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'created_at': created_at,
      'updated_at': updated_at,
      'avatar': avatar,
    };
  }
}
