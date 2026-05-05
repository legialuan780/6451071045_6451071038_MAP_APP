import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/notification_controller.dart';

class MyNotificationScreen extends StatelessWidget {
  const MyNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.find<NotificationController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Thông báo')),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (_, i) {
            final item = controller.notifications[i];
            return ListTile(
              leading: const Icon(Icons.notifications),
              title: Text(item.title),
              subtitle: Text(item.message),
            );
          },
        ),
      ),
    );
  }
}
