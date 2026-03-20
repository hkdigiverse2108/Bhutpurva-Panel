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
import 'dart:developer';

class BatchDetailsController extends BaseController {
  static BatchDetailsController get instance => Get.find();

  final apiService = ApiService();

  Rxn<BatchesModel> batchDetail = Rxn<BatchesModel>();
  BatchesModel? get batch => batchDetail.value;

  RxList<StudentModel> devotees = RxList<StudentModel>();
  RxList<StudentModel> leaders = RxList<StudentModel>();
  RxList<StudentModel> allAlumni = RxList<StudentModel>();
  RxList<StudentModel> selectedAlumni = RxList<StudentModel>();

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
    final args = Get.arguments;
    final id = Get.parameters['id'];

    if (args != null) {
      if (args is BatchesModel) {
        batchDetail.value = args;
        _initAndFetch();
      } else if (args is String) {
        fetchBatchDetailsById(args);
      }
    } else if (id != null) {
      fetchBatchDetailsById(id);
    }
  }

  void fetchBatchDetailsById(String id) {
    executeApi(
      loadingState: isBatchLoading,
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.batchDetails(id),
        );
        if (response.status == 200) {
          batchDetail.value = BatchesModel.fromJson(response.data);
          _initAndFetch();
        }
      },
      errorMessage: "Failed to load batch details",
    );
  }

  void _initAndFetch() {
    log("BatchDetailsController: Loading data for batch ${batch?.name}");
    fetchDevotees();
    fetchLeaders();
    fetchAllAlumni();
  }

  void fetchDevotees() {
    if (batch == null) return;
    executeApi(
      loadingState: isDevoteeLoading,
      apiCall: () async {
        final res = await apiService.get(
          ApiConstants.batchStudents(
            batch!.id,
            page: devoteePage,
            limit: rowsPerPage,
            query: query.value,
          ),
        );
        if (res.status == 200) {
          final data = res.data['students'] ?? res.data['data'] ?? [];
          devotees.assignAll(
            (data as Iterable).map((e) => StudentModel.fromJson(e)).toList(),
          );
          totalDevotees = res.data['totalData'] ?? res.data['total'] ?? 0;
        }
      },
    );
  }

  void fetchLeaders() {
    if (batch == null) return;
    executeApi(
      loadingState: isLeaderLoading,
      apiCall: () async {
        final res = await apiService.get(
          ApiConstants.batchLeaders(
            batch!.id,
            page: leaderPage,
            limit: rowsPerPage,
            query: query.value,
          ),
        );
        if (res.status == 200) {
          final data = res.data['leaders'] ?? res.data['data'] ?? [];
          leaders.assignAll(
            (data as Iterable).map((e) => StudentModel.fromJson(e)).toList(),
          );
          totalLeaders = res.data['totalData'] ?? res.data['total'] ?? 0;
        }
      },
    );
  }

  void onSearchChanged(String value) {
    query.value = value;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      devoteePage = 1;
      leaderPage = 1;
      fetchDevotees();
      fetchLeaders();
      fetchAllAlumni();
    });
  }

  void fetchAllAlumni() {
    executeApi(
      apiCall: () async {
        final res = await apiService.get(ApiConstants.batchStudents(batch!.id));
        if (res.status == 200) {
          final data = res.data['users'] ?? res.data['data'] ?? [];
          allAlumni.assignAll(
            (data as Iterable).map((e) => StudentModel.fromJson(e)).toList(),
          );
        }
      },
    );
  }

  void onPageChange(int value) {
    if (tab.value == 0) {
      devoteePage = (value ~/ rowsPerPage) + 1;
      fetchDevotees();
    } else {
      leaderPage = (value ~/ rowsPerPage) + 1;
      fetchLeaders();
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
}
