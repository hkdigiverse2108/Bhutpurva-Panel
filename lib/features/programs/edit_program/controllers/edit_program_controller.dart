import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/features/programs/program_list/controllers/program_list_controller.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/program_models/program_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditProgramController extends BaseController {
  static EditProgramController get instance => Get.find();

  final apiService = ApiService();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  final isBatchesLoading = false.obs;
  final batches = <BatchDropdownModel>[].obs;
  final selectedBatch = Rxn<BatchDropdownModel>();
  final pragmaDetail = Rxn<Program>();

  String? id;

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments as String?;
    getBatches();
    if (id != null) {
      getProgram();
    }
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

  void getProgram() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.programDetails(id!),
        );
        if (response.status == 200) {
          pragmaDetail.value = Program.fromJson(response.data);
          nameController.text = pragmaDetail.value!.name;
          descriptionController.text = pragmaDetail.value!.description;
          dateController.text = DateFormat(
            'yyyy-MM-dd',
          ).format(pragmaDetail.value!.date);
          selectedBatch.value = BatchDropdownModel(
            id: pragmaDetail.value!.batchId.id,
            name: pragmaDetail.value!.batchId.name,
            isActive: pragmaDetail.value!.batchId.isActive,
          );
        }
      },
      errorMessage: "Failed to load program details",
    );
  }

  void updateProgram() {
    if (selectedBatch.value == null) {
      Get.snackbar("Error", "Please select a batch");
      return;
    }

    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.put(
          ApiConstants.updateProgram(),
          body: {
            'programId': id,
            'name': nameController.text,
            'description': descriptionController.text,
            'batchId': selectedBatch.value!.id,
            'date': dateController.text,
          },
        );
        if (response.status == 200) {
          if (Get.isRegistered<ProgramListController>()) {
            ProgramListController.instance.fetchPrograms();
          }
          Get.back();
        }
      },
      errorMessage: "Failed to update program",
    );
  }
}
