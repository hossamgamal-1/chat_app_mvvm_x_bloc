import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../business_logic/ui_auth_state/ui_auth_cubit.dart';

class SwitchAuthModeButton extends StatefulWidget {
  const SwitchAuthModeButton({Key? key}) : super(key: key);

  @override
  State<SwitchAuthModeButton> createState() => _SwitchAuthModeButtonState();
}

class _SwitchAuthModeButtonState extends State<SwitchAuthModeButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<UIAuthCubit>().switchMode(),
      child: Text(
          context.watch<UIAuthCubit>().authMode == AuthMode.signIn
              ? 'Sign up'
              : 'Sign In',
          style: getMediumStyle(color: ColorManager.secondaryColor)),
    );
  }
}
