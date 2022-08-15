import 'package:get/get.dart';

import '../controllers/add_credit_card_controller.dart';

class AddCreditCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCreditCardController>(
      () => AddCreditCardController(),
    );
  }
}
