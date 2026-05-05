import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../controller/login_controller.dart';
import '../../controller/wishlist_controller.dart';
import '../../data/models/cart_item_model.dart';
import '../../routes/app_routes.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  String query = '';
  String sortMode = 'newest';

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
          final filtered = controller.items
              .where((e) => query.isEmpty ? true : e.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
          if (sortMode == 'price_asc') {
            filtered.sort((a, b) => a.price.compareTo(b.price));
          } else if (sortMode == 'price_desc') {
            filtered.sort((a, b) => b.price.compareTo(a.price));
          } else {
            filtered.sort((a, b) => b.id.compareTo(a.id));
          }

          if (controller.items.isEmpty) {
            return const Center(child: Text('Bạn chưa có sản phẩm yêu thích'));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                child: TextField(
                  onChanged: (value) => setState(() => query = value.trim()),
                  decoration: const InputDecoration(
                    hintText: 'Tìm trong wishlist',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      value: sortMode,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => sortMode = value);
                        }
                      },
                      items: const [
                        DropdownMenuItem(value: 'newest', child: Text('Mới thêm')),
                        DropdownMenuItem(value: 'price_asc', child: Text('Giá tăng dần')),
                        DropdownMenuItem(value: 'price_desc', child: Text('Giá giảm dần')),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        for (final e in controller.items) {
                          cartController.addItem(
                            CartItemModel(productId: e.id, name: e.name, price: e.price),
                          );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đã thêm tất cả vào giỏ hàng')),
                        );
                      },
                      child: const Text('Thêm tất cả vào giỏ'),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.clearAll();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đã xóa toàn bộ wishlist')),
                        );
                      },
                      child: const Text('Xóa tất cả'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? const Center(child: Text('Không tìm thấy sản phẩm yêu thích'))
                    : ListView(
                        children: filtered.map((e) {
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
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
