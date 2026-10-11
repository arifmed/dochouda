import 'package:dochouda/features/consultations/data/consultaion_api.dart';
import 'package:dochouda/features/dashboard/presentation/menu.dart';
import 'package:dochouda/features/patients/presentation/add_patient_screen.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consultation')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
        future: ConsultationApi().getAllConsultations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucune consultation trouvé'));
          } else {
            final consultations = snapshot.data!;
            return ListView.builder(
              itemCount: consultations.length,
              itemBuilder: (context, index) {
                final consultation = consultations[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        '${consultation.patient?.firstName} ${consultation.patient?.lastName}',
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat(
                              'yyyy-MM-dd HH:mm',
                            ).format(DateTime.parse(consultation.date ?? '')),
                          ),
                          Text(consultation.type_consultation ?? ''),
                          // Text(
                          //   'Patient : ${consultation.patient?.firstName} ${consultation.patient?.lastName}',
                          // ),
                        ],
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.visibility),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
