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
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PatientModel.fromJson(jsonDecode(response.body));
    }

    throw Exception('Erreur ${response.statusCode}: ${response.body}');
  }
}
