import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/group_models/group_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/student_model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupDetailsController extends BaseController {
  static GroupDetailsController get instance => Get.find();

  final apiService = ApiService();
  GroupModel? group;

  var isBatchesLoading = false.obs;
  var isLeadersLoading = false.obs;

  var tab = 0.obs;

  var batches = <BatchesModel>[].obs;
  var leaders = <dynamic>[].obs;

  int rowsPerPage = 10;

  int batchesPage = 1;
  int leadersPage = 1;
  int totalBatches = 0;
  int totalLeaders = 0;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    super.onInit();
    group = Get.arguments as GroupModel?;

    _searchWorker = debounce(query, (_) {
      if (tab.value == 0) {
        batchesPage = 1;
        fetchBatches();
      } else {
        leadersPage = 1;
        fetchLeaders();
      }
    }, time: const Duration(milliseconds: 400));

    fetchBatches();
    if (group != null) {
      leaders.assignAll(group!.leaderIds);
      totalLeaders = group!.leaderIds.length;
    } else {
      fetchLeaders();
    }
  }

  void fetchBatches() {
    if (group == null) return;
    executeApi(
      loadingState: isBatchesLoading,
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.batches(
            page: batchesPage,
            limit: rowsPerPage,
            query: query.value,
            groupId: group!.id,
          ),
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
          totalBatches =
              response.data['totalData'] ?? response.data['total'] ?? 0;
        }
      },
      errorMessage: "Failed to fetch batches",
    );
  }

  void fetchLeaders() {
    // If we need to fetch leaders specifically for a group and they are not in GroupModel
    // For now we assume they are passed or we use a general fetch if needed.
    // If ApiConstants had a groupId for users, we'd use it here.
  }

  void onTabChange(int value) {
    tab.value = value;
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onBatchTap(BatchesModel batch) {
    Get.toNamed(AppPages.batchDetails, arguments: batch);
  }

  void onEditStudent(StudentModel student) {}

  void onPageChange(int value) {
    if (tab.value == 0) {
      batchesPage = (value ~/ rowsPerPage) + 1;
      fetchBatches();
    } else {
      leadersPage = (value ~/ rowsPerPage) + 1;
      fetchLeaders();
    }
  }
}
