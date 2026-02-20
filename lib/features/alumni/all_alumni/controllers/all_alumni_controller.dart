import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/image_const.dart';
import 'package:bhutpurva_penal/shared/models/student_model/student_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllAlumniController extends GetxController {
  static AllAlumniController get instance => Get.find();

  var isLoading = false.obs;
  var allAlumni = <StudentModel>[].obs;

  var ageFilter = ''.obs;
  var ages = [
    'All',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
  ].obs;

  var roleFilter = ''.obs;
  var roles = ['All', 'Members', 'Monitors', 'Leaders'].obs;

  int page = 0;
  int rowsPerPage = 10;
  int total = 0;

  var showFilter = false.obs;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    _searchWorker = debounce(query, (_) {
      page = 0;
      fetchAlumni();
    }, time: const Duration(milliseconds: 400));

    fetchAlumni();
    super.onInit();
  }

  void fetchAlumni() async {
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 1));

      allAlumni.value = List.generate(
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
        title: "Error",
        message: "Failed to fetch alumni",
        type: AppSnackBarType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange(int value) {
    page = value ~/ rowsPerPage;
    fetchAlumni();
  }

  void onEditStudent(StudentModel student) {
    Get.toNamed(AppPages.editAlumni, arguments: student);
  }

  void onAgeChanged(String value) {
    ageFilter.value = value;
    fetchAlumni();
  }

  void onRoleChanged(String value) {
    roleFilter.value = value;
    fetchAlumni();
  }
}
