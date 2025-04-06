class PatientProfile {
  final String patientId;
  final double height;
  final List<Map<String, dynamic>> weightHistory;
  final List<String> allergies;
  final List<String> currentMedications;
  final List<Map<String, dynamic>> medicalHistory;
  final Map<String, dynamic> emergencyContact;
  final String primaryPhysician;
  final List<String> dietaryRestrictions;
  final Map<String, dynamic> insuranceInfo;

  PatientProfile({
    required this.patientId,
    required this.height,
    required this.weightHistory,
    required this.allergies,
    required this.currentMedications,
    required this.medicalHistory,
    required this.emergencyContact,
    required this.primaryPhysician,
    required this.dietaryRestrictions,
    required this.insuranceInfo,
  });

  Map<String, dynamic> toMap() => {
    'patientId': patientId,
    'height': height,
    'weightHistory': weightHistory,
    'allergies': allergies,
    'currentMedications': currentMedications,
    'medicalHistory': medicalHistory,
    'emergencyContact': emergencyContact,
    'primaryPhysician': primaryPhysician,
    'dietaryRestrictions': dietaryRestrictions,
    'insuranceInfo': insuranceInfo,
  };
}