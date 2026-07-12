import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.userId, required this.userData});

  final String userId;
  final Map<String, dynamic> userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userData['name']??'-'),
      ),
      // body: ,
    );
  }
}
