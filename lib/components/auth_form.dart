import 'dart:io';

import 'package:dev_chat/components/user_image_picker.dart';
import 'package:dev_chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authFormData = AuthFormData();

  void handlePickImage(File image) {
    _authFormData.image = image;
  }

  void handleSubmitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return _showError('Os dados não são válidos!');
    }

    if (_authFormData.image == null && _authFormData.isSignUp) {
      return _showError('Imagem não selecionada!');
    }

    _formKey.currentState?.save();
    widget.onSubmit(_authFormData);
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (_authFormData.isSignUp)
                  UserImagePicker(
                    onPickImage: handlePickImage,
                  ),
                if (_authFormData.isSignUp)
                  TextFormField(
                    key: ValueKey('auth_form_name'),
                    initialValue: _authFormData.name,
                    onChanged: (value) => _authFormData.name = value,
                    decoration: InputDecoration(label: const Text('Nome')),
                    validator: (value) {
                      final name = value ?? '';

                      if (name.trim().length < 5) {
                        return 'Nome deve conter no mínimo 5 caracteres';
                      }

                      return null;
                    },
                  ),
                const SizedBox(height: 10),
                TextFormField(
                  key: ValueKey('auth_form_email'),
                  keyboardType: TextInputType.emailAddress,
                  initialValue: _authFormData.email,
                  onChanged: (value) {
                    _authFormData.email = value;
                  },
                  decoration: InputDecoration(label: const Text('E-mail')),
                  validator: (value) {
                    final email = value ?? '';

                    if (!email.contains('@')) {
                      return 'Informe um e-mail válido';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  key: ValueKey('auth_form_password'),
                  obscureText: true,
                  initialValue: _authFormData.password,
                  onChanged: (value) => _authFormData.password = value,
                  decoration: InputDecoration(label: const Text('Senha')),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: handleSubmitForm,
                  child: Text(_authFormData.isLogin ? 'Entrar' : 'Cadastrar'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  child: Text(_authFormData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui uma conta?'),
                  onPressed: () {
                    setState(() {
                      _authFormData.toggleAuthMode();
                    });
                  },
                ),
              ],
            ),
          )),
    );
  }
}
