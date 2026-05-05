import '../models/order_model.dart';
import '../models/cart_item_model.dart';

class OrderService {
  final List<OrderModel> _orders = <OrderModel>[
    OrderModel(
      id: 'o1',
      items: <CartItemModel>[
        CartItemModel(productId: 'p1', name: 'Áo thun basic trắng', price: 199000),
      ],
      total: 199000,
      status: 'Đang giao',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  List<OrderModel> getOrders() => List<OrderModel>.from(_orders);

  OrderModel placeOrder(List<CartItemModel> cartItems) {
    final String id = 'o${DateTime.now().millisecondsSinceEpoch}';
    final List<CartItemModel> snapshot = cartItems
        .map(
          (e) => CartItemModel(
            productId: e.productId,
            name: e.name,
            price: e.price,
            quantity: e.quantity,
          ),
        )
        .toList();
    final double total = snapshot.fold(0, (sum, e) => sum + e.subtotal);

    final OrderModel order = OrderModel(
      id: id,
      items: snapshot,
      total: total,
      status: 'Chờ xác nhận',
      createdAt: DateTime.now(),
    );
    _orders.insert(0, order);
    return order;
  }

  void updateOrderStatus(String orderId, String newStatus) {
    final int index = _orders.indexWhere((e) => e.id == orderId);
    if (index < 0) return;
    _orders[index] = _orders[index].copyWith(status: newStatus);
  }
}
