import 'package:dochouda/features/patients/models/patient_model.dart';
import 'package:flutter/material.dart';

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
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Consultation ajoutée avec succès')),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,

      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = pickedDate.toIso8601String().split('T')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une consultation')),
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
                      groupValue: _typeConsultationController.text,
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
                      groupValue: _typeConsultationController.text,
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
                      groupValue: _typeConsultationController.text,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer la température';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer la fréquence cardiaque';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer la hauteur';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer la pression artérielle';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer le poids';
                        }
                        return null;
                      },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nombre de jours de repos';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
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
            ],
          ),
        ),
      ),
    );
  }
}
