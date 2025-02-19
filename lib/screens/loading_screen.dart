import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              'Carregando...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
