import 'package:proyecto_final_seminario/app/services/model_services/category_service.dart';
import 'package:proyecto_final_seminario/app/services/model_services/meal_service.dart';
import 'package:proyecto_final_seminario/app/models/category_model.dart';
import 'package:proyecto_final_seminario/app/services/model_services/purchase_service.dart';
import 'package:proyecto_final_seminario/app/services/services.dart';
import 'package:proyecto_final_seminario/app/routes/app_pages.dart';
import 'package:proyecto_final_seminario/app/models/models.dart';
import '../../../services/firebase_services/database_service.dart';
import '../../../services/model_services/menu_service.dart';
import 'package:get/get.dart';

import '../../../services/model_services/restaurant_service.dart';

class HomeController extends GetxController {
  RxList shoppingCart = [].obs;
  List<Category> categories = [];
  RxBool isLoading = false.obs;
  List<Purchase> purchases = [];
  List<Meal> meals = [];
  List<Menu> menus = [];
  User user = User();

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
    await getMenus();
    await getPurchases();
    isLoading.value = false;
  }

  /// Trae el usuario que inicia sesión
  getRestaurant() async {
    user = (await userService.getCurrentUser())!;
  }

  /// Trae las categorías
  getCategories() async {
    categories = await categoryService.getCategories();
  }

  /// Trae los platillos
  getMeals() async {
    meals = await mealService.getMeals('meals');
  }

  //Ir ald etalle de la categoría
  goToCategoryDetail(Category category) async {
    Get.toNamed(Routes.CATEGORY_DETAIL, arguments: {
      'category': category,
    });
  }

  /// Trae los menús del restaurante
  getMenus() async {
    menus = await menuService.getMenus();
  }

  // getPurchases() async {
  //   purchases = await purchaseService.getPurchasesByUserId(user.id!);
  // }

  /// Ir a detalle de  menú
  goToMenu(Menu menu) async {
    await Get.toNamed(Routes.MENU_DETAIL, arguments: {
      'menu': menu,
    });
  }

  /// Trae los purchases del usuario
  getPurchases() async {
    database
        .getOrderedSubcollectionSnapshotWithCondition(
      collection: 'purchases',
      orderProperty: 'created',
      whereProperty: 'userId',
      equal: user.id!,
      desc: true,
      limit: 100,
    )
        .listen((event) async {
      if (event.docs.isEmpty) {
        purchases = [];
      } else {
        isLoading.value = true;
        purchases = [];
        for (var element in event.docs) {
          Purchase purchase =
              Purchase.fromJson(element.data() as Map<String, dynamic>);
          purchases.add(purchase);
        }
        for (var element in purchases) {
          element.restaurant = await restaurantService
              .getUserDocumentById(element.restaurantId!);
          List<Meal> aux = await mealService.getMealsByDocumentId(
              element.mealId!, 'meals', 'id');
          element.meal = aux[0];
        }
        print('nuevo purchase');
        isLoading.value = false;
      }
    });
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

  /// Estado a partir del purchase
  setState(State state) {
    if (state.isPreparing! && !state.isDelivered! && !state.isInRoute!) {
      return 'En preparación';
    } else if (state.isPreparing! && !state.isDelivered! && state.isInRoute!) {
      return 'En camino';
    } else {
      return 'Entregado';
    }
  }
}
