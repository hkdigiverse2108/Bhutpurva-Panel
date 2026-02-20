import 'dart:developer';

import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/core/services/storage_service.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/user/user_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final storageService = StorageService.instance;
  final apiService = ApiService();

  final isPasswordHidden = true.obs;

  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  void onLogin() async {
    try {
      isLoading.value = true;
      if (loginFormKey.currentState!.validate()) {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();

        final ResModel res = await apiService.post(
          ApiConstants.login,
          body: {"email": email, "password": password},
        );

        if (res.status == 200) {
          final LoginRes loginRes = LoginRes.fromJson(res.data);
          storageService.token = loginRes.token;
          storageService.user = loginRes.user;
          Get.offAllNamed('/dashboard');
          AppSnackBar.show(
            type: AppSnackBarType.success,
            title: "Login Success",
            message: "Login successful",
          );
        }
      } else {
        AppSnackBar.show(
          type: AppSnackBarType.warning,
          title: "Empty Fields",
          message: "Please fill all the fields",
        );
      }
    } on ApiException catch (e) {
      log(e.toString());
      AppSnackBar.show(
        type: AppSnackBarType.error,
        title: "Error",
        message: e.message,
      );
    } catch (e) {
      log(e.toString());
      AppSnackBar.show(
        type: AppSnackBarType.error,
        title: "Error",
        message: "Login failed",
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onForgotPassword() {
    // Navigate or open dialog
  }
}
