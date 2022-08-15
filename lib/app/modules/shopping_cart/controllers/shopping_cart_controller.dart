import 'package:get/get.dart';
import 'package:proyecto_final_seminario/app/modules/home/controllers/home_controller.dart';

import '../../../models/cart_item_model.dart';

class ShoppingCartController extends GetxController {
  HomeController homeController = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  /// Elimina elementos del carrito
  deleteItemCart(CartItem cartItem) {
    homeController.shoppingCart.remove(cartItem);
  }
}
