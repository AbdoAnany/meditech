import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/Global.dart';
import '../../../../core/constants/StringKeys.dart';
import '../../../../core/local_storage/storage_utility.dart';
import '../../data/models/user_model.dart';

part 'login_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;
  AuthCubit() : super(AuthInitial());

  // Convert Egypt phone to international format
  String _formatEgyptianPhone(String phone) {
    // Remove any non-digit characters
    String cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');

    // Add Egypt country code if not present
    if (cleanPhone.startsWith('0')) {
      cleanPhone = cleanPhone.substring(1);
    }
    return '20$cleanPhone';
  }

  Future<UserModel?> cacheUser(id) async {
  // final _prefs = await SharedPreferences.getInstance();
    TLocalStorage _prefs = TLocalStorage();
  await _fireStore.collection('users').doc(id).get().then((user) async {
    final userModel = UserModel.fromMap(user.data()!);
  await  TLocalStorage.cacheUser(userModel);
    return userModel;

  });
return null;
}
  final _storage = FlutterSecureStorage();

  Future<void> login(String phone, String password, bool rememberMe) async {
    try {
      emit(AuthLoading());
      // Format phone number
      final formattedPhone = _formatEgyptianPhone(phone);
      print("$formattedPhone@domain.com");
      print("$password");
final _prefs = await SharedPreferences.getInstance();
      // Sign in with phone and password
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: "$formattedPhone@domain.com", // Using phone as email
        password: password,
      );

      if (userCredential.user != null) {
     await cacheUser(phone);
        // Save remember me preference
        if (rememberMe) {
          await _prefs.setBool('remember_me', true);
          await _prefs.setString('saved_phone', phone);

          // Use secure storage for sensitive data
          await _storage.write(key: 'saved_password', value: password);
        } else {
          await _prefs.clear();
          await _storage.deleteAll(); // Clear secure storage
        }

        emit(AuthSuccess(userCredential.user!));
      }
    } catch (e) {
      print("Error logging in: $e");
      emit(AuthError(_getAuthErrorMessage(e)));
    }
  }
  Future<void> checkSavedCredentials() async {
    final _prefs = await SharedPreferences.getInstance();

    final rememberMe = _prefs.getBool('remember_me') ?? false;
    if (rememberMe) {
      final phone = _prefs.getString('saved_phone');
      final password = _prefs.getString('saved_password');
      if (phone != null && password != null) {
        await login(phone, password, true);
      }
    }
  }


  // Anonymous login function
  Future<void> signInAnonymously() async {
    try {
      emit(AuthLoading()); // Notify the UI that authentication is in progress

      // Check if the user is already logged in anonymously
      final User? currentUser = _auth.currentUser;
      if (currentUser != null && currentUser.isAnonymous) {
        print("User is already logged in anonymously. UID: ${currentUser.uid}");
        // await cacheUser(currentUser);

        emit(AuthSuccess(currentUser));
        return;
      }

      // Attempt to sign in anonymously
      final UserCredential userCredential = await _auth.signInAnonymously();
      final User? user = userCredential.user;


      if (user != null) {
        // await cacheUser(userCredential.user!);

        print("Anonymous login successful. UID: ${user.uid}");
        emit(AuthSuccess(user)); // Notify the UI of successful login
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'operation-not-allowed') {
        print("Anonymous authentication is not enabled in the Firebase Console.");
        emit(AuthError("Anonymous login is not available at this time."));
      } else {
        print("Error signing in anonymously: ${e.message}");
        emit(AuthError(e.message ?? "An unknown error occurred"));
      }
    } catch (e) {
      print("Unexpected error during anonymous login: $e");
      emit(AuthError("An unexpected error occurred. Please try again later."));
    }
  }

  // Check if the user is logged in anonymously
  bool isUserAnonymous() {
  final User? user = _auth.currentUser;
  return user != null && user.isAnonymous;
  }

  // Convert anonymous account to permanent account (e.g., email/password)
  Future<void> convertAnonymousToPermanent(String email, String password) async {
  try {
  final User? user = _auth.currentUser;
  if (user == null || !user.isAnonymous) {
  throw Exception("No anonymous user found.");
  }

  // Link the anonymous account with email/password credentials
  final credential = EmailAuthProvider.credential(email: email, password: password);
  await user.linkWithCredential(credential);

  print("Anonymous account converted to permanent account.");
  } on FirebaseAuthException catch (e) {
  print("Error converting anonymous account: ${e.message}");
  }
  }

  // Sign out
  Future<void> signOut() async {
  await _auth.signOut();
  print("User signed out.");
  }

  Future<void> signUp({required UserModel user
    }) async {
    emit(AuthLoading());
    if (user.password != user.confirmPassword) {
      emit(AuthError("Passwords do not match"));
      return;
    }
    final formattedPhone = _formatEgyptianPhone(user.phone);
  await  saveDate(user: user);
    _auth.createUserWithEmailAndPassword(
      email: "$formattedPhone@domain.com",
      password: user.password,
    ).then((value) {
      value.user!.updateDisplayName(user.fullName);
      emit(AuthSuccess(value.user!));
    }).catchError((error) {
      emit(AuthError(_getAuthErrorMessage(error))); // Notify the UI of the error
    });
  }

  Future<void> saveDate({required UserModel user
}) async {

   await _fireStore.collection('users').doc(user.phone).set(user.toMap());
  }


}
  String _getAuthErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-credential':
          return 'رقم الهاتف أو كلمة المرور غير صحيحة';
        case 'user-disabled':
          return 'تم تعطيل هذا الحساب';
        case 'user-not-found':
          return 'لم يتم العثور على حساب بهذا الرقم';
        default:
          return 'حدث خطأ في تسجيل الدخول';
      }
    }
    return 'حدث خطأ غير متوقع';

}
