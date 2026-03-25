import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/anubhuti_models/anubhuti_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnubhutiController extends BaseController {
  static AnubhutiController get instance => Get.find();
  final apiService = ApiService();

  var anubhuti = <AnubhutiModel>[].obs;

  int page = 1;
  int rowsPerPage = 10;
  int total = 0;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    super.onInit();
    _searchWorker = debounce(query, (_) {
      page = 1;
      fetchAnubhuti();
    }, time: const Duration(milliseconds: 400));
    fetchAnubhuti();
  }

  void fetchAnubhuti() {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.get(
          ApiConstants.anubhuti(
            page: page,
            limit: rowsPerPage,
            query: query.value,
          ),
        );
        if (res.status == 200) {
          final dataList = res.data['anubhutis'] ?? res.data['data'] ?? [];
          anubhuti.assignAll(
            (dataList as Iterable)
                .map<AnubhutiModel>((e) => AnubhutiModel.fromJson(e))
                .toList(),
          );
          total = res.data['totalData'] ?? 0;
        }
      },
      errorMessage: "Failed to fetch anubhuti",
    );
  }

  void onDeleteAnubhuti(String id) {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.delete(
          ApiConstants.deleteAnubhuti(id),
        );
        if (res.status == 200) {
          anubhuti.removeWhere((element) => element.id == id);
          total--;
        }
      },
      errorMessage: "Failed to delete anubhuti",
    );
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange(int value) {
    page = (value ~/ rowsPerPage) + 1;
    fetchAnubhuti();
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
    _searchWorker.dispose();
  }
}
