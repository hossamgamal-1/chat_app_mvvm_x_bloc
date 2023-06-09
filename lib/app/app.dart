import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/resources/themes_manager.dart';
import '../services/auth/presentation/auth_screen.dart';
import '../services/chat/presentation/screens/sub_chat_screen.dart';
import 'app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();

  static MyApp? myApp;

  factory MyApp.getInstance() {
    myApp ??= const MyApp._internal();
    return myApp!;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(100, 100),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        theme: ThemesManager.getLightTheme(),
        onGenerateRoute: AppRouter.getRoute,
        //TODO: fix home route
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, user) {
              return user.hasData ? const SubChat() : const Auth();
            }),
      ),
    );
  }
}
