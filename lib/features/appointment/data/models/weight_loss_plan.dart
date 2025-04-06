import 'package:cloud_firestore/cloud_firestore.dart';

class WeightLossPlan {
  final String id;
  final String userId;
  final DateTime startDate;
  final double startWeight;
  final double targetWeight;
  final int durationWeeks;
  final List<String> dietaryRestrictions;
  final List<String> recommendedExercises;
  final Map<String, dynamic> weeklyGoals;
  final List<String> supplements;

  WeightLossPlan({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.startWeight,
    required this.targetWeight,
    required this.durationWeeks,
    required this.dietaryRestrictions,
    required this.recommendedExercises,
    required this.weeklyGoals,
    required this.supplements,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'startDate': startDate,
    'startWeight': startWeight,
    'targetWeight': targetWeight,
    'durationWeeks': durationWeeks,
    'dietaryRestrictions': dietaryRestrictions,
    'recommendedExercises': recommendedExercises,
    'weeklyGoals': weeklyGoals,
    'supplements': supplements,
  };

  factory WeightLossPlan.fromMap(Map<String, dynamic> map) => WeightLossPlan(
    id: map['id'],
    userId: map['userId'],
    startDate: (map['startDate'] as Timestamp).toDate(),
    startWeight: map['startWeight'].toDouble(),
    targetWeight: map['targetWeight'].toDouble(),
    durationWeeks: map['durationWeeks'],
    dietaryRestrictions: List<String>.from(map['dietaryRestrictions']),
    recommendedExercises: List<String>.from(map['recommendedExercises']),
    weeklyGoals: Map<String, dynamic>.from(map['weeklyGoals']),
    supplements: List<String>.from(map['supplements']),
  );
}