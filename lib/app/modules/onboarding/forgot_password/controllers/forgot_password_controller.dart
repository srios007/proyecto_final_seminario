import 'package:proyecto_final_seminario/app/services/services.dart';
import '../views/forgot_password_detail_view.dart'; 
import '../../../../widgets/snackbars.dart';
import '../../../../routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgotPasswordController extends GetxController {
 final TextEditingController emailController = TextEditingController();
  final formKeyRecoverPassword = GlobalKey<FormState>();

  RxBool loading = false.obs;

  void sendRecoveryMail() async {
    if (formKeyRecoverPassword.currentState!.validate()) {
      loading.value = true;

      final error = await auth.sendPasswordReset(emailController.text);
      if (error.isNotEmpty) {
        SnackBars.showErrorSnackBar(error);
        loading.value = false;
      } else {
        loading.value = false;
        Get.to(ForgotPasswordDetailView());
      }
    }
  }

  void returnToLanding() {
    Get.offAllNamed(Routes.LOGIN);
  }
}
