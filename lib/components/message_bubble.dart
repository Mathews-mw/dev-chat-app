import 'package:flutter/material.dart';
import 'package:dev_chat/models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.belongsToCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: belongsToCurrentUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          constraints: BoxConstraints(
            maxWidth: 320,
          ),
          decoration: BoxDecoration(
            color: belongsToCurrentUser
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${message.userName}:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: belongsToCurrentUser ? Colors.white : Colors.black,
                ),
              ),
              Text(
                message.text,
                style: TextStyle(
                  color: belongsToCurrentUser ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
