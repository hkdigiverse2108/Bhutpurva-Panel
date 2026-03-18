import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGroupController extends BaseController {
  static CreateGroupController get instance => Get.find();

  final apiService = ApiService();

  final isLeadersLoading = false.obs;
  final isBatchesLoading = false.obs;
  final nameController = TextEditingController();

  final leaders = <UserModel>[].obs;
  final selectedLeaders = <UserModel>[].obs;

  final batches = <BatchesModel>[].obs;
  final selectedBatches = <BatchesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getLeaders();
    getBatches();
  }

  void getLeaders() {
    executeApi(
      loadingState: isLeadersLoading,
      apiCall: () async {
        final ResModel response = await apiService.get(ApiConstants.users());
        if (response.status == 200) {
          final usersList =
              response.data['users'] ?? response.data['data'] ?? [];
          leaders.assignAll(
            usersList.map((e) => UserModel.fromJson(e)).toList(),
          );
        }
      },
      errorMessage: "Failed to load leaders",
    );
  }

  void getBatches() {
    executeApi(
      loadingState: isBatchesLoading,
      apiCall: () async {
        final ResModel response = await apiService.get(ApiConstants.batches());
        if (response.status == 200) {
          final batchList =
              response.data['batch'] ??
              response.data['batches'] ??
              response.data['data'] ??
              [];
          batches.assignAll(
            batchList.map((e) => BatchesModel.fromJson(e)).toList(),
          );
        }
      },
      errorMessage: "Failed to load batches",
    );
  }

  void createGroup() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.post(
          ApiConstants.createGroup,
          body: {
            'name': nameController.text,
            'leaders': selectedLeaders.map((e) => e.id).toList(),
            'batches': selectedBatches.map((e) => e.id).toList(),
          },
        );

        if (response.status == 200) {
          Get.back();
        }
      },
      errorMessage: "Could not create group",
    );
  }
}
