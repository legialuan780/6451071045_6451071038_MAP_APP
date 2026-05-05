import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../controller/order_controller.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/order_model.dart';

class OrderedDetailScreen extends StatelessWidget {
  final OrderModel order;
  const OrderedDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find<OrderController>();
    final CartController cartController = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết đơn hàng')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Mã đơn: ${order.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Trạng thái: ${order.status}'),
          const SizedBox(height: 8),
          Text('Tổng tiền: ${order.total.toStringAsFixed(0)} đ'),
          const Divider(height: 24),
          const Text('Sản phẩm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...order.items.map(
            (e) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(e.name),
              subtitle: Text('SL: ${e.quantity}'),
              trailing: Text('${e.subtotal.toStringAsFixed(0)} đ'),
            ),
          ),
          const SizedBox(height: 12),
          if (order.status == 'Chờ xác nhận')
            OutlinedButton(
              onPressed: () {
                orderController.cancelOrder(order.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã hủy đơn hàng')),
                );
                Navigator.pop(context);
              },
              child: const Text('Hủy đơn'),
            ),
          if (order.status == 'Đang giao')
            ElevatedButton(
              onPressed: () {
                orderController.markOrderReceived(order.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đơn hàng đã hoàn thành')),
                );
                Navigator.pop(context);
              },
              child: const Text('Đã nhận hàng'),
            ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              for (final item in order.items) {
                cartController.addItem(
                  CartItemModel(
                    productId: item.productId,
                    name: item.name,
                    price: item.price,
                    quantity: item.quantity,
                  ),
                );
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã thêm lại sản phẩm vào giỏ hàng')),
              );
            },
            icon: const Icon(Icons.replay),
            label: const Text('Mua lại'),
          ),
        ],
      ),
    );
  }
}
