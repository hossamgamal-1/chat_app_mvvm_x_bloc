import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_router.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../auth/business_logic/auth_provider.dart';
import '../../business_logic/chat_provider.dart';

class ChatsTile extends StatelessWidget {
  const ChatsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: firebaseFirestore.collection('chats').snapshots(),
      builder: (context, snapShots) {
        if (snapShots.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.white));
        }
        var filteredList = snapShots.data!.docs
            .where((element) => element.id
                .contains(context.watch<AuthProvider>().currentUserUID))
            .toList();

        List<Widget> listWidget = List.generate(filteredList.length, (index) {
          String otherUserID = '';
          if (filteredList[index].id.split('&&')[0] ==
              context.watch<AuthProvider>().currentUserUID) {
            otherUserID = filteredList[index].id.split('&&')[1];
          } else if (filteredList[index].id.split('&&')[1] ==
              context.watch<AuthProvider>().currentUserUID) {
            otherUserID = filteredList[index].id.split('&&')[0];
          }

          context.read<ChatProvider>().otherUserData(otherUserID);

          return InkWell(
            onTap: () => Navigator.pushNamed(context, RouteNames.chatRoute),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: AppMargin.m2.w,
                vertical: AppMargin.m1.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: AppSize.s10.h,
              child: Consumer<ChatProvider>(
                builder: (context, chatProviderobject, child) {
                  String url = chatProviderobject.otheruserData?['imageUrl'] ??
                      'https://image.shutterstock.com/image-vector/error-customer-icon-editable-line-260nw-1714948474.jpg';

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 89, 93, 161),
                        backgroundImage: NetworkImage(url),
                        radius: AppSize.s48,
                      ),
                      const SizedBox(width: AppSize.s5),
                      Text(
                        chatProviderobject.otheruserData?['username'] ??
                            'Unkown User',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.s26,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        });

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listWidget,
          ),
        );
      },
    );
  }
}
