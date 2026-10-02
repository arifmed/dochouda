import 'dart:typed_data';
import 'dart:convert';
import 'package:dochouda/core/storage/secure_storage.dart';
import 'package:dochouda/core/constants/api_constants.dart';
import 'package:dochouda/features/auth/models/user_model.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AddUser {
  static const String baseUrl = ApiConstants.baseUrl;

  // ============================================================
  // GET TOKEN
  // ============================================================
  static Future<Map<String, String>> _authHeaders() async {
    final token = await SecureStorage.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Token غير موجود. المرجو تسجيل الدخول من جديد.');
    }

    return {'Authorization': 'Bearer $token', 'Accept': 'application/json'};
  }

  // ============================================================
  // CREATE USER
  // ============================================================

  static Future<void> createUser({
    required String name,
    required String email,
    required String password,
    required String role,
    Uint8List? avatarBytes,
    String? avatarName,
  }) async {
    final uri = Uri.parse('$baseUrl/users');

    final request = http.MultipartRequest('POST', uri);

    // ============================================================
    // AUTHENTICATION
    // ============================================================

    final headers = await _authHeaders();

    request.headers.addAll(headers);

    // ============================================================
    // TEXT FIELDS
    // ============================================================

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['role'] = role;

    // ============================================================
    // AVATAR
    // ============================================================

    if (avatarBytes != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'avatar',
          avatarBytes,
          filename: avatarName ?? 'avatar.jpg',
        ),
      );
    }

    // ============================================================
    // SEND REQUEST
    // ============================================================

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    debugPrint('CREATE USER STATUS: ${response.statusCode}');
    debugPrint('CREATE USER BODY: ${response.body}');

    if (response.statusCode != 201) {
      throw Exception('Erreur ${response.statusCode}: ${response.body}');
    }

    final data = jsonDecode(response.body);

    debugPrint('User created: $data');

    if (role == 'admin') {
      debugPrint('L\'utilisateur actuel est un Administrateur');
    } else if (role == 'docteur') {
      debugPrint('L\'utilisateur actuel est un Docteur');
    } else {
      debugPrint(
        'L\'utilisateur actuel n\'est pas un Administrateur ou un Docteur',
      );
    }
  }

  // ============================================================
  // DELETE USER
  // ============================================================

  static Future<void> deleteUser(String id, String role) async {
    final headers = await _authHeaders();

    final response = await http.delete(
      Uri.parse('$baseUrl/users/$id'),
      headers: headers,
    );

    debugPrint('DELETE USER STATUS: ${response.statusCode}');
    debugPrint('DELETE USER BODY: ${response.body}');

    if (response.statusCode != 204) {
      throw Exception(
        'Échec de la suppression de l\'utilisateur '
        '(${response.statusCode}): ${response.body}',
      );
    }

    if (role == 'admin') {
      debugPrint('L\'utilisateur actuel est un Administrateur');
    } else if (role == 'docteur') {
      debugPrint('L\'utilisateur actuel est un Docteur');
    } else {
      debugPrint(
        'L\'utilisateur actuel n\'est pas un Administrateur ou un Docteur',
      );
    }
  }

  // ============================================================
  // GET ALL USERS
  // ============================================================

  static Future<List<UserModel>> getAllUsers() async {
    final headers = await _authHeaders();

    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: headers,
    );

    debugPrint('GET USERS STATUS: ${response.statusCode}');
    debugPrint('GET USERS BODY: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList.map((json) => UserModel.fromJson(json)).toList();
    }

    throw Exception(
      'Échec de la récupération des utilisateurs '
      '(${response.statusCode}): ${response.body}',
    );
  }

  // ============================================================
  // GET USER BY ID
  // ============================================================

  static Future<UserModel> getUserById(String id) async {
    final headers = await _authHeaders();

    final response = await http.get(
      Uri.parse('$baseUrl/users/$id'),
      headers: headers,
    );

    debugPrint('GET USER STATUS: ${response.statusCode}');
    debugPrint('GET USER BODY: ${response.body}');

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }

    throw Exception(
      'Échec de la récupération de l\'utilisateur '
      '(${response.statusCode}): ${response.body}',
    );
  }

  // ============================================================
  // UPDATE USER
  // ============================================================

  static Future<void> updateUser({
    required int id,
    required String name,
    required String email,
    String? password,
    required String role,
    required bool isActive,
    Uint8List? avatarBytes,
    String? avatarName,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/users/$id'),
    );

    // ============================================================
    // AUTHENTICATION
    // ============================================================

    final headers = await _authHeaders();

    request.headers.addAll(headers);

    // ============================================================
    // METHOD SPOOFING
    // ============================================================

    request.fields['_method'] = 'PUT';

    // ============================================================
    // TEXT FIELDS
    // ============================================================

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['role'] = role;

    request.fields['is_active'] = isActive ? '1' : '0';

    // ============================================================
    // PASSWORD
    // ============================================================

    if (password != null && password.isNotEmpty) {
      request.fields['password'] = password;
    }

    // ============================================================
    // AVATAR
    // ============================================================

    if (avatarBytes != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'avatar',
          avatarBytes,
          filename: avatarName ?? 'avatar.jpg',
        ),
      );
    }

    // ============================================================
    // SEND
    // ============================================================

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    debugPrint('UPDATE USER STATUS: ${response.statusCode}');

    debugPrint('UPDATE USER BODY: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(
        'Échec de la mise à jour de l\'utilisateur '
        '(${response.statusCode}): ${response.body}',
      );
    }

    if (role == 'admin') {
      debugPrint('L\'utilisateur actuel est un Administrateur');
    } else if (role == 'docteur') {
      debugPrint('L\'utilisateur actuel est un Docteur');
    } else {
      debugPrint(
        'L\'utilisateur actuel n\'est pas un Administrateur ou un Docteur',
      );
    }
  }

  // ============================================================
  // GET USER BY EMAIL
  // ============================================================

  static Future<UserModel> getUserByEmail(String email) async {
    final headers = await _authHeaders();

    final encodedEmail = Uri.encodeComponent(email);

    final response = await http.get(
      Uri.parse('$baseUrl/users/email/$encodedEmail'),
      headers: headers,
    );

    debugPrint('GET USER EMAIL STATUS: ${response.statusCode}');

    debugPrint('GET USER EMAIL BODY: ${response.body}');

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }

    throw Exception(
      'Utilisateur non trouvé '
      '(${response.statusCode}): ${response.body}',
    );
  }
}
