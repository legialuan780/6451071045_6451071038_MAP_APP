import 'package:get/get.dart';
import '../data/models/brand_model.dart';
import '../data/models/category_model.dart';
import '../data/models/product_model.dart';
import '../data/services/brand_service.dart';
import '../data/services/category_service.dart';
import '../data/services/product_service.dart';

class MystoreController extends GetxController {
  final BrandService _brandService = BrandService();
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();

  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxInt selectedCategoryIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    featuredBrands.assignAll(_brandService.getBrands());
    categories.assignAll(_categoryService.getCategories());
    products.assignAll(_productService.getProducts());
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }
}
