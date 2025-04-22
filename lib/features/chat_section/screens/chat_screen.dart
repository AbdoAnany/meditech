import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meditech/core/constants/colors.dart';
import 'package:meditech/features/1-login/data/models/user_model.dart';
import '../cubits/chat_cubit.dart';
import '../models/chat_message_model.dart';
import '../services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  final String senderId;
  final UserModel receiver;

  const ChatScreen({required this.senderId, required this.receiver});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == today.subtract(Duration(days: 1))) {
      return 'Yesterday';
    } else if (messageDate.isAfter(today.subtract(Duration(days: 7)))) {
      return DateFormat('EEEE').format(date); // e.g., "Monday"
    } else {
      return DateFormat('MMMM d, y').format(date); // e.g., "April 9, 2025"
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(ChatService())..loadMessages(widget.senderId, widget.receiver.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Row(
            children: [
              // CircleAvatar(
              //   radius: 20,
              //   backgroundColor: Colors.white,
              //   child: Text(
              //     widget.receiver.fullName[0].toUpperCase(),
              //     style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
              //   ),
              // ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.receiver.fullName,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.white),
          //   onPressed: () => Navigator.pop(context),
          // ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatLoaded) {
                    Future.delayed(Duration(milliseconds: 100), _scrollToBottom);
                  }
                },
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ChatLoaded) {
                    return _buildMessagesList(context, state.messages);
                  } else if (state is ChatError) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  return Center(child: Text('No messages yet'));
                },
              ),
            ),
            Builder(
              builder: (context) => _buildMessageInput(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesList(BuildContext context, List<ChatMessage> messages) {
    if (messages.isEmpty) {
      return Center(child: Text('No messages yet'));
    }

    List<Widget> messageWidgets = [];
    DateTime? lastDate;

    for (var message in messages) {
      final messageDate = DateTime(message.timestamp.year, message.timestamp.month, message.timestamp.day);
      if (lastDate == null || lastDate != messageDate) {
        lastDate = messageDate;
        messageWidgets.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _formatDateHeader(messageDate),
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ),
            ),
          ),
        );
      }

      final isMe = message.senderId == widget.senderId;
      messageWidgets.add(
        GestureDetector(
          onLongPress: () => _showMessageOptions(context, message, isMe),
          child: _buildMessageBubble(message, isMe),
        ),
      );
    }

    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.all(8),
      children: messageWidgets,
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(12).copyWith(
            bottomRight: isMe ? Radius.zero : Radius.circular(12),
            bottomLeft: isMe ? Radius.circular(12) : Radius.zero,
          ),
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('h:mm a').format(message.timestamp),
                  style: TextStyle(
                    color: isMe ? Colors.white70 : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                if (isMe) SizedBox(width: 4),
                if (isMe)
                  Icon(
                    message.isRead ? Icons.done_all : Icons.done,
                    size: 16,
                    color: message.isRead ? Colors.lightBlueAccent : Colors.white70,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMessageOptions(BuildContext context, ChatMessage message, bool isMe) {
     if (!isMe) return; // Only allow options for sender's messages
print(message.text);
    showModalBottomSheet(
      context: context,
      builder: (context1) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              _messageController.text = message.text;
              showDialog(
                context: context,
                builder: (context2) => AlertDialog(
                  title: Text('Edit Message'),
                  content: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Edit your message'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context2);
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        print('ssdsdddddddd');
                        if (_messageController.text.trim().isNotEmpty) {
                          print('ssdsd');
                          context.read<ChatCubit>().editMessage(
                            widget.senderId,
                            widget.receiver.id,
                            message.messageId,
                            _messageController.text.trim(),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
            onTap: () {
              Navigator.pop(context);
              context.read<ChatCubit>().deleteMessage(
                widget.senderId,
                widget.receiver.id,
                message.messageId,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),

                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: AppColors.transparent,
            child: IconButton(
              icon: Icon(Icons.send,color: AppColors.primary, ),
              onPressed: () {
                if (_inputController.text.trim().isNotEmpty) {
                  context.read<ChatCubit>().sendMessage(
                    widget.senderId,
                    widget.receiver.id,
                    _inputController.text.trim(),
                  );
                  _inputController.clear();
                  _scrollToBottom();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}