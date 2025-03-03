import 'dart:io';

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

  Widget _showUserAvatar(String imageURL) {
    const defaultImage = 'assets/images/avatar.png';
    ImageProvider? imageProvider;
    final uri = Uri.parse(imageURL);

    if (uri.path.contains(defaultImage)) {
      imageProvider = AssetImage(defaultImage);
    } else if (uri.scheme.contains('http')) {
      imageProvider = NetworkImage(uri.toString());
    } else {
      imageProvider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(backgroundImage: imageProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin:
                  EdgeInsetsDirectional.symmetric(vertical: 15, horizontal: 8),
              constraints: BoxConstraints(
                maxWidth: 320,
              ),
              decoration: BoxDecoration(
                color: belongsToCurrentUser
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: belongsToCurrentUser
                      ? Radius.circular(12)
                      : Radius.circular(0),
                  bottomRight: belongsToCurrentUser
                      ? Radius.circular(0)
                      : Radius.circular(12),
                ),
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
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? 0 : 320,
          right: belongsToCurrentUser ? 320 : null,
          child: _showUserAvatar(message.userImageURL),
        ),
      ],
    );
  }
}
