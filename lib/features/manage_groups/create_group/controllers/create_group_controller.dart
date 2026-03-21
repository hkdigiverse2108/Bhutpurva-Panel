import 'package:bhutpurva_penal/core/constants/enums.dart';
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

  final leaders = <UsersDropdownModel>[].obs;
  final selectedLeaders = <UsersDropdownModel>[].obs;

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
        final ResModel response = await apiService.get(
          ApiConstants.usersDropdown(roleFilter: AlumniRole.leader.name),
        );
        if (response.status == 200) {
          final usersList = response.data ?? [];
          leaders.assignAll(
            (usersList as Iterable)
                .map<UsersDropdownModel>((e) => UsersDropdownModel.fromJson(e))
                .toList(),
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
        final ResModel response = await apiService.get(
          ApiConstants.dropdownBatches(),
        );
        if (response.status == 200) {
          final batchList =
              response.data['batch'] ??
              response.data['batches'] ??
              response.data['data'] ??
              [];
          batches.assignAll(
            (batchList as Iterable)
                .map<BatchesModel>((e) => BatchesModel.fromJson(e))
                .toList(),
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
