import 'dart:developer';

import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/features/manage_batches/batch_list/controllers/batch_list_controller.dart';
import 'package:bhutpurva_penal/shared/models/group_models/group_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBatchController extends BaseController {
  static CreateBatchController get instance => Get.find();

  final apiService = ApiService();

  final isLeadersLoading = false.obs;
  final isBatchesLoading = false.obs;
  final nameController = TextEditingController();

  final groups = <GroupDropdownModel>[].obs;
  final selectedGroup = Rxn<GroupDropdownModel>();

  final students = <UsersDropdownModel>[].obs;
  final selectedStudents = <UsersDropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getGroups();
    getStudents();
  }

  void getGroups() {
    executeApi(
      loadingState: isBatchesLoading,
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
          log('groups detail : ${groups.first.name}');
        }
      },
      errorMessage: "Failed to load groups",
    );
  }

  void getStudents() {
    executeApi(
      loadingState: isLeadersLoading,
      apiCall: () async {
        final ResModel response = await apiService.get(
          // ApiConstants.usersDropdown(roleFilter: AlumniRole.user.name),
          ApiConstants.usersDropdown(),
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
      errorMessage: "Failed to load students",
    );
  }

  void createBatch() {
    if (selectedGroup.value == null) return;
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.post(
          ApiConstants.createBatch(),
          body: {
            'name': nameController.text,
            'groupId': selectedGroup.value!.id,
            'studentIds': selectedStudents.map((e) => e.id).toList(),
          },
        );

        if (response.status == 200) {
          BatchListController.instance.fetchBatches();
          Get.back();
        }
      },
      errorMessage: "Could not create batch",
    );
  }
}
