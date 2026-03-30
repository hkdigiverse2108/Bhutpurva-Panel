import 'dart:async';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/group_models/group_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

class GroupDetailsController extends BaseController {
  static GroupDetailsController get instance => Get.find();

  final apiService = ApiService();

  Rxn<GroupModel> groupDetail = Rxn<GroupModel>();
  GroupModel? get group => groupDetail.value;

  var tab = 0.obs;

  var isGroupLoading = false.obs;
  //
  int rowsPerPage = 10;
  int batchesPage = 1;
  int leadersPage = 1;

  final searchController = TextEditingController();
  var query = "".obs;
  var groupId = "".obs;

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    final id = Get.parameters['id'];

    if (args != null && args is GroupModel) {
      groupDetail.value = args;
      _initAndFetch();
    } else if (id != null) {
      fetchGroupDetails(id);
    }
  }

  void fetchGroupDetails(String id) {
    executeApi(
      loadingState: isGroupLoading,
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.groupDetails(id),
        );
        if (response.status == 200) {
          groupDetail.value = GroupModel.fromJson(response.data);
          _initAndFetch();
        }
      },
      errorMessage: "Failed to load group details",
    );
  }

  void deleteGroup() {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.delete(
          ApiConstants.deleteGroup(group?.id ?? ""),
          body: {"id": group?.id},
        );
        if (res.status == 200) {
          groupDetail.value?.batches.removeWhere(
            (element) => element.id == group?.id,
          );
          groupDetail.refresh();
        }
      },
      errorMessage: "Failed to delete group",
    );
  }

  void _initAndFetch() {
    log("GroupDetailsController: Loading data for group ${group?.name}");
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  @override
  void onClose() {
    _debounce?.cancel();
    searchController.dispose();
    super.onClose();
  }

  void onAddDevoteeTap() {
    Get.toNamed(AppPages.allAlumni);
  }

  void onAddLeaderTap() {
    Get.toNamed(AppPages.allAlumni);
  }

  void onTabChanged(int value) {
    tab.value = value;
  }

  void onEditBatchTap(dynamic batch) {
    Get.toNamed(AppPages.editBatch, arguments: batch.id);
  }

  void onEditStudent(dynamic student) {
    Get.toNamed(AppPages.editAlumni, arguments: student.id);
  }
}
