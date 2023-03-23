import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/business_logic/auth_provider.dart';
import '../../business_logic/chat_provider.dart';
import 'recieved_message_tile.dart';
import 'sent_message_tile.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('chat/roH5hykQCCKmM2ilEVtp/messages')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapShots) {
          if (snapShots.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }

          final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
              snapShots.data!.docs;
          return SingleChildScrollView(
              controller: context.watch<ChatProvider>().scrollController,
              child: Column(
                  children: docs
                      .map<Widget>((snapShotItem) {
                        return snapShotItem['senderId'] ==
                                context.read<AuthProvider>().currentUserUID
                            ? Container(
                                alignment: Alignment.centerRight,
                                child: SentMessageTile(snapShotItem),
                              )
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: RecievedMessageTile(snapShotItem),
                              );
                      })
                      .toList()
                      .reversed
                      .toList()));
        });
  }
}
