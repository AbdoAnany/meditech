import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meditech/core/constants/Global.dart';
import 'package:meditech/features/1-login/data/models/user_model.dart';

import '../../../core/constants/colors.dart';
import '../models/chat_message_model.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {

  const ChatListScreen({super.key, r});

  String getChatId(String uid1, String uid2) {
    final sorted = [uid1, uid2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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

          final users =_getUsers(userSnapshot.data?.docs);

          if (users.isEmpty) {
            return const Center(child: Text('No users available'));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final chatId = getChatId( Global.userDate!.id, user.id);

              return FutureBuilder<QuerySnapshot>(
                future: _getUnreadMessageCount(chatId),

                // FirebaseFirestore.instance
                //     .collection('messages')
                //     .where('chatId', isEqualTo: chatId)
                //     .where('receiverId', isEqualTo:  Global.userDate?.id)
                //     .where('isRead', isEqualTo: false)
                //     .snapshots(),
                builder: (context, messageSnapshot) {
                  final unreadCount = messageSnapshot.data?.docs.length ?? 0;

                  return CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ChatScreen(
                            senderId:  Global.userDate!.id,
                            receiver: user,
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
                          CircleAvatar(
                            backgroundColor: AppColors.primaryColor.withOpacity(0.7),
                            child: Text(
                              user.fullName[0].toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.fullName,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),


                              ],
                            ),
                          ),
                          Text(user.userType,

                              style:  TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              )),
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
      ),
    );
  }

  _getUnreadMessageCount(String chatId) {
    return FirebaseFirestore.instance
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .where('receiverId', isEqualTo:  Global.userDate?.id)
        .where('isRead', isEqualTo: false)
        .get();
  }

  _getUsers(List<QueryDocumentSnapshot<Object?>>? docs) {
    return  Global.userDate?.userType == 'doctor' ?

      docs
        ?.map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
        .where((user) => user.id !=  Global.userDate?.id)
        .toList():
        docs
        ?.map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
        .where((user) => user.id !=  Global.userDate?.id && user.userType == 'doctor')
        .toList();


    ;
  }
}
