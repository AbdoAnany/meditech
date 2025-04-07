
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:meditech/core/constants/Global.dart';
import 'package:meditech/features/user%20screen/caht_screen.dart';
import 'package:meditech/features/user%20screen/chat_list.dart';

// Sample User model
class ChatUser {
  final String id;
  final String name;
  final String lastMessage;
  final int unreadCount;
  final String avatarUrl;

  ChatUser({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.unreadCount,
    required this.avatarUrl,
  });
}

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // Sample chat list data
  final List<ChatUser> chatUsers = [
    ChatUser(
      id: '1',
      name: 'John Doe',
      lastMessage: 'Hey, how are you?',
      unreadCount: 2,
      avatarUrl: 'https://example.com/avatar1.jpg',
    ),
    ChatUser(
      id: '2',
      name: 'Jane Smith',
      lastMessage: 'See you tomorrow!',
      unreadCount: 0,
      avatarUrl: 'https://example.com/avatar2.jpg',
    ),
  ];

  void _viewProfile(ChatUser user) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ProfileScreen1(user: user),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
          ),
        ],
      ),
      body:
      ChatListScreen(
        currentUser: Global.userDate!,
      ),
      // ListView.builder(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new chat functionality here
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}



// WeightLossPlanScreen(),