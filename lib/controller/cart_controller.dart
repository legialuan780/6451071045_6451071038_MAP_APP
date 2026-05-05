import 'package:get/get.dart';
import '../data/models/cart_item_model.dart';
import '../data/services/cart_service.dart';

class CartController extends GetxController {
  final CartService _service = CartService();
  final RxList<CartItemModel> items = <CartItemModel>[].obs;

  double get total => items.fold(0, (sum, e) => sum + e.subtotal);

  void addItem(CartItemModel item) {
    _service.add(item);
    items.assignAll(_service.items);
  }

  void removeItem(String productId) {
    _service.remove(productId);
    items.assignAll(_service.items);
  }

  void clear() {
    items.clear();
    _service.items.clear();
  }

  void increaseQuantity(String productId) {
    final int index = items.indexWhere((e) => e.productId == productId);
    if (index < 0) return;
    items[index].quantity += 1;
    items.refresh();
  }

  void decreaseQuantity(String productId) {
    final int index = items.indexWhere((e) => e.productId == productId);
    if (index < 0) return;
    if (items[index].quantity > 1) {
      items[index].quantity -= 1;
      items.refresh();
      return;
    }
    removeItem(productId);
  }
}
