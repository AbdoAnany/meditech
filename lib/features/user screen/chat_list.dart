import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meditech/features/1-login/data/models/user_model.dart';
import 'package:meditech/features/user%20screen/caht_screen.dart';


// Chat List Screen
class ChatListScreen extends StatelessWidget {
  final UserModel currentUser;

  const ChatListScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Messages'),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (userSnapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (!userSnapshot.hasData || userSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users available'));
          }

          final users = userSnapshot.data!.docs
              .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
              .where((user) => user.id != currentUser.id)
              .toList();

          if (users.isEmpty) {
            return const Center(child: Text('No other users found'));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .where('receiverId', isEqualTo: currentUser.id)
                    .where('senderId', isEqualTo: user.id)
                    .where('isRead', isEqualTo: false)
                    .snapshots(),
                builder: (context, messageSnapshot) {
                  if (!messageSnapshot.hasData) {
                    return const SizedBox.shrink(); // Don't show anything while loading
                  }

                  final unreadCount = messageSnapshot.data!.docs.length;
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('messages')
                        .where('senderId', whereIn: [currentUser.id, user.id])
                        .where('receiverId', whereIn: [currentUser.id, user.id])
                        .orderBy('timestamp', descending: true)
                        .limit(1)
                        .snapshots(),
                    builder: (context, lastMessageSnapshot) {
                      String lastMessage = 'No messages yet';
                      if (lastMessageSnapshot.hasData && lastMessageSnapshot.data!.docs.isNotEmpty) {
                        final message = Message.fromMap(
                            lastMessageSnapshot.data!.docs.first.data() as Map<String, dynamic>);
                        lastMessage = message.content;
                      }

                      return CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ChatScreen(
                                senderId: currentUser.id,
                                receiverId: user.id,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: CupertinoColors.lightBackgroundGray),
                            ),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(radius: 25),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.fullName, style: const TextStyle(fontSize: 16)),
                                    Text(
                                      lastMessage,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors.secondaryLabel,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              if (unreadCount > 0)
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: CupertinoColors.systemBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    unreadCount.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.recipient.fullName),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .where('senderId', whereIn: [widget.currentUser.id, widget.recipient.id])
                    .where('receiverId', whereIn: [widget.currentUser.id, widget.recipient.id])
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CupertinoActivityIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No messages yet'));
                  }

                  final messages = snapshot.data!.docs
                      .map((doc) => Message.fromMap(doc.data() as Map<String, dynamic>))
                      .toList();

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.senderId == widget.currentUser.id;

                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe
                                ? CupertinoColors.systemBlue
                                : CupertinoColors.lightBackgroundGray,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            message.content,
                            style: TextStyle(
                              color: isMe ? Colors.white : CupertinoColors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: CupertinoColors.extraLightBackgroundGray,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      controller: _messageController,
                      placeholder: 'iMessage',
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                  CupertinoButton(
                    child: const Icon(CupertinoIcons.paperplane_fill),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: widget.currentUser.id,
      receiverId: widget.recipient.id,
      content: _messageController.text.trim(),
      timestamp: Timestamp.now(),
      isRead: false,
    );

    await FirebaseFirestore.instance
        .collection('messages')
        .doc(message.id)
        .set(message.toMap());

    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}