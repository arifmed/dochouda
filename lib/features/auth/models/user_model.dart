class UserModel {
  final int id;
  final String name;
  final String email;
  final String password;
  final String role;
  final bool is_active;
  final String? avatar;
  // ignore: non_constant_identifier_names
  final String? created_at;
  // ignore: non_constant_identifier_names
  final String? updated_at;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.password,
    required this.is_active,
    // ignore: non_constant_identifier_names
    this.created_at,
    // ignore: non_constant_identifier_names
    this.updated_at,
    // ignore: non_constant_identifier_names
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      is_active: json['is_active'] ?? '',
      created_at: json['created_at'] ?? '',
      updated_at: json['updated_at'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'is_active': is_active,
      'created_at': created_at,
      'updated_at': updated_at,
      'avatar': avatar,
    };
  }
}
