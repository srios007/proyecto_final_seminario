import 'package:proyecto_final_seminario/app/services/services.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../widgets/snackbars.dart';
import '../../../../routes/app_pages.dart';
import '../../../../models/models.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKeyLogin = GlobalKey<FormState>();
  final visiblePassword = false.obs;
  RxBool isLoading = false.obs;
  final box = GetStorage();
  User? user = User();

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
          if (user!.id != null) {
            isLoading.value = false;
            Get.offAllNamed(Routes.HOME, arguments: {'user': user});
          } else {
            print('2');
            isLoading.value = false;
            SnackBars.showErrorSnackBar(
              'No eres un restaurante, prueba con otra cuenta',
            );
          }
        } else {
          SnackBars.showErrorSnackBar(response);
          isLoading.value = false;
        }
      } catch (e) {
        print(e.toString());
        isLoading.value = false;
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
