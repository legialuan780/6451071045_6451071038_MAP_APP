import 'package:get/get.dart';
import '../data/models/brand_model.dart';
import '../data/models/product_model.dart';
import '../data/services/brand_service.dart';
import '../data/services/mystore_service.dart';

class AllBrandController extends GetxController {
  final BrandService _brandService = BrandService();
  final MystoreService _mystoreService = MystoreService();

  final RxBool isLoading = false.obs;
  final RxString selectedSort = 'name'.obs;
  final RxList<BrandModel> brands = <BrandModel>[].obs;
  final RxList<ProductModel> brandProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    brands.assignAll(_brandService.getBrands());
  }

  void fetchProductsByBrand(String brandId) {
    isLoading.value = true;
    brandProducts.assignAll(_mystoreService.getProductsByBrand(brandId));
    isLoading.value = false;
  }

  void sortBrandProducts(String mode) {
    selectedSort.value = mode;
    final List<ProductModel> list = List<ProductModel>.from(brandProducts);
    if (mode == 'low_price') {
      list.sort((a, b) => a.price.compareTo(b.price));
    } else if (mode == 'high_price') {
      list.sort((a, b) => b.price.compareTo(a.price));
    } else {
      list.sort((a, b) => a.name.compareTo(b.name));
    }
    brandProducts.assignAll(list);
  }
}
