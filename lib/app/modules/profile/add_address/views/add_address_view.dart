import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_address_controller.dart';

class AddAddressView extends GetView<AddAddressController> {
  const AddAddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddAddressView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddAddressView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
