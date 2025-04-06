import '../../../../core/Enums.dart';

class UserProfile {
  final String uid;
  final UserRole role;
  final String email;
  final String fullName;
  final DateTime dateOfBirth;
  final Map<String, dynamic> contactInfo;
  final List<String> permissions;
  final DateTime lastLogin;
  final bool isActive;

  UserProfile({
    required this.uid,
    required this.role,
    required this.email,
    required this.fullName,
    required this.dateOfBirth,
    required this.contactInfo,
    required this.permissions,
    required this.lastLogin,
    required this.isActive,
  });

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'role': role.toString(),
    'email': email,
    'fullName': fullName,
    'dateOfBirth': dateOfBirth,
    'contactInfo': contactInfo,
    'permissions': permissions,
    'lastLogin': lastLogin,
    'isActive': isActive,
  };
}