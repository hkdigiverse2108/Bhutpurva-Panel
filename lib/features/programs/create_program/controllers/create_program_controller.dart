import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/features/programs/program_list/controllers/program_list_controller.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProgramController extends BaseController {
  static CreateProgramController get instance => Get.find();

  final apiService = ApiService();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  final isBatchesLoading = false.obs;
  final batches = <BatchDropdownModel>[].obs;
  final selectedBatch = Rxn<BatchDropdownModel>();

  @override
  void onInit() {
    super.onInit();
    getBatches();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.onClose();
  }

  void getBatches() {
    executeApi(
      loadingState: isBatchesLoading,
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.dropdownBatches(),
        );
        if (response.status == 200) {
          final list = response.data ?? [];
          batches.assignAll(
            (list as Iterable)
                .map((e) => BatchDropdownModel.fromJson(e))
                .toList(),
          );
        }
      },
      errorMessage: "Failed to load batches",
    );
  }

  void createProgram() {
    if (selectedBatch.value == null) {
      Get.snackbar("Error", "Please select a batch");
      return;
    }

    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.post(
          ApiConstants.createProgram(),
          body: {
            'name': nameController.text,
            'description': descriptionController.text,
            'batchId': selectedBatch.value!.id,
            'date': dateController.text,
          },
        );
        if (response.status == 200 || response.status == 201) {
          if (Get.isRegistered<ProgramListController>()) {
            ProgramListController.instance.fetchPrograms();
          }
          Get.back();
          _clearFields();
        }
      },
      errorMessage: "Failed to create program",
    );
  }

  void _clearFields() {
    nameController.clear();
    descriptionController.clear();
    dateController.clear();
    selectedBatch.value = null;
  }
}
