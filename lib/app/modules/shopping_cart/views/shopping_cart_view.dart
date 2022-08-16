import 'package:cached_network_image/cached_network_image.dart';
import 'package:proyecto_final_seminario/app/models/models.dart';
import 'package:proyecto_final_seminario/app/utils/utils.dart';
import 'package:proyecto_final_seminario/app/widgets/purple_button.dart';
import '../controllers/shopping_cart_controller.dart';
import '../../home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartView extends GetView<ShoppingCartController> {
  const ShoppingCartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: PurpleButton(
        buttonText: 'Pagar ${currencyFormat.format(
              controller.total,
            ).replaceAll(',', '.')} ',
        isLoading: controller.isLoading,
        onPressed: controller.pay,
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index ==
                              controller.homeController.shoppingCart.length - 1
                          ? 80
                          : 0,
                    ),
                    child: MealContainer(
                      meal: controller
                          .homeController.shoppingCart[index].purchase,
                      homeController: controller.homeController,
                      cartItem: controller.homeController.shoppingCart[index],
                      controller: controller,
                    ),
                  );
                },
                childCount: controller
                    .homeController.shoppingCart.length, // 1000 list items
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MealContainer extends StatelessWidget {
  MealContainer({
    Key? key,
    required this.meal,
    required this.homeController,
    required this.controller,
    required this.cartItem,
  }) : super(key: key);

  final Meal meal;
  ShoppingCartController controller;
  HomeController homeController;
  CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 130,
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
      child: Row(
        children: [
          const SizedBox(width: 20),
          SizedBox(
            height: 100,
            width: 100,
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
          SizedBox(
            width: Get.width * 0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '${meal.name}',
                    style: const TextStyle(
                      fontSize: 14,
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
                    'Categoría: ${homeController.setCategory(meal.categoryId!)}',
                    style: const TextStyle(
                      fontSize: 14,
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
                      fontSize: 14,
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
                    'Precio del envío: ${cartItem.price!.deliveryCost.toInt()}',
                    style: const TextStyle(
                      fontSize: 14,
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
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              controller.deleteItemCart(cartItem);
            },
            child: const Icon(
              Icons.delete,
              color: Palette.purple,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
