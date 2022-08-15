import 'package:get/get.dart';
import 'package:proyecto_final_seminario/app/models/restaurant_model.dart';
import 'package:proyecto_final_seminario/app/services/model_services/menu_service.dart';
import 'package:proyecto_final_seminario/app/services/model_services/restaurant_service.dart';

import '../../../../models/models.dart';

class MealDetailController extends GetxController {
  RxBool isLoading = false.obs;
  late Restaurant restaurant;
  late Meal meal;
  late Menu menu;

  final count = 0.obs;
  @override
  void onInit() {
    meal = Get.arguments['meal'];
    getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    await getMenu();
    await getRestaurant();
    isLoading.value = false;
  }

  /// Trae el nombre del menu asociado al platillo
  getMenu() async {
    List<Menu> aux = await menuService.getMenuById(meal.menuId!);
    menu = aux[0];
  }

  /// Trae el usuario  asociado al platillo
  getRestaurant() async {
    restaurant =
        (await restaurantService.getUserDocumentById(meal.restaurantId!))!;
  }

  /// Categoría a partir de un category id
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
