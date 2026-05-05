import 'package:get/get.dart';
import '../data/models/cart_item_model.dart';
import '../data/models/order_model.dart';
import '../data/services/order_service.dart';

class OrderController extends GetxController {
  final OrderService _service = OrderService();
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final RxString selectedStatus = 'Tất cả'.obs;
  final RxString keyword = ''.obs;

  @override
  void onInit() {
    super.onInit();
    orders.assignAll(_service.getOrders());
  }

  OrderModel placeOrderFromCart(List<CartItemModel> cartItems) {
    final OrderModel order = _service.placeOrder(cartItems);
    orders.assignAll(_service.getOrders());
    return order;
  }

  List<OrderModel> get filteredOrders {
    return orders.where((order) {
      final bool matchStatus = selectedStatus.value == 'Tất cả'
          ? true
          : order.status == selectedStatus.value;
      final bool matchKeyword = keyword.value.isEmpty
          ? true
          : order.id.toLowerCase().contains(keyword.value.toLowerCase());
      return matchStatus && matchKeyword;
    }).toList();
  }

  void setStatusFilter(String status) {
    selectedStatus.value = status;
  }

  void setKeyword(String value) {
    keyword.value = value.trim();
  }

  void cancelOrder(String orderId) {
    _service.updateOrderStatus(orderId, 'Đã hủy');
    orders.assignAll(_service.getOrders());
  }

  void markOrderReceived(String orderId) {
    _service.updateOrderStatus(orderId, 'Hoàn thành');
    orders.assignAll(_service.getOrders());
  }
}
