import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/shared/models/feedback_models/feedback_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  static FeedbackController get instance => Get.find();

  var feedbacks = <FeedbackModel>[].obs;
  var isLoading = true.obs;

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

  void fetchFeedbacks() async {
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 1));

      feedbacks.value = List.generate(
        10,
        (index) => FeedbackModel(
          id: index,
          name: "Feedback $index",
          email: "feedback$index@example.com",
          feedback: "Feedback $index",
          createdAt: DateTime.now().toString(),
        ),
      );
    } catch (e) {
      AppSnackBar.show(
        title: 'Error',
        message: e.toString(),
        type: AppSnackBarType.error,
      );
    } finally {
      isLoading.value = false;
    }
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
