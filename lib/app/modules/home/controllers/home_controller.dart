import 'package:proyecto_final_seminario/app/routes/app_pages.dart';
import 'package:proyecto_final_seminario/app/services/model_services/category_service.dart';
import 'package:proyecto_final_seminario/app/services/model_services/meal_service.dart';
import 'package:proyecto_final_seminario/app/models/category_model.dart';
import 'package:proyecto_final_seminario/app/models/meal_model.dart';
import 'package:proyecto_final_seminario/app/services/services.dart';
import 'package:proyecto_final_seminario/app/models/user_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  User user = User();
  List<Category> categories = [];
  List<Meal> meals = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    await getRestaurant();
    await getCategories();
    await getMeals();
    isLoading.value = false;
  }

  // Trae el usuario que inicia sesión
  getRestaurant() async {
    user = (await userService.getCurrentUser())!;
  }

  // Trae las categorías
  getCategories() async {
    categories = await categoryService.getCategories();
  }

  // Trae los platillos
  getMeals() async {
    meals = await mealService.getMeals('meals');
  }

  //Ir ald etalle de la categoría
  goToCategoryDetail(Category category) async {
    Get.toNamed(Routes.CATEGORY_DETAIL, arguments: {
      'category': category,
    });
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
