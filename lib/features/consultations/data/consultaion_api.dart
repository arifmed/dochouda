import 'dart:convert';

import 'package:dochouda/core/constants/api_constants.dart';
import 'package:dochouda/core/storage/secure_storage.dart';
import 'package:dochouda/features/consultations/models/consultation_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ConsultationApi {
  static const String baseUrl = ApiConstants.baseUrl;

  static Future<void> createConsultation(ConsultationModel consultation) async {
    final token = await SecureStorage.getToken();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/consultations'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'patient_id': consultation.patientId.toString(),
          'date': consultation.date,
          'notes': consultation.notes,
          'type_consultation': consultation.type_consultation,
          'symptoms': consultation.symptoms,
          'diagnosis': consultation.diagnosis,
          'temperature': consultation.temperature.toString(),
          'heart_rate': consultation.heartRate.toString(),
          'weight': consultation.weight.toString(),
          'height': consultation.height.toString(),
          'blood_pressure': consultation.bloodPressure,
          'repos': consultation.repos.toString(),
        }),
      );
      debugPrint('Consultation: ${response.body}');

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception('Failed to create consultation');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ConsultationModel>> getAllConsultations() async {
    final token = await SecureStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/consultations'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    debugPrint('Consultation: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ConsultationModel.fromJson(json)).toList();
    }

    throw Exception('Erreur ${response.statusCode}: ${response.body}');
  }

  Future<ConsultationModel> showConsultation(int id) async {
    final token = await SecureStorage.getToken();
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/consultations/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint('Consultation: ${response.body}');
      if (response.statusCode == 200) {
        return ConsultationModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load consultation');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ConsultationModel> updateConsultation(
    int id,
    ConsultationModel consultation,
  ) async {
    final token = await SecureStorage.getToken();
    try {
      final response = await http.put(
        Uri.parse('${ApiConstants.consulations}/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(consultation.toJson()),
      );
      if (response.statusCode == 200) {
        return ConsultationModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update consultation');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteConsultation(int id) async {
    final token = await SecureStorage.getToken();
    try {
      final response = await http.delete(
        Uri.parse('${ApiConstants.consulations}/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete consultation');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<ConsultationModel>> filterConsultationsByDate(
    DateTime date,
  ) async {
    final token = await SecureStorage.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/consultations"),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ConsultationModel> consultations = body
          .map((item) => ConsultationModel.fromJson(item))
          .toList();

      return consultations.where((consultation) {
        return DateUtils.isSameDay(
          DateTime.parse(consultation.date.toString()),
          date,
        );
      }).toList();
    }
    throw Exception('Échec du chargement des consultations');
  }
}
