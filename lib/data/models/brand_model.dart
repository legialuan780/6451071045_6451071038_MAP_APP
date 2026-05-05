class BrandModel {
  final String id;
  final String name;
  final String? imageUrl;
  final int productsCount;

  const BrandModel({required this.id, required this.name, this.imageUrl, this.productsCount = 0});
}
