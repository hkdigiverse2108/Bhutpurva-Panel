import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchListController extends BaseController {
  static BatchListController get instance => Get.find();

  final apiService = ApiService();

  var batches = <BatchesModel>[].obs;

  int page = 1;
  int rowsPerPage = 10;
  int total = 0;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    _searchWorker = debounce(query, (_) {
      page = 1;
      fetchBatches();
    }, time: const Duration(milliseconds: 400));

    fetchBatches();

    super.onInit();
  }

  void fetchBatches() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.batches(
            page: page,
            limit: rowsPerPage,
            query: query.value,
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
          total = response.data['totalData'] ?? response.data['total'] ?? 0;
        }
      },
      errorMessage: "Failed to fetch batches",
    );
  }

  void deleteBatch(String batchId) {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.delete(
          ApiConstants.deleteBatch(batchId),
        );
        if (response.status == 200) {
          batches.removeWhere((element) => element.id == batchId);
          batches.refresh();
        }
      },
      errorMessage: "Failed to delete batch",
    );
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange(int value) {
    page = (value ~/ rowsPerPage) + 1;
    fetchBatches();
  }

  void onCreateBatch() {
    Get.toNamed(AppPages.createBatch);
  }

  void onEditBatch(String batchId) {
    Get.toNamed(AppPages.editBatch, arguments: batchId);
  }

  void onBatchTap(BatchesModel batch) {
    Get.toNamed(AppPages.batchDetails, arguments: batch);
  }
}
