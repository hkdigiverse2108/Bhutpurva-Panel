import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/program_models/program_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgramListController extends BaseController {
  static ProgramListController get instance => Get.find();

  final apiService = ApiService();

  final programs = <Program>[].obs;

  int page = 1;
  int rowsPerPage = 10;
  int total = 0;

  final searchController = TextEditingController();
  final query = ''.obs;

  @override
  void onInit() {
    debounce(query, (_) {
      page = 1;
      fetchPrograms();
    }, time: const Duration(milliseconds: 500));

    fetchPrograms();
    super.onInit();
  }

  void fetchPrograms() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.programs(
            page: page,
            limit: rowsPerPage,
            query: query.value,
          ),
        );

        if (response.status == 200) {
          final programData = ProgramModel.fromJson(response.data);
          programs.assignAll(programData.programs);
          total = programData.totalData;
        }
      },
      errorMessage: "Failed to fetch programs",
    );
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange(int value) {
    page = (value ~/ rowsPerPage) + 1;
    fetchPrograms();
  }

  void onCreateProgram() {
    Get.toNamed(AppPages.createProgram);
  }

  void onEditProgram(Program program) {
    Get.toNamed(AppPages.editProgram, arguments: program.id);
  }

  void onProgramTap(Program program) {
    Get.toNamed(AppPages.programDetails, arguments: program.id);
  }

  // final isDeleting = false.obs;

  void onDeleteProgram(String id) {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.delete(
          ApiConstants.deleteProgram(id),
        );
        if (response.status == 200) {
          programs.removeWhere((element) => element.id == id);
          total--;
        }
      },
      // loadingState: isDeleting,
      errorMessage: "Failed to delete program",
    );
  }
}
