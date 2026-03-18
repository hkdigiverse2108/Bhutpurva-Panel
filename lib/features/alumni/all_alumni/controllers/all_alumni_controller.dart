import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/student_model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllAlumniController extends BaseController {
  static AllAlumniController get instance => Get.find();
  final apiService = ApiService();

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

  int page = 1;
  int rowsPerPage = 10;
  int total = 0;

  var showFilter = false.obs;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    _searchWorker = debounce(query, (_) {
      page = 1;
      fetchAlumni();
    }, time: const Duration(milliseconds: 400));

    fetchAlumni();
    super.onInit();
  }

  void fetchAlumni() {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.get(ApiConstants.alumni(
        page: page,
        limit: rowsPerPage,
        query: query.value,
      ));
      if (res.status == 200) {
        final usersList = res.data['users'] ?? res.data['data'] ?? [];
          allAlumni.assignAll(
            (usersList as Iterable)
                .map<StudentModel>((e) => StudentModel.fromJson(e))
                .toList(),
          );
          total = res.data['totalData'] ?? res.data['total'] ?? 0;
        }
      },
      errorMessage: "Failed to fetch alumni",
    );
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange(int value) {
    page = (value ~/ rowsPerPage) + 1;
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
