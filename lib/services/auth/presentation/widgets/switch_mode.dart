import 'package:chat_app/core/resources/color_manger.dart';
import 'package:chat_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/auth_provider.dart';
import '../auth_screen.dart';

class SwitchAuthModeButton extends StatefulWidget {
  const SwitchAuthModeButton({Key? key}) : super(key: key);

  @override
  State<SwitchAuthModeButton> createState() => _SwitchAuthModeButtonState();
}

class _SwitchAuthModeButtonState extends State<SwitchAuthModeButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<AuthProvider>().switchMode(),
      child: Text(
          context.watch<AuthProvider>().authMode == AuthMode.signIn
              ? 'Sign up'
              : 'Sign In',
          style: getMediumStyle(color: ColorManager.secondaryColor)),
    );
  }
}
