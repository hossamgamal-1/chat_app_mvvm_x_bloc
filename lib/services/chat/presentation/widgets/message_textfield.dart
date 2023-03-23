import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../auth/business_logic/logic_auth_cubit/Logic_auth_cubit.dart';
import '../../business_logic/chat_cubit/chat_cubit.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({Key? key}) : super(key: key);
  static TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('Message'),
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(5), bottom: Radius.circular(5)),
              borderSide: BorderSide(color: Colors.transparent, width: 1)),
          hintText: 'Message',
          hintStyle:
              getRegularStyle(color: const Color.fromARGB(255, 236, 236, 236)),
          fillColor: const Color(0xff8E94FF),
          filled: true,
          suffixIcon: IconButton(
            splashRadius: 10,
            onPressed: context.watch<ChatCubit>().currentMessage != ''
                ? () async {
                    messageController.clear();
                    await FirebaseFirestore.instance
                        .collection('chat/roH5hykQCCKmM2ilEVtp/messages')
                        .add({
                      'text': context.read<ChatCubit>().currentMessage,
                      'time': Timestamp.now(),
                      'senderId': context.read<LogicAuthCubit>().currentUserUID
                    });
                    // ignore: use_build_context_synchronously
                    context.read<ChatCubit>().messageReset();
                    // ignore: use_build_context_synchronously
                    context.read<ChatCubit>().scrollControllerReset();
                  }
                : null,
            icon: Icon(
              Icons.send,
              color: context.watch<ChatCubit>().currentMessage != ''
                  ? Colors.white
                  : Colors.grey,
            ),
          ),
          errorStyle: const TextStyle(color: Color.fromARGB(255, 179, 12, 0))),
      onChanged: context.read<ChatCubit>().sendMessageIcon,
      style: getRegularStyle(color: ColorManager.white),
      controller: messageController,
    );
  }
}
