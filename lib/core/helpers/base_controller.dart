import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:get/get.dart';
import 'dart:developer';

class BaseController extends GetxController {
  final isLoading = false.obs;

  Future<void> executeApi({
    required Future<void> Function() apiCall,
    RxBool? loadingState,
    String? errorMessage,
    bool showSnackbarOnError = true,
  }) async {
    final state = loadingState ?? isLoading;
    try {
      state.value = true;
      await apiCall();
    } catch (e) {
      if (ApiConstants.showLogs) log(e.toString());
      if (showSnackbarOnError) {
        AppSnackBar.show(
          title: "Error",
          message: e is ApiException
              ? e.message
              : (errorMessage ?? "Something went wrong"),
          type: AppSnackBarType.error,
        );
      }
    } finally {
      state.value = false;
    }
  }
}
