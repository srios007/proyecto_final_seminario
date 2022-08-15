import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/meal_detail_controller.dart';

class MealDetailView extends GetView<MealDetailController> {
  const MealDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MealDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MealDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
