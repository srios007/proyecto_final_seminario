import 'package:get/get.dart';
import 'package:proyecto_final_seminario/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_seminario/app/services/model_services/purchase_service.dart';
import 'package:proyecto_final_seminario/app/widgets/snackbars.dart';

import '../../../models/models.dart';

class ShoppingCartController extends GetxController {
  HomeController homeController = Get.find();
  List<Purchase> purchases = [];
  RxBool isLoading = false.obs;
  double total = 0;

  @override
  void onInit() {
    setTotal();
    super.onInit();
  }

  /// Elimina elementos del carrito
  deleteItemCart(CartItem cartItem) {
    homeController.shoppingCart.remove(cartItem);
  }

  /// Crea los purchases
  pay() async {
    isLoading.value = true;
    State state = State(
      isPreparing: false,
      isInRoute: false,
      isDelivered: false,
    );
    for (var element in homeController.shoppingCart) {
      purchases.add(
        Purchase(
            created: DateTime.now(),
            restaurantId: element.meal.restaurantId,
            mealId: element.meal.id,
            prices: element.price,
            userId: homeController.user.id,
            state: state),
      );
    }
    for (var purchase in purchases) {
      await purchaseService.createPurchase(purchase: purchase);
    }
    homeController.shoppingCart.clear();
    isLoading.value = false;
    Get.back();
    SnackBars.showSuccessSnackBar('Compra exitosa');
  }

  /// Determina el total del carrito
  setTotal() {
    for (var element in homeController.shoppingCart) {
      total += element!.price.total;
    }
  }
}
