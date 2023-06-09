import 'package:flutter/material.dart';

import '../core/resources/string_manager.dart';
import '../services/auth/presentation/auth_screen.dart';
import '../services/chat/presentation/screens/chat_screen.dart';
import '../services/chat/presentation/screens/sub_chat_screen.dart';

class RouteNames {
  static const String authRoute = '/auth';
  static const String subChatRoute = '/'; //subChat
  static const String chatRoute = '/chat';
}

class AppRouter {
  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.authRoute:
        return MaterialPageRoute(builder: (context) => const Auth());
      case RouteNames.chatRoute:
        return MaterialPageRoute(builder: (context) => const Chat());
      case RouteNames.subChatRoute:
        return MaterialPageRoute(builder: (context) => const SubChat());
      default:
        return MaterialPageRoute(builder: (context) => const NoRouteFound());
    }
  }
}

class NoRouteFound extends StatelessWidget {
  const NoRouteFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.noRoutePlaceholder),
      ),
    );
  }
}
