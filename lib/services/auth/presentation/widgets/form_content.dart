import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums.dart';
import '../../business_logic/ui_auth_state/ui_auth_cubit.dart';
import '../widgets/text_field.dart';

class AuthFormContent extends StatelessWidget {
  const AuthFormContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthMode authMode = context.watch<UIAuthCubit>().authMode;
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Form(
        key: context.watch<UIAuthCubit>().formKey,
        child: Column(
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
        ),
      ),
    );
  }
}
