import 'package:dev_chat/models/chat_user.dart';
import 'package:dev_chat/screens/auth_screen.dart';
import 'package:dev_chat/screens/chat_screen.dart';
import 'package:dev_chat/screens/loading_screen.dart';
import 'package:dev_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthOrAppScreen extends StatelessWidget {
  const AuthOrAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else {
            return snapshot.hasData ? ChatScreen() : AuthScreen();
          }
        },
      ),
    );
  }
}
