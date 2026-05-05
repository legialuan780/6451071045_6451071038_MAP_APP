import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/product_card.dart';
import '../../controller/product_controller.dart';

class PopularProductScreen extends StatelessWidget {
  const PopularProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();
    return Scaffold(
      appBar: AppBar(title: const Text('S?n ph?m ph? bi?n')),
      body: Obx(() => GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (_, i) => ProductCard(product: controller.products[i]),
          )),
    );
  }
}
