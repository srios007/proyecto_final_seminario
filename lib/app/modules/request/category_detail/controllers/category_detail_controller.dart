import 'package:proyecto_final_seminario/app/services/model_services/meal_service.dart';
import 'package:proyecto_final_seminario/app/models/category_model.dart';
import '../../../../models/meal_model.dart';
import 'package:get/get.dart';


class CategoryDetailController extends GetxController {
  late Category category;
  List<Meal> meals = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    category = Get.arguments['category'];
    getData();
    super.onInit();
  }

  getData() async {
    await getMeals();
  }

  getMeals() async {
    isLoading.value = true;
    meals = await mealService.getMealsByDocumentId(
      category.id!,
      'meals',
      'categoyId',
    );
    isLoading.value = false;
  }

  // Categoría a partir de un category id
  setCategory(String categoryId) {
    switch (categoryId) {
      case 'beverage':
        return 'Bebida';

      case 'dessert':
        return 'Postre';

      case 'entree':
        return 'Plato fuerte';

      case 'side':
        return 'Acompañamiento';

      case 'starter':
        return 'Entrada';

      default:
        return '';
    }
  }
}
