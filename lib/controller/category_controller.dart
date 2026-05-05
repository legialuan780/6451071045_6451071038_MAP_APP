import 'package:get/get.dart';
import '../data/models/category_model.dart';
import '../data/services/category_service.dart';

class CategoryController extends GetxController {
  final CategoryService _service = CategoryService();
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    categories.assignAll(_service.getCategories());
  }
}
