import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/branch_models/branch_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchesController extends BaseController {
  final apiService = ApiService();

  var branches = <BranchModel>[].obs;

  int page = 1;
  int limit = 10;
  int total = 0;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    super.onInit();
    fetchBranches();
    _searchWorker = debounce(query, (_) {
      page = 1;
      fetchBranches();
    }, time: const Duration(milliseconds: 400));
  }

  void fetchBranches() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.branches(page: page, limit: limit, query: query.value),
        );
        if (response.status == 200) {
          final dataList =
              response.data['branches'] ?? response.data['data'] ?? [];
          branches.assignAll(
            (dataList as Iterable)
                .map<BranchModel>((e) => BranchModel.fromJson(e))
                .toList(),
          );
          total = response.data['totalData'] ?? response.data['total'] ?? 0;
        }
      },
      errorMessage: "Failed to fetch branches data",
    );
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChanged(int value) {
    page = (value ~/ limit) + 1;
    fetchBranches();
  }

  void deleteBranch(String id) {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.delete(
          ApiConstants.deleteBranch(id),
          body: {"id": id},
        );
        if (res.status == 200) {
          branches.removeWhere((element) => element.id == id);
          total--;
          Get.snackbar("Success", "Branch deleted successfully");
        }
      },
      errorMessage: "Failed to delete branch",
    );
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
    _searchWorker.dispose();
  }
}
