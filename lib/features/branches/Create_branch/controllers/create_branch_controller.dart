import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/features/branches/controllers/branches_controller.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBranchController extends BaseController {
  final apiService = ApiService();

  final nameController = TextEditingController();
  final isActive = true.obs;

  void createBranch() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.post(
          ApiConstants.createBranch(),
          body: {
            'name': nameController.text.trim(),
            'isActive': isActive.value,
          },
        );
        if (response.status == 200 || response.status == 201) {
          if (Get.isRegistered<BranchesController>()) {
            Get.find<BranchesController>().fetchBranches();
          }
          Get.back();
        }
      },
      errorMessage: "Could not create branch",
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
