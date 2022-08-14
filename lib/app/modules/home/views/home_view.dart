import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:proyecto_final_seminario/app/models/meal_model.dart';
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
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Categorías',
                            style: styles.titleOffer,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 200,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 180,
                              crossAxisCount: 2,
                            ),
                            itemCount: controller.categories.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () async {
                               await controller.goToCategoryDetail(controller.categories[index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                height: 40,
                                width: 120,
                                decoration: ShapeDecoration.fromBoxDecoration(
                                  BoxDecoration(
                                    color: Palette.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 209, 208, 208),
                                        offset: Offset(4.0, 4.0),
                                        blurRadius: 4.0,
                                      ),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${controller.categories[index].name}',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Palette.purple,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Platillos disponibles',
                            style: styles.titleOffer,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: Get.width,
                          height: 250,
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.meals.length,
                            itemBuilder: (context, index) {
                              var meal = controller.meals[index];
                              return MealContainer(
                                meal: meal,
                                controller: controller,
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
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 40,
                        //     vertical: 30,
                        //   ),
                        //   child: PurpleButton(
                        //     height: 40,
                        //     width: Get.width - 80,
                        //     isLoading: false.obs,
                        //     onPressed: controller.goToAddMenu,
                        //     buttonText: 'Agregar menú',
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              );
      }),
    );
  }
}

class MealContainer extends StatelessWidget {
  MealContainer({
    Key? key,
    required this.meal,
    required this.controller,
  }) : super(key: key);

  final Meal meal;
  HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 100,
      width: 170,
      decoration: ShapeDecoration.fromBoxDecoration(
        BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 209, 208, 208),
              offset: Offset(4.0, 4.0),
              blurRadius: 8.0,
            ),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 130,
            width: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: meal.pictureUrl!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${meal.name}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Palette.purple,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Categoría: ${controller.setCategory(meal.categoryId!)}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Palette.purple,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Precio: ${currencyFormat.format(
                    meal.price,
                  ).replaceAll(',', '.')}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Palette.purple,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
