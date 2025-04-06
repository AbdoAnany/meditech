import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app.dart';


/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager  {
  static NetworkManager get instance =>NetworkManager();

  final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  /// Initialize the network manager and set up a stream to continually check the connection status.
  void onInit() {
    // _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
Future<void> _updateConnectionStatus(ConnectivityResult results) async {
  _connectionStatus = results;
  if (_connectionStatus == ConnectivityResult.none) {
    TLoaders.warningSnackBar(title: 'No Internet Connection');
  }
}
  /// Update the connection status based on changes in connectivity and show a relevant popup for no internet connection.
  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   _connectionStatus.value = result;
  //   if (_connectionStatus.value == ConnectivityResult.none) {
  //     TLoaders.warningSnackBar(title: 'No Internet Connection');
  //   }
  // }

  /// Check the internet connection status.
  /// Returns `true` if connected, `false` otherwise.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Dispose or close the active connectivity stream.
  @override
  void onClose() {
    _connectivitySubscription.cancel();
  }
}

class TLoaders {
  static void warningSnackBar({required String title}) =>ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(title)));
}
