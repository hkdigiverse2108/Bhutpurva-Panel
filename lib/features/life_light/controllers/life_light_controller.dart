import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/life_light_models/life_light_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LifeLightController extends GetxController {
  static LifeLightController get instance => Get.find();

  final apiService = ApiService();

  var isLoading = true.obs;
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

  void fetchLifeLight() async {
    try {
      isLoading.value = true;
      final ResModel res = await apiService.get(ApiConstants.lifeLight());
      if (res.status == 200) {
        lifeLight.assignAll(
          (res.data['lifeLight'] as List)
              .map((e) => LifeLightModel.fromJson(e))
              .toList(),
        );
        total = res.data['total'];
      }
    } catch (e) {
      AppSnackBar.show(
        title: 'Error',
        message: e.toString(),
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
    fetchLifeLight();
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
    _searchWorker.dispose();
  }
}
