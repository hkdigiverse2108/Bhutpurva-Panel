import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/feedback_models/feedback_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackController extends BaseController {
  static FeedbackController get instance => Get.find();

  var feedbacks = <FeedbackModel>[].obs;

  int page = 0;
  int rowsPerPage = 10;
  int total = 0;

  final searchController = TextEditingController();
  var query = ''.obs;

  late Worker _searchWorker;

  @override
  void onInit() {
    super.onInit();
    _searchWorker = debounce(query, (_) {
      page = 0;
      fetchFeedbacks();
    }, time: const Duration(milliseconds: 400));
    fetchFeedbacks();
  }

  void fetchFeedbacks() {
    executeApi(
      apiCall: () async {
        final ResModel response = await ApiService().get(
          ApiConstants.feedback(
            page: page + 1,
            limit: rowsPerPage,
            query: query.value,
          ),
        );
        if (response.status == 200) {
          final feedbackList =
              response.data['feedback'] ??
              response.data['feedbacks'] ??
              response.data['data'] ??
              [];
          feedbacks.assignAll(
            (feedbackList as Iterable)
                .map<FeedbackModel>((e) => FeedbackModel.fromJson(e))
                .toList(),
          );
          total = response.data['totalData'] ?? 0;
        }
      },
      errorMessage: "Failed to fetch feedbacks",
    );
  }
  
  void deleteFeedback(String id) {
    executeApi(
      apiCall: () async {
        // ... assuming there's a delete endpoint ...
        // final ResModel response = await ApiService().delete('${ApiConstants.deleteFeedback}/$id');
        // For now, let's just remove it locally as a placeholder for the logic
        feedbacks.removeWhere((f) => f.id == id);
        total--;
      },
      errorMessage: "Failed to delete feedback",
    );
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange(int value) {
    page = value ~/ rowsPerPage;
    fetchFeedbacks();
  }

  @override
  void onClose() {
    searchController.dispose();
    _searchWorker.dispose();
    super.onClose();
  }
}
