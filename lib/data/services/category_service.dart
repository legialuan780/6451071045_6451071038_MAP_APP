import '../models/category_model.dart';

class CategoryService {
  List<CategoryModel> getCategories() => const <CategoryModel>[
        CategoryModel(id: 'c1', name: 'Áo'),
        CategoryModel(id: 'c2', name: 'Quần'),
        CategoryModel(id: 'c3', name: 'Váy'),
        CategoryModel(id: 'c4', name: 'Giày dép'),
        CategoryModel(id: 'c5', name: 'Phụ kiện'),
      ];
}
