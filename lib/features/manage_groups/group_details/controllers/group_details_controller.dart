import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/image_const.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/student_model/student_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupDetailsController extends GetxController {
  static GroupDetailsController get instance => Get.find();

  var isBatchesLoading = false.obs;
  var isLeadersLoading = false.obs;

  var tab = 0.obs;

  var batches = <BatchesModel>[].obs;
  var leaders = <StudentModel>[].obs;

  int rowsPerPage = 10;

  int batchesPage = 0;
  int leadersPage = 0;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    super.onInit();
    _searchWorker = debounce(query, (_) {
      if (tab.value == 0) {
        batchesPage = 0;
        fetchBatches();
      } else {
        leadersPage = 0;
        fetchLeaders();
      }
    }, time: const Duration(milliseconds: 400));

    fetchBatches();
    fetchLeaders();
  }

  void fetchBatches() async {
    try {
      isBatchesLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));

      batches.value = List.generate(
        10,
        (index) => BatchesModel(
          id: index.toString(),
          name: 'Batch $index ${query.value}',
          monitorIds: [],
          isActive: true,
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      AppSnackBar.show(
        title: 'Error',
        message: e.toString(),
        type: AppSnackBarType.error,
      );
    } finally {
      isBatchesLoading.value = false;
    }
  }

  void fetchLeaders() async {
    try {
      isLeadersLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));

      leaders.value = List.generate(
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
      isLeadersLoading.value = false;
    }
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

  void onPageChange() {}
}
