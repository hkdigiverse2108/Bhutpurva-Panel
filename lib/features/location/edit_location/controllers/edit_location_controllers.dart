import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/features/location/location_list/controllers/location_controller.dart';
import 'package:bhutpurva_penal/shared/models/location_models/location_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditLocationController extends BaseController {
  final apiService = ApiService();

  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final statusController = TextEditingController();

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
  final selectedParentLocation = RxnString();
  final isActive = true.obs;

  final isFetching = false.obs;
  final isParentLocationLoading = false.obs;

  final String id;

  EditLocationController({required this.id});

  @override
  void onInit() {
    super.onInit();
    fetchLocation();
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
          for (var element in list) {
            final loc = LocationDropdownModel.fromJson(element);
            // Don't add current location to allLocations to avoid it being its own parent
            if (loc.id != id) {
              allLocations.add(loc);
            }
          }

          if (selectedType.value != null) {
            updateParentLocations(selectedType.value!);
          }
        }
      },
      errorMessage: "Could not get parent locations",
    );
  }

  void updateParentLocations(String type) {
    selectedType.value = type;
    final parentType = parentMap[type];

    if (parentType == null) {
      parentLocationList.clear();
      selectedParentLocation.value = null;
      return;
    }

    final normalizedParentType = parentType.toLowerCase();
    parentLocationList.assignAll(
      allLocations
          .where((e) => e.type?.toLowerCase() == normalizedParentType)
          .toList(),
    );

    // If the currently selected parent is not in the list, we don't necessarily clear it
    // immediately if allLocations is still loading or if we are in initial load
  }

  void fetchLocation() {
    executeApi(
      loadingState: isFetching,
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.locationDetails(id),
        );

        if (response.status == 200) {
          final data = response.data;
          nameController.text = data['name'] ?? '';
          isActive.value = data['isActive'] ?? true;

          final parentData = data['parentId'];
          String? parentId;
          if (parentData is Map) {
            parentId = parentData['_id'];
          } else {
            parentId = parentData?.toString();
          }
          selectedParentLocation.value = parentId;

          final type = data['type']?.toString() ?? '';
          if (type.isNotEmpty) {
            selectedType.value = locationTypes.firstWhere(
              (element) => element.toLowerCase() == type.toLowerCase(),
              orElse: () => locationTypes.first,
            );

            updateParentLocations(selectedType.value!);
            // Restore parent location because updateParentLocations might have cleared it if it wasn't loaded yet
            selectedParentLocation.value = parentId;
          }
        }
      },
      errorMessage: "Failed to load location details",
    );
  }

  void updateLocation() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.put(
          ApiConstants.updateLocation(),
          body: {
            'locationId': id,
            'name': nameController.text.trim(),
            'type': selectedType.value?.toLowerCase(),
            'parentId': selectedParentLocation.value,
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
      errorMessage: "Could not update location",
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
