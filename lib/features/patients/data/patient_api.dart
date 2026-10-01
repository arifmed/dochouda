import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dochouda/features/patients/models/patient_model.dart';
import 'package:dochouda/core/constants/api_constants.dart';

class PatientApi {
  static const String baseUrl = ApiConstants.baseUrl;

  static Future<List<PatientModel>> getAllPatients() async {
    final response = await http.get(Uri.parse('$baseUrl/patients'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => PatientModel.fromJson(json)).toList();
    }
    throw Exception('Échec de la récupération des patients');
  }

  static Future<PatientModel> getPatientById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/patients/$id'));
    if (response.statusCode == 200) {
      return PatientModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Échec de la récupération du patient');
  }

  static Future<PatientModel> createPatient(PatientModel patient) async {
    final response = await http.post(
      Uri.parse('$baseUrl/patients'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'first_name': patient.firstName,
        'last_name': patient.lastName,
        'full_name': patient.fullName,
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
    if (response.statusCode == 201) {
      return PatientModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Échec de la création du patient');
  }

  static Future<PatientModel> updatePatient(PatientModel patient) async {
    final response = await http.put(
      Uri.parse('$baseUrl/patients/${patient.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'first_name': patient.firstName,
        'last_name': patient.lastName,
        'full_name': patient.fullName,
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
    if (response.statusCode == 200) {
      return PatientModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Échec de la mise à jour du patient');
  }

  static Future<void> deletePatient(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/patients/$id'));
    if (response.statusCode != 204) {
      throw Exception('Échec de la suppression du patient');
    }
  }
}
