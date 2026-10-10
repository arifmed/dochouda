class ConsultationModel {
  final int? id;
  final int? patientId;
  final String? typeConsultation;
  final DateTime? date;
  final String? symptoms;
  final String? diagnosis;
  final String? notes;
  final double? temperature;
  final int? heartRate;
  final double? weight;
  final double? height;
  final String? bloodPressure;
  final int? repos;

  ConsultationModel({
    this.id,
    this.patientId,
    this.typeConsultation,
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
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) =>
      ConsultationModel(
        id: json['id'],
        patientId: json['patientId'],
        date: json['date'],
        typeConsultation: json['typeConsultation'],
        symptoms: json['symptoms'],
        diagnosis: json['diagnosis'],
        notes: json['notes'],
        repos: json['repos'],
        temperature: json['temperature'],
        heartRate: json['heartRate'],
        weight: json['weight'],
        height: json['height'],
        bloodPressure: json['bloodPressure'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'patient_id': patientId,
    'type_consultation': typeConsultation,
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
