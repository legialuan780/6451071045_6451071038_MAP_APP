import 'package:get/get.dart';
import '../data/models/cart_item_model.dart';
import '../data/models/order_model.dart';
import '../data/services/order_service.dart';

class OrderController extends GetxController {
  final OrderService _service = OrderService();
  final RxList<OrderModel> orders = <OrderModel>[].obs;

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
}
