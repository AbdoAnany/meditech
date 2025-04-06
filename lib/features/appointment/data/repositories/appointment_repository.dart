import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meditech/features/appointment/data/models/progress_note.dart';
import 'package:meditech/features/appointment/data/models/weight_loss_plan.dart';

import '../../../../core/Enums.dart';
import '../../../../core/constants/Global.dart';
import '../models/appointment.dart';


class AppointmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Common method to handle Firestore document creation
  Future<void> _createDocument(String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(docId).set(data);
    } catch (e) {
      throw Exception('Failed to create document in $collection: $e');
    }
  }

  /// Common method to fetch documents with optional filters
  Future<QuerySnapshot<Map<String, dynamic>>> _fetchDocuments({
    required String collection,
    Map<String, dynamic>? filters,
    String? orderByField,
    bool descending = false,
    int? limit,
  })
  async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection(collection);

      if (filters != null) {
        for (final entry in filters.entries) {
          query = query.where(entry.key, isEqualTo: entry.value);
        }
      }

      if (orderByField != null) {
        query = query.orderBy(orderByField, descending: descending);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      return await query.get();
    } catch (e) {
      throw Exception('Failed to fetch documents from $collection: $e');
    }
  }
  // Appointment methods
  Future<void> createAppointment(Appointment appointment) async {
    await _createDocument('appointments', appointment.id, appointment.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAppointmentsStream() {
    var query = _firestore.collection('appointments').orderBy('timestamp', descending: true);

    if (Global.userDate?.userType == UserRole.patient.name) {
      query = query.where('userId', isEqualTo: Global.userDate?.phone);
    }

    return query.snapshots();
  }
//print(querySnapshot.docs.map((doc) => Appointment.fromMap(doc.data()).toMap()).toList());

  Future<List<Appointment>> getUserAppointments({String? userId}) async {
    if (userId == null && Global.userDate?.phone == null) {
      throw Exception('User ID or phone number is required to fetch appointments.');
    }
    print("userId  "+userId.toString());

    final querySnapshot = await _fetchDocuments(
      collection: 'appointments',
      // filters: {'userId': "01118836732"},
      orderByField: 'timestamp',
    );
    print('querySnapshot  ${querySnapshot.docs.map((doc) => Appointment.fromFirestore(doc)).toList().length}');
    return querySnapshot.docs.map<Appointment>((doc) => Appointment.fromFirestore(doc)).
     where((element) => element.userId == userId).
    toList();
  }

  Future<List<Appointment>> getUserAppointmentsAsAdmin({String? userId}) async {
    final querySnapshot = await _fetchDocuments(
      collection: 'appointments',
      // filters: {'userId': userId ?? Global.userDate?.phone},
      orderByField: 'timestamp',
    );
   // print('querySnapshot   '+ querySnapshot.docs.first.data().toString());

    return querySnapshot.docs.map<Appointment>((doc) => Appointment.fromFirestore(doc))
    .toList();
  }
  Stream<List<Appointment>?> getUserAppointmentsStream({required String userId}) {
    return _firestore
        .collection('appointments')
        .orderBy('timestamp')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map<Appointment>((doc) => Appointment.fromFirestore(doc))
        .where((appointment) => appointment.userId == userId)
        .toList());
  }
  Stream<List<Appointment>> getAdminAppointmentsStream() {
    return _firestore
        .collection('appointments')
        .orderBy('timestamp')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map<Appointment>((doc) => Appointment.fromFirestore(doc))
        .toList());
  }

  // Weight Loss Plan methods
  Future<void> createWeightLossPlan(WeightLossPlan plan) async {
    await _createDocument('weightLossPlans', plan.id, plan.toMap());
  }

  Future<WeightLossPlan?> getCurrentPlan(String userId) async {
    final querySnapshot = await _fetchDocuments(
      collection: 'weightLossPlans',
      filters: {'userId': userId},
      orderByField: 'startDate',
      descending: true,
      limit: 1,
    );

    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    return WeightLossPlan.fromMap(querySnapshot.docs.first.data());
  }

  // Progress Note methods
  Future<void> addProgressNote(ProgressNote note) async {
    await _createDocument('progressNotes', note.id, note.toMap());
  }

  Future<List<ProgressNote>> getUserNotes(String userId, {String? noteType}) async {
    final querySnapshot = await _fetchDocuments(
      collection: 'progressNotes',
      filters: {'userId': userId, if (noteType != null) 'noteType': noteType},
      orderByField: 'timestamp',
      descending: true,
    );

    return querySnapshot.docs.map((doc) => ProgressNote.fromMap(doc.data())).toList();
  }

  // Analytics methods
  Future<Map<String, dynamic>> getUserProgress(String userId) async {
    try {
      final notes = await getUserNotes(userId);
      final appointments = await getUserAppointments(userId: userId);
      final currentPlan = await getCurrentPlan(userId);

      if (currentPlan == null) {
        throw Exception('No active weight loss plan found for the user.');
      }

      final lastWeightNote = notes.lastWhere(
            (note) => note.metrics['weight'] != null,
      );

      return {
        'totalAppointments': appointments.length,
        'completedAppointments': appointments.where((a) => a.status == 'completed').length,
        'weightLossProgress': currentPlan.startWeight - (lastWeightNote.metrics['weight'] ?? currentPlan.startWeight),
        'remainingWeeks': currentPlan.durationWeeks - DateTime.now().difference(currentPlan.startDate).inDays ~/ 7,
        'lastNote': notes.isNotEmpty ? notes.first.content : null,
      };
    } catch (e) {
      throw Exception('Failed to calculate user progress: $e');
    }
  }

  updateAppointmentStatus(String orderId, String status, {String? note, String? rejectionReason, DateTime? visitDateTime}) async {
  await  _firestore.collection('appointments').doc(orderId).update({
      'status': status,
      'note': note,

      'rejectionReason': rejectionReason,
      'visitDateTime': visitDateTime,
    });
  }

  Future<List<Appointment>>  getAppointments() {
  return  Global.userDate?.userType == UserRole.patient.name
        ? getUserAppointments(userId: Global.userDate?.phone)
        : getUserAppointmentsAsAdmin();
  }
}


// class AppointmentRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Appointment methods
//   Future<void> createAppointment(Appointment appointment) async {
//
//   }
//   Stream<QuerySnapshot> getAppointmentsStream() {
//     var query = _firestore.collection('appointments')
//         .orderBy('timestamp', descending: true);
//
//     if (Global.userDate?.userType == UserRole.patient.name) {
//       query = query.where('userId', isEqualTo: Global.userDate?.phone);
//     }
//     return query.snapshots();
//   }
//   Future<List<Appointment>> getUserAppointments() async {
//     try {
//       final querySnapshot = await _firestore
//           .collection('appointments')
//           // .where('userId', isEqualTo: userId)
//           .orderBy('timestamp')
//           .get();
//
//       return querySnapshot.docs
//           .map((doc) => Appointment.fromMap(doc.data()))
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to get user appointments: $e');
//     }
//   }
//   Future<List<Appointment>> getAppointmentsByUserId(String? userId) async {
//     try {
//       final querySnapshot = await _firestore
//           .collection('appointments')
//           .where('userId', isEqualTo: userId)
//           .orderBy('timestamp')
//           .get();
//
//       return querySnapshot.docs
//           .map((doc) => Appointment.fromMap(doc.data()))
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to get user appointments: $e');
//     }
//   }
//
//   // Weight Loss Plan methods
//   Future<void> createWeightLossPlan(WeightLossPlan plan) async {
//     try {
//       await _firestore.collection('weightLossPlans').doc(plan.id).set(plan.toMap());
//     } catch (e) {
//       throw Exception('Failed to create weight loss plan: $e');
//     }
//   }
//
//   Future<WeightLossPlan> getCurrentPlan(String userId) async {
//     try {
//       final querySnapshot = await _firestore
//           .collection('weightLossPlans')
//           .where('userId', isEqualTo: userId)
//           .orderBy('startDate', descending: true)
//           .limit(1)
//           .get();
//
//       if (querySnapshot.docs.isEmpty) {
//         throw Exception('No active weight loss plan found');
//       }
//
//       return WeightLossPlan.fromMap(querySnapshot.docs.first.data());
//     } catch (e) {
//       throw Exception('Failed to get current weight loss plan: $e');
//     }
//   }
//
//   // Progress Note methods
//   Future<void> addProgressNote(ProgressNote note) async {
//     try {
//       await _firestore.collection('progressNotes').doc(note.id).set(note.toMap());
//     } catch (e) {
//       throw Exception('Failed to add progress note: $e');
//     }
//   }
//
//   Future<List<ProgressNote>> getUserNotes(String userId, {String? noteType}) async {
//     try {
//       var query = _firestore
//           .collection('progressNotes')
//           .where('userId', isEqualTo: userId)
//           .orderBy('timestamp', descending: true);
//
//       if (noteType != null) {
//         query = query.where('noteType', isEqualTo: noteType);
//       }
//
//       final querySnapshot = await query.get();
//
//       return querySnapshot.docs
//           .map((doc) => ProgressNote.fromMap(doc.data()))
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to get user notes: $e');
//     }
//   }
//
//   // Analytics methods
//   Future<Map<String, dynamic>> getUserProgress(String userId) async {
//     try {
//       final notes = await getUserNotes(userId);
//       final appointments = await getUserAppointments();
//       final currentPlan = await getCurrentPlan(userId);
//
//       // Calculate progress metrics
//       final progress = {
//         'totalAppointments': appointments.length,
//         'completedAppointments': appointments.where((a) => a.status == 'completed').length,
//         'weightLossProgress': currentPlan.startWeight - (notes.lastWhere((n) => n.metrics['weight'] != null).metrics['weight'] ?? currentPlan.startWeight),
//         'remainingWeeks': currentPlan.durationWeeks - DateTime.now().difference(currentPlan.startDate).inDays ~/ 7,
//         'lastNote': notes.isNotEmpty ? notes.first.content : null,
//       };
//
//       return progress;
//     } catch (e) {
//       throw Exception('Failed to calculate user progress: $e');
//     }
//   }
// }