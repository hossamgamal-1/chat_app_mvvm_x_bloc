import 'package:chat_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/color_manger.dart';
import '../../../chat/business_logic/chat_provider.dart';
import '../../business_logic/auth_provider.dart';
import '../auth_screen.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
    this.type, {
    Key? key,
  }) : super(key: key);

  final String type;
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController repeatPasswordController =
      TextEditingController();

  final Map<String, dynamic> data = {
    'Username': {
      'hintText': 'User name',
      'key': 'Username',
      'suffixIcon': null,
      'controller': CustomTextField.userNameController,
    },
    'Email': {
      'hintText': 'Email address',
      'key': 'Email',
      'suffixIcon': null,
      'controller': CustomTextField.emailController,
    },
    'Password': {
      'hintText': 'Password',
      'key': 'Password',
      'controller': CustomTextField.passwordController,
    },
    'repeatPassword': {
      'hintText': 'Enter your Password again',
      'key': 'repeatPassword',
      'controller': CustomTextField.repeatPasswordController,
    },
  };

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(data[type]['key']),
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(5), bottom: Radius.circular(5)),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
          ),
          hintText: data[type]['hintText'],
          hintStyle: getRegularStyle(color: ColorManager.white),
          fillColor: const Color(0xff8E94FF),
          filled: true,
          suffixIcon: type == 'Password' ||
                  (type == 'repeatPassword' &&
                      context.read<AuthProvider>().authMode == AuthMode.signUp)
              ? IconButton(
                  splashRadius: 1,
                  onPressed: () => context.read<AuthProvider>().eyeToggle(),
                  icon: Icon(context.watch<AuthProvider>().eye,
                      color: Colors.white))
              : null,
          errorStyle: const TextStyle(color: Color.fromARGB(255, 179, 12, 0))),
      obscureText: type == 'Password' ||
              (type == 'repeatPassword' &&
                  context.read<AuthProvider>().authMode == AuthMode.signUp)
          ? context.watch<AuthProvider>().secured
          : false,
      onChanged: type == 'Message'
          ? context.read<ChatProvider>().sendMessageIcon
          : null,
      style: getRegularStyle(color: ColorManager.white),
      validator: type == 'Username'
          ? (String? username) => username == null ||
                  username.length < 6 &&
                      context.read<AuthProvider>().authMode == AuthMode.signUp
              ? 'User Name must be at least 6 letters'
              : null
          : type == 'Email'
              ? (String? email) => email == null || !email.contains('@')
                  ? 'Enter a valid email'
                  : null
              : type == 'Password'
                  ? (String? username) =>
                      username == null || username.length < 6
                          ? 'User Password must be at least 6 letters'
                          : null
                  : type == 'repeatPassword'
                      ? (String? repeatPassword) => repeatPassword == null ||
                              repeatPassword !=
                                      CustomTextField.passwordController.text &&
                                  context.read<AuthProvider>().authMode ==
                                      AuthMode.signUp
                          ? 'Passwords are not the same'
                          : null
                      : null,
      onSaved: type == 'Username'
          ? (String? username) =>
              context.read<AuthProvider>().userName = username
          : type == 'Email'
              ? (String? emailAddress) =>
                  context.read<AuthProvider>().emailAddress = emailAddress
              : type == 'Password'
                  ? (String? password) =>
                      context.read<AuthProvider>().password = password
                  : null,
      controller: data[type]['controller'],
    );
  }
}
