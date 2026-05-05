import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/brand_card.dart';
import '../../controller/brand_controller.dart';
import 'brand_detail_screen.dart';

class AllBrandScreen extends StatelessWidget {
  AllBrandScreen({super.key});

  final AllBrandController controller = Get.put(AllBrandController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thương hiệu phổ biến')),
      body: Obx(() => GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.brands.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
            itemBuilder: (_, i) {
              final brand = controller.brands[i];
              return InkWell(
                onTap: () => Get.to(() => BrandDetailScreen(brandId: brand.id, brandName: brand.name)),
                child: BrandCard(brandName: brand.name, imageUrl: brand.imageUrl, productCount: brand.productsCount),
              );
            },
          )),
    );
  }
}
