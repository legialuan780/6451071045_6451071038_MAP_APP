import 'package:get/get.dart';
import '../data/models/product_model.dart';
import '../data/services/wishlist_service.dart';

class WishlistController extends GetxController {
  final WishlistService _service = WishlistService();
  final RxList<ProductModel> items = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    items.assignAll(_service.getAll());
  }

  void toggle(ProductModel product) {
    _service.toggle(product);
    items.assignAll(_service.getAll());
  }

  bool contains(String productId) {
    return items.any((e) => e.id == productId);
  }

  void clearAll() {
    _service.clearAll();
    items.assignAll(_service.getAll());
  }
}
