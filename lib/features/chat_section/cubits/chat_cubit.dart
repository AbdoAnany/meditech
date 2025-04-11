import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_message_model.dart';
import '../services/chat_service.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatService _chatService;
  final Uuid _uuid = Uuid();

  ChatCubit(this._chatService) : super(ChatInitial());

  void loadMessages(String senderId, String receiverId) {
    emit(ChatLoading());
    _chatService.getMessages(senderId, receiverId).listen((messages) {
      emit(ChatLoaded(messages));
    }).onError((error) {
      emit(ChatError(error.toString()));
    });
  }

  void sendMessage(String senderId, String receiverId, String text) {
    final messageId = _uuid.v4();
    final message = ChatMessage(
      messageId: messageId,
      text: text,
      senderId: senderId,
      receiverId: receiverId,
      timestamp: DateTime.now(),
      isRead: false,
      reactions: {},
      isEdited: false,
    );
    _chatService.sendMessage(message);
  }

  void editMessage(String senderId, String receiverId, String messageId, String newText) {
    _chatService.editMessage(senderId, receiverId, messageId, newText);
  }

  void deleteMessage(String senderId, String receiverId, String messageId) {
    _chatService.deleteMessage(senderId, receiverId, messageId);
  }

  void addReaction(String senderId, String receiverId, String messageId, String reaction) {
    _chatService.addReaction(senderId, receiverId, messageId, reaction);
  }

  void markMessageAsRead(String senderId, String receiverId, String messageId) {
    _chatService.markMessageAsRead(senderId, receiverId, messageId);
  }

  void markAllMessagesAsRead(String senderId, String receiverId) {
    _chatService.markAllMessagesAsRead(senderId, receiverId);
  }
}