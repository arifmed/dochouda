import 'dart:core';

import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'package:dochouda/core/constants/api_constants.dart';
import 'package:dochouda/features/auth/models/user_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AddUser {
  static const String baseUrl = ApiConstants.baseUrl;

  // CREATE
  static Future<void> createUser({
    required String name,
    required String email,
    required String password,
    required String role,
    Uint8List? avatarBytes, // Pass raw bytes instead of File
    String? avatarName, // Pass file name (e.g., 'avatar.png')
  }) async {
    final uri = Uri.parse('$baseUrl/users');
    final request = http.MultipartRequest('POST', uri);

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

    if (response.statusCode != 201) {
      throw Exception('Erreur ${response.statusCode}: ${response.body}');
    }

    final data = jsonDecode(response.body);
    print('User created: $data');
    if (role == 'admin') {
      print('L\'utilisateur actuel est un Administrateur');
    } else if (role == 'docteur') {
      print('L\'utilisateur actuel est un Docteur');
    } else {
      print('L\'utilisateur actuel n\'est pas un Administrateur ou un Docteur');
    }
  }

  static Future<void> deleteUser(String id, String role) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode != 204) {
      throw Exception('Échec de la suppression de l\'utilisateur');
    }

    if (role == 'admin') {
      print('L\'utilisateur actuel est un Administrateur');
    } else if (role == 'docteur') {
      print('L\'utilisateur actuel est un Docteur');
    } else {
      print('L\'utilisateur actuel n\'est pas un Administrateur ou un Docteur');
    }
  }

  static Future<List<UserModel>> getAllUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => UserModel.fromJson(json)).toList();
    }

    throw Exception('Échec de la récupération des utilisateurs');
  }

  // READ BY ID
  static Future<UserModel> getUserById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Échec de la récupération de l\'utilisateur');
  }

  static Future<void> updateUser({
    required int id,
    required String name,
    required String email,
    String? password,
    required String role,
    required bool isActive,
    Uint8List? avatarBytes, // Pass bytes instead of File
    String? avatarName, // File name (e.g., 'avatar.jpg')
  }) async {
    // Use POST with _method=PUT to ensure multipart data is parsed correctly on backend frameworks like Laravel
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/users/$id'),
    );

    // Method spoofing for frameworks that don't process multipart/form-data on PUT
    request.fields['_method'] = 'PUT';

    // ============================================================
    // TEXT FIELDS
    // ============================================================
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['role'] = role;
    request.fields['is_active'] = isActive
        ? '1'
        : '0'; // Send '1'/'0' or 'true'/'false' depending on backend requirement

    // Only send password when specified
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
    // SEND REQUEST
    // ============================================================
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception(
        'Échec de la mise à jour de l\'utilisateur (${response.statusCode}): ${response.body}',
      );
    }

    if (role == 'admin') {
      print('L\'utilisateur actuel est un Administrateur');
    } else if (role == 'docteur') {
      print('L\'utilisateur actuel est un Docteur');
    } else {
      print('L\'utilisateur actuel n\'est pas un Administrateur ou un Docteur');
    }
  }

  // RÉCUPÉRER PAR EMAIL
  static Future<UserModel> getUserByEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/users/email/$email'));

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }

    throw Exception('Utilisateur non trouvé');
  }
}
