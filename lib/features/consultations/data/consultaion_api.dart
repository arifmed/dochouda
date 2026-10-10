import 'dart:convert';

import 'package:dochouda/core/constants/api_constants.dart';
import 'package:dochouda/core/storage/secure_storage.dart';
import 'package:dochouda/features/consultations/models/consultation_model.dart';
import 'package:http/http.dart' as http;

class ConsultationApi {
  Future<void> createConsultation(ConsultationModel consultation) async {
    final token = await SecureStorage.getToken();
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.consulations),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(consultation.toJson()),
      );
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
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.consulations),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['data'];
        return jsonList
            .map((json) => ConsultationModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load consultations');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ConsultationModel> showConsultation(int id) async {
    final token = await SecureStorage.getToken();
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.consulations}/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
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
}
