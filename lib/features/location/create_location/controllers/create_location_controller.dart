import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/features/location/location_list/controllers/location_controller.dart';
import 'package:bhutpurva_penal/shared/models/location_models/location_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateLocationController extends BaseController {
  final apiService = ApiService();

  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final statusController = TextEditingController();

  final locationTypes = ["District", "State", "Country", "City"].obs;

  final parentLocation = RxnString();
  final selectedType = RxnString();
  final isActive = true.obs;

  final isParentLocationLoading = false.obs;

  final parentLocationList = <LocationDropdownModel>[].obs;

  @override
  void onInit() {
    getParentLocation();
    super.onInit();
  }

  void getParentLocation() {
    executeApi(
      loadingState: isParentLocationLoading,
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.locationsDropdown(status: "Active"),
        );

        if (response.status == 200 || response.status == 201) {
          final list = response.data as List? ?? [];
          for (var element in list) {
            parentLocationList.add(LocationDropdownModel.fromJson(element));
          }
        }
      },
      errorMessage: "Could not get parent location",
    );
  }

  void createLocation() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.post(
          ApiConstants.createLocation(),
          body: {
            'name': nameController.text.trim(),
            'type': selectedType.value?.toLowerCase(),
            'isActive': isActive.value,
          },
        );

        if (response.status == 200 || response.status == 201) {
          if (Get.isRegistered<LocationController>()) {
            Get.find<LocationController>().fetchLocations();
          }
          Get.back();
        }
      },
      errorMessage: "Could not create location",
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    typeController.dispose();
    statusController.dispose();
    super.onClose();
  }
}
