import 'dart:developer';

import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchListController extends GetxController {
  static BatchListController get instance => Get.find();

  var batches = <BatchesModel>[].obs;
  var isLoading = false.obs;

  int page = 0;
  int rowsPerPage = 10;
  int total = 0;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    _searchWorker = debounce(query, (_) {
      page = 0;
      fetchBatches();
    }, time: const Duration(milliseconds: 400));

    fetchBatches();

    super.onInit();
  }

  void fetchBatches() async {
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 1));

      batches.value = List.generate(
        10,
        (index) => BatchesModel(
          id: index.toString(),
          name: 'Batch $index ${query.value}',
          monitorIds: [],
          isActive: true,
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange(int value) {
    page = value ~/ rowsPerPage;
    fetchBatches();
  }

  void onCreateBatch() {
    Get.toNamed(AppPages.createBatch);
  }

  void onEditBatch(BatchesModel batch) {
    Get.toNamed(AppPages.editBatch, arguments: batch);
  }
}
