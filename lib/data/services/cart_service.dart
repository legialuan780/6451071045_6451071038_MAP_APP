import '../models/cart_item_model.dart';

class CartService {
  final List<CartItemModel> _items = <CartItemModel>[];

  List<CartItemModel> get items => _items;

  void add(CartItemModel item) {
    final idx = _items.indexWhere((e) => e.productId == item.productId);
    if (idx >= 0) {
      _items[idx].quantity += 1;
    } else {
      _items.add(item);
    }
  }

  void remove(String productId) => _items.removeWhere((e) => e.productId == productId);
}
