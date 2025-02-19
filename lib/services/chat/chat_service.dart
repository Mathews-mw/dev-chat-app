import 'package:dev_chat/models/chat_user.dart';
import 'package:dev_chat/models/chat_message.dart';
import 'package:dev_chat/services/chat/chat_mock_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();

  Future<ChatMessage> save(String text, ChatUser user);

  factory ChatService() {
    return ChatMockService();
  }
}
