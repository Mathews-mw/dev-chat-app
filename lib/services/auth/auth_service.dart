import 'dart:io';

import 'package:dev_chat/models/chat_user.dart';
import 'package:dev_chat/services/auth/auth_mock_service.dart';

abstract class AuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    File? image,
  });

  Future<void> signOut();

  factory AuthService() {
    return AuthMockService();
  }
}
