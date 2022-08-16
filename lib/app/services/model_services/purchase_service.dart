import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_seminario/app/models/purchase_model.dart';
import 'package:proyecto_final_seminario/app/services/model_services/meal_service.dart';
import 'package:proyecto_final_seminario/app/services/model_services/restaurant_service.dart';
import '../../models/meal_model.dart';
import '../../utils/connectivity.dart';
import '../../utils/references.dart';
import '../firebase_services/database_service.dart';

class PurchaseService {
  static String restaurantsReference = firebaseReferences.restaurants;
  static String addressReference = firebaseReferences.addresses;
  static String mealReference = firebaseReferences.meals;

  static final PurchaseService _instance = PurchaseService._internal();

  factory PurchaseService() {
    return _instance;
  }

  PurchaseService._internal();
  var firestore = FirebaseFirestore.instance;

  createPurchase({
    required Purchase purchase,
  }) async {
    try {
      purchase.created = DateTime.now();

      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection('purchases')
          .add(purchase.toJson());

      database.savePurchase(
        collection: 'purchases',
        customId: documentReference.id,
        purchase: purchase,
      );

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  getPurchasesByUserId(
    String documentId,
  ) async {
    connectionStatus.getNormalStatus();
    List<Purchase> purchases = [];
    var querySnapshot =
        await database.getDataByCustonParam(documentId, 'purchases', 'userId');
    if (querySnapshot.docs.isEmpty) return [];
    for (var element in querySnapshot.docs) {
      Purchase purchase = Purchase.fromJson(
        (element.data() as Map<String, dynamic>),
      );

      purchase.id = element.id;
      purchases.add(purchase);
      for (var element in purchases) {
        element.restaurant =
            await restaurantService.getUserDocumentById(element.restaurantId!);
        List<Meal> aux = await mealService.getMealsByDocumentId(
            element.mealId!, 'meals', 'id');
        element.meal = aux[0];
      }
    }
    return purchases;
  }

  Future<List<Meal>> getMeals(
    String collection,
  ) async {
    connectionStatus.getNormalStatus();
    List<Meal> meals = [];
    var querySnapshot = await database.getData(collection);
    if (querySnapshot.docs.isEmpty) return [];
    for (var element in querySnapshot.docs) {
      Meal meal = Meal.fromJson(
        (element.data() as Map<String, dynamic>),
      );
      meal.ingredients = [].obs;
      meal.id = element.id;
      meals.add(meal);
    }
    return meals;
  }
}

PurchaseService purchaseService = PurchaseService();
