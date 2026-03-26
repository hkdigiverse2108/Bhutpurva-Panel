import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/survey_models/survey_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveyListController extends BaseController {
  static SurveyListController get instance => Get.find();
  final apiService = ApiService();

  var surveys = <SurveyModel>[].obs;

  int page = 1;
  int rowsPerPage = 10;
  int total = 0;

  final searchController = TextEditingController();
  var query = ''.obs;
  var scopeFilter = RxnString();

  late Worker _searchWorker;

  @override
  void onInit() {
    super.onInit();
    _searchWorker = debounce(query, (_) {
      page = 1;
      fetchSurveys();
    }, time: const Duration(milliseconds: 500));

    fetchSurveys();
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onScopeFilterChanged(String? scope) {
    scopeFilter.value = scope;
    page = 1;
    fetchSurveys();
  }

  void fetchSurveys() {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.get(
          ApiConstants.surveys(
            page: page,
            limit: rowsPerPage,
            query: query.value.isNotEmpty ? query.value : null,
            scope: scopeFilter.value,
          ),
        );

        if (res.status == 200) {
          dynamic rawData = res.data;
          List dataList = [];
          
          if (rawData is List) {
            dataList = rawData;
          } else if (rawData is Map) {
            dataList = rawData['surveys'] ?? rawData['survey'] ?? rawData['data'] ?? [];
          }

          surveys.value = dataList.map((e) => SurveyModel.fromJson(e)).toList();
          
          if (rawData is Map) {
            total = rawData['totalData'] ?? rawData['total'] ?? dataList.length;
          } else {
            total = dataList.length;
          }
        } else {
          surveys.clear();
          total = 0;
        }
      },
      errorMessage: "Failed to fetch surveys",
    );
  }

  void onPageChange(int newPage) {
    page = newPage;
    fetchSurveys();
  }

  void deleteSurvey(String id) {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.delete(
          ApiConstants.deleteSurvey(id),
          body: {"id": id},
        );
        if (res.status == 200) {
          surveys.removeWhere((element) => element.id == id);
          total--;
          AppSnackBar.show(
            title: "Success",
            message: "Survey deleted successfully",
            type: AppSnackBarType.success,
          );
        } else {
          AppSnackBar.show(
            title: "Error",
            message: res.message ?? "Failed to delete survey",
            type: AppSnackBarType.error,
          );
        }
      },
      errorMessage: "Failed to delete survey",
    );
  }

  @override
  void onClose() {
    _searchWorker.dispose();
    searchController.dispose();
    super.onClose();
  }
}
