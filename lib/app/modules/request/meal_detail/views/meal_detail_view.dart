import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/utils.dart';
import '../controllers/meal_detail_controller.dart';

class MealDetailView extends GetView<MealDetailController> {
  const MealDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.meal.name!),
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Obx(() {
              return controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: Get.width * 0.6,
                              width: Get.width * 0.6,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: controller.meal.pictureUrl!,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Descripción',
                            style: styles.titleOffer,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            controller.meal.description!,
                            style: styles.profileLabelStyle,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Nombre del restaurante',
                            style: styles.titleOffer,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            controller.restaurant.restaurantName!,
                            style: styles.profileLabelStyle,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Nombre del menú',
                            style: styles.titleOffer,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            controller.menu.name!,
                            style: styles.profileLabelStyle,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Precio',
                            style: styles.titleOffer,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            currencyFormat
                                .format(
                                  controller.meal.price,
                                )
                                .replaceAll(',', '.'),
                            style: styles.profileLabelStyle,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Unidades disponibles',
                            style: styles.titleOffer,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${controller.meal.amount}',
                            style: styles.profileLabelStyle,
                          ),
                        ],
                      ),
                    );
            }),
          )
        ],
      ),
    );
  }
}
