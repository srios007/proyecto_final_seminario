import 'package:proyecto_final_seminario/app/services/services.dart';
import 'package:proyecto_final_seminario/app/models/models.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../widgets/snackbars.dart';
import '../../../../routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:io';

class RegisterController extends GetxController {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKeyRegister = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  PhoneNumber phoneNumber = PhoneNumber(code: 'CO', dialingCode: '+57');
  ContactInfo contactInfo = ContactInfo();
  User user = User();
  final visiblePassword = false.obs;
  RxBool isLoadingPP = false.obs;
  RxBool isLoading = false.obs;
  final box = GetStorage();
  RxBool error = false.obs;
  File? profilePicture;

  String? validatePhone(String? _) {
    if (phoneController.text.isEmpty) {
      error.value = true;
      return null;
    } else {
      error.value = false;
      return null;
    }
  }

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

  recoverUser() {
    Get.toNamed(Routes.FORGOT_USER);
  }

  recoverPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  logIn() {
    Get.toNamed(Routes.LOGIN);
  }

  getProfilePicture(bool isCamera) async {
    if (await Permission.mediaLibrary.request().isGranted &&
        await Permission.camera.request().isGranted) {
      isLoadingPP.value = true;
      try {
        final result = await _picker.pickImage(
            source: isCamera ? ImageSource.camera : ImageSource.gallery);

        if (result != null) {
          profilePicture = File(result.path);
          isLoadingPP.value = false;
        } else {
          isLoadingPP.value = false;
        }
      } catch (e) {
        print(e);
        SnackBars.showErrorSnackBar(
          'Por favor, activa los permisos desde la configuración de tu celular para poder acceder a los archivos que necesites y tomar fotos',
        );
        isLoadingPP.value = false;
      }
    } else {
      SnackBars.showErrorSnackBar(
        'Por favor, activa los permisos desde la configuración de tu celular para poder acceder a los archivos que necesites y tomar fotos',
      );
      isLoadingPP.value = false;
    }
  }

  createAccount() async {
    if (!formKeyRegister.currentState!.validate()) {
      SnackBars.showErrorSnackBar(
        'Por favor, rellena todos los campos.',
      );
    } else {
      contactInfo.fullName = userNameController.text;
      contactInfo.email = emailController.text.trim();
      phoneNumber.basePhoneNumber = phoneController.text.trim();
      contactInfo.phoneNumber = phoneNumber;
      user.contactInfo = contactInfo;
      user.creditCard = CreditCard();
      user.address = Address();
      user.userType = 'Client';
      try {
        isLoading.value = true;
        var signUpResult = await auth.signUp(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        if (signUpResult ==
            'There is an account already registered with this email.') {
          SnackBars.showErrorSnackBar('Ya existe un usuario con este correo.');
          isLoading.value = false;
        } else if (signUpResult ==
            'Your email address appears to be malformed.') {
          SnackBars.showErrorSnackBar('Tu correo está mal escrito');
        } else if (signUpResult is String) {
          SnackBars.showErrorSnackBar(signUpResult);
          isLoading.value = false;
        } else {
          if (profilePicture != null) {
            var urlRutResult = await storageService.uploadFile(
              signUpResult.user.uid,
              'FotoPerfil',
              profilePicture!,
            );
            user.profilePictureUrl = urlRutResult;
          } else {
            user.profilePictureUrl = '';
          }
          user.id = signUpResult.user.uid;
          await userService.saveUser(
            user: user,
            customId: signUpResult.user.uid,
          );
          Get.offAllNamed(Routes.HOME);
        }
        isLoading.value = false;
      } catch (e) {
        print(e.toString());
        await auth.deleteUser();
        isLoading.value = false;
      }
    }
  }
}
