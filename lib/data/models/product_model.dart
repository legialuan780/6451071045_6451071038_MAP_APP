class ProductModel {
  final String id;
  final String name;
  final String? imageUrl;
  final double price;
  final String categoryId;
  final String brandId;

  const ProductModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.price,
    required this.categoryId,
    required this.brandId,
  });
}
