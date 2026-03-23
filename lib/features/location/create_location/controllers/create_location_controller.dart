import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateLocationController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    typeController.dispose();
    statusController.dispose();
    super.onClose();
  }
}
