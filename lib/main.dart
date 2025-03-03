import 'package:dev_chat/screens/auth_or_app_screen.dart';
import 'package:dev_chat/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatNotificationService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle().copyWith(
              backgroundColor: WidgetStateProperty<Color>.fromMap(
                <WidgetStatesConstraint, Color>{
                  WidgetState.any: Colors.blue,
                },
              ),
              foregroundColor: WidgetStateProperty<Color>.fromMap(
                <WidgetStatesConstraint, Color>{
                  WidgetState.pressed | WidgetState.hovered: Colors.blue,
                  WidgetState.any: Colors.white,
                },
              ),
            ),
          ),
        ),
        home: AuthOrAppScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
