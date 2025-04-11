import 'package:flutter/material.dart';
import '../models/chat_message_model.dart';

class ReplyWidget extends StatelessWidget {
  final ChatMessage replyTo;

  const ReplyWidget({required this.replyTo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(replyTo.text, style: TextStyle(fontSize: 12)),
          SizedBox(height: 4),
          Text('Replying to ${replyTo.senderId}', style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}