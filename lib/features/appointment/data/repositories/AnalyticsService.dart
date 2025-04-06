// ... (previous imports remain the same)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../../../../core/Enums.dart';

// ... (previous code remains the same until AnalyticsService)

class AnalyticsService {
  Future<Map<String, dynamic>> getPatientMetrics(String patientId) async {
    final patientData = await FirebaseFirestore.instance
        .collection('patients')
        .doc(patientId)
        .get();

    final weightHistory = List<Map<String, dynamic>>.from(
        patientData.data()?['weightHistory'] ?? []);
    final height = patientData.data()?['height'] ?? 0.0;
    final targetWeight = patientData.data()?['targetWeight'] ?? 0.0;

    return {
      'currentWeight': weightHistory.last['weight'],
      'weightChange': _calculateWeightChange(weightHistory),
      'bmiTrend': _calculateBMITrend(weightHistory, height),
      // 'targetProgress': _calculateTargetProgress(weightHistory, targetWeight),
    };
  }

  double _calculateWeightChange(List<Map<String, dynamic>> history) {
    if (history.length < 2) return 0.0;
    return history.last['weight'] - history.first['weight'];
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




}

// Time zone handling for notifications
class TimeZoneService {
  static Future<void> initialize() async {
    tz.initializeTimeZones();
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

// IP Address handling for audit logs

// Update NotificationService to use timezone-aware scheduling
class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await TimeZoneService.initialize();
    
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
    final scheduledDateTime = TimeZoneService.convertToTZ(scheduledDate);
    
    await _notifications.zonedSchedule(
      DateTime.now().millisecond,
      title,
      body,
      scheduledDateTime,
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
    );
  }
}

// ... (previous Firebase Security Rules remain the same)