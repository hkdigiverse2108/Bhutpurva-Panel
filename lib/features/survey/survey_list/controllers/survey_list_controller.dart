import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/group_models/group_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/survey_models/survey_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveyListController extends BaseController {
  static SurveyListController get instance => Get.find();
  final apiService = ApiService();

  var surveys = <SurveyModel>[].obs;
  var batches = <BatchesModel>[].obs;
  var groups = <GroupDropdownModel>[].obs;

  // Stable pre-mapped items — prevents identity churn in dropdown widgets
  var groupDropdownItems = <AdminDropdownItem<String>>[].obs;
  var batchDropdownItems = <AdminDropdownItem<String>>[].obs;

  var page = 1.obs;
  var rowsPerPage = 10.obs;
  var total = 0.obs;

  final searchController = TextEditingController();
  var query = ''.obs;
  var scopeFilter = RxnString();
  var groupIdFilter = RxnString();
  var batchIdFilter = RxnString();
  var showFilter = false.obs;

  final groupAndBatchLoading = false.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    super.onInit();
    _searchWorker = debounce(query, (_) {
      page.value = 1;
      fetchSurveys();
    }, time: const Duration(milliseconds: 500));

    fetchSurveys();
    fetchGroupsAndBatches();
  }

  void fetchGroupsAndBatches() {
    executeApi(
      loadingState: groupAndBatchLoading,
      apiCall: () async {
        final groupRes = await apiService.get(ApiConstants.groups(limit: 1000));
        if (groupRes.status == 200) {
          final data = groupRes.data;
          final List dataList =
              data['groups'] ?? data['group'] ?? data['data'] ?? [];
          groups.assignAll(
            dataList.map((e) => GroupDropdownModel.fromJson(e)).toList(),
          );
          groupDropdownItems.assignAll(
            groups.map((e) => AdminDropdownItem(value: e.id, label: e.name)).toList(),
          );
        }

        final batchRes = await apiService.get(
          ApiConstants.batches(limit: 1000),
        );
        if (batchRes.status == 200) {
          final data = batchRes.data;
          final List dataList =
              data['batches'] ?? data['batch'] ?? data['data'] ?? [];
          batches.assignAll(
            dataList.map((e) => BatchesModel.fromJson(e)).toList(),
          );
          batchDropdownItems.assignAll(
            batches.map((e) => AdminDropdownItem(value: e.id, label: e.name)).toList(),
          );
        }
      },
    );
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onScopeFilterChanged(String? scope) {
    scopeFilter.value = scope;
    page.value = 1;
    fetchSurveys();
  }

  void onGroupFilterChanged(String? groupId) {
    groupIdFilter.value = groupId;
    page.value = 1;
    fetchSurveys();
  }

  void onBatchFilterChanged(String? batchId) {
    batchIdFilter.value = batchId;
    page.value = 1;
    fetchSurveys();
  }

  void resetFilters() {
    scopeFilter.value = null;
    groupIdFilter.value = null;
    batchIdFilter.value = null;
    query.value = '';
    searchController.clear();
    page.value = 1;
    fetchSurveys();
  }

  void fetchSurveys() {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.get(
          ApiConstants.surveys(
            page: page.value,
            limit: rowsPerPage.value,
            query: query.value.isNotEmpty ? query.value : null,
            scope: scopeFilter.value,
            groupFilter: groupIdFilter.value,
            batchFilter: batchIdFilter.value,
          ),
        );

        if (res.status == 200) {
          dynamic rawData = res.data;
          List dataList = [];

          if (rawData is List) {
            dataList = rawData;
          } else if (rawData is Map) {
            dataList =
                rawData['surveys'] ??
                rawData['survey'] ??
                rawData['data'] ??
                [];
          }

          surveys.assignAll(
            dataList.map((e) => SurveyModel.fromJson(e)).toList(),
          );

          if (rawData is Map) {
            total.value =
                rawData['totalData'] ?? rawData['total'] ?? dataList.length;
          } else {
            total.value = dataList.length;
          }
        } else {
          surveys.clear();
          total.value = 0;
        }
      },
      errorMessage: "Failed to fetch surveys",
    );
  }

  void onPageChange(int newPage) {
    page.value = newPage;
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
          total.value--;
          AppSnackBar.show(
            title: "Success",
            message: "Survey deleted successfully",
          );
        } else {
          AppSnackBar.show(
            title: "Error",
            message: res.message ?? "Failed to delete survey",
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
