// notification_model.dart
class NotificationItem {
  final String id;
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final DateTime timestamp;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.data,
    required this.timestamp,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'data': data,
    'timestamp': timestamp.toIso8601String(),
    'isRead': isRead,
  };

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
    id: json['id'],
    title: json['title'],
    body: json['body'],
    data: json['data'],
    timestamp: DateTime.parse(json['timestamp']),
    isRead: json['isRead'] ?? false,
  );
}

// notification_state.dart
abstract class NotificationState {
  final List<NotificationItem> notifications;
  final Set<String> subscribedTopics;

  NotificationState({
    required this.notifications,
    required this.subscribedTopics,
  });
}

// notification_service.dart