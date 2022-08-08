import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_seminario/app/routes/app_pages.dart';

import '../../../services/firebase_services/auth_service.dart';
import '../../home/controllers/home_controller.dart';

class ProfileController extends GetxController {
  HomeController homeController = Get.find();

  logOut() async {
    await auth.signOut();
    Get.toNamed(Routes.LOGIN);
  }
}
