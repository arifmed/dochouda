import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class UserService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {'Accept': 'application/json'},
    ),
  );

  Future<Map<String, dynamic>> getUser(String token) async {
    final response = await dio.get(
      '/user',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return response.data;
  }
}
