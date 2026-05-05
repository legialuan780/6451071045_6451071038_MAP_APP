import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../controller/login_controller.dart';
import '../../controller/wishlist_controller.dart';
import '../../data/models/cart_item_model.dart';
import '../../routes/app_routes.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find<AuthController>();
    final WishlistController controller = Get.find<WishlistController>();
    final CartController cartController = Get.find<CartController>();
    final bool loggedIn = auth.currentUser != null;

    if (!loggedIn) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
              color: Colors.blue,
              child: Column(
                children: [
                  const Icon(Icons.favorite_border, size: 80, color: Colors.white),
                  const SizedBox(height: 16),
                  const Text(
                    'Wishlist',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Đăng nhập để xem danh sách yêu thích',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                    child: const Text('Đăng nhập ngay'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách yêu thích')),
      body: Obx(
        () {
          if (controller.items.isEmpty) {
            return const Center(child: Text('Bạn chưa có sản phẩm yêu thích'));
          }
          return ListView(
            children: controller.items.map((e) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title: Text(e.name),
                  subtitle: Text('${e.price.toStringAsFixed(0)} đ'),
                  trailing: Wrap(
                    spacing: 8,
                    children: [
                      IconButton(
                        tooltip: 'Thêm vào giỏ',
                        onPressed: () {
                          cartController.addItem(
                            CartItemModel(
                              productId: e.id,
                              name: e.name,
                              price: e.price,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Đã thêm ${e.name} vào giỏ hàng')),
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart),
                      ),
                      IconButton(
                        tooltip: 'Bỏ yêu thích',
                        onPressed: () => controller.toggle(e),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
