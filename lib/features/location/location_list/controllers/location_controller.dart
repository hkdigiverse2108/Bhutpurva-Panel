import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/location_models/location_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationController extends BaseController {
  final apiService = ApiService();

  var locations = <LocationModel>[].obs;

  var typeFilter = ''.obs;
  var statusFilter = ''.obs;
  var showFilter = false.obs;

  var locationTypes = <String>['City', 'District', 'State', 'Country'].obs;
  var statusTypes = <String>['Active', 'Inactive'].obs;

  int page = 1;
  int rowsPerPage = 10;
  int total = 0;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    super.onInit();
    _searchWorker = debounce(query, (_) {
      page = 1;
      fetchLocations();
    }, time: const Duration(milliseconds: 400));
    fetchLocations();
  }

  void fetchLocations() {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.get(
          ApiConstants.locations(
            page: page,
            limit: rowsPerPage,
            query: query.value,
          ),
        );

        if (res.status == 200) {
          final dataList = res.data['locations'] ?? res.data['data'] ?? [];
          locations.assignAll(
            (dataList as Iterable)
                .map<LocationModel>((e) => LocationModel.fromJson(e))
                .toList(),
          );
          total = res.data['totalData'] ?? res.data['total'] ?? 0;
        }
      },
      errorMessage: "Failed to fetch locations data",
    );
  }

  void onCreateLocation() {
    Get.toNamed(AppPages.createLocation);
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange(int value) {
    page = (value ~/ rowsPerPage) + 1;
    fetchLocations();
  }

  void deleteLocation(String id) {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.delete(
          ApiConstants.deleteLocation(id),
          body: {"locationId": id},
        );
        if (res.status == 200) {
          locations.removeWhere((element) => element.id == id);
          total--;
        }
      },
      errorMessage: "Failed to delete location data",
    );
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
    _searchWorker.dispose();
  }
}
