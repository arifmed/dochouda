import 'package:dochouda/features/patients/data/patient_api.dart';
import 'package:dochouda/features/patients/models/patient_model.dart';
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
  Future<PatientModel?> showPatient() async {
    return await PatientApi.showPatient(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détails du patient')),
      body: Column(
        children: [
          FutureBuilder(
            future: showPatient(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final patient = snapshot.data!;
                return Column(
                  children: [
                    Card.outlined(
                      child: Column(
                        mainAxisSize: .min,
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.person, size: 40),
                            ),
                            title: Text(
                              '${patient.firstName} ${patient.lastName}',
                              style: TextStyle(
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
                                      patient.phone ??
                                          'Actuellement indisponible',
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
                                    Text(
                                      patient.email ??
                                          'Actuellement indisponible',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: .min,
                              children: <Widget>[
                                IconButton.filledTonal(
                                  icon: Icon(Icons.print),
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 10),
                                IconButton.filledTonal(
                                  icon: Icon(Icons.edit),
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => UpdatePatientScreen(
                                          patient: patient,
                                        ),
                                      ),
                                    );
                                    if (result == true) {
                                      // قم باستدعاء الدالة المسؤولة عن جلب البيانات من واجهة برمجة التطبيقات (API)
                                      // أو استخدم setState لإعادة بناء الواجهة
                                      setState(() {
                                        // مثال: fetchPatients(); أو تحديث بيانات المريض الحالي
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(width: 10),
                                IconButton.filledTonal(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                          const Divider(indent: 30, endIndent: 30),

                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_today),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Date de naissance: ${DateFormat("dd/MM/yyyy").format(DateTime.parse("${patient.dateOfBirth}").toLocal())}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(Icons.person),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Sexe: ${patient.gender}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Adresse: ${patient.address}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(Icons.bloodtype),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Groupe sanguin: ${patient.bloodType}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(Icons.contact_emergency),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Nom du contact d\'urgence: ${patient.emergencyContactName}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(Icons.contact_emergency_rounded),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Numéro du contact d\'urgence: ${patient.emergencyContactPhone}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(Icons.medical_services),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Allergies: ${patient.allergies}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(Icons.medical_services),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Maladies chroniques: ${patient.chronicDiseases}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Card.outlined(
                      margin: EdgeInsets.all(16),

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.person, size: 50),
                          ),
                          const SizedBox(height: 10),
                          Text('Nom: ${patient.firstName}'),
                          const SizedBox(height: 10),
                          Text('Prenom: ${patient.lastName}'),
                          const SizedBox(height: 10),
                          Text('Phone: ${patient.phone}'),
                          const SizedBox(height: 10),
                          Text('Email: ${patient.email}'),
                          const SizedBox(height: 10),
                          Text('Date de naissance: ${patient.dateOfBirth}'),
                          const SizedBox(height: 10),
                          Text('Sexe: ${patient.gender}'),
                          Text('Adresse: ${patient.address}'),
                          Text('Blood type: ${patient.bloodType}'),
                          Text(
                            'Emergency contact name: ${patient.emergencyContactName}',
                          ),
                          Text(
                            'Emergency contact phone: ${patient.emergencyContactPhone}',
                          ),
                          Text('Allergies: ${patient.allergies}'),
                          Text('Chronic diseases: ${patient.chronicDiseases}'),

                          Text('id: ${patient.id}'),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur: ${snapshot.error}'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
