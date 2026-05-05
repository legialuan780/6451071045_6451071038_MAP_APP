import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart';
import '../controller/order_controller.dart';
import 'order/order_success_screen.dart';

class CartOverviewScreen extends StatelessWidget {
  const CartOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();
    final OrderController orderController = Get.find<OrderController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ hàng')),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return const Center(child: Text('Chưa có sản phẩm trong giỏ hàng'));
        }

        return ListView(
          children: [
            ...controller.items.map(
              (e) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(e.name),
                  subtitle: Text('SL: ${e.quantity}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${e.subtotal.toStringAsFixed(0)} VND'),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => controller.decreaseQuantity(e.productId),
                            child: const Icon(Icons.remove_circle_outline, size: 18),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => controller.increaseQuantity(e.productId),
                            child: const Icon(Icons.add_circle_outline, size: 18),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => controller.removeItem(e.productId),
                            child: const Icon(Icons.delete_outline, size: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Tổng cộng',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                '${controller.total.toStringAsFixed(0)} VND',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    orderController.placeOrderFromCart(controller.items.toList());
                    controller.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
                    );
                  },
                  child: const Text('Đặt hàng'),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
