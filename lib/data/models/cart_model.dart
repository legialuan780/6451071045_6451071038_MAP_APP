import 'cart_item_model.dart';

class CartModel {
  final List<CartItemModel> items;

  CartModel({required this.items});

  double get total => items.fold(0, (sum, e) => sum + e.subtotal);
}
