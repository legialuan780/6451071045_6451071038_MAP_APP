import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/order_controller.dart';
import 'ordered_detail_screen.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.find<OrderController>();
    const statuses = <String>[
      'Tất cả',
      'Chờ xác nhận',
      'Đang giao',
      'Hoàn thành',
      'Đã hủy',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Đơn hàng của tôi')),
      body: Obx(
        () {
          final filtered = controller.filteredOrders;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                child: TextField(
                  onChanged: controller.setKeyword,
                  decoration: const InputDecoration(
                    hintText: 'Tìm theo mã đơn',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 42,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) {
                    final status = statuses[i];
                    return ChoiceChip(
                      label: Text(status),
                      selected: controller.selectedStatus.value == status,
                      onSelected: (_) => controller.setStatusFilter(status),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemCount: statuses.length,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: filtered.isEmpty
                    ? const Center(child: Text('Không có đơn hàng phù hợp'))
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (_, i) {
                          final order = filtered[i];
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
            ],
          );
        },
      ),
    );
  }
}
