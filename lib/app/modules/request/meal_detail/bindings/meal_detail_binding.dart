import 'package:get/get.dart';

import '../controllers/meal_detail_controller.dart';

class MealDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealDetailController>(
      () => MealDetailController(),
    );
  }
}
