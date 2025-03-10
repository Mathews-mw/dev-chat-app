import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dev_chat/models/chat_user.dart';
import 'package:dev_chat/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static final _defaultUser1 = ChatUser(
    id: '1',
    name: 'Default User',
    email: 'defaultuser@gmail.com',
    password: '123456',
    imageUrl: 'assets/images/avatar.png',
  );
  static final _defaultUser2 = ChatUser(
    id: '2',
    name: 'Mathews Araujo',
    email: 'mathews.mw@gmail.com',
    password: '123456',
    imageUrl: 'assets/images/avatar.png',
  );

  static final Map<String, ChatUser> _users = {
    _defaultUser1.email: _defaultUser1,
    _defaultUser2.email: _defaultUser2,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(null);
  });

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> signOut() async {
    _updateUser(null);
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    File? image,
  }) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      password: password,
      imageUrl: image?.path ?? 'assets/images/avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
