import 'package:get_storage/get_storage.dart';

import '../../features/1-login/data/models/user_model.dart';
import '../constants/Global.dart';
import '../constants/StringKeys.dart';

class TLocalStorage {
  static final TLocalStorage _instance = TLocalStorage._internal();

  factory TLocalStorage() {
    return _instance;
  }

  TLocalStorage._internal();

  final _storage = GetStorage();

  // Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  Future<void> saveUserData<UserModel>(String key, UserModel value) async {
    await _storage.write(key, value);
  }

  Future<dynamic> getAllKeys() async {
    return await _storage.getKeys();
  }

  Future<dynamic> getAllValues() async {
    return await _storage.getValues();
  }

  // Generic method to read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }

  static Future<UserModel?> cacheUser(UserModel user) async {
    TLocalStorage _prefs = TLocalStorage();

    try {
      // final userSnapshot = await _fireStore.collection('users').doc(id).get();
      // if (userSnapshot.exists) {

      print('User cached: ${user.toMap()}');

      // Save the user data using the toJson method
      await _prefs.saveData<Map<String, dynamic>>(
          StringKeys.userInfo, user.toMap());

      Global.userDate = user;
      return user;
      // }
    } catch (e) {
      print('Error caching user: $e');
    }

    return null;
  }

  static Future<UserModel?> getCacheUser() async {
    TLocalStorage _prefs = TLocalStorage();

    // try {

    // Save the user data using the toJson method
    final Map<String, dynamic>? userModel =
        await _prefs.readData<Map<String, dynamic>>(StringKeys.userInfo);

    Global.userDate = UserModel.fromMap(userModel);
    return Global.userDate;
    // }
    // } catch (e) {
    //   print('Error get caching user: $e');
    // }

    return null;
  }
}


/// *** *** *** *** *** Example *** *** *** *** *** ///

// LocalStorage localStorage = LocalStorage();
//
// // Save data
// localStorage.saveData('username', 'JohnDoe');
//
// // Read data
// String? username = localStorage.readData<String>('username');
// print('Username: $username'); // Output: Username: JohnDoe
//
// // Remove data
// localStorage.removeData('username');
//
// // Clear all data
// localStorage.clearAll();

