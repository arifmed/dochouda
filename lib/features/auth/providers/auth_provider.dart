import 'package:dochouda/core/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/network/dio_client.dart';
import '../data/auth_api.dart';
import '../data/auth_repository.dart';
import '../models/user_model.dart';

final dioProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final authApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthApi(dio.dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.watch(authApiProvider);

  return AuthRepository(api);
});

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const AuthState({this.user, this.isLoading = false, this.error});

  AuthState copyWith({UserModel? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository repository;

  AuthController(this.repository) : super(const AuthState()) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      state = state.copyWith(isLoading: true);

      final token = await SecureStorage.getToken();

      if (token != null) {
        final user = await repository.me();

        state = AuthState(user: user, isLoading: false);
      } else {
        state = const AuthState(isLoading: false);
      }
    } catch (e) {
      state = AuthState(
        isLoading: false,
        error: 'Erreur lors de la connexion.',
      );
    }
  }

  Future<bool> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await repository.login(email: email, password: password);

      state = AuthState(user: user, isLoading: false);

      return true;
    } catch (e) {
      state = AuthState(
        isLoading: false,
        error: "L'email ou le mot de passe est incorrect.",
      );

      return false;
    }
  }

  Future<void> logout() async {
    await repository.logout();

    state = const AuthState();
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    final repository = ref.watch(authRepositoryProvider);

    return AuthController(repository);
  },
);
