import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/shared/models/life_light_models/life_light_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LifeLightController extends GetxController {
  static LifeLightController get instance => Get.find();

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

      await Future.delayed(const Duration(seconds: 1));

      lifeLight.value = List.generate(
        10,
        (index) => LifeLightModel(
          id: '$index',
          name: 'User $index',
          email: 'User$index@gmail.com',
          phoneNumber: '1234567890',
          message: 'Message $index',
          status: 'Active',
          createdAt: DateTime.now().toString(),
        ),
      );
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
