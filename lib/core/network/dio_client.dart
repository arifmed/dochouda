import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../storage/secure_storage.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,

        connectTimeout: const Duration(seconds: 20),

        receiveTimeout: const Duration(seconds: 20),

        sendTimeout: const Duration(seconds: 20),

        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorage.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },

        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await SecureStorage.deleteToken();
          }

          return handler.next(error);
        },
      ),
    );
  }
}
