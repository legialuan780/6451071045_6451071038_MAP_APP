import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/order_controller.dart';
import 'ordered_detail_screen.dart';

class OrderOverviewScreen extends StatelessWidget {
  const OrderOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.find<OrderController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Tổng quan đơn hàng')),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (_, i) {
            final order = controller.orders[i];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
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
              ),
            );
          },
        ),
      ),
    );
  }
}
