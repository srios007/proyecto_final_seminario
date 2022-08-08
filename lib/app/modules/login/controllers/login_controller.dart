import 'package:proyecto_final_seminario/app/services/services.dart';

import '../../../services/model_services/restaurant_service.dart';
import '../../../services/firebase_services/auth_service.dart';
import 'package:get_storage/get_storage.dart';
import '../../../widgets/snackbars.dart';
import '../../../routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import '../../../models/models.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKeyLogin = GlobalKey<FormState>();
  User? user = User();
  final visiblePassword = false.obs;
  RxBool isLoading = false.obs;
  final box = GetStorage();

  showPassword() {
    visiblePassword.value
        ? visiblePassword.value = false
        : visiblePassword.value = true;
  }

  String? validatePassword(String? _) {
    if (passwordController.text.isEmpty) {
      return 'Por favor, rellena este campo';
    } else if (passwordController.text.length < 6) {
      return 'La longitud mínima es de 6 caracteres';
    } else {
      return null;
    }
  }

  login() async {
    if (formKeyLogin.currentState!.validate()) {
      isLoading.value = true;
      try {
        final response = await auth.signIn(
            email: emailController.text.trim(),
            password: passwordController.text);
        if (response is! String) {
          user = (await userService.getCurrentUser())!;
          if (user != null) {
            userService.update(user!);
            isLoading.value = false;
            Get.offAllNamed(Routes.HOME, arguments: {'user': user});
          } else {
            SnackBars.showErrorSnackBar(
                'No eres un restaurante, prueba con otra cuenta');
          }
        } else {
          SnackBars.showErrorSnackBar(response);
          isLoading.value = false;
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  recoverUser() {
    Get.toNamed(Routes.FORGOT_USER);
  }

  recoverPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  createAccount() {
    Get.toNamed(Routes.REGISTER);
  }
}
