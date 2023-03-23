import 'package:flutter/material.dart';

import '../widgets/chats_tile.dart';
import 'chat_screen.dart';

class SubChat extends StatelessWidget {
  const SubChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SignOutAppBar(),
      ),
      body: ChatsTile(),
      backgroundColor: Color.fromARGB(255, 51, 53, 136),
    );
  }
}
