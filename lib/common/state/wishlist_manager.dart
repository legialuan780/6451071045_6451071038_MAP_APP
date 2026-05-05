class WishlistManager {
  static final Set<String> _ids = <String>{};

  static bool isFavorite(String productId) => _ids.contains(productId);
  static List<String> get all => _ids.toList();

  static void toggle(String productId) {
    if (_ids.contains(productId)) {
      _ids.remove(productId);
    } else {
      _ids.add(productId);
    }
  }
}
