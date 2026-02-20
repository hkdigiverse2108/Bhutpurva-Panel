import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/image_const.dart';
import 'package:bhutpurva_penal/shared/models/student_model/student_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchDetailsController extends GetxController {
  static BatchDetailsController get instance => Get.find();

  var isStudentsLoading = false.obs;
  var isMonitorsLoading = false.obs;

  var normalRoute = true.obs;

  var tab = 0.obs;

  var students = <StudentModel>[].obs;
  var monitors = <StudentModel>[].obs;
  var selectedStudent = <StudentModel>[].obs;

  int rowsPerPage = 10;

  int studentsPage = 0;
  int monitorsPage = 0;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    super.onInit();
    normalRoute.value = false;
    _searchWorker = debounce(query, (_) {
      if (tab.value == 0) {
        studentsPage = 0;
        fetchStudents();
      } else {
        monitorsPage = 0;
        fetchMonitors();
      }
    }, time: const Duration(milliseconds: 400));

    fetchStudents();
    fetchMonitors();
  }

  void fetchStudents() async {
    try {
      isStudentsLoading.value = true;

      await Future.delayed(const Duration(seconds: 1));

      students.value = List.generate(
        20,
        (index) => StudentModel(
          id: (index + 1).toString(),
          name: 'Student $index ${query.value}',
          email: 'Student$index@gmail.com',
          phone: '1234567890',
          address: 'Address $index',
          image: ImageConst.logo,
          age: 20,
          profileStatus: 'Not Updated',
        ),
      );
    } catch (e) {
      AppSnackBar.show(
        title: 'Error',
        message: e.toString(),
        type: AppSnackBarType.error,
      );
    } finally {
      isStudentsLoading.value = false;
    }
  }

  void fetchMonitors() async {
    try {
      isMonitorsLoading.value = true;

      await Future.delayed(const Duration(seconds: 1));

      monitors.value = List.generate(
        20,
        (index) => StudentModel(
          id: (index + 1).toString(),
          name: 'Student $index ${query.value}',
          email: 'Student$index@gmail.com',
          phone: '1234567890',
          address: 'Address $index',
          image: ImageConst.logo,
          age: 20,
          profileStatus: 'Not Updated',
        ),
      );
    } catch (e) {
      AppSnackBar.show(
        title: 'Error',
        message: e.toString(),
        type: AppSnackBarType.error,
      );
    } finally {
      isMonitorsLoading.value = false;
    }
  }

  void onTabChange(int value) {
    tab.value = value;
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange() {}

  void removeSelected(StudentModel item) {
    selectedStudent.remove(item);
    selectedStudent.refresh();
  }

  void onEditStudent(StudentModel student) {}
}
