import 'package:flutter/material.dart';
import 'package:meditech/core/constants/colors.dart';
import '../models/chat_message_model.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    bool isMe = message.senderId == 'currentUserId'; // Replace with actual user ID
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isMe ?   Colors.grey[200]:AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.text,  style: TextStyle(
              fontSize: 16,
              color: isMe ?   Colors.grey[200]:AppColors.white,

            )),
            // SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${message.timestamp.hour}:${message.timestamp..minute}',
                style: TextStyle(
                  color: isMe ?   Colors.grey[200]:AppColors.white,

                )),
                if (isMe && message.isRead)
                  Icon(Icons.done_all, size: 16, color: Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}