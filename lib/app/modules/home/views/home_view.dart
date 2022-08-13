import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:proyecto_final_seminario/app/utils/utils.dart';

import '../../../widgets/purple_button.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_drawer.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        contextGlobal: context,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Bienvenido ${controller.user.contactInfo!.fullName}',
                            style: styles.titleOffer,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Aquí puedes hacer pedidos a tus restaurantes favoritos.',
                            style: styles.hintTextStyleRegister,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Platillos disponibles',
                            style: styles.titleOffer,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: Get.width,
                          height: 100,
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.meals.length,
                            itemBuilder: (context, index) {
                              var meal = controller.meals[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                height: 30,
                                width: Get.width * 0.4,
                                decoration: ShapeDecoration.fromBoxDecoration(
                                  BoxDecoration(
                                    color: Palette.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 209, 208, 208),
                                        offset: Offset(4.0, 4.0),
                                        blurRadius: 8.0,
                                      ),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      '${meal.name}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Palette.purple,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      textScaleFactor:
                                          context.textScaleFactor > 1
                                              ? 1
                                              : context.textScaleFactor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Mis órdenes activas',
                              style: styles.titleOffer),
                        ),
                        const SizedBox(height: 30),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 30,
                          ),
                          child: PurpleButton(
                            height: 40,
                            width: Get.width - 80,
                            isLoading: false.obs,
                            onPressed: controller.goToAddMenu,
                            buttonText: 'Agregar menú',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
      }),
    );
  }
}
