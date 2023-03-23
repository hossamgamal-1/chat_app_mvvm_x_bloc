import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/auth_provider.dart';
import '../auth_screen.dart';
import '../widgets/text_field.dart';

class AuthFormContent extends StatelessWidget {
  const AuthFormContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthMode authMode = context.watch<AuthProvider>().authMode;
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
          constraints: BoxConstraints(
              minHeight: authMode == AuthMode.signUp ? 50 : 0,
              maxHeight: authMode == AuthMode.signUp ? 100 : 0),
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: CustomTextField('Username'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: CustomTextField('Email'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: CustomTextField('Password'),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
          constraints: BoxConstraints(
            minHeight: authMode == AuthMode.signUp ? 50 : 0,
            maxHeight: authMode == AuthMode.signUp ? 100 : 0,
          ),
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: CustomTextField('repeatPassword'),
        ),
      ],
    );
  }
}
