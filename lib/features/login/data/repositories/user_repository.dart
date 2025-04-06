import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

// Data model for user


// Repository class to handle all Firebase operations
class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'users';

  // Create new user
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection(_collection).doc(user.id).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  // Get user by ID
  Future<UserModel> getUser(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();
      if (!doc.exists) {
        throw Exception('User not found');
      }
      return UserModel.fromMap(doc.data()!);
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  // Update user weight
  Future<void> updateWeight(String userId, double newWeight) async {
    try {
      final user = await getUser(userId);
      final weightEntry = {
        'weight': newWeight,
        'date': DateTime.now(),
      };
      
      List<Map<String, dynamic>> updatedHistory = [{}, weightEntry];
      
      await _firestore.collection(_collection).doc(userId).update({
        'currentWeight': newWeight,
        'weightHistory': updatedHistory,
      });
    } catch (e) {
      throw Exception('Failed to update weight: $e');
    }
  }

  // Update next appointment
  Future<void> updateAppointment(String userId, DateTime newAppointment) async {
    try {
      await _firestore.collection(_collection).doc(userId).update({
        'nextAppointment': newAppointment,
      });
    } catch (e) {
      throw Exception('Failed to update appointment: $e');
    }
  }

  // Update medications
  Future<void> updateMedications(String userId, List<String> medications) async {
    try {
      await _firestore.collection(_collection).doc(userId).update({
        'medications': medications,
      });
    } catch (e) {
      throw Exception('Failed to update medications: $e');
    }
  }

  // Get all users for a specific doctor
  Future<List<UserModel>> getUsersByDoctor(String doctorId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('assignedDoctor', isEqualTo: doctorId)
          .get();
      
      return querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get users by doctor: $e');
    }
  }

  // Delete user
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection(_collection).doc(userId).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}