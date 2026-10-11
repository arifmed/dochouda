import 'package:dochouda/features/consultations/data/consultaion_api.dart';
import 'package:dochouda/features/consultations/models/consultation_model.dart'
    hide PatientModel;
import 'package:dochouda/features/consultations/presentation/consultation_screen.dart';
import 'package:dochouda/features/patients/models/patient_model.dart';
import 'package:dochouda/features/patients/presentation/add_patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dochouda/features/dashboard/presentation/menu.dart';

class AddConsultationScreen extends StatefulWidget {
  const AddConsultationScreen({super.key, required this.patient});

  final PatientModel patient;

  @override
  State<AddConsultationScreen> createState() => _AddConsultationScreenState();
}

class _AddConsultationScreenState extends State<AddConsultationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _typeConsultationController = TextEditingController();
  final _dateController = TextEditingController();
  final _symptomsController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _notesController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _heartRateController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _bloodPressureController = TextEditingController();
  final _reposController = TextEditingController();

  Future<void> _createConsultation() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ConsultationApi.createConsultation(
          ConsultationModel(
            id: 0,
            patientId: widget.patient.id,
            date: _dateController.text,
            type_consultation: _typeConsultationController.text,
            symptoms: _symptomsController.text,
            diagnosis: _diagnosisController.text,
            notes: _notesController.text,
            temperature: double.tryParse(_temperatureController.text) ?? 0.0,
            heartRate: int.tryParse(_heartRateController.text) ?? 0,
            weight: double.tryParse(_weightController.text) ?? 0.0,
            height: double.tryParse(_heightController.text) ?? 0.0,
            bloodPressure: _bloodPressureController.text,
            repos: int.tryParse(_reposController.text) ?? 1,
          ),
        );

        // Afficher un message de succès
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Consultation ajoutée avec succès')),
          );

          // Optionnel: revenir à l'écran précédent ou à la liste des consultations
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ConsultationScreen()),
          );
        }
      } catch (e) {
        // Afficher un message d'erreur
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de l\'ajout : $e')),
          );
        }
      }
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate =
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2050),
        ).then((selectedDate) {
          // After selecting the date, display the time picker.
          if (selectedDate != null) {
            showTimePicker(context: context, initialTime: TimeOfDay.now()).then(
              (selectedTime) {
                if (selectedTime != null) {
                  DateTime selectedDateTime = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );
                  setState(() {
                    _dateController.text = DateFormat(
                      'yyyy-MM-dd HH:mm',
                    ).format(selectedDateTime);
                  });
                }
              },
            );
          }
          return null;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une consultation')),
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
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Consultation'),
                      value: 'Consultation',
                      // ignore: deprecated_member_use
                      groupValue: _typeConsultationController.text,
                      // ignore: deprecated_member_use
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _typeConsultationController.text = value;
                          });
                        }
                      },
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Controle'),
                      value: 'Controle',
                      // ignore: deprecated_member_use
                      groupValue: _typeConsultationController.text,
                      // ignore: deprecated_member_use
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _typeConsultationController.text = value;
                          });
                        }
                      },
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Visite'),
                      value: 'Visite',
                      // ignore: deprecated_member_use
                      groupValue: _typeConsultationController.text,
                      // ignore: deprecated_member_use
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _typeConsultationController.text = value;
                          });
                        }
                      },
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today),
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  await _selectDate();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _symptomsController,
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.add_reaction),
                  labelText: 'Symptômes',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer les symptômes';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _diagnosisController,
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.medical_information),
                  labelText: 'Diagnostique',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le diagnostic';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.note),
                  labelText: 'Notes',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _temperatureController,
                      decoration: const InputDecoration(
                        labelText: 'Température (C)',
                        prefixIcon: Icon(Icons.thermostat),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _heartRateController,
                      decoration: const InputDecoration(
                        labelText: 'Fréquence cardiaque (bpm)',
                        prefixIcon: Icon(Icons.monitor_heart),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        labelText: 'Hauteur (cm)',
                        prefixIcon: Icon(Icons.height),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _bloodPressureController,
                      decoration: const InputDecoration(
                        labelText: 'Pression artérielle (mmHg)',
                        prefixIcon: Icon(Icons.water_drop),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      decoration: const InputDecoration(
                        labelText: 'Poids (kg)',
                        prefixIcon: Icon(Icons.monitor_weight),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _reposController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.timer),
                  labelText: 'Repos (nombre de jours)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _createConsultation,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 10),
                      Text(
                        'Enregistrer la consultation',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 140),
            ],
          ),
        ),
      ),
    );
  }
}
