import '../models/notification_model.dart';

class NotificationService {
  List<NotificationModel> getMock() {
    return <NotificationModel>[
      NotificationModel(
        id: 'n1',
        title: 'Khuyến mãi',
        message: 'Bạn có mã giảm giá mới',
        createdAt: DateTime.now(),
      ),
      NotificationModel(
        id: 'n2',
        title: 'Đơn hàng',
        message: 'Đơn hàng của bạn đang giao',
        createdAt: DateTime.now(),
      ),
    ];
  }
}
