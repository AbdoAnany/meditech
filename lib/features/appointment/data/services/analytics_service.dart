import 'package:cloud_firestore/cloud_firestore.dart';

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
      'targetProgress': _calculateTargetProgress(weightHistory, targetWeight),
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
  ) {
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
}