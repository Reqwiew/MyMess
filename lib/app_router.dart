// lib/app_router.dart
import 'package:flutter/material.dart';
import 'package:messengerr/presentation/chat_screen.dart';
import 'package:messengerr/presentation/forgot_password_screen.dart';
import 'package:messengerr/presentation/home_screen.dart';
import 'package:messengerr/presentation/login_screen.dart';
import 'package:messengerr/presentation/register_screen.dart';
import 'package:messengerr/presentation/reset_password_screen.dart';
import 'package:messengerr/presentation/send_otp_screen.dart';


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
      case '/forgotPassword':
        return MaterialPageRoute(builder: (_) =>  ForgotPasswordScreen());
      case '/sendOtp':
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => SendOtpScreen(email: email),
        );
      case '/resetPassword':
        final args = settings.arguments as Map<String, String>;
        final email = args['email']!;
        final code = args['code']!;
        return MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(email: email, code: code),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Нет маршрута: ${settings.name}')),
          ),
        );
    }
  }
}
