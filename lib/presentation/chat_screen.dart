// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenSctate();
}

class _ChatScreenSctate extends State<ChatScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample Code')),
      body: Center(child: Text('chat')),
      backgroundColor: Colors.blueGrey.shade200,
    );
  }
}
