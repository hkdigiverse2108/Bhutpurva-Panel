import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/shared/models/anubhuti_models/anubhuti_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnubhutiController extends GetxController {
  static AnubhutiController get instance => Get.find();

  var isLoading = true.obs;
  var anubhuti = <AnubhutiModel>[].obs;

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
      fetchAnubhuti();
    }, time: const Duration(milliseconds: 400));
    fetchAnubhuti();
  }

  void fetchAnubhuti() async {
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 1));

      anubhuti.value = List.generate(
        10,
        (index) => AnubhutiModel(
          id: '$index',
          name: 'User $index',
          email: 'User$index@gmail.com',
          phoneNumber: '1234567890',
          message: 'Message $index',
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
    fetchAnubhuti();
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
    _searchWorker.dispose();
  }
}
