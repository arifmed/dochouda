class ConsultationModel {
  final int? id;
  final int? patientId;
  final String? type_consultation;
  final String? date;
  final String? symptoms;
  final String? diagnosis;
  final String? notes;
  final double? temperature;
  final int? heartRate;
  final double? weight;
  final double? height;
  final String? bloodPressure;
  final int? repos;
  final PatientModel? patient;

  ConsultationModel({
    this.id,
    this.patientId,
    this.type_consultation,
    this.date,
    this.symptoms,
    this.diagnosis,
    this.notes,
    this.repos,
    this.temperature,
    this.heartRate,
    this.weight,
    this.height,
    this.bloodPressure,
    this.patient,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) =>
      ConsultationModel(
        id: json['id'],
        patientId: json['patientId'],
        date: json['date'],
        type_consultation: json['type_consultation'],
        symptoms: json['symptoms'],
        diagnosis: json['diagnosis'],
        notes: json['notes'],
        repos: json['repos'],
        temperature: double.tryParse(json['temperature']?.toString() ?? ''),
        heartRate: json['heartRate'],
        weight: double.tryParse(json['weight']?.toString() ?? ''),
        height: double.tryParse(json['height']?.toString() ?? ''),
        bloodPressure: json['bloodPressure'],
        patient: json['patient'] != null
            ? PatientModel.fromJson(json['patient'])
            : null,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'patient_id': patientId,
    'type_consultation': type_consultation,
    'date': date,
    'symptoms': symptoms,
    'diagnosis': diagnosis,
    'notes': notes,
    'repos': repos,
    'temperature': temperature,
    'heart_rate': heartRate,
    'weight': weight,
    'height': height,
    'blood_pressure': bloodPressure,
  };
}

class PatientModel {
  final int id;
  final String firstName;
  final String lastName;

  PatientModel({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
    );
  }
}
