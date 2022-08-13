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
                      ],
                    ),
                  )
                ],
              );
      }),
    );
  }
}
