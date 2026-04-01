import 'dart:developer';

import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/features/manage_batches/batch_list/controllers/batch_list_controller.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
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

  final batchDetails = Rxn<BatchesModel>();

  final groups = <GroupDropdownModel>[].obs;
  final selectedGroup = Rxn<GroupDropdownModel>();

  final students = <UsersDropdownModel>[].obs;
  final selectedStudents = <UsersDropdownModel>[].obs;

  String? batchId;

  @override
  void onInit() {
    super.onInit();
    batchId = Get.arguments;
    initialize();
  }

  Future<void> initialize() async {
    await Future.wait([getGroups(), getStudents()]);
    if (batchId != null) {
      await fetchBatchDetails();
    }
  }

  Future<void> getGroups() {
    return executeApi(
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

  Future<void> getStudents() {
    return executeApi(
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
    );
  }

  Future<void> fetchBatchDetails() {
    return executeApi(
      loadingState: isBatchLoading,
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.batchDetails(batchId!),
        );
        if (response.status == 200) {
          batchDetails.value = BatchesModel.fromJson(response.data);
          nameController.text = batchDetails.value!.name;
          // Match group by ID from the loaded groups list
          if (batchDetails.value!.groupId != null) {
            log(batchDetails.value!.groupId!.id);
            final matchedGroup = groups.where(
              (e) => e.id == batchDetails.value!.groupId!.id,
            );
            if (matchedGroup.isNotEmpty) {
              selectedGroup.value = matchedGroup.first;
            }
          }

          // Match students by ID from the loaded students list
          final batchStudentIds = batchDetails.value!.students
              .map((e) => e.id)
              .toSet();
          final matchedStudents = students
              .where((e) => batchStudentIds.contains(e.id))
              .toList();
          selectedStudents.assignAll(matchedStudents);
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
          ApiConstants.updateBatch(),
          body: {
            'batchId': batchId!,
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
      errorMessage: "Could not update batch",
    );
  }
}
