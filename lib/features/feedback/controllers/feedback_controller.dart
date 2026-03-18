import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/shared/models/feedback_models/feedback_model.dart';
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
        await Future.delayed(const Duration(seconds: 1));

        feedbacks.assignAll(List.generate(
          10,
          (index) => FeedbackModel(
            id: index,
            name: "Feedback $index",
            email: "feedback$index@example.com",
            feedback: "Feedback $index",
            createdAt: DateTime.now().toString(),
          ),
        ));
      },
      errorMessage: "Failed to fetch feedbacks",
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
