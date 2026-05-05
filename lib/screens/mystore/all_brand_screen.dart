import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/brand_card.dart';
import '../../controller/brand_controller.dart';
import 'brand_detail_screen.dart';

class AllBrandScreen extends StatefulWidget {
  const AllBrandScreen({super.key});

  @override
  State<AllBrandScreen> createState() => _AllBrandScreenState();
}

class _AllBrandScreenState extends State<AllBrandScreen> {
  final AllBrandController controller = Get.put(AllBrandController());
  final TextEditingController searchController = TextEditingController();
  final RxString keyword = ''.obs;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thương hiệu phổ biến')),
      body: Obx(() {
        final filteredBrands = controller.brands
            .where(
              (b) => keyword.value.isEmpty
                  ? true
                  : b.name.toLowerCase().contains(keyword.value.toLowerCase()),
            )
            .toList();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                controller: searchController,
                onChanged: (value) => keyword.value = value.trim(),
                decoration: const InputDecoration(
                  hintText: 'Tìm nhãn hàng',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredBrands.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (_, i) {
                  final brand = filteredBrands[i];
                  return InkWell(
                    onTap: () => Get.to(
                      () => BrandDetailScreen(brandId: brand.id, brandName: brand.name),
                    ),
                    child: BrandCard(
                      brandName: brand.name,
                      imageUrl: brand.imageUrl,
                      productCount: brand.productsCount,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
