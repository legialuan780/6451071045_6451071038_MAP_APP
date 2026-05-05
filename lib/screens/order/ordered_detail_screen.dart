import 'package:flutter/material.dart';
import '../../data/models/order_model.dart';

class OrderedDetailScreen extends StatelessWidget {
  final OrderModel order;
  const OrderedDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
