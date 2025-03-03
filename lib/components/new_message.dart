import 'package:dev_chat/services/auth/auth_service.dart';
import 'package:dev_chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _messageValue = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user == null) {
      return;
    }

    await ChatService().save(_messageValue, user);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: 'Digite uma mensagem...'),
            controller: _messageController,
            onChanged: (value) => setState(() => _messageValue = value),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: _messageValue.trim().isEmpty ? null : _sendMessage,
        ),
      ],
    );
  }
}
