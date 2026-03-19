import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/group_models/group_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBatchController extends BaseController {
  static EditBatchController get instance => Get.find();

  final apiService = ApiService();

  final isBatchLoading = false.obs;
  final isSaving = false.obs;

  final nameController = TextEditingController();

  final groups = <GroupDropdownModel>[].obs;
  final selectedGroup = Rxn<GroupDropdownModel>();

  final students = <UsersDropdownModel>[].obs;
  final selectedStudents = <UsersDropdownModel>[].obs;

  String? batchId;

  @override
  void onInit() {
    super.onInit();
    batchId = Get.arguments;
    getGroups();
    getStudents();
    if (batchId != null) {
      fetchBatchDetails();
    }
  }

  void getGroups() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.groupsDropdown(""),
        );
        if (response.status == 200) {
          final list = response.data ?? [];
          groups.assignAll(
            (list as Iterable)
                .map<GroupDropdownModel>((e) => GroupDropdownModel.fromJson(e))
                .toList(),
          );
        }
      },
    );
  }

  void getStudents() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.usersDropdown(roleFilter: AlumniRole.user.name),
        );
        if (response.status == 200) {
          final usersList = response.data ?? [];
          students.assignAll(
            (usersList as Iterable)
                .map<UsersDropdownModel>((e) => UsersDropdownModel.fromJson(e))
                .toList(),
          );
        }
      },
    );
  }

  void fetchBatchDetails() {
    executeApi(
      loadingState: isBatchLoading,
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.batchDetails(batchId!),
        );
        if (response.status == 200) {
          final data = response.data;
          nameController.text = data['name'] ?? '';
          // Handle setting selected group and students based on response data
          // Assuming data['group'] and data['students'] are present
        }
      },
      errorMessage: "Failed to load batch details",
    );
  }

  void updateBatch() {
    if (batchId == null || selectedGroup.value == null) return;
    executeApi(
      loadingState: isSaving,
      apiCall: () async {
        final ResModel response = await apiService.put(
          ApiConstants.batchDetails(batchId!),
          body: {
            'name': nameController.text,
            'groupId': selectedGroup.value!.id,
            'studentIds': selectedStudents.map((e) => e.id).toList(),
          },
        );

        if (response.status == 200) {
          Get.back();
        }
      },
      errorMessage: "Could not update batch",
    );
  }
}
