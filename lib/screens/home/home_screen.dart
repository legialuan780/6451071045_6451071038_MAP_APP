import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/category_item.dart';
import '../../common/widgets/home_banner_slider.dart';
import '../../common/widgets/product_card.dart';
import '../../controller/cart_controller.dart';
import '../../controller/category_controller.dart';
import '../../controller/login_controller.dart';
import '../../controller/notification_controller.dart';
import '../../controller/product_controller.dart';
import '../../controller/wishlist_controller.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/product_model.dart';
import '../../routes/app_routes.dart';
import '../product/popular_product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController controller = Get.find<ProductController>();
  final CategoryController categoryController = Get.put(CategoryController());
  final NotificationController notificationController =
      Get.find<NotificationController>();
  final CartController cartController = Get.find<CartController>();
  final WishlistController wishlistController = Get.find<WishlistController>();
  final AuthController authController = Get.find<AuthController>();
  String keyword = '';
  String selectedCategoryId = 'all';

  @override
  Widget build(BuildContext context) {
    final user = authController.currentUser;
    final String fullName =
        user == null ? 'Guest User' : '${user.firstName} ${user.lastName}'.trim();

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Good day for shopping',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          fullName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  notificationController.notifications.isEmpty
                                      ? 'Không có thông báo mới'
                                      : notificationController
                                          .notifications
                                          .first
                                          .message,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.notifications, color: Colors.white),
                        ),
                        if (notificationController.notifications.isNotEmpty)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: _buildBadge(
                              notificationController.notifications.length,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.cartOverview);
                          },
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                        if (cartController.items.isNotEmpty)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: _buildBadge(cartController.items.length),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          keyword = value.trim().toLowerCase();
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Tìm kiếm sản phẩm',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        notificationController.notifications.isEmpty
                            ? 'Không có cập nhật đơn hàng mới'
                            : 'Cập nhật mới: ${notificationController.notifications.first.message}',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const HomeBannerSlider(),
                  const SizedBox(height: 24),
                  const Text(
                    'Danh mục sản phẩm',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 90,
                    child: Obx(
                      () => ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryController.categories.length,
                        separatorBuilder: (_, index) => const SizedBox(width: 12),
                        itemBuilder: (_, i) => CategoryItem(
                          category: categoryController.categories[i],
                          onTap: () {
                            setState(() {
                              selectedCategoryId =
                                  categoryController.categories[i].id;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('Tất cả'),
                        selected: selectedCategoryId == 'all',
                        onSelected: (_) {
                          setState(() {
                            selectedCategoryId = 'all';
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Text(
                        'Sản phẩm phổ biến',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PopularProductScreen()),
                        ),
                        child: const Text('Xem tất cả'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () {
                      final List<ProductModel> products = controller.products
                          .where(
                            (p) => keyword.isEmpty
                                ? true
                                : p.name.toLowerCase().contains(keyword),
                          )
                          .where(
                            (p) => selectedCategoryId == 'all'
                                ? true
                                : p.categoryId == selectedCategoryId,
                          )
                          .toList();

                      if (products.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Center(child: Text('Không tìm thấy sản phẩm')),
                        );
                      }

                      return GridView.builder(
                        itemCount: products.length.clamp(0, 6),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.62,
                        ),
                        itemBuilder: (_, i) {
                          final product = products[i];
                          final isFavorite = wishlistController.items
                              .any((e) => e.id == product.id);
                          return ProductCard(
                            product: product,
                            isFavorite: isFavorite,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Đã chọn: ${product.name}'),
                                ),
                              );
                            },
                            onToggleFavorite: () {
                              final wasFavorite = wishlistController.items
                                  .any((e) => e.id == product.id);
                              wishlistController.toggle(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    wasFavorite
                                        ? 'Đã bỏ ${product.name} khỏi wishlist'
                                        : 'Đã thêm ${product.name} vào wishlist',
                                  ),
                                ),
                              );
                            },
                            onAddToCart: () {
                              cartController.addItem(
                                CartItemModel(
                                  productId: product.id,
                                  name: product.name,
                                  price: product.price,
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Đã thêm ${product.name} vào giỏ hàng',
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(int value) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: Text(
        '$value',
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}