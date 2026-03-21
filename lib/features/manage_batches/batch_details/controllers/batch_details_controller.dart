import 'dart:async';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/shared/models/student_model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchDetailsController extends BaseController {
  static BatchDetailsController get instance => Get.find();

  final apiService = ApiService();

  Rxn<BatchesModel> batchDetail = Rxn<BatchesModel>();
  BatchesModel? get batch => batchDetail.value;

  RxList<StudentModel> devotees = RxList<StudentModel>();
  RxList<StudentModel> monitors = RxList<StudentModel>();
  RxList<StudentModel> allAlumni = RxList<StudentModel>();
  RxList<StudentModel> selectedAlumni = RxList<StudentModel>();

  late String id;

  var tab = 0.obs;

  var isBatchLoading = false.obs;
  var isDevoteeLoading = false.obs;
  var isLeaderLoading = false.obs;
  var isGroupLoading = false.obs;

  //
  int rowsPerPage = 10;
  int devoteePage = 1;
  int leaderPage = 1;
  int totalDevotees = 0;
  int totalLeaders = 0;

  final searchController = TextEditingController();
  var query = "".obs;
  var groupId = "".obs;

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    batchDetail.value = Get.arguments;
    id = batchDetail.value!.id;
    fetchBatchDetailsById(id);
    // fetchAllAlumni();
  }

  void fetchBatchDetailsById(String id) {
    executeApi(
      loadingState: isBatchLoading,
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.batchDetails(id),
        );
        if (response.status == 200) {
          final model = BatchesModel.fromJson(response.data);
          batchDetail.value = model;

          // Populate lists
          devotees.assignAll(
            model.students.map((e) => StudentModel.fromJson(e.toJson())),
          );

          if (model.monitorIds.isNotEmpty && model.monitorIds.first is Map) {
            monitors.assignAll(
              model.monitorIds.map((e) => StudentModel.fromJson(e)),
            );
          }
        }
      },
      errorMessage: "Failed to load batch details",
    );
  }

  void deleteBatch(String batchId) {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.delete(
          ApiConstants.deleteBatch(batchId),
        );
        if (response.status == 200) {
          batchDetail.value = null;
          batchDetail.refresh();
        }
      },
      errorMessage: "Failed to delete batch",
    );
  }

  void onSearchChanged(String value) {
    query.value = value;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      devoteePage = 1;
      leaderPage = 1;
    });
  }

  void onPageChange(int value) {
    if (tab.value == 0) {
      devoteePage = (value ~/ rowsPerPage) + 1;
    }
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

  void fetchAllAlumni() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.alumni(limit: 100),
        );
        if (response.status == 200) {
          final List<dynamic> data =
              response.data['users'] ?? response.data['data'] ?? [];
          allAlumni.assignAll(data.map((e) => StudentModel.fromJson(e)));
        }
      },
      showSnackbarOnError: false,
    );
  }
}
