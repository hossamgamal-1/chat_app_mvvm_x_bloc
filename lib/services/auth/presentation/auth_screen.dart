import 'package:chat_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../app/app_router.dart';
import '../../../core/resources/color_manger.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../business_logic/auth_provider.dart';
import 'widgets/form_content.dart';
import 'widgets/pick_image.dart';
import 'widgets/switch_mode.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider watch = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppMargin.m15.w),
          child: Column(
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
                        color: ColorManager.white, fontSize: FontSize.s42)),
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
                        color: ColorManager.white, fontSize: FontSize.s24)),
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
              Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child:
                    Form(key: watch.formKey, child: (const AuthFormContent())),
              ),
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
                            color: ColorManager.white, fontSize: FontSize.s17)),
                  ],
                ),
              ),
              //SignInButton
              context.watch<AuthProvider>().isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Container(
                      margin: EdgeInsets.only(bottom: AppMargin.m2.h),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ColorManager.secondaryColor)),
                        onPressed: () async {
                          if (watch.formKey.currentState!.validate()) {
                            watch.formKey.currentState!.save();
                            context.read<AuthProvider>().loadingSetter(true);

                            try {
                              context.read<AuthProvider>().authMode ==
                                      AuthMode.signIn
                                  ? await context.read<AuthProvider>().signIn()
                                  : await context.read<AuthProvider>().signUp();
                              // ignore: use_build_context_synchronously
                              context.read<AuthProvider>().loadingSetter(false);
                              // ignore: use_build_context_synchronously
                              await Navigator.pushReplacementNamed(
                                  context, RouteNames.subChatRoute);
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          } else {
                            watch.formKey.currentState!.validate();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                              context.watch<AuthProvider>().authMode ==
                                      AuthMode.signIn
                                  ? 'Sign In'
                                  : 'Sign up',
                              style: getMediumStyle(
                                  color: ColorManager.primaryColor,
                                  fontSize: FontSize.s17)),
                        ),
                      ),
                    ),
              const MyDivider(),
              //signInMethods
              /* Padding(
                padding: EdgeInsets.only(top: height * 0.05),
                child: const SignInMethods(),
              ), */
              //switch signup,login
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        context.watch<AuthProvider>().authMode ==
                                AuthMode.signIn
                            ? 'Don\'t you have an account?'
                            : 'You already have an account?',
                        style: getRegularStyle(
                            color: ColorManager.white, fontSize: FontSize.s18)),
                    const SwitchAuthModeButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInMethods extends StatelessWidget {
  const SignInMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < 3; i++)
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: AppMargin.m5, vertical: AppMargin.m10),
            padding: EdgeInsets.zero,
            width: AppPadding.p13.w,
            height: AppPadding.p13.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
          )
      ],
    );
  }
}

enum AuthMode { signIn, signUp }

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: ColorManager.lightPurple, thickness: 2),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.m10),
          child: Text(
            'OR',
            style: getRegularStyle(
                color: ColorManager.lightPurple, fontSize: FontSize.s14),
          ),
        ),
        const Expanded(
          child: Divider(color: ColorManager.lightPurple, thickness: 2),
        ),
      ],
    );
  }
}
