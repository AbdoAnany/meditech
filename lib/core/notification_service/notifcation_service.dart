
import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NotificationItem.dart';
import 'TokenMonitor.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  // Stream controllers
  // Stream controllers
  final _notificationController = BehaviorSubject<List<NotificationItem>>();
  final _messageController = BehaviorSubject<Map<String, dynamic>>();

  // Stream getters
  Stream<List<NotificationItem>> get notifications => _notificationController.stream;
  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  // Instance variables
  late final FirebaseMessaging _messaging;
  late final FlutterLocalNotificationsPlugin _localNotifications;
  late final SharedPreferences _prefs;
  final Set<String> _subscribedTopics = {};

  // Constants
  static const String _notificationKey = 'notifications';
  static const String _topicsKey = 'subscribed_topics';
  final String _serverUrl = 'https://abdoanany.pythonanywhere.com/pushFCM';

  // Channel configuration
  final _channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  Future<void> initialize() async {
    // Initialize dependencies
    _messaging = FirebaseMessaging.instance;
    _localNotifications = FlutterLocalNotificationsPlugin();
    _prefs = await SharedPreferences.getInstance();

    // Setup notifications
    await _setupNotifications();
    await TokenMonitor.refreshToken();

    // Load saved data
    await _loadSavedData();

    // Configure message handlers
    _setupMessageHandlers();

 //   FirebaseMessaging.instance.unsubscribeFromTopic('doctors_topic');
  }

  Future<void> _setupNotifications() async {
    // Request permissions
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications
    const   initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,

      // onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,


    );

    await _localNotifications.initialize(
      initializationSettings,

      onDidReceiveNotificationResponse: _onNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: _onBackgroundNotificationResponse,
    );

    // Create notification channel
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // Configure foreground notification options
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _setupMessageHandlers() {
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }

  Future<void> _loadSavedData() async {
    // Load saved notifications
    final notificationsJson = _prefs.getStringList(_notificationKey) ?? [];
    final notifications = notificationsJson
        .map((json) => NotificationItem.fromJson(jsonDecode(json)))
        .toList();
    _notificationController.add(notifications);

    // Load saved topics
    final topics = _prefs.getStringList(_topicsKey) ?? [];
    _subscribedTopics.addAll(topics);
  }

  Future<void> _saveNotifications(List<NotificationItem> notifications) async {
    final notificationsJson = notifications
        .map((notification) => jsonEncode(notification.toJson()))
        .toList();
    await _prefs.setStringList(_notificationKey, notificationsJson);
    _notificationController.add(notifications);
  }

  Future<void> _saveTopics() async {
    await _prefs.setStringList(_topicsKey, _subscribedTopics.toList());
  }

  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    _subscribedTopics.add(topic);
    await _saveTopics();
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    _subscribedTopics.remove(topic);
    await _saveTopics();
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    final notification = NotificationItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      data: message.data,
      timestamp: DateTime.now(),
    );

    final currentNotifications = _notificationController.value;
    currentNotifications.insert(0, notification);
    await _saveNotifications(currentNotifications);

    await _showLocalNotification(notification);
    _messageController.add(message.data);
  }

  Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    _messageController.add(message.data);
  }

  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    // Handle background message here
    print('Handling a background message: ${message.messageId}');
  }

  Future<void> _showLocalNotification(NotificationItem notification) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
      payload: jsonEncode(notification.toJson()),
    );
  }

  Future<void> markAsRead(String notificationId) async {
    final notifications = _notificationController.value;
    final index = notifications.indexWhere((n) => n.id == notificationId);

    if (index != -1) {
      notifications[index].isRead = true;
      await _saveNotifications(notifications);
    }
  }

  Future<void> clearAll() async {
    await _saveNotifications([]);
  }

  Future<void> deleteNotification(String notificationId) async {
    final notifications = _notificationController.value;
    notifications.removeWhere((n) => n.id == notificationId);
    await _saveNotifications(notifications);
  }

  List<NotificationItem> getUnreadNotifications() {
    return _notificationController.value.where((n) => !n.isRead).toList();
  }

  Future<void> sendNotification({
    required String title,
    required String message,
    required dynamic registrationTokens,
    required Map<String, dynamic> data,
    String? topic,
  }) async {
    final List<String> tokens = registrationTokens is String
        ? [registrationTokens]
        : List<String>.from(registrationTokens);

    final response = await http.post(
      Uri.parse(_serverUrl),
      body: json.encode({
        'title': title,
        'msg': message,
        'token': tokens.first,
        'data': data,
        'topic': topic ?? '',
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send notification: ${response.statusCode}');
    }
  }

  void _onNotificationResponse(NotificationResponse response) {
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      _messageController.add(data);
    }
  }

  static void _onBackgroundNotificationResponse(NotificationResponse response) {
    // Handle background notification response if needed
  }

  static void _onDidReceiveLocalNotification(
      int id,
      String? title,
      String? body,
      String? payload,
      ) {
    // Handle iOS local notification if needed
  }

  void dispose() {
    _notificationController.close();
    _messageController.close();
  }
}