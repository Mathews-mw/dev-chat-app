import 'package:dev_chat/components/messages.dart';
import 'package:dev_chat/components/new_message.dart';
import 'package:dev_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dev Chat'),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: const Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10),
                      Text('Sair'),
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') {
                AuthService().signOut();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      )),
    );
  }
}
