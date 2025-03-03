import 'package:dev_chat/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationService = Provider.of<ChatNotificationService>(context);
    final items = notificationService.items;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        titleTextStyle: TextStyle(color: Colors.white),
        title: const Text(
          'Notificações',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: notificationService.itemsAmount,
          itemBuilder: (ctx, i) {
            return ListTile(
              title: Text(items[i].title),
              subtitle: Text(items[i].body),
              onTap: () => notificationService.remove(i),
            );
          }),
    );
  }
}
