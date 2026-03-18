import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/student_model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchDetailsController extends BaseController {
  static BatchDetailsController get instance => Get.find();

  final apiService = ApiService();
  BatchesModel? batch;

  var isStudentsLoading = false.obs;
  var isMonitorsLoading = false.obs;

  var normalRoute = true.obs;

  var tab = 0.obs;

  var students = <StudentModel>[].obs;
  var monitors = <StudentModel>[].obs;
  var selectedStudent = <StudentModel>[].obs;

  int rowsPerPage = 10;

  int studentsPage = 1;
  int monitorsPage = 1;
  int totalStudents = 0;
  int totalMonitors = 0;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    super.onInit();
    batch = Get.arguments as BatchesModel?;
    normalRoute.value = false;
    _searchWorker = debounce(query, (_) {
      if (tab.value == 0) {
        studentsPage = 1;
        fetchStudents();
      } else {
        monitorsPage = 1;
        fetchMonitors();
      }
    }, time: const Duration(milliseconds: 400));

    fetchStudents();
    fetchMonitors();
  }

  void fetchStudents() {
    executeApi(
      loadingState: isStudentsLoading,
      apiCall: () async {
        // Placeholder for batch-specific students if endpoint exists
        // For now, keeping it as is but prepared for real integration
        await Future.delayed(const Duration(milliseconds: 500));
        students.clear();
        totalStudents = 0;
      },
    );
  }

  void fetchMonitors() {
    executeApi(
      loadingState: isMonitorsLoading,
      apiCall: () async {
        await Future.delayed(const Duration(milliseconds: 500));
        monitors.clear();
        totalMonitors = 0;
      },
    );
  }

  void onTabChange(int value) {
    tab.value = value;
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange(int value) {
    if (tab.value == 0) {
      studentsPage = (value ~/ rowsPerPage) + 1;
      fetchStudents();
    } else {
      monitorsPage = (value ~/ rowsPerPage) + 1;
      fetchMonitors();
    }
  }

  void removeSelected(StudentModel item) {
    selectedStudent.remove(item);
    selectedStudent.refresh();
  }

  void onEditStudent(StudentModel student) {}
}
