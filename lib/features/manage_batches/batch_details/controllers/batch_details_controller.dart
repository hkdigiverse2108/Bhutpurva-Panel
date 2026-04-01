import 'dart:async';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/shared/models/student_model/student_model.dart';
import 'package:bhutpurva_penal/shared/models/monitor_model/monitor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchDetailsController extends BaseController {
  static BatchDetailsController get instance => Get.find();

  final apiService = ApiService();

  Rxn<BatchesModel> batchDetail = Rxn<BatchesModel>();
  BatchesModel? get batch => batchDetail.value;

  RxList<StudentModel> devotees = RxList<StudentModel>();
  RxList<MonitorModel> monitors = RxList<MonitorModel>();
  RxList<StudentModel> allAlumni = RxList<StudentModel>();
  RxList<StudentModel> selectedAlumni = RxList<StudentModel>();

  late String id;

  var tab = 0.obs;

  var isBatchLoading = false.obs;
  var isDevoteeLoading = false.obs;
  var isMonitorLoading = false.obs;
  var isGroupLoading = false.obs;

  //
  int rowsPerPage = 10;
  int devoteePage = 1;
  int leaderPage = 1;
  var totalDevotees = 0.obs;
  var totalMonitors = 0.obs;

  final searchController = TextEditingController();
  var query = "".obs;
  var groupId = "".obs;

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is BatchesModel) {
      batchDetail.value = args;
      id = args.id;
    } else {
      id = args.id;
    }
    fetchBatchDetailsById(id);
    fetchMonitors();
    fetchUnassignedDevotees();
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
          final students = model.students
              .map((e) => StudentModel.fromJson(e.toJson()))
              .toList();
          devotees.assignAll(students);
          totalDevotees.value = students.length;
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

  void fetchMonitors() {
    executeApi(
      loadingState: isMonitorLoading,
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.monitors(batchFilter: id),
        );
        if (response.status == 200) {
          final dynamic payload = response.data;
          List<dynamic> dataList = [];

          if (payload is Map) {
            dataList =
                payload['monitors'] ??
                payload['users'] ??
                payload['data'] ??
                [];
          } else if (payload is List) {
            dataList = payload;
          }

          final monitorList = dataList
              .map((e) => MonitorModel.fromJson(e))
              .toList();
          monitors.assignAll(monitorList);

          if (payload is Map) {
            totalMonitors.value =
                payload['total'] ?? payload['totalCount'] ?? monitorList.length;
          } else {
            totalMonitors.value = monitorList.length;
          }
        }
      },
      showSnackbarOnError: false,
    );
  }

  void promoteToMonitor(String userId) {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.post(
          ApiConstants.createMonitor(),
          body: {'batchId': id, 'userId': userId},
        );
        if (response.status == 200) {
          fetchMonitors();
          fetchBatchDetailsById(id);
        }
      },
      errorMessage: "Failed to promote to monitor",
    );
  }

  void removeMonitor(String monitorId) {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.post(
          ApiConstants.removeMonitor(monitorId),
        );
        if (response.status == 200) {
          fetchMonitors();
          fetchBatchDetailsById(id);
        }
      },
      errorMessage: "Failed to demote monitor",
    );
  }

  void fetchUnassignedDevotees() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.unassignedDevotees(batchFilter: id),
        );
        if (response.status == 200) {
          final dynamic payload = response.data;
          List<dynamic> dataList = [];

          if (payload is Map) {
            dataList = payload['users'] ?? payload['data'] ?? [];
          } else if (payload is List) {
            dataList = payload;
          }

          allAlumni.assignAll(dataList.map((e) => StudentModel.fromJson(e)));
        }
      },
      showSnackbarOnError: false,
    );
  }

  void assignDevotees(String monitorId, List<String> devoteeIds) {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.post(
          ApiConstants.assignDevotee(),
          body: {'monitorId': monitorId, 'devoteeIds': devoteeIds},
        );
        if (response.status == 200) {
          fetchUnassignedDevotees();
          fetchMonitors();
          fetchBatchDetailsById(id);
        }
      },
      errorMessage: "Failed to assign devotee",
    );
  }

  void unassignDevotee(String monitorId, String devoteeId) {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.post(
          ApiConstants.unassignDevotee(),
          body: {
            'monitorId': monitorId,
            'devoteeIds': [devoteeId],
          },
        );
        if (response.status == 200) {
          fetchUnassignedDevotees();
          fetchMonitors();
          fetchBatchDetailsById(id);
        }
      },
      errorMessage: "Failed to remove devotee",
    );
  }
}
