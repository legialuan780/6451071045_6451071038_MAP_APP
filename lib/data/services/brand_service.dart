import '../models/brand_model.dart';

class BrandService {
  List<BrandModel> getBrands() => const <BrandModel>[
        BrandModel(id: 'b1', name: 'Nike', productsCount: 10),
        BrandModel(id: 'b2', name: 'Adidas', productsCount: 8),
      ];
}
