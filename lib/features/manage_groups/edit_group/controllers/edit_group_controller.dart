import 'dart:developer';

import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/group_models/group_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/user/user_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditGroupController extends GetxController {
  static EditGroupController get instance => Get.find();

  final apiService = ApiService();

  final isLoading = false.obs;
  final isLeadersLoading = false.obs;
  final isBatchesLoading = false.obs;
  final nameController = TextEditingController();

  final leaders = <UserModel>[].obs;
  final selectedLeaders = <UserModel>[].obs;

  final batches = <BatchesModel>[].obs;
  final selectedBatches = <BatchesModel>[].obs;

  GroupModel? group;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    if (Get.arguments != null && Get.arguments is GroupModel) {
      group = Get.arguments as GroupModel;
      nameController.text = group!.name;
    } else {
      AppSnackBar.show(
        title: "Error",
        message: "Group data is missing.",
        type: AppSnackBarType.error,
      );
      Get.back();
    }
    getLeaders();
    getBatches();
    isLoading.value = false;
  }

  void getLeaders() async {
    try {
      isLeadersLoading.value = true;
      final ResModel response = await apiService.get(ApiConstants.users());

      if (response.status == 200) {
        final usersList = response.data['users'] ?? response.data['data'] ?? [];
        for (var element in usersList) {
          final user = UserModel.fromJson(element);
          leaders.add(user);
          if (group != null &&
              group!.leaderIds!.any((l) => (l.id) == user.id)) {
            selectedLeaders.add(user);
          }
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLeadersLoading.value = false;
    }
  }

  void getBatches() async {
    try {
      isBatchesLoading.value = true;
      final ResModel response = await apiService.get(ApiConstants.batches());

      if (response.status == 200) {
        final batchList = response.data['batch'] ?? response.data['batches'] ?? response.data['data'] ?? [];
        for (var element in batchList) {
          final batch = BatchesModel.fromJson(element);
          batches.add(batch);
        }

        if (group != null) {
          // Preselect batches assigned to this group
          final ResModel groupBatchesResponse = await apiService.get(
            ApiConstants.batches(groupId: group!.id),
          );
          if (groupBatchesResponse.status == 200) {
            final groupBatchList = groupBatchesResponse.data['batch'] ?? groupBatchesResponse.data['batches'] ?? groupBatchesResponse.data['data'] ?? [];
            for (var element in groupBatchList) {
              final batch = BatchesModel.fromJson(element);
              if (!selectedBatches.any((b) => b.id == batch.id)) {
                selectedBatches.add(batch);
              }
            }
          }
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isBatchesLoading.value = false;
    }
  }

  void updateGroup() async {
    if (group == null) return;
    try {
      isLoading.value = true;
      final ResModel response = await apiService.put(
        ApiConstants.updateGroup,
        body: {
          'groupId': group!.id,
          'name': nameController.text,
          'leaders': selectedLeaders.map((e) => e.id).toList(),
          'batches': selectedBatches.map((e) => e.id).toList(),
        },
      );

      if (response.status == 200) {
        Get.back(result: true);
      }
    } catch (e) {
      log(e.toString());
      AppSnackBar.show(
        title: "Error",
        message: "Failed to update group.",
        type: AppSnackBarType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
