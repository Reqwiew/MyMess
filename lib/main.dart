import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'app_router.dart';
import 'presentation/home_screen.dart';
import 'presentation/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? firebaseToken = await messaging.getToken();
  print("Firebase Device Token: $firebaseToken");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedToken = prefs.getString('access_token');

  runApp(MyApp(firebaseToken: firebaseToken, storedToken: storedToken));
}

class MyApp extends StatelessWidget {
  final String? firebaseToken;
  final String? storedToken;

  const MyApp({super.key, required this.firebaseToken, required this.storedToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Messenger',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: storedToken != null && storedToken!.isNotEmpty
          ? HomeScreen(token: storedToken)
          : LoginScreen(),

      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
