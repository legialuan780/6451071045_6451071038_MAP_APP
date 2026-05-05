import 'package:flutter/material.dart';
import 'my_order_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 12),
            const Text('Đặt hàng thành công'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MyOrderScreen()),
                  (route) => route.isFirst,
                );
              },
              child: const Text('Xem đơn hàng'),
            ),
          ],
        ),
      ),
    );
  }
}
