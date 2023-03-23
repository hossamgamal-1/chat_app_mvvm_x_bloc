import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SentMessageTile extends StatelessWidget {
  const SentMessageTile(this.snapShotItem, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot snapShotItem;
  @override
  Widget build(BuildContext context) {
    final Timestamp time = snapShotItem['time'];
    return Container(
      constraints: BoxConstraints(
        minWidth: 25.w,
        maxWidth: 70.w,
      ),
      margin: const EdgeInsets.only(top: 10, right: 10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 117, 122, 209),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.zero,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            snapShotItem['text'],
            style: const TextStyle(color: Colors.white, fontSize: 16),
            softWrap: true,
          ),
          Positioned(
            bottom: -16,
            right: -8,
            child: Text(
              DateFormat('hh:mm a').format(time.toDate()),
              style: const TextStyle(
                color: Color.fromARGB(255, 241, 241, 241),
                fontSize: 12,
              ),
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
