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

  final locationTypes = ["Country", "State", "District", "City"].obs;

  final allLocations = <LocationDropdownModel>[].obs;

  final parentLocationList = <LocationDropdownModel>[].obs;

  final parentMap = {
    "City": "District",
    "District": "State",
    "State": "Country",
    "Country": null,
  };

  final selectedType = RxnString();
  final parentLocation = RxnString();
  final isActive = true.obs;

  final isParentLocationLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getParentLocation();
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

          allLocations.clear();
          parentLocationList.clear();

          for (var element in list) {
            allLocations.add(LocationDropdownModel.fromJson(element));
          }
        }
      },
      errorMessage: "Could not get parent location",
    );
  }

  void updateParentLocations(String type) {
    selectedType.value = type;

    final parentType = parentMap[type];

    parentLocation.value = null;

    if (parentType == null) {
      parentLocationList.clear();
      return;
    }

    final normalizedParentType = parentType.toLowerCase();

    parentLocationList.assignAll(
      allLocations
          .where((e) => e.type?.toLowerCase() == normalizedParentType)
          .toList(),
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
            'parentId': parentLocation.value,
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
    super.onClose();
  }
}
