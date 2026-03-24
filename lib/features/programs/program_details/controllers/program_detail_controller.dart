import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/attendense_models/attendense_models.dart';
import 'package:bhutpurva_penal/shared/models/program_models/program_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgramDetailController extends BaseController {
  static ProgramDetailController get instance => Get.find();

  final apiService = ApiService();

  final searchController = TextEditingController();

  String? programId;

  final attendances = <AttendanceModel>[].obs;
  final program = <Program>[].obs;

  final RxInt total = 0.obs;
  final RxInt rowsPerPage = 10.obs;
  final RxInt currentPage = 1.obs;
  final RxString search = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Program) {
      programId = args.id;
      program.assignAll([args]);
    } else if (args is String) {
      programId = args;
    }
    fetchAttendance();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void fetchAttendance() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.attendances(
            page: currentPage.value,
            limit: rowsPerPage.value,
            query: search.value.isNotEmpty ? search.value : null,
          ),
        );
        if (response.status == 200) {
          final data = response.data;
          if (data is List) {
            attendances.assignAll(
              data.map((e) => AttendanceModel.fromJson(e)).toList(),
            );
          } else if (data is Map) {
            final list = data['data'] ?? data['attendances'] ?? [];
            attendances.assignAll(
              (list as List).map((e) => AttendanceModel.fromJson(e)).toList(),
            );
            total.value = data['totalData'] ?? data['total'] ?? 0;
          }
        }
      },
      errorMessage: 'Failed to fetch attendances',
    );
  }

  void onPageChange(int rowOffset) {
    currentPage.value = (rowOffset ~/ rowsPerPage.value) + 1;
    fetchAttendance();
  }

  void onSearchChanged(String query) {
    search.value = query;
    currentPage.value = 1;
    fetchAttendance();
  }

  void onUpdateAttendance(String id) {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.put(
          ApiConstants.updateAttendance(id),
        );
        if (response.status == 200) {
          fetchAttendance();
        }
      },
      errorMessage: 'Failed to update attendance',
    );
  }
}
