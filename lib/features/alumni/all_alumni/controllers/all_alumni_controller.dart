import 'dart:developer';

import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/student_model/student_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllAlumniController extends GetxController {
  static AllAlumniController get instance => Get.find();
  final apiService = ApiService();

  var isLoading = false.obs;
  var allAlumni = <StudentModel>[].obs;

  var ageFilter = ''.obs;
  // var ages = [
  //   'All',
  //   '18',
  //   '19',
  //   '20',
  //   '21',
  //   '22',
  //   '23',
  //   '24',
  //   '25',
  //   '26',
  //   '27',
  //   '28',
  //   '29',
  //   '30',
  // ].obs;

  var roleFilter = ''.obs;
  var batchFilter = ''.obs;
  var batches = <BatchesModel>[].obs;

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

      final ResModel res = await apiService.get(ApiConstants.alumni());
      if (res.status == 200) {
        allAlumni.assignAll(
          (res.data['users'] as List)
              .map((e) => StudentModel.fromJson(e))
              .toList(),
        );
        total = res.data['totalData'] ?? 0;
      }
    } catch (e) {
      log(e.toString());
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
