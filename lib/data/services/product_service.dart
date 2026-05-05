import '../models/product_model.dart';

class ProductService {
  List<ProductModel> getProducts() {
    return const <ProductModel>[
      ProductModel(
        id: 'p1',
        name: 'Áo thun basic trắng',
        price: 199000,
        imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800',
        categoryId: 'c2',
        brandId: 'b1',
      ),
      ProductModel(
        id: 'p2',
        name: 'Áo hoodie oversize',
        price: 399000,
        imageUrl: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=800',
        categoryId: 'c2',
        brandId: 'b2',
      ),
      ProductModel(
        id: 'p3',
        name: 'Quần jean xanh slim fit',
        price: 459000,
        imageUrl: 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=800',
        categoryId: 'c2',
        brandId: 'b1',
      ),
      ProductModel(
        id: 'p4',
        name: 'Áo sơ mi linen',
        price: 329000,
        imageUrl: 'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=800',
        categoryId: 'c2',
        brandId: 'b2',
      ),
      ProductModel(
        id: 'p5',
        name: 'Váy midi nữ',
        price: 379000,
        imageUrl: 'https://images.unsplash.com/photo-1496747611176-843222e1e57c?w=800',
        categoryId: 'c2',
        brandId: 'b1',
      ),
      ProductModel(
        id: 'p6',
        name: 'Áo khoác denim',
        price: 529000,
        imageUrl: 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=800',
        categoryId: 'c2',
        brandId: 'b2',
      ),
      ProductModel(
        id: 'p7',
        name: 'Tai nghe bluetooth',
        price: 890000,
        imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800',
        categoryId: 'c1',
        brandId: 'b1',
      ),
      ProductModel(
        id: 'p8',
        name: 'Nồi chiên không dầu',
        price: 1290000,
        imageUrl: 'https://images.unsplash.com/photo-1585515656046-2e684f7f0d42?w=800',
        categoryId: 'c3',
        brandId: 'b2',
      ),
    ];
  }
}
