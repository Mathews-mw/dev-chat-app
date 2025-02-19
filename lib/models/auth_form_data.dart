import 'dart:io';

enum AuthMode { login, sigUp }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.login;

  bool get isLogin {
    return _mode == AuthMode.login;
  }

  bool get isSignUp {
    return _mode == AuthMode.sigUp;
  }

  void toggleAuthMode() {
    _mode = isLogin ? AuthMode.sigUp : AuthMode.login;
  }
}
