import 'package:dochouda/core/constants/api_constants.dart';
import 'package:dochouda/features/auth/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddUser {
  static const String baseUrl = ApiConstants.baseUrl;

  // CREATE
  static Future<UserModel> createUser(UserModel user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Échec de la création de l\'utilisateur');
  }

  static Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/user/$id'));
    if (response.statusCode != 204) {
      throw Exception('Échec de la suppression de l\'utilisateur');
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
    final response = await http.get(Uri.parse('$baseUrl/user/$id'));
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Échec de la récupération de l\'utilisateur');
  }

  // UPDATE
  static Future<UserModel> updateUser(String id, UserModel user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/user/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Échec de la mise à jour de l\'utilisateur');
  }

  // CHANGER LE MOT DE PASSE
  static Future<void> changePassword(String userId, String newPassword) async {
    final response = await http.put(
      Uri.parse('$baseUrl/user/$userId/password'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'password': newPassword}),
    );

    if (response.statusCode != 200) {
      throw Exception('Échec du changement de mot de passe');
    }
  }

  // RÉCUPÉRER PAR EMAIL
  static Future<UserModel> getUserByEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/user/email/$email'));

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }

    throw Exception('Utilisateur non trouvé');
  }
}
