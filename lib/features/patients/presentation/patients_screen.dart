import 'package:dochouda/features/dashboard/presentation/menu.dart';
import 'package:dochouda/features/patients/data/patient_api.dart';
import 'package:dochouda/features/patients/presentation/add_patient_screen.dart';
import 'package:dochouda/features/patients/presentation/patient_details_screen.dart';
import 'package:flutter/material.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patients')),
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
      body: FutureBuilder(
        future: PatientApi.getAllPatients(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun patient trouvé'));
          } else {
            final patients = snapshot.data!;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      labelText: 'Rechercher',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.clear),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: patients.length,
                    itemBuilder: (context, index) {
                      final patient = patients[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                            '${patient.firstName ?? ''} ${patient.lastName ?? ''}'
                                .trim(),
                          ),
                          subtitle: Text(patient.phone?.toString() ?? ''),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            final result = Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    PatientDetailsScreen(id: patient.id),
                              ),
                            );

                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 140),
              ],
            );
          }
        },
      ),
    );
  }
}
