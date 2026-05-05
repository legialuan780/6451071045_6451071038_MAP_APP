import '../models/product_model.dart';
import 'product_service.dart';

class MystoreService {
  final ProductService _productService = ProductService();

  List<ProductModel> getProductsByBrand(String brandId) {
    return _productService.getProducts().where((e) => e.brandId == brandId).toList();
  }
}
