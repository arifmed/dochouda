import 'dart:convert';

import 'package:dochouda/core/constants/api_constants.dart';
import 'package:dochouda/core/storage/secure_storage.dart';
import 'package:dochouda/features/patients/models/patient_model.dart';

import 'package:http/http.dart' as http;

class PatientApi {
  static const String baseUrl = ApiConstants.baseUrl;

  // CREATE
  static Future<PatientModel> createPatient(PatientModel patient) async {
    final token = await SecureStorage.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/patients'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'first_name': patient.firstName,
        'last_name': patient.lastName,
        'date_of_birth': patient.dateOfBirth,
        'gender': patient.gender,
        'phone': patient.phone,
        'email': patient.email,
        'address': patient.address,
        'blood_type': patient.bloodType,
        'emergency_contact_name': patient.emergencyContactName,
        'emergency_contact_phone': patient.emergencyContactPhone,
        'allergies': patient.allergies,
        'chronic_diseases': patient.chronicDiseases,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PatientModel.fromJson(jsonDecode(response.body));
    }

    throw Exception('Erreur ${response.statusCode}: ${response.body}');
  }

  // READ ALL
  static Future<List<PatientModel>> getAllPatients() async {
    final token = await SecureStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/patients'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body)['data'];
      return jsonList.map((json) => PatientModel.fromJson(json)).toList();
    }

    throw Exception('Erreur ${response.statusCode}: ${response.body}');
  }

  // show patient by id
  static Future<PatientModel> showPatient(int id) async {
    final token = await SecureStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/patients/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return PatientModel.fromJson(jsonDecode(response.body));
    }

    throw Exception('Erreur ${response.statusCode}: ${response.body}');
  }

  // UPDATE patient by id
  static Future<PatientModel> updatePatient(
    int id,
    PatientModel patient,
  ) async {
    final Uri url = Uri.parse('$baseUrl/patients/$id');
    final token = await SecureStorage.getToken();
    try {
      // استخدم http.put للتحديث الكامل، أو http.patch للتحديث الجزئي
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'first_name': patient.firstName,
          'last_name': patient.lastName,
          'date_of_birth': patient.dateOfBirth,
          'gender': patient.gender,
          'phone': patient.phone,
          'email': patient.email,
          'address': patient.address,
          'blood_type': patient.bloodType,
          'emergency_contact_name': patient.emergencyContactName,
          'emergency_contact_phone': patient.emergencyContactPhone,
          'allergies': patient.allergies,
          'chronic_diseases': patient.chronicDiseases,
        }),
      );

      print('Response body: ${response.body}');
      print('Response status: ${response.statusCode}');

      // التأكد من نجاح الطلب (200 OK أو 204 No Content)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return PatientModel.fromJson(data);
      } else if (response.statusCode == 204) {
        return patient; // في حال كان السيرفر لا يرجع محتوى بعد التحديث
      } else {
        throw Exception(
          'فشل تحديث البيانات. كود الاستجابة: ${response.statusCode}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('حدث خطأ أثناء الاتصال بالخادم: $e');
    }
  }

  // DELETE
  static Future<PatientModel> deletePatient(PatientModel patient) async {
    final token = await SecureStorage.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/patients/${patient.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PatientModel.fromJson(jsonDecode(response.body));
    }

    throw Exception('Erreur ${response.statusCode}: ${response.body}');
  }
}
