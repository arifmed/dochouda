import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    return dio.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );
  }

  Future<Response> me() async {
    return dio.get(ApiConstants.me);
  }

  Future<Response> logout() async {
    return dio.post(ApiConstants.logout);
  }
}
