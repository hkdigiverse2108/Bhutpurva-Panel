import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/life_light_models/life_light_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LifeLightController extends BaseController {
  static LifeLightController get instance => Get.find();

  final apiService = ApiService();

  var lifeLight = <LifeLightModel>[].obs;

  int page = 0;
  int rowsPerPage = 10;
  int total = 0;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    super.onInit();
    _searchWorker = debounce(query, (_) {
      page = 0;
      fetchLifeLight();
    }, time: const Duration(milliseconds: 400));
    fetchLifeLight();
  }

  void fetchLifeLight() {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.get(
          ApiConstants.lifeLight(
            page: page,
            limit: rowsPerPage,
            query: query.value,
          ),
        );

        if (res.status == 200) {
          final dataList = res.data['lifeLight'] ?? res.data['data'] ?? [];
          lifeLight.assignAll(
            (dataList as List).map((e) => LifeLightModel.fromJson(e)).toList(),
          );
          total = res.data['totalData'] ?? res.data['total'] ?? 0;
        }
      },
      errorMessage: "Failed to fetch life light data",
    );
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange(int value) {
    page = value ~/ rowsPerPage;
    fetchLifeLight();
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
    _searchWorker.dispose();
  }
}
