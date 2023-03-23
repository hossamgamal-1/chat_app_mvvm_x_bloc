import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/values_manager.dart';

class RecievedMessageTile extends StatelessWidget {
  const RecievedMessageTile(this.snapShotItem, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot snapShotItem;

  @override
  Widget build(BuildContext context) {
    final Timestamp time = snapShotItem['time'];
    return Container(
      clipBehavior: Clip.antiAlias,
      constraints: BoxConstraints(
        minWidth: 25.w,
        maxWidth: 70.w,
      ),
      margin: const EdgeInsets.only(top: AppMargin.m10, left: AppMargin.m10),
      padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p20, horizontal: AppPadding.p15),
      decoration: const BoxDecoration(
        color: Color(0xff8E94FF),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(AppSize.s15),
          topRight: Radius.circular(AppSize.s15),
          topLeft: Radius.circular(AppSize.s15),
          bottomLeft: Radius.zero,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            snapShotItem['text'],
            style: const TextStyle(color: Colors.white, fontSize: FontSize.s16),
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
