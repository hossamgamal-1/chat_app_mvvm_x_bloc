import 'package:chat_app/services/chat/business_logic/chat_cubit/chat_cubit.dart';
import 'package:chat_app/services/chat/business_logic/chat_cubit/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/app_router.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/values_manager.dart';

class ChatsTile extends StatelessWidget {
  const ChatsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    //   stream: firebaseFirestore.collection('chats').snapshots(),
    //   builder: (context, snapShots) {
    // if (snapShots.connectionState == ConnectionState.waiting) {
    //   return const Center(
    //       child: CircularProgressIndicator(color: Colors.white));
    // }
    // var filteredList = snapShots.data!.docs
    //     .where((element) => element.id
    //         .contains(context.watch<LogicAuthCubit>().currentUserUID))
    //     .toList();

    // List<Widget> listWidget = List.generate(filteredList.length, (index) {
    //   String otherUserID = '';
    //   if (filteredList[index].id.split('&&')[0] ==
    //       context.watch<LogicAuthCubit>().currentUserUID) {
    //     otherUserID = filteredList[index].id.split('&&')[1];
    //   } else if (filteredList[index].id.split('&&')[1] ==
    //       context.watch<LogicAuthCubit>().currentUserUID) {
    //     otherUserID = filteredList[index].id.split('&&')[0];
    //   }

    //   context.read<ChatProvider>().otherUserData(otherUserID);

    //   });

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
        child: BlocProvider(
          create: (context) => ChatCubit(),
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              final watch = context.watch<ChatCubit>();

              String url = watch.otheruserData?['imageUrl'] ??
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
                    watch.otheruserData?['username'] ?? 'Unkown User',
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
      ),
      // );
      // },
    );
  }
}
