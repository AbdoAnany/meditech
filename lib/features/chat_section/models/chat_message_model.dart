import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String text;
  final String senderId;
  final String receiverId;
  final String messageId; // 👈 New field
  final DateTime timestamp;
  final bool isRead;
  final bool isEdited;
  final Map<String, int> reactions;

  ChatMessage({
    required this.text,
    required this.senderId,
    required this.receiverId,
    required this.messageId,
    required this.timestamp,
    required this.isRead,
    required this.isEdited,
    required this.reactions,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json,) {
    print("json  "+json.toString());
    return ChatMessage(
      text: json['text'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      messageId: json['messageId'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      isRead: json['isRead'] ?? false,
      isEdited: json['isEdited'] ?? false,
      reactions: Map<String, int>.from(json['reactions'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'messageId': messageId, // 👈 Must be included
      'timestamp': Timestamp.fromDate(timestamp),
      'isRead': isRead,
      'isEdited': isEdited,
      'reactions': reactions,
    };
  }
}
