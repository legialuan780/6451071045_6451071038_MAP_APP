import '../models/product_model.dart';

class WishlistService {
  final List<ProductModel> _wishlist = <ProductModel>[];

  List<ProductModel> getAll() => List<ProductModel>.from(_wishlist);

  void toggle(ProductModel product) {
    final idx = _wishlist.indexWhere((e) => e.id == product.id);
    if (idx >= 0) {
      _wishlist.removeAt(idx);
    } else {
      _wishlist.add(product);
    }
  }
}
