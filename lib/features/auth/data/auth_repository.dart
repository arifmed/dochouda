import '../../../core/storage/secure_storage.dart';
import '../models/user_model.dart';
import 'auth_api.dart';

class AuthRepository {
  final AuthApi api;

  AuthRepository(this.api);

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await api.login(email: email, password: password);

    final data = response.data['data'];

    final token = data['token'];

    final user = UserModel.fromJson(data['user']);

    await SecureStorage.saveToken(token);

    return user;
  }

  Future<UserModel> me() async {
    final response = await api.me();

    return UserModel.fromJson(response.data['data']);
  }

  Future<void> logout() async {
    try {
      await api.logout();
    } finally {
      await SecureStorage.deleteToken();
    }
  }
}
