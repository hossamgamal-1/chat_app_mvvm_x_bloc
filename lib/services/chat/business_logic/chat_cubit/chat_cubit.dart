import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  String currentMessage = '';
  sendMessageIcon(newString) {
    currentMessage = newString;
    emit(ChatPrepare());
  }

  messageReset() {
    currentMessage = '';
    emit(ChatInitial());
  }

  final ScrollController scrollController = ScrollController();
  scrollControllerReset() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  DocumentSnapshot<Map<String, dynamic>>? otheruserData;
  otherUserData(String otherUserID) async {
    var x = FirebaseFirestore.instance.collection('users').doc(otherUserID);
    otheruserData = await x.get();
    emit(ChatSuccess());
  }
}
