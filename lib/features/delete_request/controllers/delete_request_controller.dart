import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/delet_request_models/delete_requset_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteRequestController extends BaseController {
  static DeleteRequestController get instance => Get.find();
  final apiService = ApiService();

  final deleteRequests = <DeleteRequestModel>[].obs;
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
        if (response.status == 200 || response.status == 201) {
          final data = DeleteRequestListModel.fromJson(response.data);
          deleteRequests.assignAll(data.deleteRequests);
          total.value = data.totalData;
        }
      },
    );
  }

  void updateDeleteRequestStatus(String id, String status) {
    executeApi(
      apiCall: () async {
        final response = await apiService.put(
          ApiConstants.deleteRequestUpdate,
          body: {'id': id, 'status': status},
        );
        if (response.status == 200) {
          AppSnackBar.show(
            title: "Success",
            message: "Request status updated to $status",
          );
          fetchDeleteRequests();
        }
      },
      errorMessage: "Failed to update request status",
    );
  }

  void deleteDeleteRequest(String id) {
    executeApi(
      apiCall: () async {
        final response = await apiService.delete(
          "${ApiConstants.deleteRequestUpdate}/$id",
        );
        if (response.status == 200) {
          AppSnackBar.show(
            title: "Success",
            message: "Request deleted successfully",
          );
          fetchDeleteRequests();
        }
      },
      errorMessage: "Failed to delete request",
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

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
