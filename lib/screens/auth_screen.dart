import 'package:dev_chat/components/auth_form.dart';
import 'package:dev_chat/models/auth_form_data.dart';
import 'package:dev_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;

  Future<void> handleAuthenticate(AuthFormData data) async {
    try {
      setState(() => _isLoading = true);

      if (data.isLogin) {
        await AuthService().signIn(
          email: data.email,
          password: data.password,
        );
      } else {
        await AuthService().signUp(
          name: data.name,
          email: data.email,
          password: data.password,
          image: data.image,
        );
      }
    } catch (err) {
      print('Authentication error: $err');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: handleAuthenticate),
            ),
          ),
          if (_isLoading)
            Container(
              decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
