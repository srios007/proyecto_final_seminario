import 'package:proyecto_final_seminario/app/routes/app_pages.dart';
import '../../../home/controllers/home_controller.dart';
import '../../../../services/services.dart';
import 'package:get/get.dart';
 

class ProfileController extends GetxController {
  HomeController homeController = Get.find();

  logOut() async {
    await auth.signOut();
    Get.toNamed(Routes.LOGIN);
  }
}
