import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/features/branches/controllers/branches_controller.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBranchController extends BaseController {
  final apiService = ApiService();

  final nameController = TextEditingController();
  final isActive = true.obs;
  final isFetching = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBranch();
  }

  void fetchBranch() {
    executeApi(
      loadingState: isFetching,
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.branchDetails(Get.arguments['id']),
        );
        if (response.status == 200) {
          final data = response.data;
          nameController.text = data['name'] ?? '';
          isActive.value = data['isActive'] ?? true;
        }
      },
      errorMessage: "Failed to load branch details",
    );
  }

  void updateBranch() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.put(
          ApiConstants.updateBranch(),
          body: {
            'branchId': Get.arguments['id'],
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
      errorMessage: "Could not update branch",
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
