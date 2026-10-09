import 'package:dochouda/features/patients/data/patient_api.dart';
import 'package:dochouda/features/patients/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class UpdatePatientScreen extends StatefulWidget {
  final PatientModel patient;
  const UpdatePatientScreen({super.key, required this.patient});

  @override
  State<UpdatePatientScreen> createState() => _UpdatePatientScreenState();
}

class _UpdatePatientScreenState extends State<UpdatePatientScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _emergencyContactNameController =
      TextEditingController();
  final TextEditingController _emergencyContactPhoneController =
      TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _chronicDiseasesController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.patient.firstName ?? '';
    _lastNameController.text = widget.patient.lastName ?? '';
    _dateOfBirthController.text = widget.patient.dateOfBirth ?? '';
    _genderController.text = widget.patient.gender ?? '';
    _phoneController.text = widget.patient.phone ?? '';
    _emailController.text = widget.patient.email ?? '';
    _addressController.text = widget.patient.address ?? '';
    _bloodTypeController.text = widget.patient.bloodType ?? '';
    _emergencyContactNameController.text =
        widget.patient.emergencyContactName ?? '';
    _emergencyContactPhoneController.text =
        widget.patient.emergencyContactPhone ?? '';
    _allergiesController.text = widget.patient.allergies ?? '';
    _chronicDiseasesController.text = widget.patient.chronicDiseases ?? '';
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text = picked.toIso8601String().split('T')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mettre à jour le patient')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prénom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: TextEditingController(
                  text: DateFormat("dd/MM/yyyy").format(
                    DateTime.parse("${widget.patient.dateOfBirth}").toLocal(),
                  ),
                ),
                decoration: const InputDecoration(
                  labelText: 'Date de naissance',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: _selectDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner une date de naissance.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Homme'),
                      value: 'Homme',
                      groupValue: _genderController.text,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _genderController.text = value;
                          });
                        }
                      },
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Femme'),
                      value: 'Femme',
                      groupValue: _genderController.text,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _genderController.text = value;
                          });
                        }
                      },
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Téléphone',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un numéro de téléphone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Adresse',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _bloodTypeController,
                decoration: const InputDecoration(
                  labelText: 'Groupe sanguin',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emergencyContactNameController,
                decoration: const InputDecoration(
                  labelText: 'Contact d\'urgence',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emergencyContactPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Téléphone contact d\'urgence',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _chronicDiseasesController,
                decoration: const InputDecoration(
                  labelText: 'Maladies chroniques',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _allergiesController,
                decoration: const InputDecoration(
                  labelText: 'Allergies',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    final patient = PatientModel(
                      id: widget.patient.id,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      dateOfBirth: _dateOfBirthController.text,
                      gender: _genderController.text,
                      phone: _phoneController.text,
                      email: _emailController.text,
                      address: _addressController.text,
                      bloodType: _bloodTypeController.text,
                      emergencyContactName:
                          _emergencyContactNameController.text,
                      emergencyContactPhone:
                          _emergencyContactPhoneController.text,
                      allergies: _allergiesController.text,
                      chronicDiseases: _chronicDiseasesController.text,
                    );

                    // انتظار انتهاء التحديث في قاعدة البيانات
                    await PatientApi.updatePatient(widget.patient.id, patient);

                    // إغلاق الشاشة الحالية
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Patient mis à jour avec succès'),
                        ),
                      );
                      Navigator.pop(context, true);
                    }
                  },
                  child: const Text(
                    'Enregistrer les modifications',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
