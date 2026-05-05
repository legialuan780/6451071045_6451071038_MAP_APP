import 'package:get/get.dart';
import '../data/models/notification_model.dart';
import '../data/services/notification_service.dart';

class NotificationController extends GetxController {
  final NotificationService _service = NotificationService();
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    notifications.assignAll(_service.getMock());
  }
}
