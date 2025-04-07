import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔥 Get Chat ID (Sorted IDs ensure unique chat for two users)
  String _getChatId(String user1, String user2) {
    return user1.hashCode <= user2.hashCode ? '$user1 _ $user2' : '$user2 _ $user1';
  }

  // ✉️ Send Message
  Future<void> sendMessage(String senderId, String receiverId, String text) async {
    String chatId = _getChatId(senderId, receiverId);
    Message message = Message(id: '', senderId: senderId, receiverId: receiverId, text: text, timestamp: DateTime.now());

    await _firestore.collection('chats').doc(chatId).collection('messages').add(message.toFirestore());
  }

  // 💬 Get Chat Messages (Real-time)
  Stream<QuerySnapshot> getMessages(String user1, String user2) {
    String chatId = _getChatId(user1, user2);
    return _firestore.collection('chats').doc(chatId).collection('messages').orderBy('timestamp').snapshots();
  }
}


class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timestamp;

  Message({required this.id, required this.senderId, required this.receiverId, required this.text, required this.timestamp});

  factory Message.fromFirestore(Map<String, dynamic> data, String id) {
    return Message(
      id: id,
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      text: data['text'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "text": text,
      "timestamp": FieldValue.serverTimestamp(),
    };
  }
}