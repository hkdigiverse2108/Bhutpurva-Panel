import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/delet_request_models/delete_requset_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteRequestController extends BaseController {
  static DeleteRequestController get instance => Get.find();
  final apiService = ApiService();
  final deleteRequest = <DeleteRequestModel>[].obs;
  final total = 0.obs;
  final page = 1.obs;
  final rowsPerPage = 10.obs;
  final searchController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    fetchDeleteRequests();
  }

  void fetchDeleteRequests() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.deleteRequest,
        );
        deleteRequest.assignAll(response.data);
        total.value = DeleteRequestModel.fromJson(response.data).totalData;
      },
    );
  }

  void updateDeleteRequest(String id, String status) {
    executeApi(
      apiCall: () async {
        await apiService.put(
          ApiConstants.deleteRequestUpdate,
          body: {'id': id, 'status': status},
        );
        fetchDeleteRequests();
      },
    );
  }

  void deleteDeleteRequest(String id) {
    executeApi(
      apiCall: () async {
        await apiService.delete(ApiConstants.deleteRequestUpdate);
        fetchDeleteRequests();
      },
    );
  }

  void onPageChange(int newPage) {
    page.value = newPage;
    fetchDeleteRequests();
  }

  void onSearchChanged(String query) {
    page.value = 1;
    fetchDeleteRequests();
  }
}
