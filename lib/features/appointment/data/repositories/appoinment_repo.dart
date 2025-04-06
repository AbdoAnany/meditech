// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:meditech/features/appointment/data/models/progress_note.dart';
// import 'package:meditech/features/appointment/data/models/weight_loss_plan.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
// import '../models/appointment.dart';
// import '../services/healthcare_data_service.dart';

// class HealthcareRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Appointment methods
//   Future<void> createAppointment(Appointment appointment) async {
//     try {
//       await _firestore.collection('appointments').doc(appointment.id).set(appointment.toMap());
//     } catch (e) {
//       throw Exception('Failed to create appointment: $e');
//     }
//   }

//   Future<List<Appointment>> getUserAppointments(String userId) async {
//     try {
//       final querySnapshot = await _firestore
//           .collection('appointments')
//           .where('userId', isEqualTo: userId)
//           .orderBy('dateTime')
//           .get();

//       return querySnapshot.docs
//           .map((doc) => Appointment.fromMap(doc.data()))
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to get user appointments: $e');
//     }
//   }

//   // Weight Loss Plan methods
//   Future<void> createWeightLossPlan(WeightLossPlan plan) async {
//     try {
//       await _firestore.collection('weightLossPlans').doc(plan.id).set(plan.toMap());
//     } catch (e) {
//       throw Exception('Failed to create weight loss plan: $e');
//     }
//   }

//   Future<WeightLossPlan> getCurrentPlan(String userId) async {
//     try {
//       final querySnapshot = await _firestore
//           .collection('weightLossPlans')
//           .where('userId', isEqualTo: userId)
//           .orderBy('startDate', descending: true)
//           .limit(1)
//           .get();

//       if (querySnapshot.docs.isEmpty) {
//         throw Exception('No active weight loss plan found');
//       }

//       return WeightLossPlan.fromMap(querySnapshot.docs.first.data());
//     } catch (e) {
//       throw Exception('Failed to get current weight loss plan: $e');
//     }
//   }

//   // Progress Note methods
//   Future<void> addProgressNote(ProgressNote note) async {
//     try {
//       await _firestore.collection('progressNotes').doc(note.id).set(note.toMap());
//     } catch (e) {
//       throw Exception('Failed to add progress note: $e');
//     }
//   }

//   Future<List<ProgressNote>> getUserNotes(String userId, {String? noteType}) async {
//     try {
//       var query = _firestore
//           .collection('progressNotes')
//           .where('userId', isEqualTo: userId)
//           .orderBy('timestamp', descending: true);

//       if (noteType != null) {
//         query = query.where('noteType', isEqualTo: noteType);
//       }

//       final querySnapshot = await query.get();

//       return querySnapshot.docs
//           .map((doc) => ProgressNote.fromMap(doc.data()))
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to get user notes: $e');
//     }
//   }

//   // Analytics methods
//   Future<Map<String, dynamic>> getUserProgress(String userId) async {
//     try {
//       final notes = await getUserNotes(userId);
//       final appointments = await getUserAppointments(userId);
//       final currentPlan = await getCurrentPlan(userId);

//       // Calculate progress metrics
//       final progress = {
//         'totalAppointments': appointments.length,
//         'completedAppointments': appointments.where((a) => a.status == 'completed').length,
//         'weightLossProgress': currentPlan.startWeight - (notes.lastWhere((n) => n.metrics['weight'] != null).metrics['weight'] ?? currentPlan.startWeight),
//         'remainingWeeks': currentPlan.durationWeeks - DateTime.now().difference(currentPlan.startDate).inDays ~/ 7,
//         'lastNote': notes.isNotEmpty ? notes.first.content : null,
//       };

//       return progress;
//     } catch (e) {
//       throw Exception('Failed to calculate user progress: $e');
//     }
//   }
// }

// class HealthcareDataService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Encryption key management (implement with your preferred encryption library)
//   Future<void> initializeEncryption() async {
//     // Initialize encryption keys and services
//   }

//   // Secure data access methods
//   Future<bool> hasPermission(String userId, String permission) async {
//     final userDoc = await _db.collection('users').doc(userId).get();
//     final permissions = List<String>.from(userDoc.data()?['permissions'] ?? []);
//     return permissions.contains(permission);
//   }

//   // Audit logging
//   Future<void> logAccess(String userId, String resource, String action) async {
//     await _db.collection('audit_logs').add({
//       'userId': userId,
//       'resource': resource,
//       'action': action,
//       'timestamp': FieldValue.serverTimestamp(),
//       'ipAddress': await _getClientIP(),
//     });
//   }
//   Future<String> _getClientIP() async {
//     try {
//       // Use a reliable IP address API
//       final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return data['ip'];
//       }

//       // Fallback if the primary service fails
//       final backupResponse = await http.get(Uri.parse('https://ip.seeip.org/jsonip'));

//       if (backupResponse.statusCode == 200) {
//         final data = json.decode(backupResponse.body);
//         return data['ip'];
//       }
//     } catch (e) {
//       // Log the error but don't expose it
//       print('Error getting IP address: $e');
//     }

//     return 'unknown';
//   }


//   // Appointment methods
//   Future<void> createAppointment(Appointment appointment) async {
//     try {
//       await _db.collection('appointments').doc(appointment.id).set(appointment.toMap());
//     } catch (e) {
//       throw Exception('Failed to create appointment: $e');
//     }
//   }

//   Future<List<Appointment>> getUserAppointments(String userId) async {
//     try {
//       final querySnapshot = await _db
//           .collection('appointments')
//           .where('userId', isEqualTo: userId)
//           .orderBy('dateTime')
//           .get();
      
//       return querySnapshot.docs
//           .map((doc) => Appointment.fromMap(doc.data()))
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to get user appointments: $e');
//     }
//   }

//   // Weight Loss Plan methods
//   Future<void> createWeightLossPlan(WeightLossPlan plan) async {
//     try {
//       await _db.collection('weightLossPlans').doc(plan.id).set(plan.toMap());
//     } catch (e) {
//       throw Exception('Failed to create weight loss plan: $e');
//     }
//   }

//   Future<WeightLossPlan> getCurrentPlan(String userId) async {
//     try {
//       final querySnapshot = await _db
//           .collection('weightLossPlans')
//           .where('userId', isEqualTo: userId)
//           .orderBy('startDate', descending: true)
//           .limit(1)
//           .get();
      
//       if (querySnapshot.docs.isEmpty) {
//         throw Exception('No active weight loss plan found');
//       }
      
//       return WeightLossPlan.fromMap(querySnapshot.docs.first.data());
//     } catch (e) {
//       throw Exception('Failed to get current weight loss plan: $e');
//     }
//   }

//   // Progress Note methods
//   Future<void> addProgressNote(ProgressNote note) async {
//     try {
//       await _db.collection('progressNotes').doc(note.id).set(note.toMap());
//     } catch (e) {
//       throw Exception('Failed to add progress note: $e');
//     }
//   }

//   Future<List<ProgressNote>> getUserNotes(String userId, {String? noteType}) async {
//     try {
//       var query = _db
//           .collection('progressNotes')
//           .where('userId', isEqualTo: userId)
//           .orderBy('timestamp', descending: true);
      
//       if (noteType != null) {
//         query = query.where('noteType', isEqualTo: noteType);
//       }
      
//       final querySnapshot = await query.get();
      
//       return querySnapshot.docs
//           .map((doc) => ProgressNote.fromMap(doc.data()))
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to get user notes: $e');
//     }
//   }

//   // Analytics methods
//   Future<Map<String, dynamic>> getUserProgress(String userId) async {
//     try {
//       final notes = await getUserNotes(userId);
//       final appointments = await getUserAppointments(userId);
//       final currentPlan = await getCurrentPlan(userId);

//       // Calculate progress metrics
//       final progress = {
//         'totalAppointments': appointments.length,
//         'completedAppointments': appointments.where((a) => a.status == 'completed').length,
//         'weightLossProgress': currentPlan.startWeight - (notes.lastWhere((n) => n.metrics['weight'] != null).metrics['weight'] ?? currentPlan.startWeight),
//         'remainingWeeks': currentPlan.durationWeeks - DateTime.now().difference(currentPlan.startDate).inDays ~/ 7,
//         'lastNote': notes.isNotEmpty ? notes.first.content : null,
//       };

//       return progress;
//     } catch (e) {
//       throw Exception('Failed to calculate user progress: $e');
//     }
//   }
// }
