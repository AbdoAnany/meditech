import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Generate a unique chat ID
  String _getChatId(String uid1, String uid2) {
    final sorted = [uid1, uid2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }

  // Fetch messages between two users
  Stream<List<ChatMessage>> getMessages(String senderId, String receiverId) {
    final chatId = _getChatId(senderId, receiverId);
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ChatMessage.fromJson({...doc.data(), 'messageId': doc.id})).toList();
    });
  }

  // Send a new message
  Future<void> sendMessage(ChatMessage message) async {
    try {
      final chatId = _getChatId(message.senderId, message.receiverId);
      final docRef = _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(message.messageId);
      await docRef.set(message.toJson());
    } catch (e) {
      print('Error sending message: $e');
      rethrow;
    }
  }

  // Edit an existing message
  Future<void> editMessage(String senderId, String receiverId, String messageId, String newText) async {
    try {
      final chatId = _getChatId(senderId, receiverId);
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .update({
        'text': newText,
        'isEdited': true,
      });
    } catch (e) {
      print('Error editing message: $e');
      rethrow;
    }
  }

  // Delete a message
  Future<void> deleteMessage(String senderId, String receiverId, String messageId) async {
    try {
      final chatId = _getChatId(senderId, receiverId);
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (e) {
      print('Error deleting message: $e');
      rethrow;
    }
  }

  // Add a reaction to a message
  Future<void> addReaction(String senderId, String receiverId, String messageId, String reaction) async {
    try {
      final chatId = _getChatId(senderId, receiverId);
      final docRef = _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId);
      final doc = await docRef.get();
      final data = doc.data();
      if (data == null) {
        throw Exception('Message not found for ID: $messageId');
      }

      final reactions = Map<String, int>.from(data['reactions'] ?? {});
      reactions[reaction] = (reactions[reaction] ?? 0) + 1;

      await docRef.update({'reactions': reactions});
    } catch (e) {
      print('Error adding reaction: $e');
      rethrow;
    }
  }

  // Mark a single message as read
  Future<void> markMessageAsRead(String senderId, String receiverId, String messageId) async {
    try {
      final chatId = _getChatId(senderId, receiverId);
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .update({
        'isRead': true,
      });
    } catch (e) {
      print('Error marking message as read: $e');
      rethrow;
    }
  }

  // Mark all unread messages from a specific sender as read
  Future<void> markAllMessagesAsRead(String senderId, String receiverId) async {
    try {
      final chatId = _getChatId(senderId, receiverId);
      final querySnapshot = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .where('senderId', isEqualTo: senderId)
          .where('receiverId', isEqualTo: receiverId)
          .where('isRead', isEqualTo: false)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.update({'isRead': true});
      }
    } catch (e) {
      print('Error marking all messages as read: $e');
      rethrow;
    }
  }
}