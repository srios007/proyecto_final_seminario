import 'package:proyecto_final_seminario/app/models/category_model.dart';
import 'package:proyecto_final_seminario/app/utils/utils.dart';
import '../firebase_services/database_service.dart';
import 'package:get/get.dart';

class CategoryService {
  static String categoryReference = firebaseReferences.categories;

  Future<List<Category>> getCategories() async {
    connectionStatus.getNormalStatus();
    List<Category> categories = [];
    var querySnapshot = await database.getData(categoryReference);
    if (querySnapshot.docs.isEmpty) return [];
    for (var element in querySnapshot.docs) {
      Category category = Category.fromJson(
        (element.data() as Map<String, dynamic>),
      );
      category.meals = [].obs;
      category.id = element.id;
      categories.add(category);
    }
    return categories;
  }
}

CategoryService categoryService = CategoryService();
