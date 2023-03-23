import 'package:chat_app/services/auth/business_logic/logic_auth_cubit/Logic_auth_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection.dart';
import '../../business_logic/chat_cubit/chat_cubit.dart';
import 'recieved_message_tile.dart';
import 'sent_message_tile.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogicAuthCubit(sL()),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                controller: context.watch<ChatCubit>().scrollController,
                child: Column(
                    children: docs
                        .map<Widget>((snapShotItem) {
                          return snapShotItem['senderId'] ==
                                  context.read<LogicAuthCubit>().currentUserUID
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
          }),
    );
  }
}
