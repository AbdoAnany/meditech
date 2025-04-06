// Core models and security rules
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../../core/Enums.dart';


// User profile model with role-based access
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

// Patient-specific medical profile
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

// HIPAA-compliant data service

// Notification service
class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    final initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _notifications.initialize(initializationSettings);
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
    required NotificationType type,
  }) async {
    await _notifications.zonedSchedule(
      DateTime.now().millisecond,
      title,
      body,
        tz. TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'healthcare_channel',
          'Healthcare Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.inexact,
      // androidAllowWhileIdle: true,
    );
  }
}

// Analytics service
class AnalyticsService {
  Future<Map<String, dynamic>> getPatientMetrics(String patientId) async {
    // Calculate and return key metrics
    final patientData = await FirebaseFirestore.instance
        .collection('patients')
        .doc(patientId)
        .get();
    
    final weightHistory = List<Map<String, dynamic>>.from(
        patientData.data()?['weightHistory'] ?? []);

    final height = patientData.data()?['height'] ?? 0.0;
    final targetWeight = patientData.data()?['targetWeight'] ?? 0.0;
    
    // Calculate trends and metrics
    return {
      'currentWeight': weightHistory.last['weight'],
      'weightChange': _calculateWeightChange(weightHistory),
      'bmiTrend': _calculateBMITrend(weightHistory,height),
      'targetProgress': _calculateTargetProgress(weightHistory,targetWeight),
    };
  }

  Map<String, dynamic> _calculateTargetProgress(
      List<Map<String, dynamic>> weightHistory,
      double targetWeight,
      ) {
    if (weightHistory.isEmpty || targetWeight <= 0) {
      return {'progressPercent': 0.0, 'remainingWeight': 0.0};
    }

    final initialWeight = weightHistory.first['weight'] as double;
    final currentWeight = weightHistory.last['weight'] as double;
    final totalWeightToLose = initialWeight - targetWeight;

    if (totalWeightToLose <= 0) {
      return {'progressPercent': 0.0, 'remainingWeight': 0.0};
    }

    final weightLost = initialWeight - currentWeight;
    final progressPercent = (weightLost / totalWeightToLose * 100)
        .clamp(0.0, 100.0);
    final remainingWeight = currentWeight - targetWeight;

    return {
      'progressPercent': double.parse(progressPercent.toStringAsFixed(1)),
      'remainingWeight': double.parse(remainingWeight.toStringAsFixed(1)),
      'initialWeight': initialWeight,
      'currentWeight': currentWeight,
      'weightLost': double.parse(weightLost.toStringAsFixed(1)),
      'targetWeight': targetWeight,
      'projectedCompletionDate': _calculateProjectedCompletionDate(
        weightHistory,
        targetWeight,
      ),
    };
  }
  DateTime? _calculateProjectedCompletionDate(
      List<Map<String, dynamic>> weightHistory,
      double targetWeight,
      )
  {
    if (weightHistory.length < 2) return null;

    // Calculate average weight loss per day
    final firstEntry = weightHistory.first;
    final lastEntry = weightHistory.last;
    final daysDifference = (lastEntry['date'] as Timestamp)
        .toDate()
        .difference((firstEntry['date'] as Timestamp).toDate())
        .inDays;

    if (daysDifference == 0) return null;

    final totalWeightLoss = firstEntry['weight'] - lastEntry['weight'];
    final avgWeightLossPerDay = totalWeightLoss / daysDifference;

    if (avgWeightLossPerDay <= 0) return null;

    // Calculate remaining days
    final remainingWeight = lastEntry['weight'] - targetWeight;
    final remainingDays = (remainingWeight / avgWeightLossPerDay).ceil();

    return DateTime.now().add(Duration(days: remainingDays));
  }
  List<Map<String, dynamic>> _calculateBMITrend(
      List<Map<String, dynamic>> weightHistory,
      double height
      )
  {
    if (height <= 0) return [];

    // Convert height to meters if stored in cm
    final heightInMeters = height > 3 ? height / 100 : height;

    // Calculate BMI for each weight entry
    return weightHistory.map((entry) {
      final weight = entry['weight'] as double;
      final date = (entry['date'] as Timestamp).toDate();
      final bmi = weight / (heightInMeters * heightInMeters);

      return {
        'date': date,
        'bmi': double.parse(bmi.toStringAsFixed(1)),
        'category': _getBMICategory(bmi),
        'weight': weight,
      };
    }).toList();
  }
  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25.0) return 'Normal';
    if (bmi < 30.0) return 'Overweight';
    return 'Obese';
  }
  double _calculateWeightChange(List<Map<String, dynamic>> history) {
    if (history.length < 2) return 0.0;
    return history.last['weight'] - history.first['weight'];
  }
}





// Time zone handling for notifications
class TimeZoneService {
  static Future<void> initialize() async {
    // tz.initializeTimeZones();
    final String timeZone = await _getDeviceTimeZone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  static Future<String> _getDeviceTimeZone() async {
    try {
      // First try to get the timezone from the device
      final timezone = DateTime.now().timeZoneName;
      return timezone;
    } catch (e) {
      // Fallback to a default timezone if device timezone is not available
      return 'UTC';
    }
  }

  static tz.TZDateTime convertToTZ(DateTime dateTime) {
    return tz.TZDateTime.from(dateTime, tz.local);
  }
}

// Firebase Security Rules (to be deployed to Firebase)
