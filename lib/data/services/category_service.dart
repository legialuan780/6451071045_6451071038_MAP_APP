import '../models/category_model.dart';

class CategoryService {
  List<CategoryModel> getCategories() => const <CategoryModel>[
        CategoryModel(id: 'c1', name: 'Điện tử'),
        CategoryModel(id: 'c2', name: 'Thời trang'),
        CategoryModel(id: 'c3', name: 'Gia dụng'),
      ];
}
