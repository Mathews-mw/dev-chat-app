import 'dart:math';
import 'dart:async';

import 'package:dev_chat/models/chat_user.dart';
import 'package:dev_chat/models/chat_message.dart';
import 'package:dev_chat/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _messages = [
    ChatMessage(
      id: '1',
      text: 'ghpgttjxkduzgjaiyqphel',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Bia',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'ghpgttjxkduzgjaiyqphelakljsdklasjd',
      createdAt: DateTime.now(),
      userId: '456',
      userName: 'Ana',
      userImageURL: 'assets/images/avatar.png',
    ),
  ];

  static MultiStreamController<List<ChatMessage>>? _controller;

  static final _messageStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_messages);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _messageStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final msg = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageUrl,
    );

    _messages.add(msg);
    _controller?.add(_messages.reversed.toList());

    return msg;
  }
}
