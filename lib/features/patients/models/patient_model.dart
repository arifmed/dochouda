class PatientModel {
  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String dateOfBirth;
  final String gender;
  final String phone;
  final String email;
  final String address;
  final String bloodType;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String allergies;
  final String chronicDiseases;

  PatientModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.phone,
    required this.email,
    required this.address,
    required this.bloodType,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.allergies,
    required this.chronicDiseases,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      fullName: json['full_name'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      bloodType: json['blood_type'],
      emergencyContactName: json['emergency_contact_name'],
      emergencyContactPhone: json['emergency_contact_phone'],
      allergies: json['allergies'],
      chronicDiseases: json['chronic_diseases'],
    );
  }
}
