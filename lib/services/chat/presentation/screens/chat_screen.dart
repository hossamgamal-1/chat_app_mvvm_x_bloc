import 'package:chat_app/services/chat/business_logic/chat_cubit/chat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app_router.dart';
import '../../../../core/resources/color_manger.dart';
import '../widgets/chat_messages.dart';
import '../widgets/message_textfield.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SignOutAppBar(isChat: true)),
      body: BlocProvider(
        create: (context) => ChatCubit(),
        child: Column(
          children: const [
            Expanded(child: ChatMessages()),
            SizedBox(height: 5),
            MessageTextField(),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 51, 53, 136),
    );
  }
}

class SignOutAppBar extends StatelessWidget {
  const SignOutAppBar({this.isChat = false, Key? key}) : super(key: key);
  final bool isChat;
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 51, 53, 136),
      elevation: 0,
      leading: isChat
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                // color: Colors.white,
              ),
            )
          : null,
      actions: [
        DropdownButton(
          icon: const Icon(Icons.more_vert_outlined, color: ColorManager.white),
          underline: Container(),
          items: [
            DropdownMenuItem(
              value: const Text('SignOut'),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();

                  // ignore: use_build_context_synchronously
                  await Navigator.pushReplacementNamed(
                      context, RouteNames.authRoute);
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              child: Row(
                children: const [
                  Icon(Icons.exit_to_app_outlined, color: ColorManager.black),
                  SizedBox(width: 5),
                  FittedBox(
                    child: Text(
                      'Sign out',
                      style: TextStyle(color: ColorManager.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
          onChanged: (Text? value) {},
        ),
      ],
    );
  }
}
