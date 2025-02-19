import 'package:dev_chat/components/message_bubble.dart';
import 'package:dev_chat/models/chat_message.dart';
import 'package:dev_chat/services/auth/auth_service.dart';
import 'package:dev_chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
        stream: ChatService().messagesStream(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Está bem quieto por aqui... Vamos conversar?'),
            );
          } else {
            final messages = snapshot.data!;
            return ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (ctx, i) {
                return MessageBubble(
                  key: ValueKey(messages[i].id),
                  message: messages[i],
                  belongsToCurrentUser: messages[i].userId == currentUser?.id,
                );
              },
            );
          }
        });
  }
}
