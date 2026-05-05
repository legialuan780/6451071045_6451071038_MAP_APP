import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/order_controller.dart';
import 'ordered_detail_screen.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.find<OrderController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Đơn hàng của tôi')),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (_, i) {
            final order = controller.orders[i];
            return ListTile(
              title: Text('Đơn #${order.id}'),
              subtitle: Text(order.status),
              trailing: Text('${order.total.toStringAsFixed(0)} đ'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderedDetailScreen(order: order),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
