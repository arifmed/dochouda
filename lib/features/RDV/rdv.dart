import 'package:dochouda/features/consultations/data/consultaion_api.dart';
import 'package:dochouda/features/dashboard/presentation/menu.dart';
import 'package:dochouda/features/patients/presentation/add_patient_screen.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RDV extends StatefulWidget {
  const RDV({super.key});

  @override
  State<RDV> createState() => _RDVState();
}

DateTime selectedDate = DateTime.now();

class _RDVState extends State<RDV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rendez-vous')),

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            EasyDateTimeLine(
              initialDate: selectedDate,
              locale: 'fr-FR',
              onDateChange: (date) {
                setState(() {
                  selectedDate = date;
                });

                ConsultationApi.filterConsultationsByDate(selectedDate);
              },
            ),

            SizedBox(height: 24),

            FutureBuilder(
              future: ConsultationApi.filterConsultationsByDate(selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "Aucun Rendez-vous pour la date sélectionnée",
                        style: TextStyle(
                          fontSize: 20,

                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var consultation = snapshot.data![index];
                      SizedBox(height: 20);
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card.outlined(
                          clipBehavior: Clip.hardEdge,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Avatar
                                    const CircleAvatar(
                                      radius: 24,
                                      child: Icon(Icons.person, size: 24),
                                    ),
                                    const SizedBox(width: 16),

                                    // Name and Handle
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${consultation.patient?.firstName ?? ""} ${consultation.patient?.lastName ?? ""}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),

                                          Text(
                                            consultation.type_consultation
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Close 'X' Button
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time_outlined,
                                              size: 23,
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                              ),

                                              DateFormat("HH:mm").format(
                                                DateTime.parse(
                                                  "${consultation.date}",
                                                ).toLocal(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 2),
                                            Text(
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              DateFormat("dd/MM/yyyy").format(
                                                DateTime.parse(
                                                  "${consultation.date}",
                                                ).toLocal(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // --- Middle Section: Text Input ---
                                Column(
                                  children: [
                                    Text(
                                      "Diagnostique : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(consultation.diagnosis ?? ""),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey[300],
                                  height: 1,
                                ),

                                const SizedBox(height: 16),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Left-side icons
                                    Row(
                                      children: [
                                        IconButton.filledTonal(
                                          icon: const Icon(Icons.mode_edit),
                                          onPressed: () {},
                                        ),
                                        const SizedBox(width: 8),
                                        IconButton.filledTonal(
                                          icon: const Icon(Icons.print),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),

                                    // Publish Button
                                    FilledButton(
                                      onPressed: () {},
                                      child: Text(""),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Text("Aucune tâche aujourd'hui ");
                }
              },
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
