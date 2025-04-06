// Enums for type safety
enum UserRole { patient, doctor, admin }
enum AppointmentStatus { scheduled, completed, cancelled, noShow, pending }
enum NotificationType { appointment, medication, milestone }
enum MenuState { home, favourite, message, profile }
extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.patient:
        return 'patient';
      case UserRole.doctor:
        return 'doctor';
      case UserRole.admin:
        return 'admin';
      default:
        return 'patient';
    }
  }

  static UserRole fromString(String? role) {
    switch (role) {
      case 'patient':
        return UserRole.patient;
      case 'doctor':
        return UserRole.doctor;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.patient;
    }
  }
}