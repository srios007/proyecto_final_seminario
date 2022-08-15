import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_services/database_service.dart';
import '../../utils/connectivity.dart';
import '../../models/menu_model.dart';
import '../../utils/references.dart';

class MenuService {
  static String restaurantsReference = firebaseReferences.restaurants;
  static String addressReference = firebaseReferences.addresses;
  static String mealReference = firebaseReferences.meals;

  static final MenuService _instance = MenuService._internal();

  factory MenuService() {
    return _instance;
  }

  MenuService._internal();
  var firestore = FirebaseFirestore.instance;

  getMenus() async {
    connectionStatus.getNormalStatus();
    List<Menu> meals = [];
    var querySnapshot = await database.getData('menus');
    if (querySnapshot.docs.isEmpty) return [];
    for (var element in querySnapshot.docs) {
      Menu meal = Menu.fromJson(
        (element.data() as Map<String, dynamic>),
      );

      meal.id = element.id;
      meals.add(meal);
    }
    return meals;
  }

  getMenuById(String menuId) async {
    connectionStatus.getNormalStatus();
    List<Menu> meals = [];
    var querySnapshot = await database.getDataById(menuId, 'menus');
    if (querySnapshot.docs.isEmpty) return [];
    for (var element in querySnapshot.docs) {
      Menu meal = Menu.fromJson(
        (element.data() as Map<String, dynamic>),
      );

      meal.id = element.id;
      meals.add(meal);
    }
    return meals;
  }
}

MenuService menuService = MenuService();
