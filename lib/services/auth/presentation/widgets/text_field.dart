import 'package:chat_app/services/chat/business_logic/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../business_logic/ui_auth_state/ui_auth_cubit.dart';

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
                      context.read<UIAuthCubit>().authMode == AuthMode.signUp)
              ? IconButton(
                  splashRadius: 1,
                  onPressed: () => context.read<UIAuthCubit>().eyeToggle(),
                  icon: Icon(context.watch<UIAuthCubit>().eye,
                      color: Colors.white))
              : null,
          errorStyle: const TextStyle(color: Color.fromARGB(255, 179, 12, 0))),
      obscureText: type == 'Password' ||
              (type == 'repeatPassword' &&
                  context.read<UIAuthCubit>().authMode == AuthMode.signUp)
          ? context.watch<UIAuthCubit>().secured
          : false,
      onChanged:
          type == 'Message' ? context.read<ChatCubit>().sendMessageIcon : null,
      style: getRegularStyle(color: ColorManager.white),
      validator: type == 'Username'
          ? (String? username) => username == null ||
                  username.length < 6 &&
                      context.read<UIAuthCubit>().authMode == AuthMode.signUp
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
                                  context.read<UIAuthCubit>().authMode ==
                                      AuthMode.signUp
                          ? 'Passwords are not the same'
                          : null
                      : null,
      onSaved: type == 'Username'
          ? (String? username) =>
              context.read<UIAuthCubit>().userName = username
          : type == 'Email'
              ? (String? emailAddress) =>
                  context.read<UIAuthCubit>().emailAddress = emailAddress
              : type == 'Password'
                  ? (String? password) =>
                      context.read<UIAuthCubit>().password = password
                  : null,
      controller: data[type]['controller'],
    );
  }
}
