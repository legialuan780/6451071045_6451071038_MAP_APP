import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/product_card.dart';
import '../../controller/brand_controller.dart';
import '../../controller/cart_controller.dart';
import '../../controller/main_navigation_controller.dart';
import '../../controller/wishlist_controller.dart';
import '../../data/models/cart_item_model.dart';
import '../home/main_navigation_screen.dart';

class BrandDetailScreen extends StatefulWidget {
  final String brandId;
  final String brandName;
  const BrandDetailScreen({super.key, required this.brandId, required this.brandName});

  @override
  State<BrandDetailScreen> createState() => _BrandDetailScreenState();
}

class _BrandDetailScreenState extends State<BrandDetailScreen> {
  late AllBrandController controller;
  final CartController cartController = Get.find<CartController>();
  final WishlistController wishlistController = Get.find<WishlistController>();
  final MainNavigationController navigationController =
      Get.find<MainNavigationController>();

  final Map<String, String> filterMap = const {
    'Tên A-Z': 'name',
    'Giá thấp-cao': 'low_price',
    'Giá cao-thấp': 'high_price',
  };

  @override
  void initState() {
    super.initState();
    controller = Get.find<AllBrandController>();
    controller.fetchProductsByBrand(widget.brandId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.brandName)),
      body: Obx(
        () => Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: filterMap.keys.map((name) {
                  final selected = controller.selectedSort.value == filterMap[name];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(name),
                      selected: selected,
                      onSelected: (_) => controller.sortBrandProducts(filterMap[name]!),
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.brandProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (_, i) {
                  final product = controller.brandProducts[i];
                  final bool isFavorite = wishlistController.items.any(
                    (e) => e.id == product.id,
                  );
                  return ProductCard(
                    product: product,
                    isFavorite: isFavorite,
                    onToggleFavorite: () {
                      wishlistController.toggle(product);
                      navigationController.setIndex(2);
                      Get.offAll(
                        () => const MainNavigationScreen.withIndex(
                          initialIndex: 2,
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
                        SnackBar(content: Text('Đã thêm ${product.name} vào giỏ hàng')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
