import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatProvider with ChangeNotifier {
  String currentMessage = '';
  sendMessageIcon(newString) {
    currentMessage = newString;
    notifyListeners();
  }

  messageReset() {
    currentMessage = '';
    notifyListeners();
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
    // print(otherUserID);
    var x = FirebaseFirestore.instance.collection('users').doc(otherUserID);
    otheruserData = await x.get();
    notifyListeners();
  }
}
