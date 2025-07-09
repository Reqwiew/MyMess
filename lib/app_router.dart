// lib/app_router.dart
import 'package:flutter/material.dart';
import 'package:messengerr/presentation/chat_screen.dart';
import 'package:messengerr/presentation/home_screen.dart';
import 'package:messengerr/presentation/login_screen.dart';
import 'package:messengerr/presentation/register_screen.dart';


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        final token = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => HomeScreen(token: token),
        );
      case '/chat':
        return MaterialPageRoute(builder: (_) =>  ChatScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) =>  LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) =>  RegisterScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Нет маршрута: ${settings.name}')),
          ),
        );
    }
  }
}
