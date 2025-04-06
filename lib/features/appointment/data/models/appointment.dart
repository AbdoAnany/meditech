
import 'package:cloud_firestore/cloud_firestore.dart';

import 'comment.dart';

class Appointment
{
  final String id;
  final String userId;
  final String doctorId;
  final String description;
  final String status;
  final String appointmentType;
  final String notes;
  final String? token;
  final String? rejectionReason;
  final String? patientName;
  final DateTime? timestamp;
  final List<Comment> comments;
  final DateTime? visitDateTime;

  Appointment({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.patientName,
     this.token='',
    required this.description,
    required this.status,
    required this.appointmentType,
     this.notes = '',
    this.rejectionReason,
     this.timestamp,
    required this.comments,
    this.visitDateTime,
  });

  factory Appointment.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    // print('data: ${ doc.id.toString()}');
    // print('timestamp: ${data['timestamp'].runtimeType}');
    // if(data['visitDateTime'] .runtimeType == Timestamp){
    //   print('ddddddddddddd');
    //   data['visitDateTime']=(data['visitDateTime'] as Timestamp).toDate().toIso8601String();
    // }
    // print('visitDateTime....: ${data['visitDateTime'].runtimeType}');

    return Appointment(
      id: doc.id.toString(),
      userId: data['userId'],
      token: data['token']??'',
      patientName: data['patientName'],
      doctorId: data['doctorId'],
      appointmentType: data['appointmentType'],
      description: data['description'] ?? '',
      status: data['status'] ?? 'pending',
      notes: data['note'] ?? 'لا يوجد ملاحظات',
      rejectionReason: data['rejectionReason'],
      timestamp: _handleDateTime(data['timestamp'])  ,
      comments:
      (data['comments'] as List<dynamic>?)
          ?.map((c) => Comment.fromMap(c))
          .toList() ??
          [],
    visitDateTime:_handleDateTime(data['visitDateTime'])
    );
  }

 static DateTime? _handleDateTime(dynamic value) {
    if (value == null) return DateTime.now();

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        print('Invalid date string format: $value');
        return null; // قيمة افتراضية عند الفشل
      }
    }

    print('Unexpected type: ${value.runtimeType}');
    return null;
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'token': token??'',
    'doctorId': doctorId,
    'patientName': patientName,
    'appointmentType': appointmentType,
    'status': status,
    'description': description,
    'note': notes,
    'rejectionReason': rejectionReason,
    'timestamp': timestamp?.toIso8601String(),
    'comments': comments.map((c) => c.toMap()).toList(),
    'visitDateTime': visitDateTime?.toIso8601String(),
  };

  factory Appointment.fromMap(Map<String, dynamic> map) => Appointment(
    id: map['id'],
    userId: map['userId'],
    doctorId: map['doctorId'],
      token: map['token']??'',
    appointmentType: map['appointmentType'],
    status: map['status'],
      patientName: map['patientName'],
    description: map['description'],
    notes: map['note'],
    rejectionReason: map['rejectionReason'],
    timestamp: DateTime.parse((map['timestamp'] as Timestamp).toDate().toString()),
    comments: (map['comments'] as List<dynamic>?)
        ?.map((c) => Comment.fromMap(c))
        .toList() ??
        [],
    visitDateTime: DateTime.parse((map['visitDateTime'] as Timestamp).toDate().toString())
  );
}
