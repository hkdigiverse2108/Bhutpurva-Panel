import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/group_models/group_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditGroupController extends BaseController {
  static EditGroupController get instance => Get.find();

  final apiService = ApiService();

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
    if (Get.arguments != null && Get.arguments is GroupModel) {
      group = Get.arguments as GroupModel;
      nameController.text = group!.name;
    } else {
      Get.back();
    }
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
          final usersList = response.data['data'] ?? [];
          final allLeaders = (usersList as Iterable)
              .map<UserModel>((e) => UserModel.fromJson(e))
              .toList();

          leaders.assignAll(allLeaders);

          if (group != null) {
            selectedLeaders.assignAll(
              allLeaders
                  .where((u) => group!.leaderIds.any((l) => l.id == u.id))
                  .toList(),
            );
          }
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
            (batchList as Iterable)
                .map<BatchesModel>((e) => BatchesModel.fromJson(e))
                .toList(),
          );

          if (group != null) {
            final ResModel groupBatchesResponse = await apiService.get(
              ApiConstants.batches(groupId: group!.id),
            );
            if (groupBatchesResponse.status == 200) {
              final groupBatchList =
                  groupBatchesResponse.data['batch'] ??
                  groupBatchesResponse.data['batches'] ??
                  groupBatchesResponse.data['data'] ??
                  [];
              selectedBatches.assignAll(
                (groupBatchList as Iterable)
                    .map<BatchesModel>((e) => BatchesModel.fromJson(e))
                    .toList(),
              );
            }
          }
        }
      },
      errorMessage: "Failed to load batches",
    );
  }

  void updateGroup() {
    if (group == null) return;
    executeApi(
      apiCall: () async {
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
      },
      errorMessage: "Failed to update group",
    );
  }
}
