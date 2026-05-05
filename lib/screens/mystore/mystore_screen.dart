import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/product_card.dart';
import '../../controller/cart_controller.dart';
import '../../controller/main_navigation_controller.dart';
import '../../controller/mystore_controller.dart';
import '../../controller/wishlist_controller.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/product_model.dart';
import 'all_brand_screen.dart';
import 'brand_detail_screen.dart';

class MystoreScreen extends StatefulWidget {
  const MystoreScreen({super.key});

  @override
  State<MystoreScreen> createState() => _MystoreScreenState();
}

class _MystoreScreenState extends State<MystoreScreen> {
  final MystoreController controller = Get.put(MystoreController());
  final CartController cartController = Get.find<CartController>();
  final WishlistController wishlistController = Get.find<WishlistController>();
  final MainNavigationController navigationController =
      Get.find<MainNavigationController>();
  String keyword = '';
  String selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        title: const Text(
          'Cửa hàng của chúng tôi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Obx(
        () {
          final List<ProductModel> filtered = controller.products
              .where(
                (p) => keyword.isEmpty
                    ? true
                    : p.name.toLowerCase().contains(keyword.toLowerCase()),
              )
              .where(
                (p) => selectedCategory == 'all'
                    ? true
                    : p.categoryId == selectedCategory,
              )
              .toList();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: TextField(
                    onChanged: (value) => setState(() => keyword = value),
                    decoration: const InputDecoration(
                      hintText: 'Tìm sản phẩm hoặc nhãn hàng',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('Tất cả'),
                        selected: selectedCategory == 'all',
                        onSelected: (_) => setState(() => selectedCategory = 'all'),
                      ),
                      ...controller.categories.map(
                        (c) => ChoiceChip(
                          label: Text(c.name),
                          selected: selectedCategory == c.id,
                          onSelected: (_) => setState(() => selectedCategory = c.id),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    children: [
                      const Text(
                        'Các thương hiệu nổi bật',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Get.to(() => AllBrandScreen()),
                        child: const Text('Xem tất cả'),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.featuredBrands.length,
                    itemBuilder: (_, i) {
                      final b = controller.featuredBrands[i];
                      return GestureDetector(
                        onTap: () => Get.to(
                          () => BrandDetailScreen(brandId: b.id, brandName: b.name),
                        ),
                        child: Container(
                          width: 120,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(child: Text(b.name)),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.65,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (_, i) {
                      final product = filtered[i];
                      final bool isFavorite = wishlistController.items.any(
                        (e) => e.id == product.id,
                      );
                      return ProductCard(
                        product: product,
                        isFavorite: isFavorite,
                        onToggleFavorite: () {
                          wishlistController.toggle(product);
                          navigationController.setIndex(2);
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
                              content: Text('Đã thêm ${product.name} vào giỏ hàng'),
                            ),
                          );
                        },
                      );
                    },
                    childCount: filtered.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}