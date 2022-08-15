import 'package:proyecto_final_seminario/app/routes/app_pages.dart';
import 'package:proyecto_final_seminario/app/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import '../../../../utils/utils.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Mi perfil',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: controller.homeController.user.profilePictureUrl != ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:
                              controller.homeController.user.profilePictureUrl!,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )
                    : Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 80,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              Text(
                controller.homeController.user.contactInfo!.fullName!,
                style: styles.nameProfile,
              ),
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Correo electrónico',
                      style: styles.titleOffer,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      controller.homeController.user.contactInfo!.email!,
                      style: styles.profileLabelStyle,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Número de celular',
                      style: styles.titleOffer,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${controller.homeController.user.contactInfo!.phoneNumber!.dialingCode!} ${controller.homeController.user.contactInfo!.phoneNumber!.basePhoneNumber!}',
                      style: styles.profileLabelStyle,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dirección',
                          style: styles.titleOffer,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.ADD_ADDRESS);
                          },
                          child: Text(
                            'Editar',
                            style: styles.editProfile,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${controller.homeController.user.address ?? 'Sin dirección'}',
                      style: styles.profileLabelStyle,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tarjeta de crédito',
                          style: styles.titleOffer,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.ADD_CREDIT_CARD);
                          },
                          child: Text(
                            'Editar',
                            style: styles.editProfile,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      controller.homeController.user.creditCard!.cardNumber ?? 'Sin tarjeta',
                      style: styles.profileLabelStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: PurpleButton(
        buttonText: 'Cerrar sesión',
        isLoading: false.obs,
        onPressed: controller.logOut,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
