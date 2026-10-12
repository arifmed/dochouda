import 'package:dochouda/features/consultations/presentation/add_consultation_screen.dart';
import 'package:dochouda/features/dashboard/presentation/menu.dart';
import 'package:dochouda/features/patients/data/patient_api.dart';
import 'package:dochouda/features/patients/models/patient_model.dart';
import 'package:dochouda/features/patients/presentation/add_patient_screen.dart';
import 'package:dochouda/features/patients/presentation/patients_screen.dart';

import 'package:dochouda/features/patients/presentation/update_patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientDetailsScreen extends StatefulWidget {
  final int id;
  const PatientDetailsScreen({super.key, required this.id});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  // 1. تعريف الـ Future هنا لمنع الاستدعاء المتكرر
  late Future<PatientModel?> _patientFuture;

  @override
  void initState() {
    super.initState();
    _fetchPatientData();
  }

  // دالة لجلب البيانات يمكن إعادة استدعائها عند الحاجة للتحديث
  void _fetchPatientData() {
    // تم تصحيح id إلى widget.id هنا
    _patientFuture = PatientApi.showPatient(widget.id);
  }

  // دالة مساعدة لتنسيق التاريخ بأمان
  String _formatDate(dynamic dateString) {
    if (dateString == null || dateString.toString().isEmpty) {
      return 'Indisponible';
    }
    try {
      return DateFormat(
        "dd/MM/yyyy",
      ).format(DateTime.parse(dateString.toString()).toLocal());
    } catch (e) {
      return 'Format invalide';
    }
  }

  Future<void> _deletePatient() async {
    try {
      await PatientApi.deletePatient(widget.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Patient supprimé avec succès')),
        );
        // إضافة true كقيمة مرجعة لتحديث الشاشة السابقة
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PatientsScreen()),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PatientsScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détails du patient')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1. The Main Floating Toolbar
          Menu(),

          const SizedBox(width: 12),

          // 2. The Isolated "+" Action Button
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFE6D6FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Color(0xFF5E4A83), size: 28),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddPatientScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<PatientModel?>(
        future: _patientFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Aucun patient trouvé'));
          }

          final patient = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card.outlined(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.person, size: 40),
                        ),
                        title: Text(
                          '${patient.firstName} ${patient.lastName}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  patient.phone ?? 'Actuellement indisponible',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    patient.email ??
                                        'Actuellement indisponible',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.grey[700],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton.filledTonal(
                              icon: const Icon(Icons.print),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 10),
                            IconButton.filledTonal(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        UpdatePatientScreen(patient: patient),
                                  ),
                                );
                                if (result == true) {
                                  setState(() {
                                    _fetchPatientData();
                                  });
                                }
                              },
                            ),
                            const SizedBox(width: 10),
                            IconButton.filledTonal(
                              icon: const Icon(Icons.delete),
                              onPressed: _deletePatient,
                            ),
                          ],
                        ),
                      ),
                      const Divider(indent: 30, endIndent: 30),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            _buildInfoRow(
                              Icons.calendar_today,
                              'Date de naissance: ${_formatDate(patient.dateOfBirth)}',
                            ),
                            const SizedBox(height: 10),
                            _buildInfoRow(
                              Icons.person,
                              'Sexe: ${patient.gender ?? 'N/A'}',
                            ),
                            const SizedBox(height: 10),
                            _buildInfoRow(
                              Icons.location_on,
                              'Adresse: ${patient.address ?? 'N/A'}',
                            ),
                            const SizedBox(height: 10),
                            _buildInfoRow(
                              Icons.bloodtype,
                              'Groupe sanguin: ${patient.bloodType ?? 'N/A'}',
                            ),
                            const SizedBox(height: 10),
                            _buildInfoRow(
                              Icons.contact_emergency,
                              'Nom du contact d\'urgence: ${patient.emergencyContactName ?? 'N/A'}',
                            ),
                            const SizedBox(height: 10),
                            _buildInfoRow(
                              Icons.contact_emergency_rounded,
                              'Numéro du contact d\'urgence: ${patient.emergencyContactPhone ?? 'N/A'}',
                            ),
                            const SizedBox(height: 10),
                            _buildInfoRow(
                              Icons.medical_services,
                              'Allergies: ${patient.allergies ?? 'N/A'}',
                            ),
                            const SizedBox(height: 10),
                            _buildInfoRow(
                              Icons.medical_services,
                              'Maladies chroniques: ${patient.chronicDiseases ?? 'N/A'}',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddConsultationScreen(patient: patient),
                        ),
                      );
                    },
                    child: const Text(
                      'Ajouter une consultation',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                SizedBox(height: 140),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
