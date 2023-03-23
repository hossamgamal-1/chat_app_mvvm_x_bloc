import 'package:chat_app/app/app_router.dart';
import 'package:chat_app/core/dependency_injection.dart';
import 'package:chat_app/services/auth/business_logic/logic_auth_cubit/Logic_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums.dart';
import '../../../core/resources/color_manger.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../business_logic/logic_auth_cubit/logic_auth_state.dart';
import '../business_logic/ui_auth_state/ui_auth_cubit.dart';
import '../business_logic/ui_auth_state/ui_auth_state.dart';
import 'widgets/custom_divider.dart';
import 'widgets/form_content.dart';
import 'widgets/pick_image.dart';
import 'widgets/switch_mode.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppMargin.m15.w),
          child: BlocProvider(
            create: (context) => UIAuthCubit(),
            child: BlocBuilder<UIAuthCubit, UIAuthState>(
              builder: (context, uIState) {
                UIAuthCubit watch = context.watch<UIAuthCubit>();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //title
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.only(
                        top: watch.authMode == AuthMode.signIn
                            ? AppPadding.p20.h
                            : AppPadding.p8.h,
                      ),
                      child: Text(
                          watch.authMode == AuthMode.signIn
                              ? 'Welcome Back'
                              : 'Welcome',
                          style: getMediumStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s8_4.sp)),
                    ),
                    //sub title
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: watch.authMode == AuthMode.signUp ? 5.h : 10.h,
                      ),
                      child: Text(
                          watch.authMode == AuthMode.signIn
                              ? 'sign in to continue'
                              : 'sign up to continue',
                          style: getRegularStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s24)),
                    ),
                    //Pick your Image
                    Visibility(
                      visible: watch.authMode == AuthMode.signUp,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: const PickImage(),
                      ),
                    ),
                    //Auth form
                    const AuthFormContent(),
                    //remember me , forget password
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.check_circle,
                                  color: Colors.white, size: 24),
                              const SizedBox(width: 2),
                              Text('Remember me',
                                  style: getMediumStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.s17)),
                            ],
                          ),
                          Text('Forgot Password?',
                              style: getMediumStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s17)),
                        ],
                      ),
                    ),
                    //SignInButton
                    const SignInButton(),
                    const CustomDivider(),
                    //signInMethods
                    // const SignInMethods(),
                    //switch signup,login
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              context.watch<UIAuthCubit>().authMode ==
                                      AuthMode.signIn
                                  ? 'Don\'t you have an account?'
                                  : 'You already have an account?',
                              style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s18)),
                          const SwitchAuthModeButton(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogicAuthCubit(sL()),
      child: BlocConsumer<LogicAuthCubit, LogicAuthState>(
          listener: (context, state) {
        if (state is FailureState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
        if (state is SuccessState) {
          Navigator.pushReplacementNamed(context, RouteNames.subChatRoute);
        }
      }, builder: (context, state) {
        if (state is LoadingState) {
          return const CircularProgressIndicator(color: Colors.white);
        } else {
          UIAuthCubit watch = context.watch<UIAuthCubit>();
          return Container(
            margin: EdgeInsets.only(bottom: AppMargin.m2.h),
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorManager.secondaryColor)),
              onPressed: () async {
                if (watch.formKey.currentState!.validate()) {
                  watch.formKey.currentState!.save();

                  watch.authMode == AuthMode.signIn
                      ? await context.read<LogicAuthCubit>().signIn(
                          emailAddress: watch.emailAddress!,
                          password: watch.password!,
                          userName: watch.userName!)
                      : await context.read<LogicAuthCubit>().signUp(
                          emailAddress: watch.emailAddress!,
                          password: watch.password!,
                          userName: watch.userName!);
                } else {
                  watch.formKey.currentState!.validate();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                    context.watch<UIAuthCubit>().authMode == AuthMode.signIn
                        ? 'Sign In'
                        : 'Sign up',
                    style: getMediumStyle(
                        color: ColorManager.primaryColor,
                        fontSize: FontSize.s17)),
              ),
            ),
          );
        }
      }),
    );
  }
}
