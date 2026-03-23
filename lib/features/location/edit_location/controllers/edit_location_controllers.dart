import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/features/location/location_list/controllers/location_controller.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditLocationController extends BaseController {
  final apiService = ApiService();

  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final statusController = TextEditingController();

  final locationTypes = ["District", "State", "Country", "City"].obs;
  final selectedType = RxnString();
  final isActive = true.obs;

  final isFetching = false.obs;

  final String id;

  EditLocationController({required this.id});

  @override
  void onInit() {
    super.onInit();
    fetchLocation();
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

          final type = data['type']?.toString() ?? '';
          if (type.isNotEmpty) {
            // Find the matching type in the list (ignoring case)
            selectedType.value = locationTypes.firstWhere(
              (element) => element.toLowerCase() == type.toLowerCase(),
              orElse: () => locationTypes.first,
            );
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
