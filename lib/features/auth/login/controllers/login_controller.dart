import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final storageService = StorageService();

  final isPasswordHidden = true.obs;

  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  void onLogin() {
    if (loginFormKey.currentState?.validate() ?? false) {
      storageService.token = 'token';
      // API call here
      Get.toNamed(AppPages.dashboard);
    }
  }

  void onForgotPassword() {
    // Navigate or open dialog
  }
}
